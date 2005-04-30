From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 06:50:39 +0200
Message-ID: <20050430065039.21ac9a4e.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 06:45:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRjr5-0003LS-Ge
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 06:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVD3EvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 00:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVD3EvD
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 00:51:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262508AbVD3Eun (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 00:50:43 -0400
Received: (qmail invoked by alias); 30 Apr 2005 04:50:42 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp031) with SMTP; 30 Apr 2005 06:50:42 +0200
X-Authenticated: #271361
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Luck, Tony wrote:
>
> >What's wrong with the patch I sent to fix this:
>
> I missed it ... there is a problem that you drop the timezone.

Upps, sorry.

> I'd much rather see your version fixed up to preserve the timezone
> than have the libcurl dependency.

Fixed version below.

--- x/commit-tree.c	Thu Apr 21 19:58:47 2005
+++ y/commit-tree.c	Sat Apr 30 06:24:19 2005
@@ -113,6 +113,25 @@
 	}
 }
 
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
 static const char *month_names[] = {
         "Jan", "Feb", "Mar", "Apr", "May", "Jun",
         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
@@ -136,7 +155,7 @@
 static void parse_rfc2822_date(char *date, char *result, int maxlen)
 {
 	struct tm tm;
-	char *p;
+	char *p, *tz;
 	int i, offset;
 	time_t then;
 
@@ -194,7 +213,7 @@
 		return;
 	tm.tm_hour = strtoul(p, &p, 10);
 	
-	if (!tm.tm_hour > 23)
+	if (tm.tm_hour > 23)
 		return;
 
 	if (*p != ':')
@@ -206,14 +225,11 @@
 		return;
 	tm.tm_min = strtoul(p, &p, 10);
 	
-	if (!tm.tm_min > 59)
+	if (tm.tm_min > 59)
 		return;
 
-	if (isspace(*p))
-		goto zone;
-
 	if (*p != ':')
-		return; /* Error -- bad time */
+		goto zone;
 	p++;
 
 	/* second */
@@ -221,13 +237,13 @@
 		return;
 	tm.tm_sec = strtoul(p, &p, 10);
 	
-	if (!tm.tm_sec > 59)
+	if (tm.tm_sec > 59)
 		return;
 
+ zone:
 	if (!isspace(*p))
 		return;
 
- zone:
 	p = skipfws(p);
 
 	if (*p == '-')
@@ -240,19 +256,21 @@
 	if (!isdigit(p[1]) || !isdigit(p[2]) || !isdigit(p[3]) || !isdigit(p[4]))
 		return;
 
+	tz = p;
 	i = strtoul(p+1, NULL, 10);
 	offset *= ((i % 100) + ((i / 100) * 60));
 
-	if (*(skipfws(p + 5)))
+	p = skipfws(p + 5);
+	if (*p && *p != '(') /* trailing comment like (EDT) is ok */
 		return;
 
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
+	then = my_mktime(&tm); /* mktime uses local timezone */
 	if (then == -1)
 		return;
 
 	then -= offset;
 
-	snprintf(result, maxlen, "%lu %5.5s", then, p);
+	snprintf(result, maxlen, "%lu %5.5s", then, tz);
 }
 
 static void check_valid(unsigned char *sha1, const char *expect)


Ciao, ET.
