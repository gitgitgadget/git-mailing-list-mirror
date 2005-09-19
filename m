From: Linus Torvalds <torvalds@osdl.org>
Subject: Return proper error valud from "parse_date()"
Date: Mon, 19 Sep 2005 15:53:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191548180.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Sep 20 00:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHUWY-0006rS-DY
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVISWyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVISWyG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:54:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932675AbVISWyF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 18:54:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JMrpBo014589
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 15:53:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JMroOe021397;
	Mon, 19 Sep 2005 15:53:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.116 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8919>


Right now we don't return any error value at all from parse_date(), and if 
we can't parse it, we just silently leave the result buffer unchanged. 

That's fine for the current user, which will always default to the current 
date, but it's a crappy interface, and we might well be better off with an 
error message rather than just the default date.

So let's change the thing to return a negative value if an error occurs, 
and the length of the result otherwise (snprintf behaviour: if the buffer 
is too small, it returns how big it _would_ have been).

[ I started looking at this in case we could support date-based revision 
  names. Looks ugly. Would have to parse relative dates.. ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -241,7 +241,7 @@ extern void *read_object_with_reference(
 					unsigned char *sha1_ret);
 
 const char *show_date(unsigned long time, int timezone);
-void parse_date(const char *date, char *buf, int bufsize);
+int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 
 extern int setup_ident(void);
diff --git a/date.c b/date.c
--- a/date.c
+++ b/date.c
@@ -388,7 +388,7 @@ static int match_tz(const char *date, in
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-void parse_date(const char *date, char *result, int maxlen)
+int parse_date(const char *date, char *result, int maxlen)
 {
 	struct tm tm;
 	int offset, sign, tm_gmt;
@@ -431,7 +431,7 @@ void parse_date(const char *date, char *
 		offset = (then - mktime(&tm)) / 60;
 
 	if (then == -1)
-		return;
+		return -1;
 
 	if (!tm_gmt)
 		then -= offset * 60;
@@ -442,7 +442,7 @@ void parse_date(const char *date, char *
 		sign = '-';
 	}
 
-	snprintf(result, maxlen, "%lu %c%02d%02d", then, sign, offset/60, offset % 60);
+	return snprintf(result, maxlen, "%lu %c%02d%02d", then, sign, offset/60, offset % 60);
 }
 
 void datestamp(char *buf, int bufsize)
