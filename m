From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 12:53:33 +0200
Message-ID: <20050430125333.2bd81b18.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 12:48:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRpWC-0002bf-Lx
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 12:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVD3KyB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 06:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVD3KyB
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 06:54:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:61335 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261191AbVD3Kxi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 06:53:38 -0400
Received: (qmail invoked by alias); 30 Apr 2005 10:53:37 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp024) with SMTP; 30 Apr 2005 12:53:37 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> Edgar, willing to create a separate "parse-date.c" with your "my_mktime()" 
> thing and move the old date parsing there? That way we'll just use that 
> instead of libcurl..

Here it is.  I moved the strftime stuff too (workaround for non-standard
%s %z sequence).

--- k/Makefile  (mode:100644)
+++ l/Makefile  (mode:100644)
@@ -28,7 +28,8 @@ all: $(PROG)
 install: $(PROG) $(SCRIPTS)
 	install $(PROG) $(SCRIPTS) $(HOME)/bin/
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o tag.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
+	 tag.o date.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
--- k/cache.h  (mode:100644)
+++ l/cache.h  (mode:100644)
@@ -147,6 +160,9 @@ extern void *read_object_with_reference(
 					const unsigned char *required_type,
 					unsigned long *size,
 					unsigned char *sha1_ret);
+
+void parse_date(char *date, char *buf, int bufsize);
+void datestamp(char *buf, int bufsize);
 
 static inline void *xmalloc(int size)
 {
--- k/commit-tree.c  (mode:100644)
+++ l/commit-tree.c  (mode:100644)
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <ctype.h>
 #include <time.h>
-#include <curl/curl.h>
 
 #define BLOCKING (1ul << 14)
 
@@ -81,24 +80,6 @@ static void remove_special(char *p)
 	}
 }
 
-/* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
-   (i.e. English) day/month names, and it doesn't work correctly with %z. */
-static void parse_date(char *date, time_t *now, char *result, int maxlen)
-{
-	char *p;
-	time_t then;
-
-	if ((then = curl_getdate(date, now)) == 0)
-		return;
-
-	/* find the timezone at the end */
-	p = date + strlen(date);
-	while (p > date && isdigit(*--p))
-		;
-	if ((*p == '+' || *p == '-') && strlen(p) == 5)
-		snprintf(result, maxlen, "%lu %5.5s", then, p);
-}
-
 static void check_valid(unsigned char *sha1, const char *expect)
 {
 	void *buf;
@@ -132,8 +113,6 @@ int main(int argc, char **argv)
 	char *audate;
 	char comment[1000];
 	struct passwd *pw;
-	time_t now;
-	struct tm *tm;
 	char *buffer;
 	unsigned int size;
 
@@ -163,10 +142,8 @@ int main(int argc, char **argv)
 		strcat(realemail, ".");
 		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
 	}
-	time(&now);
-	tm = localtime(&now);
 
-	strftime(realdate, sizeof(realdate), "%s %z", tm);
+	datestamp(realdate, sizeof(realdate));
 	strcpy(date, realdate);
 
 	commitgecos = getenv("COMMIT_AUTHOR_NAME") ? : realgecos;
@@ -175,7 +152,7 @@ int main(int argc, char **argv)
 	email = getenv("AUTHOR_EMAIL") ? : realemail;
 	audate = getenv("AUTHOR_DATE");
 	if (audate)
-		parse_date(audate, &now, date, sizeof(date));
+		parse_date(audate, date, sizeof(date));
 
 	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
 	remove_special(email); remove_special(realemail); remove_special(commitemail);
