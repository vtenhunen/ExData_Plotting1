# Set the URL of the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the zip-file to the working directory. 
# Here we use Linux Ubuntu and therefore we do not need any method like "curl" 
download.file(fileUrl, destfile = "./exdata%2Fdata%2Fhousehold_power_consumption.zip")

#unzip the package
unzip("./exdata%2Fdata%2Fhousehold_power_consumption.zip")

# Now we have in the working directory the file household_power_consumption.txt

# Next we read the file
hpc_data <- read.table("household_power_consumption.txt", 
                       sep = ";", 
                       header = TRUE, 
                       na = "?", 
                       colClasses = c("character", "character", rep("numeric",7)))

# Now we have data in hpc_data

# manipulate the time
hpc_data$Time <- strptime(paste(hpc_data$Date, hpc_data$Time), "%d/%m/%Y %H:%M:%S")

# manipulate the date
hpc_data$Date <- as.Date(hpc_data$Date, "%d/%m/%Y")

# let's subsetting the data, we will only be using data from the dates 2007-02-01 and 2007-02-02
hpc_dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
hpc_data <- subset(hpc_data, Date %in% hpc_dates)

# The we should do the third plot and print it into the png-file.
png("plot3.png", width=480, height=480)
plot(hpc_data$Time, hpc_data$Sub_metering_1, 
     type="l", ylab = "Energy sub metering", 
     xlab="", 
     col="black")
lines(hpc_data$Time, hpc_data$Sub_metering_2, col="red")
lines(hpc_data$Time, hpc_data$Sub_metering_3, col="blue")
legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
