Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6954E1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 01:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfIIByX (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 21:54:23 -0400
Received: from omta015.useast.a.cloudfilter.net ([34.195.253.206]:34343 "EHLO
        omta015.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732572AbfIIByW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 21:54:22 -0400
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.148])
        by cmsmtp with ESMTP
        id 6yT5iGOw4Le2C78luiC2xy; Mon, 09 Sep 2019 01:47:14 +0000
Received: from thunderbird.smith.home ([68.231.71.156])
        by cmsmtp with ESMTPSA
        id 78lriH3865o3c78ltitlKd; Mon, 09 Sep 2019 01:47:14 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.3 cv=X/Is11be c=1 sm=1 tr=0
 a=3BwGCz7hYCwPRAPwzRnSaA==:117 a=3BwGCz7hYCwPRAPwzRnSaA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=J70Eh1EUuV4A:10 a=kviXuzpPAAAA:8
 a=6Dg1UW8z-wIKkNVS6RkA:9 a=qrIFiuKZe2vaD64auk6j:22
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id AD85FB8286F
        for <git@vger.kernel.org>; Sun,  8 Sep 2019 18:47:11 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] Quit passing 'now' to date code
Date:   Sun,  8 Sep 2019 18:47:10 -0700
Message-Id: <20190909014711.3894-2-ischis2@cox.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909014711.3894-1-ischis2@cox.net>
References: <20190909014711.3894-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEelTFsE3+VZA+9r/KTvz1BY4OhqGiBQK+NYqDWU5P3rrV2GW6aPZiONzIf0WDDUbzGYbfzG9Q+cUNfGoDh7MSGoVEE36ERqbK1mQuMl2jh5enY4N5f1
 2DgYtTw65P2WfRT40gHWi/Rpmg8K3SqB/8tnH62haYdEA9r1/pEFeQEc3126XArsw90x2wFXVO3uow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of a previous patch set, the get_time() function was added to
date.c eliminating the need to pass a `now` parameter from the test
code.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 cache.h              |  5 ++---
 date.c               | 27 +++++++++++++--------------
 t/helper/test-date.c | 26 +++++++++-----------------
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/cache.h b/cache.h
index b1da1ab08f..48d4287aa7 100644
--- a/cache.h
+++ b/cache.h
@@ -1516,8 +1516,7 @@ struct date_mode {
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
-void show_date_relative(timestamp_t time, const struct timeval *now,
-			struct strbuf *timebuf);
+void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 void show_date_human(timestamp_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
@@ -1526,7 +1525,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp);
 void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 timestamp_t approxidate_careful(const char *, int *);
-timestamp_t approxidate_relative(const char *date, const struct timeval *now);
+timestamp_t approxidate_relative(const char *date);
 void parse_date_format(const char *format, struct date_mode *mode);
 int date_overflows(timestamp_t date);
 
diff --git a/date.c b/date.c
index 8126146c50..041db7db4e 100644
--- a/date.c
+++ b/date.c
@@ -128,16 +128,17 @@ static void get_time(struct timeval *now)
 		gettimeofday(now, NULL);
 }
 
-void show_date_relative(timestamp_t time,
-			const struct timeval *now,
-			struct strbuf *timebuf)
+void show_date_relative(timestamp_t time, struct strbuf *timebuf)
 {
+	struct timeval now;
 	timestamp_t diff;
-	if (now->tv_sec < time) {
+
+	get_time(&now);
+	if (now.tv_sec < time) {
 		strbuf_addstr(timebuf, _("in the future"));
 		return;
 	}
-	diff = now->tv_sec - time;
+	diff = now.tv_sec - time;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
 			 Q_("%"PRItime" second ago", "%"PRItime" seconds ago", diff), diff);
@@ -240,9 +241,7 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
 
 	/* Show "today" times as just relative times */
 	if (hide.wday) {
-		struct timeval now;
-		get_time(&now);
-		show_date_relative(time, &now, buf);
+		show_date_relative(time, buf);
 		return;
 	}
 
@@ -313,11 +312,8 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	}
 
 	if (mode->type == DATE_RELATIVE) {
-		struct timeval now;
-
 		strbuf_reset(&timebuf);
-		get_time(&now);
-		show_date_relative(time, &now, &timebuf);
+		show_date_relative(time, &timebuf);
 		return timebuf.buf;
 	}
 
