From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pass TIME_DATE_NOW to approxidate future-check
Date: Thu, 13 Nov 2014 06:04:52 -0500
Message-ID: <20141113110452.GA4386@peff.net>
References: <20141113110325.GD8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Colin Smith <colin.webdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:05:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosCz-0007NC-O5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbaKMLE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:04:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:39824 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932666AbaKMLEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:04:54 -0500
Received: (qmail 22723 invoked by uid 102); 13 Nov 2014 11:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 05:04:54 -0600
Received: (qmail 23082 invoked by uid 107); 13 Nov 2014 11:05:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 06:05:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 06:04:52 -0500
Content-Disposition: inline
In-Reply-To: <20141113110325.GD8329@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approxidate functions accept an extra "now" parameter to
avoid calling time() themselves. We use this in our test
suite to make sure we have a consistent time for computing
relative dates. However, deep in the bowels of approxidate,
we also call time() to check whether possible dates are far
in the future. Let's make sure that the "now" override makes
it to that spot, too, so we can consistently test that
feature.

Signed-off-by: Jeff King <peff@peff.net>
---
This code path also gets called from the more-strict parse_date (which
does not know about the current time). This continues to call time()
dynamically, but it is not clear to me if that ever actually matters in
practice.

 date.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/date.c b/date.c
index 59dfe57..e1a4d49 100644
--- a/date.c
+++ b/date.c
@@ -405,9 +405,9 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return 0;
 }
 
-static int match_multi_number(unsigned long num, char c, const char *date, char *end, struct tm *tm)
+static int match_multi_number(unsigned long num, char c, const char *date,
+			      char *end, struct tm *tm, time_t now)
 {
-	time_t now;
 	struct tm now_tm;
 	struct tm *refuse_future;
 	long num2, num3;
@@ -433,7 +433,8 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 	case '-':
 	case '/':
 	case '.':
-		now = time(NULL);
+		if (!now)
+			now = time(NULL);
 		refuse_future = NULL;
 		if (gmtime_r(&now, &now_tm))
 			refuse_future = &now_tm;
@@ -513,7 +514,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	case '/':
 	case '-':
 		if (isdigit(end[1])) {
-			int match = match_multi_number(num, *end, date, end, tm);
+			int match = match_multi_number(num, *end, date, end, tm, 0);
 			if (match)
 				return match;
 		}
@@ -1013,7 +1014,8 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	return end;
 }
 
-static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
+static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
+				     time_t now)
 {
 	char *end;
 	unsigned long number = strtoul(date, &end, 10);
@@ -1024,7 +1026,8 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	case '/':
 	case '-':
 		if (isdigit(end[1])) {
-			int match = match_multi_number(number, *end, date, end, tm);
+			int match = match_multi_number(number, *end, date, end,
+						       tm, now);
 			if (match)
 				return date + match;
 		}
@@ -1087,7 +1090,7 @@ static unsigned long approxidate_str(const char *date,
 		date++;
 		if (isdigit(c)) {
 			pending_number(&tm, &number);
-			date = approxidate_digit(date-1, &tm, &number);
+			date = approxidate_digit(date-1, &tm, &number, time_sec);
 			touched = 1;
 			continue;
 		}
-- 
2.1.2.596.g7379948
