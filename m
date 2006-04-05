From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] date parsing: be friendlier to our European friends.
Date: Wed, 05 Apr 2006 15:39:35 -0700
Message-ID: <7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
	<20060404231606.219a4cc5.akpm@osdl.org>
	<7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 06 00:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRGfA-0008Oz-Ad
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 00:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWDEWjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWDEWjl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 18:39:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49852 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932110AbWDEWjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 18:39:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405223939.XMHU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 18:39:39 -0400
To: git@vger.kernel.org
In-Reply-To: <7virpo4jxf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 04 Apr 2006 23:26:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18456>

This does three things, only applies to cases where the user
manually tries to override the author/commit time by environment
variables, with non-ISO, non-2822 format date-string:

 - Refuses to use the interpretation to put the date in the
   future; recent kernel history has a commit made with
   10/03/2006 which is recorded as October 3rd.

 - Adds '.' as the possible year-month-date separator.  We
   learned from our European friends on the #git channel that
   dd.mm.yyyy is the norm there.

 - When the separator is '.', we prefer dd.mm.yyyy over
   mm.dd.yyyy; otherwise mm/dd/yy[yy] takes precedence over
   dd/mm/yy[yy].

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is more of a RFC than ready-to-be-merged patch.
   Alternative patches and improvements are welcome.

 date.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 56 insertions(+), 21 deletions(-)

b9065540826426ac0e4959e869ba7e08d1ae65d8
diff --git a/date.c b/date.c
index 376d25d..034d722 100644
--- a/date.c
+++ b/date.c
@@ -197,26 +197,43 @@ static int match_alpha(const char *date,
 	return skip_alpha(date);
 }
 
-static int is_date(int year, int month, int day, struct tm *tm)
+static int is_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
 {
 	if (month > 0 && month < 13 && day > 0 && day < 32) {
+		struct tm check = *tm;
+		struct tm *r = (now_tm ? &check : tm);
+		time_t specified;
+
+		r->tm_mon = month - 1;
+		r->tm_mday = day;
 		if (year == -1) {
-			tm->tm_mon = month-1;
-			tm->tm_mday = day;
-			return 1;
+			if (!now_tm)
+				return 1;
+			r->tm_year = now_tm->tm_year;
 		}
-		if (year >= 1970 && year < 2100) {
-			year -= 1900;
-		} else if (year > 70 && year < 100) {
-			/* ok */
-		} else if (year < 38) {
-			year += 100;
-		} else
+		else if (year >= 1970 && year < 2100)
+			r->tm_year = year - 1900;
+		else if (year > 70 && year < 100)
+			r->tm_year = year;
+		else if (year < 38)
+			r->tm_year = year + 100;
+		else
 			return 0;
+		if (!now_tm)
+			return 1;
+
+		specified = my_mktime(r);
 
-		tm->tm_mon = month-1;
-		tm->tm_mday = day;
-		tm->tm_year = year;
+		/* Be it commit time or author time, it does not make
+		 * sense to specify timestamp way into the future.  Make
+		 * sure it is not later than ten days from now...
+		 */
+		if (now + 10*24*3600 < specified)
+			return 0;
+		tm->tm_mon = r->tm_mon;
+		tm->tm_mday = r->tm_mday;
+		if (year != -1)
+			tm->tm_year = r->tm_year;
 		return 1;
 	}
 	return 0;
@@ -224,6 +241,9 @@ static int is_date(int year, int month, 
 
 static int match_multi_number(unsigned long num, char c, const char *date, char *end, struct tm *tm)
 {
+	time_t now;
+	struct tm now_tm;
+	struct tm *refuse_future;
 	long num2, num3;
 
 	num2 = strtol(end+1, &end, 10);
@@ -246,19 +266,33 @@ static int match_multi_number(unsigned l
 
 	case '-':
 	case '/':
+	case '.':
+		now = time(NULL);
+		refuse_future = NULL;
+		if (gmtime_r(&now, &now_tm))
+			refuse_future = &now_tm;
+
 		if (num > 70) {
 			/* yyyy-mm-dd? */
-			if (is_date(num, num2, num3, tm))
+			if (is_date(num, num2, num3, refuse_future, now, tm))
 				break;
 			/* yyyy-dd-mm? */
-			if (is_date(num, num3, num2, tm))
+			if (is_date(num, num3, num2, refuse_future, now, tm))
 				break;
 		}
-		/* mm/dd/yy ? */
-		if (is_date(num3, num, num2, tm))
+		/* Our eastern European friends say dd.mm.yy[yy]
+		 * is the norm there, so giving precedence to
+		 * mm/dd/yy[yy] form only when separator is not '.'
+		 */
+		if (c != '.' &&
+		    is_date(num3, num, num2, refuse_future, now, tm))
+			break;
+		/* European dd.mm.yy[yy] or funny US dd/mm/yy[yy] */
+		if (is_date(num3, num2, num, refuse_future, now, tm))
 			break;
-		/* dd/mm/yy ? */
-		if (is_date(num3, num2, num, tm))
+		/* Funny European mm.dd.yy */
+		if (c == '.' &&
+		    is_date(num3, num, num2, refuse_future, now, tm))
 			break;
 		return 0;
 	}
@@ -288,10 +322,11 @@ static int match_digit(const char *date,
 	}
 
 	/*
-	 * Check for special formats: num[:-/]num[same]num
+	 * Check for special formats: num[-.:/]num[same]num
 	 */
 	switch (*end) {
 	case ':':
+	case '.':
 	case '/':
 	case '-':
 		if (isdigit(end[1])) {
-- 
1.3.0.rc2.g1b83
