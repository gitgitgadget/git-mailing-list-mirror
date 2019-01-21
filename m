Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043921F453
	for <e@80x24.org>; Mon, 21 Jan 2019 07:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfAUHNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 02:13:10 -0500
Received: from fed1rmfepi102.cox.net ([68.230.241.133]:43375 "EHLO
        fed1rmfepi102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfAUHNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:08 -0500
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190121051647.TRLE4136.fed1rmfepo103.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:16:47 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 0E0B6B82571;
        Sun, 20 Jan 2019 22:16:47 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5C4555BF.0035,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Iouqj43g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10 a=Z4Rwk6OoAAAA:8 a=kviXuzpPAAAA:8
 a=4XSfByAG1AGq6XVSogIA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 1/5] Add 'human' date format
Date:   Sun, 20 Jan 2019 22:16:42 -0700
Message-Id: <20190121051646.20991-2-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190121051646.20991-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20190121051646.20991-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

This adds --date=human, which skips the timezone if it matches the
current time-zone, and doesn't print the whole date if that matches (ie
skip printing year for dates that are "this year", but also skip the
whole date itself if it's in the last few days and we can just say what
weekday it was).

For really recent dates (same day), use the relative date stamp, while
for old dates (year doesn't match), don't bother with time and timezone.

Also add 'auto' date mode, which defaults to human if we're using the
pager.  So you can do

	git config --add log.date auto

and your "git log" commands will show the human-legible format unless
you're scripting things.

Note that this time format still shows the timezone for recent enough
events (but not so recent that they show up as relative dates).  You can
combine it with the "-local" suffix to never show timezones for an even
more simplified view.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 builtin/blame.c |   4 ++
 cache.h         |   1 +
 date.c          | 130 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6d798f9939..f684e31d82 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -925,6 +925,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
+	case DATE_HUMAN:
+		/* If the year is shown, no time is shown */
+		blame_date_width = sizeof("Thu Oct 19 16:00");
+		break;
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
diff --git a/cache.h b/cache.h
index 49713cc5a5..34c33e6a28 100644
--- a/cache.h
+++ b/cache.h
@@ -1439,6 +1439,7 @@ extern struct object *peel_to_type(const char *name, int namelen,
 
 enum date_mode_type {
 	DATE_NORMAL = 0,
+	DATE_HUMAN,
 	DATE_RELATIVE,
 	DATE_SHORT,
 	DATE_ISO8601,
diff --git a/date.c b/date.c
index 9bc15df6f9..a8d50eb206 100644
--- a/date.c
+++ b/date.c
@@ -77,22 +77,16 @@ static struct tm *time_to_tm_local(timestamp_t time)
 }
 
 /*
- * What value of "tz" was in effect back then at "time" in the
- * local timezone?
+ * Fill in the localtime 'struct tm' for the supplied time,
+ * and return the local tz.
  */
-static int local_tzoffset(timestamp_t time)
+static int local_time_tzoffset(time_t t, struct tm *tm)
 {
-	time_t t, t_local;
-	struct tm tm;
+	time_t t_local;
 	int offset, eastwest;
 
-	if (date_overflows(time))
-		die("Timestamp too large for this system: %"PRItime, time);
-
-	t = (time_t)time;
-	localtime_r(&t, &tm);
-	t_local = tm_to_time_t(&tm);
-
+	localtime_r(&t, tm);
+	t_local = tm_to_time_t(tm);
 	if (t_local == -1)
 		return 0; /* error; just use +0000 */
 	if (t_local < t) {
@@ -107,6 +101,20 @@ static int local_tzoffset(timestamp_t time)
 	return offset * eastwest;
 }
 
+/*
+ * What value of "tz" was in effect back then at "time" in the
+ * local timezone?
+ */
+static int local_tzoffset(timestamp_t time)
+{
+	struct tm tm;
+
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
+	return local_time_tzoffset((time_t)time, &tm);
+}
+
 void show_date_relative(timestamp_t time, int tz,
 			       const struct timeval *now,
 			       struct strbuf *timebuf)
@@ -191,9 +199,80 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
+static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, struct tm *human_tm, int human_tz, int local)
+{
+	struct {
+		unsigned int	year:1,
+				date:1,
+				wday:1,
+				time:1,
+				seconds:1,
+				tz:1;
+	} hide = { 0 };
+
+	hide.tz = local || tz == human_tz;
+	hide.year = tm->tm_year == human_tm->tm_year;
+	if (hide.year) {
+		if (tm->tm_mon == human_tm->tm_mon) {
+			if (tm->tm_mday > human_tm->tm_mday) {
+				/* Future date: think timezones */
+			} else if (tm->tm_mday == human_tm->tm_mday) {
+				hide.date = hide.wday = 1;
+			} else if (tm->tm_mday + 5 > human_tm->tm_mday) {
+				/* Leave just weekday if it was a few days ago */
+				hide.date = 1;
+			}
+		}
+	}
+
+	/* Show "today" times as just relative times */
+	if (hide.wday) {
+		struct timeval now;
+		gettimeofday(&now, NULL);
+		show_date_relative(time, tz, &now, buf);
+		return;
+	}
+
+	/*
+	 * Always hide seconds for human-readable.
+	 * Hide timezone if showing date.
+	 * Hide weekday and time if showing year.
+	 *
+	 * The logic here is two-fold:
+	 *  (a) only show details when recent enough to matter
+	 *  (b) keep the maximum length "similar", and in check
+	 */
+	if (human_tm->tm_year) {
+		hide.seconds = 1;
+		hide.tz |= !hide.date;
+		hide.wday = hide.time = !hide.year;
+	}
+
+	if (!hide.wday)
+		strbuf_addf(buf, "%.3s ", weekday_names[tm->tm_wday]);
+	if (!hide.date)
+		strbuf_addf(buf, "%.3s %d ", month_names[tm->tm_mon], tm->tm_mday);
+
+	/* Do we want AM/PM depending on locale? */
+	if (!hide.time) {
+		strbuf_addf(buf, "%02d:%02d", tm->tm_hour, tm->tm_min);
+		if (!hide.seconds)
+			strbuf_addf(buf, ":%02d", tm->tm_sec);
+	} else
+		strbuf_rtrim(buf);
+
+	if (!hide.year)
+		strbuf_addf(buf, " %d", tm->tm_year + 1900);
+
+	if (!hide.tz)
+		strbuf_addf(buf, " %+05d", tz);
+}
+
 const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
+	struct tm human_tm = { 0 };
+	int human_tz = -1;
 	static struct strbuf timebuf = STRBUF_INIT;
 
 	if (mode->type == DATE_UNIX) {
@@ -202,6 +281,15 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
+	if (mode->type == DATE_HUMAN) {
+		struct timeval now;
+
+		gettimeofday(&now, NULL);
+
+		/* Fill in the data for "current time" in human_tz and human_tm */
+		human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
+	}
+
 	if (mode->local)
 		tz = local_tzoffset(time);
 
@@ -258,14 +346,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
 				!mode->local);
 	else
-		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
-				weekday_names[tm->tm_wday],
-				month_names[tm->tm_mon],
-				tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				tm->tm_year + 1900,
-				mode->local ? 0 : ' ',
-				tz);
+		show_date_normal(&timebuf, time, tm, tz, &human_tm, human_tz, mode->local);
 	return timebuf.buf;
 }
 
@@ -802,6 +883,11 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
+static int auto_date_style(void)
+{
+	return (isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
+}
+
 static enum date_mode_type parse_date_type(const char *format, const char **end)
 {
 	if (skip_prefix(format, "relative", end))
@@ -819,6 +905,10 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_SHORT;
 	if (skip_prefix(format, "default", end))
 		return DATE_NORMAL;
+	if (skip_prefix(format, "human", end))
+		return DATE_HUMAN;
+	if (skip_prefix(format, "auto", end))
+		return auto_date_style();
 	if (skip_prefix(format, "raw", end))
 		return DATE_RAW;
 	if (skip_prefix(format, "unix", end))
-- 
2.20.1.2.gb21ebb671b

