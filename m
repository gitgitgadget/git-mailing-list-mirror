From: Edgar Toernig <froese@gmx.de>
Subject: [PATCH] Fix rfc2822 date parser
Date: Mon, 25 Apr 2005 23:32:44 +0200
Message-ID: <20050425233244.5f79d59c.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 23:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBAm-0002jL-Qe
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDYVgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDYVgE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:36:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:54748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261228AbVDYVcs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 17:32:48 -0400
Received: (qmail invoked by alias); 25 Apr 2005 21:32:47 -0000
Received: from p50906A90.dip.t-dialin.net (EHLO dialup) [80.144.106.144]
  by mail.gmx.net (mp005) with SMTP; 25 Apr 2005 23:32:47 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

- Fix some broken tests like "if (!tm.tm_sec > 59)"
- Make seconds optional
- Allow trailing comments like (EDT)
- Stand-alone mktime without timezone correction

Ciao, ET.


diff -u git-0.6-orig/commit-tree.c git-0.6/commit-tree.c
--- git-0.6-orig/commit-tree.c	Thu Apr 21 19:58:47 2005
+++ git-0.6/commit-tree.c	Mon Apr 25 23:06:36 2005
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
@@ -243,10 +259,11 @@
 	i = strtoul(p+1, NULL, 10);
 	offset *= ((i % 100) + ((i / 100) * 60));
 
-	if (*(skipfws(p + 5)))
+	p = skipfws(p + 5);
+	if (*p && *p != '(') /* trailing comment like (EDT) is ok */
 		return;
 
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
+	then = my_mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
 	if (then == -1)
 		return;
 