--- /dev/null
+++ l/date.c  (mode:100644)
@@ -0,0 +1,187 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <time.h>
+
+static time_t my_mktime(struct tm *tm)
+{
+	static const int mdays[] = {
+	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
+	};
+	int year = tm->tm_year - 70;
+	int month = tm->tm_mon;
+	int day = tm->tm_mday;
+
+	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
+		return -1;
+	if (month < 0 || month > 11) /* array bounds */
+		return -1;
+	if (month < 2 || (year + 2) % 4)
+		day--;
+	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
+		tm->tm_hour * 60*60 + tm->tm_min * 60 + tm->tm_sec;
+}
+
+static const char *month_names[] = {
+        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
+        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
+};
+
+static const char *weekday_names[] = {
+        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
+};
+
+
+static char *skipfws(char *str)
+{
+	while (isspace(*str))
+		str++;
+	return str;
+}
+
+	
+/* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
+   (i.e. English) day/month names, and it doesn't work correctly with %z. */
+void parse_date(char *date, char *result, int maxlen)
+{
+	struct tm tm;
+	char *p, *tz;
+	int i, offset;
+	time_t then;
+
+	memset(&tm, 0, sizeof(tm));
+
+	/* Skip day-name */
+	p = skipfws(date);
+	if (!isdigit(*p)) {
+		for (i=0; i<7; i++) {
+			if (!strncmp(p,weekday_names[i],3) && p[3] == ',') {
+				p = skipfws(p+4);
+				goto day;
+			}
+		}
+		return;
+	}					
+
+	/* day */
+ day:
+	tm.tm_mday = strtoul(p, &p, 10);
+
+	if (tm.tm_mday < 1 || tm.tm_mday > 31)
+		return;
+
+	if (!isspace(*p))
+		return;
+
+	p = skipfws(p);
+
+	/* month */
+
+	for (i=0; i<12; i++) {
+		if (!strncmp(p, month_names[i], 3) && isspace(p[3])) {
+			tm.tm_mon = i;
+			p = skipfws(p+strlen(month_names[i]));
+			goto year;
+		}
+	}
+	return; /* Error -- bad month */
+
+	/* year */
+ year:	
+	tm.tm_year = strtoul(p, &p, 10);
+
+	if (!tm.tm_year && !isspace(*p))
+		return;
+
+	if (tm.tm_year > 1900)
+		tm.tm_year -= 1900;
+		
+	p=skipfws(p);
+
+	/* hour */
+	if (!isdigit(*p))
+		return;
+	tm.tm_hour = strtoul(p, &p, 10);
+	
+	if (tm.tm_hour > 23)
+		return;
+
+	if (*p != ':')
+		return; /* Error -- bad time */
+	p++;
+
+	/* minute */
+	if (!isdigit(*p))
+		return;
+	tm.tm_min = strtoul(p, &p, 10);
+	
+	if (tm.tm_min > 59)
+		return;
+
+	if (*p != ':')
+		goto zone;
+	p++;
+
+	/* second */
+	if (!isdigit(*p))
+		return;
+	tm.tm_sec = strtoul(p, &p, 10);
+	
+	if (tm.tm_sec > 59)
+		return;
+
+ zone:
+	if (!isspace(*p))
+		return;
+
+	p = skipfws(p);
+
+	if (*p == '-')
+		offset = -60;
+	else if (*p == '+')
+		offset = 60;
+	else
+	       return;
+
+	if (!isdigit(p[1]) || !isdigit(p[2]) || !isdigit(p[3]) || !isdigit(p[4]))
+		return;
+
+	tz = p;
+	i = strtoul(p+1, NULL, 10);
+	offset *= ((i % 100) + ((i / 100) * 60));
+
+	p = skipfws(p + 5);
+	if (*p && *p != '(') /* trailing comment like (EDT) is ok */
+		return;
+
+	then = my_mktime(&tm); /* mktime uses local timezone */
+	if (then == -1)
+		return;
+
+	then -= offset;
+
+	snprintf(result, maxlen, "%lu %5.5s", then, tz);
+}
+
+void datestamp(char *buf, int bufsize)
+{
+	time_t now;
+	struct tm *tm;
+	int offset;
+
+	time(&now);
+
+	tm = localtime(&now); /* get timezone and tm_isdst */
+	offset = -timezone / 60;
+	if (tm->tm_isdst > 0)
+		offset += 60;
+
+	snprintf(buf, bufsize, "%lu %+05d", now, offset/60*100 + offset%60);
+}

Ciao, ET.
