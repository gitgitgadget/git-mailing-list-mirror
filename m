From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Fri, 29 Sep 2006 12:36:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609291231560.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
 <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
 <118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
 <Pine.LNX.4.64.0609282300190.3952@g5.osdl.org> <7vd59fp5b9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609282330440.3952@g5.osdl.org> <7vslibno88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 21:37:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTOAD-0006qW-2u
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 21:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWI2Tgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWI2Tgl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 15:36:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbWI2Tgk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 15:36:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8TJaIaX010901
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Sep 2006 12:36:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8TJaE1f028344;
	Fri, 29 Sep 2006 12:36:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslibno88.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.452 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28125>



On Fri, 29 Sep 2006, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > If you write
> >
> > 	12:30 am
> >
> > you really _should_ subtract 12, leaving you with 0:30. We don't. So we 
> > end up with a 24-hour time of 12:30, which is obviously _pm_, and wrong.
> >
> > And "12 am" or "12 pm" doesn't work at all.
> 
> Ah, that's what you meant.  My brain a bit too tired from the
> day job tonight X-<.

Here's a patch that should work. It just simplifies the whole thing to say 

	"hour = (hour % 12) + X"

where X is 12 for PM and 0 for AM.

It also fixes the "exact date" parsing, which didn't parse AM at all, and 
as such would do the same "12:30 AM" means "12:30 24-hour-format" bug. Of 
course, I hope that no exact dates use AM/PM anyway, but since we support 
the PM format, let's just get it right.

Not hugely tested, but I did test some of it, and it all _looks_ sane.

		Linus
---
diff --git a/date.c b/date.c
index db4c185..1825922 100644
--- a/date.c
+++ b/date.c
@@ -256,8 +256,12 @@ static int match_alpha(const char *date,
 	}
 
 	if (match_string(date, "PM") == 2) {
-		if (tm->tm_hour > 0 && tm->tm_hour < 12)
-			tm->tm_hour += 12;
+		tm->tm_hour = (tm->tm_hour % 12) + 12;
+		return 2;
+	}
+
+	if (match_string(date, "AM") == 2) {
+		tm->tm_hour = (tm->tm_hour % 12) + 0;
 		return 2;
 	}
 
@@ -600,28 +604,30 @@ static void date_tea(struct tm *tm, int 
 
 static void date_pm(struct tm *tm, int *num)
 {
-	int hour = *num;
+	int hour, n = *num;
 	*num = 0;
 
-	if (hour > 0 && hour < 12) {
-		tm->tm_hour = hour;
+	hour = tm->tm_hour;
+	if (n) {
+		hour = n;
 		tm->tm_min = 0;
 		tm->tm_sec = 0;
 	}
-	if (tm->tm_hour > 0 && tm->tm_hour < 12)
-		tm->tm_hour += 12;
+	tm->tm_hour = (hour % 12) + 12;
 }
 
 static void date_am(struct tm *tm, int *num)
 {
-	int hour = *num;
+	int hour, n = *num;
 	*num = 0;
 
-	if (hour > 0 && hour < 12) {
-		tm->tm_hour = hour;
+	hour = tm->tm_hour;
+	if (n) {
+		hour = n;
 		tm->tm_min = 0;
 		tm->tm_sec = 0;
 	}
+	tm->tm_hour = (hour % 12);
 }
 
 static const struct special {
