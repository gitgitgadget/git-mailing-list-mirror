From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix strange timezone handling
Date: Wed, 21 Sep 2005 15:50:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211527500.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 22 00:51:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIDQF-0007u6-TE
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 00:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVIUWug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVIUWug
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 18:50:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbVIUWug (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 18:50:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LMoUBo024402
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 15:50:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LMoShR002269;
	Wed, 21 Sep 2005 15:50:29 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9085>


We generate the ASCII representation of our internal date representation 
("seconds since 1970, UTC + timezone information") in two different 
places.

One of them uses the stupid and obvious way to make sure that it gets the
sexagecimal representation right for negative timezones even if they might
not be exact hours, and the other one depends on the modulus operator
always matching the sign of argument.

Hey, the clever one works. And C90 even specifies that behaviour. But I
had to think about it for a while when I was re-visiting this area, and
even if I didn't have to, it's kind of strange to have two different ways
to print out the same data format.

So use a common helper for this. And select the stupid and straighforward
way.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Yeah. Maybe I should have picked the smart one-liner one. Somebody should
double-check this and make an informed decision.

diff --git a/date.c b/date.c
--- a/date.c
+++ b/date.c
@@ -386,12 +386,23 @@ static int match_tz(const char *date, in
 	return end - date;
 }
 
+static int date_string(unsigned long date, int offset, char *buf, int len)
+{
+	int sign = '+';
+
+	if (offset < 0) {
+		offset = -offset;
+		sign = '-';
+	}
+	return snprintf(buf, len, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
+}
+
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
 int parse_date(const char *date, char *result, int maxlen)
 {
 	struct tm tm;
-	int offset, sign, tm_gmt;
+	int offset, tm_gmt;
 	time_t then;
 
 	memset(&tm, 0, sizeof(tm));
@@ -435,14 +446,7 @@ int parse_date(const char *date, char *r
 
 	if (!tm_gmt)
 		then -= offset * 60;
-
-	sign = '+';
-	if (offset < 0) {
-		offset = -offset;
-		sign = '-';
-	}
-
-	return snprintf(result, maxlen, "%lu %c%02d%02d", then, sign, offset/60, offset % 60);
+	return date_string(then, offset, result, maxlen);
 }
 
 void datestamp(char *buf, int bufsize)
@@ -455,5 +459,5 @@ void datestamp(char *buf, int bufsize)
 	offset = my_mktime(localtime(&now)) - now;
 	offset /= 60;
 
-	snprintf(buf, bufsize, "%lu %+05d", now, offset/60*100 + offset%60);
+	date_string(now, offset, buf, bufsize);
 }
