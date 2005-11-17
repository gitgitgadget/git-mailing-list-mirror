From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 12:36:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 21:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcqVH-0001ve-0i
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 21:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVKQUg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVKQUg7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 15:36:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964829AbVKQUg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 15:36:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHKaXnO000501
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 12:36:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHKaUEE008459;
	Thu, 17 Nov 2005 12:36:32 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12150>


This allows people to use syntax like "last thursday" for the approxidate. 

(Or, indeed, more complex "three thursdays ago", but I suspect that would 
be pretty unusual).

NOTE! The parsing is strictly sequential, so if you do

	"one day before last thursday"

it will _not_ do what you think it does. It will take the current time, 
subtract one day, and then go back to the thursday before that. So to get 
what you want, you'd have to write it the other way around:

	"last thursday and one day before"

which is insane (it's usually the same as "last wednesday" _except_ if 
today is Thursday, in which case "last wednesday" is yesterday, and "last 
thursday and one day before" is eight days ago).

Similarly,

	"last thursday one month ago"

will first go back to last thursday, and then go back one month from 
there, not the other way around.

I doubt anybody would ever use insane dates like that, but I thought I'd 
point out that the approxidate parsing is not exactly "standard English".

Side note 2: if you want to avoid spaces (because of quoting issues), you 
can use any non-alphanumberic character instead. So

	git log --since=2.days.ago

works without any quotes.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/date.c b/date.c
index 73c063b..d2a67cc 100644
--- a/date.c
+++ b/date.c
@@ -34,7 +34,7 @@ static const char *month_names[] = {
 };
 
 static const char *weekday_names[] = {
-	"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
+	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
 /*
@@ -531,6 +531,22 @@ static const char *approxidate_alpha(con
 		tl++;
 	}
 
+	for (i = 0; i < 7; i++) {
+		int match = match_string(date, weekday_names[i]);
+		if (match >= 3) {
+			int diff, n = *num -1;
+			*num = 0;
+
+			diff = tm->tm_wday - i;
+			if (diff <= 0)
+				n++;
+			diff += 7*n;
+
+			update_tm(tm, diff * 24 * 60 * 60);
+			return end;
+		}
+	}
+
 	if (match_string(date, "months") >= 5) {
 		int n = tm->tm_mon - *num;
 		*num = 0;
