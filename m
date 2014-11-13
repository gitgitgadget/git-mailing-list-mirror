From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Thu, 13 Nov 2014 06:07:23 -0500
Message-ID: <20141113110722.GB4386@peff.net>
References: <20141113110325.GD8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Colin Smith <colin.webdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosFO-0000Kz-1o
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbaKMLH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:07:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:39828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932364AbaKMLHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:07:25 -0500
Received: (qmail 22816 invoked by uid 102); 13 Nov 2014 11:07:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 05:07:25 -0600
Received: (qmail 23130 invoked by uid 107); 13 Nov 2014 11:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 06:07:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 06:07:23 -0500
Content-Disposition: inline
In-Reply-To: <20141113110325.GD8329@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are parsing approxidate strings and we find three
numbers separate by one of ":/-.", we guess that it may be a
date. We feed the numbers to match_multi_number, which
checks whether it makes sense as a date in various orderings
(e.g., dd/mm/yy or mm/dd/yy, etc).

One of the checks we do is to see whether it is a date more
than 10 days in the future. This was added in 38035cf (date
parsing: be friendlier to our European friends.,
2006-04-05), and lets us guess that if it is currently April
2014, then "10/03/2014" is probably March 10th, not October
3rd.

This has a downside, though; if you want to be overly
generous with your "--until" date specification, we may
wrongly parse "2014-12-01" as "2014-01-12" (because the
latter is an in-the-past date). If the year is a future year
(i.e., both are future dates), it gets even weirder. Due to
the vagaries of approxidate, months _after_ the current date
(no matter the year) get flipped, but ones before do not.

This patch drops the "in the future" check for dates of this
form, letting us treat them always as yyyy-mm-dd, even if
they are in the future. This does not affect the normal
dd/mm/yyyy versus mm/dd/yyyy lookup, because this code path
only kicks in when the first number is greater than 70
(i.e., it must be a year, and cannot be either a date or a
month).

The one possible casualty is that "yyyy-dd-mm" is less
likely to be chosen over "yyyy-mm-dd". That's probably OK,
though because:

  1. The difference happens only when the date is in the
     future. Already we prefer yyyy-mm-dd for dates in the
     past.

  2. It's unclear whether anybody even uses yyyy-dd-mm
     regularly. It does not appear in lists of common date
     formats in Wikipedia[1,2].

  3. Even if (2) is wrong, it is better to prefer ISO-like
     dates, as that is consistent with what we use elsewhere
     in git.

[1] http://en.wikipedia.org/wiki/Date_and_time_representation_by_country
[2] http://en.wikipedia.org/wiki/Calendar_date

Reported-by: Colin Smith <colin.webdev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I did not single out "yyyy-mm-dd" here versus "yyyy/mm/dd"; the change
applies no matter which separator is used. If we wanted to be more
conservative, we could apply it only to the more ISO-looking form with
dashes, but I tend to think the reasoning makes sense no matter which
separate you use (i.e., I do not think any variant with year then day is
in common use).

 date.c          | 29 ++++++++++++++++-------------
 t/t0006-date.sh |  3 +++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/date.c b/date.c
index e1a4d49..b9eecfb 100644
--- a/date.c
+++ b/date.c
@@ -363,7 +363,8 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 	return skip_alpha(date);
 }
 
-static int is_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
+static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
+		   struct tm *tm, int allow_future)
 {
 	if (month > 0 && month < 13 && day > 0 && day < 32) {
 		struct tm check = *tm;
@@ -388,14 +389,16 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 		if (!now_tm)
 			return 1;
 
-		specified = tm_to_time_t(r);
+		if (!allow_future) {
+			specified = tm_to_time_t(r);
 
-		/* Be it commit time or author time, it does not make
-		 * sense to specify timestamp way into the future.  Make
-		 * sure it is not later than ten days from now...
-		 */
-		if ((specified != -1) && (now + 10*24*3600 < specified))
-			return 0;
+			/* Be it commit time or author time, it does not make
+			 * sense to specify timestamp way into the future.  Make
+			 * sure it is not later than ten days from now...
+			 */
+			if ((specified != -1) && (now + 10*24*3600 < specified))
+				return 0;
+		}
 		tm->tm_mon = r->tm_mon;
 		tm->tm_mday = r->tm_mday;
 		if (year != -1)
@@ -441,10 +444,10 @@ static int match_multi_number(unsigned long num, char c, const char *date,
 
 		if (num > 70) {
 			/* yyyy-mm-dd? */
-			if (is_date(num, num2, num3, refuse_future, now, tm))
+			if (is_date(num, num2, num3, refuse_future, now, tm, 1))
 				break;
 			/* yyyy-dd-mm? */
-			if (is_date(num, num3, num2, refuse_future, now, tm))
+			if (is_date(num, num3, num2, refuse_future, now, tm, 1))
 				break;
 		}
 		/* Our eastern European friends say dd.mm.yy[yy]
@@ -452,14 +455,14 @@ static int match_multi_number(unsigned long num, char c, const char *date,
 		 * mm/dd/yy[yy] form only when separator is not '.'
 		 */
 		if (c != '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    is_date(num3, num, num2, refuse_future, now, tm, 0))
 			break;
 		/* European dd.mm.yy[yy] or funny US dd/mm/yy[yy] */
-		if (is_date(num3, num2, num, refuse_future, now, tm))
+		if (is_date(num3, num2, num, refuse_future, now, tm, 0))
 			break;
 		/* Funny European mm.dd.yy */
 		if (c == '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    is_date(num3, num, num2, refuse_future, now, tm, 0))
 			break;
 		return 0;
 	}
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index e53cf6d..fac0986 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -82,4 +82,7 @@ check_approxidate 'Jun 6, 5AM' '2009-06-06 05:00:00'
 check_approxidate '5AM Jun 6' '2009-06-06 05:00:00'
 check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
 
+check_approxidate '2008-12-01' '2008-12-01 19:20:00'
+check_approxidate '2009-12-01' '2009-12-01 19:20:00'
+
 test_done
-- 
2.1.2.596.g7379948