@@ -1288,15 +1284,18 @@ static timestamp_t approxidate_str(const char *date,
 	return (timestamp_t)update_tm(&tm, &now, 0);
 }
 
-timestamp_t approxidate_relative(const char *date, const struct timeval *tv)
+timestamp_t approxidate_relative(const char *date)
 {
+	struct timeval tv;
 	timestamp_t timestamp;
 	int offset;
 	int errors = 0;
 
 	if (!parse_date_basic(date, &timestamp, &offset))
 		return timestamp;
-	return approxidate_str(date, tv, &errors);
+
+	get_time(&tv);
+	return approxidate_str(date, (const struct timeval *) &tv, &errors);
 }
 
 timestamp_t approxidate_careful(const char *date, int *error_ret)
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 585347ea48..deb5869343 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -12,13 +12,13 @@ static const char *usage_msg = "\n"
 "  test-tool date is64bit\n"
 "  test-tool date time_t-is64bit\n";
 
-static void show_relative_dates(const char **argv, struct timeval *now)
+static void show_relative_dates(const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 
 	for (; *argv; argv++) {
 		time_t t = atoi(*argv);
-		show_date_relative(t, now, &buf);
+		show_date_relative(t, &buf);
 		printf("%s -> %s\n", *argv, buf.buf);
 	}
 	strbuf_release(&buf);
@@ -74,20 +74,20 @@ static void parse_dates(const char **argv)
 	strbuf_release(&result);
 }
 
-static void parse_approxidate(const char **argv, struct timeval *now)
+static void parse_approxidate(const char **argv)
 {
 	for (; *argv; argv++) {
 		timestamp_t t;
-		t = approxidate_relative(*argv, now);
+		t = approxidate_relative(*argv);
 		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
 	}
 }
 
-static void parse_approx_timestamp(const char **argv, struct timeval *now)
+static void parse_approx_timestamp(const char **argv)
 {
 	for (; *argv; argv++) {
 		timestamp_t t;
-		t = approxidate_relative(*argv, now);
+		t = approxidate_relative(*argv);
 		printf("%s -> %"PRItime"\n", *argv, t);
 	}
 }
@@ -103,22 +103,14 @@ static void getnanos(const char **argv)
 
 int cmd__date(int argc, const char **argv)
 {
-	struct timeval now;
 	const char *x;
-
 	x = getenv("GIT_TEST_DATE_NOW");
-	if (x) {
-		now.tv_sec = atoi(x);
-		now.tv_usec = 0;
-	}
-	else
-		gettimeofday(&now, NULL);
 
 	argv++;
 	if (!*argv)
 		usage(usage_msg);
 	if (!strcmp(*argv, "relative"))
-		show_relative_dates(argv+1, &now);
+		show_relative_dates(argv+1);
 	else if (!strcmp(*argv, "human"))
 		show_human_dates(argv+1);
 	else if (skip_prefix(*argv, "show:", &x))
@@ -126,9 +118,9 @@ int cmd__date(int argc, const char **argv)
 	else if (!strcmp(*argv, "parse"))
 		parse_dates(argv+1);
 	else if (!strcmp(*argv, "approxidate"))
-		parse_approxidate(argv+1, &now);
+		parse_approxidate(argv+1);
 	else if (!strcmp(*argv, "timestamp"))
-		parse_approx_timestamp(argv+1, &now);
+		parse_approx_timestamp(argv+1);
 	else if (!strcmp(*argv, "getnanos"))
 		getnanos(argv+1);
 	else if (!strcmp(*argv, "is64bit"))
-- 
2.23.0

