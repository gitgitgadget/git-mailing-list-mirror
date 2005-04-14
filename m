From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 18:38:36 +0100
Message-ID: <1113500316.27227.8.camel@hades.cambridge.redhat.com>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:39:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8HJ-0006hb-RH
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDNRkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDNRkj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:40:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5766 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261570AbVDNRir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 13:38:47 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM8IX-0001RC-MU; Thu, 14 Apr 2005 18:38:39 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.7 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 REMOVE_REMOVAL_2WORD   BODY: List removal information
	0.2 OFFERS_ETC             BODY: Stop the offers, coupons, discounts etc!
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 02:12 -0700, Linus Torvalds wrote:
> I take that back. I'd be much happier with you doing and testing it, 
> because now I'm crashing.

OK. commit-tree now eats RFC2822 dates as AUTHOR_DATE because that's
what you're going to want to feed it. We store seconds since UTC epoch,
we add the author's or committer's timezone as auxiliary data so that
dates can be pretty-printed in the original timezone later if anyone
cares. I left the date parsing in rev-tree.c for backward compatibility
but it can be dropped when we change to base64 :)

Yes, glibc sucks and strptime is a pile of crap. We have to parse it
ourselves.

Index: commit-tree.c
--- 1756b578489f93999ded68ae347bef7d6063101c/commit-tree.c  (mode:100664 sha1:12196c79f31d004dff0df1f50dda67d8204f5568)
+++ 82ba574c85e9a2e4652419c88244e9dd1bfa8baa/commit-tree.c  (mode:100644 sha1:35cb09402c9868499bcaf6de42afbad9fdfebe05)
@@ -7,6 +7,9 @@
 
 #include <pwd.h>
 #include <time.h>
+#include <string.h>
+#include <ctype.h>
+#include <time.h>
 
 #define BLOCKING (1ul << 14)
 #define ORIG_OFFSET (40)
@@ -95,6 +98,148 @@
 	}
 }
 
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
+static void parse_rfc2822_date(char *date, char *result, int maxlen)
+{
+	struct tm tm;
+	char *p;
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
+	if (!tm.tm_hour > 23)
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
+	if (!tm.tm_min > 59)
+		return;
+
+	if (isspace(*p))
+		goto zone;
+
+	if (*p != ':')
+		return; /* Error -- bad time */
+	p++;
+
+	/* second */
+	if (!isdigit(*p))
+		return;
+	tm.tm_sec = strtoul(p, &p, 10);
+	
+	if (!tm.tm_sec > 59)
+		return;
+
+	if (!isspace(*p))
+		return;
+
+ zone:
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
+	i = strtoul(p+1, NULL, 10);
+	offset *= ((i % 100) + ((i / 100) * 60));
+
+	if (*(skipfws(p + 5)))
+		return;
+
+	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
+	if (then == -1)
+		return;
+
+	then -= offset;
+
+	snprintf(result, maxlen, "%lu %5.5s", then, p);
+}
+
 /*
  * Having more than two parents may be strange, but hey, there's
  * no conceptual reason why the file format couldn't accept multi-way
@@ -114,10 +259,12 @@
 	unsigned char commit_sha1[20];
 	char *gecos, *realgecos;
 	char *email, realemail[1000];
-	char *date, *realdate;
+	char date[20], realdate[20];
+	char *audate;
 	char comment[1000];
 	struct passwd *pw;
 	time_t now;
+	struct tm *tm;
 	char *buffer;
 	unsigned int size;
 
@@ -142,15 +289,19 @@
 	realemail[len] = '@';
 	gethostname(realemail+len+1, sizeof(realemail)-len-1);
 	time(&now);
-	realdate = ctime(&now);
+	tm = localtime(&now);
+
+	strftime(realdate, sizeof(realdate), "%s %z", tm);
+	strcpy(date, realdate);
 
 	gecos = getenv("AUTHOR_NAME") ? : realgecos;
 	email = getenv("AUTHOR_EMAIL") ? : realemail;
-	date = getenv("AUTHOR_DATE") ? : realdate;
+	audate = getenv("AUTHOR_DATE");
+	if (audate)
+		parse_rfc2822_date(audate, date, sizeof(date));
 
 	remove_special(gecos); remove_special(realgecos);
 	remove_special(email); remove_special(realemail);
-	remove_special(date); remove_special(realdate);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
Index: rev-tree.c
--- 1756b578489f93999ded68ae347bef7d6063101c/rev-tree.c  (mode:100664 sha1:7bf9e9a92f528485360f374239809714ce7a19f5)
+++ 82ba574c85e9a2e4652419c88244e9dd1bfa8baa/rev-tree.c  (mode:100644 sha1:9443f4560beedcf81f2f5e7e0664d169cb5c8527)
@@ -1,4 +1,5 @@
 #define _XOPEN_SOURCE /* glibc2 needs this */
+#define _BSD_SOURCE /* for tm.tm_gmtoff */
 #include <time.h>
 #include <ctype.h>
 
@@ -21,6 +22,7 @@
 	char buffer[100];
 	struct tm tm;
 	const char *formats[] = {
+		"%s",
 		"%c",
 		"%a %b %d %T %y",
 		NULL
@@ -30,7 +32,7 @@
 	p = buffer;
 	while (isspace(c = *buf))
 		buf++;
-	while ((c = *buf++) != '\n')
+	while ((c = *buf++) != '\n' && c)
 		*p++ = c;
 	*p++ = 0;
 	buf = buffer;
@@ -50,6 +52,8 @@
 
 static unsigned long parse_commit_date(const char *buf)
 {
+	unsigned long time;
+
 	if (memcmp(buf, "author", 6))
 		return 0;
 	while (*buf++ != '\n')
@@ -58,7 +62,11 @@
 		return 0;
 	while (*buf++ != '>')
 		/* nada */;
-	return parse_time(buf);
+
+	time = strtoul(buf, NULL, 10);
+	if (!time)
+		time = parse_time(buf);
+	return time;
 }
 
 static int parse_commit(unsigned char *sha1)


-- 
dwmw2

