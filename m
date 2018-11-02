Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668791F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKBO3E (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:29:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:37642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727350AbeKBO3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:29:04 -0400
Received: (qmail 26583 invoked by uid 109); 2 Nov 2018 05:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 05:23:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 641 invoked by uid 111); 2 Nov 2018 05:22:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 01:22:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 01:23:09 -0400
Date:   Fri, 2 Nov 2018 01:23:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] approxidate: handle pending number for "specials"
Message-ID: <20181102052309.GB19234@sigill.intra.peff.net>
References: <20181102052239.GA19162@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102052239.GA19162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approxidate parser has a table of special keywords like
"yesterday", "noon", "pm", etc. Some of these, like "pm", do
the right thing if we've recently seen a number: "3pm" is
what you'd think.

However, most of them do not look at or modify the
pending-number flag at all, which means a number may "jump"
across a significant keyword and be used unexpectedly. For
example, when parsing:

  January 5th noon pm

we'd connect the "5" to "pm", and ignore it as a
day-of-month. This is obviously a bit silly, as "noon"
already implies "pm". And other mis-parsed things are
generally as silly ("January 5th noon, years ago" would
connect the 5 to "years", but probably nobody would type
that).

However, the fix is simple: when we see a keyword like
"noon", we should flush the pending number (as we would if
we hit another number, or the end of the string). In a few
of the specials that actually modify the day, we can simply
throw away the number (saying "Jan 5 yesterday" should not
respect the number at all).

Note that we have to either move or forward-declare the
static pending_number() to make it accessible to these
functions; this patch moves it.

Signed-off-by: Jeff King <peff@peff.net>
---
 date.c          | 60 +++++++++++++++++++++++++++----------------------
 t/t0006-date.sh |  1 +
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/date.c b/date.c
index 49f943e25b..7adce327a3 100644
--- a/date.c
+++ b/date.c
@@ -887,13 +887,42 @@ static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
 	return n;
 }
 
+/*
+ * Do we have a pending number at the end, or when
+ * we see a new one? Let's assume it's a month day,
+ * as in "Dec 6, 1992"
+ */
+static void pending_number(struct tm *tm, int *num)
+{
+	int number = *num;
+
+	if (number) {
+		*num = 0;
+		if (tm->tm_mday < 0 && number < 32)
+			tm->tm_mday = number;
+		else if (tm->tm_mon < 0 && number < 13)
+			tm->tm_mon = number-1;
+		else if (tm->tm_year < 0) {
+			if (number > 1969 && number < 2100)
+				tm->tm_year = number - 1900;
+			else if (number > 69 && number < 100)
+				tm->tm_year = number;
+			else if (number < 38)
+				tm->tm_year = 100 + number;
+			/* We screw up for number = 00 ? */
+		}
+	}
+}
+
 static void date_now(struct tm *tm, struct tm *now, int *num)
 {
+	*num = 0;
 	update_tm(tm, now, 0);
 }
 
 static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 {
+	*num = 0;
 	update_tm(tm, now, 24*60*60);
 }
 
@@ -908,16 +937,19 @@ static void date_time(struct tm *tm, struct tm *now, int hour)
 
 static void date_midnight(struct tm *tm, struct tm *now, int *num)
 {
+	pending_number(tm, num);
 	date_time(tm, now, 0);
 }
 
 static void date_noon(struct tm *tm, struct tm *now, int *num)
 {
+	pending_number(tm, num);
 	date_time(tm, now, 12);
 }
 
 static void date_tea(struct tm *tm, struct tm *now, int *num)
 {
+	pending_number(tm, num);
 	date_time(tm, now, 17);
 }
 
@@ -953,6 +985,7 @@ static void date_never(struct tm *tm, struct tm *now, int *num)
 {
 	time_t n = 0;
 	localtime_r(&n, tm);
+	*num = 0;
 }
 
 static const struct special {
@@ -1110,33 +1143,6 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 	return end;
 }
 
-/*
- * Do we have a pending number at the end, or when
- * we see a new one? Let's assume it's a month day,
- * as in "Dec 6, 1992"
- */
-static void pending_number(struct tm *tm, int *num)
-{
-	int number = *num;
-
-	if (number) {
-		*num = 0;
-		if (tm->tm_mday < 0 && number < 32)
-			tm->tm_mday = number;
-		else if (tm->tm_mon < 0 && number < 13)
-			tm->tm_mon = number-1;
-		else if (tm->tm_year < 0) {
-			if (number > 1969 && number < 2100)
-				tm->tm_year = number - 1900;
-			else if (number > 69 && number < 100)
-				tm->tm_year = number;
-			else if (number < 38)
-				tm->tm_year = 100 + number;
-			/* We screw up for number = 00 ? */
-		}
-	}
-}
-
 static timestamp_t approxidate_str(const char *date,
 				   const struct timeval *tv,
 				   int *error_ret)
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 64ff86df8e..b7ea5fbc36 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -113,6 +113,7 @@ check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
+check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.19.1.1336.g081079ac04

