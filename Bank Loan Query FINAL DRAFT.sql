
-- use bank_loan database

select issue_date from Bank_loan_data; 
select * from bank_loan_data where id = 1077430
---------------------------------------------------------------- KEY PERFORMANCE INDICATORS DASHBOARD ----------------------------------------------------------------------------------

-- Find out the total amount of loan applications

select count(id) AS total_loan_applications FROM bank_loan_data; 

-- Find out the amount of loan applications per month

SELECT count(id) AS total_loan_applications FROM bank_loan_data
where month(issue_date) = 12 

-- find out the amount of loan applications for the prior month

SELECT count(id) AS total_loan_applications FROM bank_loan_data
where month(issue_date) = 11

-- Find out the amount of loan applications per month in a particular year

SELECT count(id) AS total_loan_applications FROM bank_loan_data
where month(issue_date) = 12 AND year(issue_date) = 2021

-- Find out the amount of loan applications from the prior month in a particular year

SELECT count(id) AS total_loan_applications FROM bank_loan_data
where month(issue_date) = 11 AND year(issue_date) = 2021

-- what is the total amount loaned out by the bank?

select sum(loan_amount) AS Total_Funded_Amount FROM Bank_Loan_Data 

-- what is the total amount loaned out by the bank per monthly basis?

SELECT sum(loan_amount) AS total_Monthly_Funded_Amount FROM bank_loan_data
where month(issue_date) = 12 AND year(issue_date) = 2021

-- What is the total amount loaned out by the bank per the previous month?

SELECT sum(loan_amount) AS PMTD_Monthly_Funded_Amount FROM bank_loan_data
where month(issue_date) = 11 AND year(issue_date) = 2021

-- What is the total amount that has been paid back by the customers? 

SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data

-- what is the total amount paid back by the customers per monthly basis?

SELECT sum(total_payment) AS total_Monthly_Payment_Amount FROM bank_loan_data
where month(issue_date) = 12 AND year(issue_date) = 2021

-- What is the total amount paid back by the customers per the previous month?

SELECT sum(loan_amount) AS PMTD_Monthly_Payment_Amount FROM bank_loan_data
where month(issue_date) = 11 AND year(issue_date) = 2021

-- what is the average interest rate provided by the bank?

SELECT avg(int_rate) AS avg_Interest_rate from bank_loan_data 

--convert this into a percentage

SELECT round(avg(int_rate), 4)*100 AS avg_Interest_rate from bank_loan_data 

-- What is the average interest rate provided by the bank per month?

SELECT round(avg(int_rate), 4)*100 AS avg_Interest_rate from bank_loan_data 
WHERE month(issue_date) = 12 AND year(issue_date) = 2021

-- What is the average interest rate provided by the bank from the previous month?

SELECT round(avg(int_rate), 4)*100 AS PMTD_avg_Interest_rate from bank_loan_data 
WHERE month(issue_date) = 11 AND year(issue_date) = 2021

--What is the average debt-to-income ratio of all the customers?

SELECT avg(dti) * 100 AS Average_DTI FROM bank_loan_data

SELECT round(avg(dti),4) * 100 AS Average_DTI FROM bank_loan_data

--What is the average monthly debt-to-income ratio of all the customers?

SELECT round(avg(dti),4) * 100 AS Average_DTI FROM bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021

--What is the average prior monthly debt-to-income ratio of all the customers?

SELECT round(avg(dti),4) * 100 AS Average_DTI FROM bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021

--------------------------------------------------------------------------------------------
select * from Bank_loan_data; 

select loan_status FROM bank_loan_data

-- notice when running the query above, we can see here there are a few options; fully paid, charged offf, and current. To see the different kinds, you can use EXCEL 
-- or just run a distinct function like the one below:

select distinct(loan_status) from bank_loan_data


-- What is the total percentage of good loans (anything marked as fully paid or current) 

SELECT 
	(COUNT(CASE WHEN loan_status = 'fully Paid' OR Loan_status = 'Current' THEN id END) * 100)
	/
	count(id) AS Good_Loan_percentage
FROM bank_loan_data

-- What is the total count of good loan applications?

SELECT COUNT(ID) AS Count_of_good_loan_applications FROM bank_Loan_data 
WHERE loan_status = 'fully paid' OR Loan_status = 'Current' 

-- What is the total dollar amount of good loan applications?

select sum(loan_amount) AS sum_of_good_loan_applications FROM bank_loan_data 
WHERE loan_status = 'fully paid' OR Loan_status = 'Current' 

-- What is the total dollar amount of payments received from these loans?

select sum(total_payment) AS sum_of_good_loan_applications FROM bank_loan_data 
WHERE loan_status = 'fully paid' OR Loan_status = 'Current' 

-- What is the total percentage amount of bad loans issued?

SELECT 
	(Count(CASE WHEN Loan_status = 'Charged Off' THEN id END) * 100.0) 
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data


--How many bad loan applications are there?

select count(id) AS Bad_Loan_applications FROM bank_loan_data
where loan_status = 'charged off'

--How much has the bank given out that falls under bad loans?

select sum(loan_amount) AS Bad_Loan_amount_funded FROM bank_loan_data
where loan_status = 'charged off' 

-- How much has the bank received back from the bad loan total it has funded? 

select sum(total_payment) AS Bad_Loan_amount_funded FROM bank_loan_data
where loan_status = 'charged off' 

   

--------------------------------------------------------------------- Loan Status information -------------------------------------------------

SELECT Loan_status, count(id) AS Loancount, sum(total_payment) AS Total_Amount_received, sum(loan_amount) AS total_funded_amount, AVG(Int_rate * 100) AS Interest_rate, AVG(dti * 100) AS DTI
FROM bank_loan_data 
GROUP BY loan_status; 

--Monthly trends by issue date

SELECT Loan_status, sum(total_payment) AS MTD_Total_Amount_Received, SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data 
WHERE Month(issue_date) = 12 
GROUP BY loan_status 

SELECT
	Month(Issue_date) AS Month_Number, DATENAME(Month, issue_date) AS Month_Name, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY Month(issue_date), Datename(Month, issue_date)
	order by month(issue_date)


-- Regional analysis by state

SELECT
	address_state, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY address_state
	order by count(id) DESC


-- Loan Term Analysis

SELECT
	term, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY term
	order by term 

-- Employee Length Analysis

SELECT
	emp_length, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY emp_length
	order by count(id) desc

-- purpose of loan analysis

SELECT
	purpose, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY purpose
	order by count(id) desc

-- Home Ownership Analysis

SELECT
	Home_ownership, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY home_ownership
	order by count(id) desc

-- Home Ownership Analysis with respect to a particular grade

select distinct(grade) from bank_loan_data; 

	SELECT
	Home_ownership, count(id) AS Total_Loan_applications, sum(loan_amount) AS total_funded_amount, sum(total_payment) AS total_received_amount FROM Bank_loan_data 
	GROUP BY home_ownership
	where grade = 'A'
	order by count(id) desc

