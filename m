Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766321F453
	for <e@80x24.org>; Tue, 29 Jan 2019 03:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfA2DuT (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 22:50:19 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:60791 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfA2DuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 22:50:19 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190129035018.OSYD4175.fed1rmfepo202.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 28 Jan 2019 22:50:18 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 206C2B819D3;
        Mon, 28 Jan 2019 20:50:17 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5C4FCD79.0057,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Tv9Sewfh c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=kviXuzpPAAAA:8 a=QSJ3QlV4PZC--piD8cAA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v4 4/5] Add `human` format to test-tool
Date:   Mon, 28 Jan 2019 20:50:15 -0700
Message-Id: <20190129035016.25981-5-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190129035016.25981-1-ischis2@cox.net>
References: <20190121053112.4736-1-ischis2@cox.net>
 <20190129035016.25981-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the human format support to the test tool so that
GIT_TEST_DATE_NOW can be used to specify the current time.

The get_time() helper function was created and and checks the
GIT_TEST_DATE_NOW environment variable.  If GIT_TEST_DATE_NOW is set,
then that date is used instead of the date returned by by
gettimeofday().

All calls to gettimeofday() were replaced by calls to get_time().

Renamed occurances of TEST_DATE_NOW to GIT_TEST_DATE_NOW since the
variable is now used in the get binary and not just in the test-tool.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 cache.h              |  2 ++
 date.c               | 21 +++++++++++++++++----
 t/helper/test-date.c | 13 ++++++++++++-
 t/t0006-date.sh      |  4 ++--
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 34c33e6a28..fe00ddf910 100644
--- a/cache.h
+++ b/cache.h
@@ -1467,6 +1467,8 @@ struct date_mode *date_mode_from_type(enum date_mode_type type);
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
+void show_date_human(timestamp_t time, int tz, const struct timeval *now,
+			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
 int parse_expiry_date(const char *date, timestamp_t *timestamp);
diff --git a/date.c b/date.c
index 43c3a84e25..e997664c1a 100644
--- a/date.c
+++ b/date.c
@@ -115,6 +115,19 @@ static int local_tzoffset(timestamp_t time)
 	return local_time_tzoffset((time_t)time, &tm);
 }
 
+static void get_time(struct timeval *now)
+{
+	const char *x;
+
+	x = getenv("GIT_TEST_DATE_NOW");
+	if (x) {
+		now->tv_sec = atoi(x);
+		now->tv_usec = 0;
+	}
+	else
+		gettimeofday(now, NULL);
+}
+
 void show_date_relative(timestamp_t time, int tz,
 			       const struct timeval *now,
 			       struct strbuf *timebuf)
@@ -228,7 +241,7 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
 	/* Show "today" times as just relative times */
 	if (hide.wday) {
 		struct timeval now;
-		gettimeofday(&now, NULL);
+		get_time(&now);
 		show_date_relative(time, tz, &now, buf);
 		return;
 	}
@@ -284,7 +297,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	if (mode->type == DATE_HUMAN) {
 		struct timeval now;
 
-		gettimeofday(&now, NULL);
+		get_time(&now);
 
 		/* Fill in the data for "current time" in human_tz and human_tm */
 		human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
@@ -303,7 +316,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		struct timeval now;
 
 		strbuf_reset(&timebuf);
-		gettimeofday(&now, NULL);
+		get_time(&now);
 		show_date_relative(time, tz, &now, &timebuf);
 		return timebuf.buf;
 	}
@@ -1296,7 +1309,7 @@ timestamp_t approxidate_careful(const char *date, int *error_ret)
 		return timestamp;
 	}
 
-	gettimeofday(&tv, NULL);
+	get_time(&tv);
 	return approxidate_str(date, &tv, error_ret);
 }
 
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a0837371ab..9b2ac772ee 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -3,6 +3,7 @@
 
 static const char *usage_msg = "\n"
 "  test-tool date relative [time_t]...\n"
+"  test-tool date human [time_t]...\n"
 "  test-tool date show:<format> [time_t]...\n"
 "  test-tool date parse [date]...\n"
 "  test-tool date approxidate [date]...\n"
@@ -22,6 +23,14 @@ static void show_relative_dates(const char **argv, struct timeval *now)
 	strbuf_release(&buf);
 }
 
+static void show_human_dates(const char **argv)
+{
+	for (; *argv; argv++) {
+		time_t t = atoi(*argv);
+		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(HUMAN)));
+	}
+}
+
 static void show_dates(const char **argv, const char *format)
 {
 	struct date_mode mode;
@@ -87,7 +96,7 @@ int cmd__date(int argc, const char **argv)
 	struct timeval now;
 	const char *x;
 
-	x = getenv("TEST_DATE_NOW");
+	x = getenv("GIT_TEST_DATE_NOW");
 	if (x) {
 		now.tv_sec = atoi(x);
 		now.tv_usec = 0;
@@ -100,6 +109,8 @@ int cmd__date(int argc, const char **argv)
 		usage(usage_msg);
 	if (!strcmp(*argv, "relative"))
 		show_relative_dates(argv+1, &now);
+	else if (!strcmp(*argv, "human"))
+		show_human_dates(argv+1);
 	else if (skip_prefix(*argv, "show:", &x))
 		show_dates(argv+1, x);
 	else if (!strcmp(*argv, "parse"))
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index ffb2975e48..90930c2aa7 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -4,10 +4,10 @@ test_description='test date parsing and printing'
 . ./test-lib.sh
 
 # arbitrary reference time: 2009-08-30 19:20:00
-TEST_DATE_NOW=1251660000; export TEST_DATE_NOW
+GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 
 check_relative() {
-	t=$(($TEST_DATE_NOW - $1))
+	t=$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
 	test-tool date relative $t >actual &&
-- 
2.20.1.2.gb21ebb671b

