From: tony.luck@intel.com
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 17:21:36 -0700
Message-ID: <200504300021.j3U0La023762@unix-os.sc.intel.com>
References: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRfeO-0003UK-4E
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVD3AVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVD3AVr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:21:47 -0400
Received: from fmr24.intel.com ([143.183.121.16]:1456 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S263081AbVD3AVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 20:21:37 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3U0LaeO015518;
	Sat, 30 Apr 2005 00:21:36 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3U0Gc5F011617;
	Sat, 30 Apr 2005 00:16:38 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3U0La023762;
	Fri, 29 Apr 2005 17:21:36 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4272C4DE.8090806@zytor.com>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> There was a time-parsing bug somewhere, where mktime() got invoked on a 
> UTC date.  I proposed changing it to curl_gettime() instead.

Here's a patch to switch to using curl_getdate():

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

 Makefile      |    1 
 commit-tree.c |  143 ++++------------------------------------------------------
 2 files changed, 11 insertions(+), 133 deletions(-)

Makefile: d73bea1cbb9451a89b03d6066bf2ed7fec32fd31
--- k/Makefile
+++ l/Makefile
@@ -92,6 +92,7 @@ $(LIB_FILE): $(LIB_OBJS)
 rpush: rsh.c
 rpull: rsh.c
 http-pull: LIBS += -lcurl
+commit-tree: LIBS += -lcurl
 
 
 ifneq (,$(wildcard .git))
commit-tree.c: 23de13361944ad7ba7c5320cf7cdd04e81842c60
--- k/commit-tree.c
+++ l/commit-tree.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <time.h>
+#include <curl/curl.h>
 
 #define BLOCKING (1ul << 14)
 
@@ -80,146 +81,22 @@ static void remove_special(char *p)
 	}
 }
 
-static const char *month_names[] = {
-        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
-        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
-};
-
-static const char *weekday_names[] = {
-        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
-};
-
-
-static char *skipfws(char *str)
-{
-	while (isspace(*str))
-		str++;
-	return str;
-}
-
-	
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-static void parse_rfc2822_date(char *date, char *result, int maxlen)
+static void parse_date(char *date, time_t *now, char *result, int maxlen)
 {
-	struct tm tm;
 	char *p;
-	int i, offset;
 	time_t then;
 
-	memset(&tm, 0, sizeof(tm));
-
-	/* Skip day-name */
-	p = skipfws(date);
-	if (!isdigit(*p)) {
-		for (i=0; i<7; i++) {
-			if (!strncmp(p,weekday_names[i],3) && p[3] == ',') {
-				p = skipfws(p+4);
-				goto day;
-			}
-		}
-		return;
-	}					
-
-	/* day */
- day:
-	tm.tm_mday = strtoul(p, &p, 10);
-
-	if (tm.tm_mday < 1 || tm.tm_mday > 31)
-		return;
-
-	if (!isspace(*p))
-		return;
-
-	p = skipfws(p);
-
-	/* month */
-
-	for (i=0; i<12; i++) {
-		if (!strncmp(p, month_names[i], 3) && isspace(p[3])) {
-			tm.tm_mon = i;
-			p = skipfws(p+strlen(month_names[i]));
-			goto year;
-		}
-	}
-	return; /* Error -- bad month */
-
-	/* year */
- year:	
-	tm.tm_year = strtoul(p, &p, 10);
-
-	if (!tm.tm_year && !isspace(*p))
-		return;
-
-	if (tm.tm_year > 1900)
-		tm.tm_year -= 1900;
-		
-	p=skipfws(p);
-
-	/* hour */
-	if (!isdigit(*p))
-		return;
-	tm.tm_hour = strtoul(p, &p, 10);
-	
-	if (!tm.tm_hour > 23)
-		return;
-
-	if (*p != ':')
-		return; /* Error -- bad time */
-	p++;
-
-	/* minute */
-	if (!isdigit(*p))
-		return;
-	tm.tm_min = strtoul(p, &p, 10);
-	
-	if (!tm.tm_min > 59)
+	if ((then = curl_getdate(date, now)) == 0)
 		return;
 
-	if (isspace(*p))
-		goto zone;
-
-	if (*p != ':')
-		return; /* Error -- bad time */
-	p++;
-
-	/* second */
-	if (!isdigit(*p))
-		return;
-	tm.tm_sec = strtoul(p, &p, 10);
-	
-	if (!tm.tm_sec > 59)
-		return;
-
-	if (!isspace(*p))
-		return;
-
- zone:
-	p = skipfws(p);
-
-	if (*p == '-')
-		offset = -60;
-	else if (*p == '+')
-		offset = 60;
-	else
-	       return;
-
-	if (!isdigit(p[1]) || !isdigit(p[2]) || !isdigit(p[3]) || !isdigit(p[4]))
-		return;
-
-	i = strtoul(p+1, NULL, 10);
-	offset *= ((i % 100) + ((i / 100) * 60));
-
-	if (*(skipfws(p + 5)))
-		return;
-
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
-	if (then == -1)
-		return;
-
-	then -= offset;
-
-	snprintf(result, maxlen, "%lu %5.5s", then, p);
+	/* find the timezone at the end */
+	p = date + strlen(date);
+	while (p > date && isdigit(*--p))
+		;
+	if ((*p == '+' || *p == '-') && strlen(p) == 5)
+		snprintf(result, maxlen, "%lu %5.5s", then, p);
 }
 
 static void check_valid(unsigned char *sha1, const char *expect)
@@ -298,7 +175,7 @@ int main(int argc, char **argv)
 	email = getenv("AUTHOR_EMAIL") ? : realemail;
 	audate = getenv("AUTHOR_DATE");
 	if (audate)
-		parse_rfc2822_date(audate, date, sizeof(date));
+		parse_date(audate, &now, date, sizeof(date));
 
 	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
 	remove_special(email); remove_special(realemail); remove_special(commitemail);
