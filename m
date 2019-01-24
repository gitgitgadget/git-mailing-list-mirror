Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A591F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAXNMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:12:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:47202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727798AbfAXNMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:23 -0500
Received: (qmail 27481 invoked by uid 109); 24 Jan 2019 13:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:12:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28297 invoked by uid 111); 24 Jan 2019 13:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:12:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:12:21 -0500
Date:   Thu, 24 Jan 2019 08:12:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/8] show_date_relative(): drop unused "tz" parameter
Message-ID: <20190124131221.GE22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The timestamp we receive is in epoch time, so there's no need for a
timezone parameter to interpret it. The matching show_date() uses "tz"
to show dates in author local time, but relative dates show only the
absolute time difference. The author's location is irrelevant, barring
relativistic effects from using Git close to the speed of light.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h              | 2 +-
 date.c               | 8 ++++----
 t/helper/test-date.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 49713cc5a5..8d97939c0d 100644
--- a/cache.h
+++ b/cache.h
@@ -1464,7 +1464,7 @@ struct date_mode {
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
-void show_date_relative(timestamp_t time, int tz, const struct timeval *now,
+void show_date_relative(timestamp_t time, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
diff --git a/date.c b/date.c
index 9bc15df6f9..61449f8b2e 100644
--- a/date.c
+++ b/date.c
@@ -107,9 +107,9 @@ static int local_tzoffset(timestamp_t time)
 	return offset * eastwest;
 }
 
-void show_date_relative(timestamp_t time, int tz,
-			       const struct timeval *now,
-			       struct strbuf *timebuf)
+void show_date_relative(timestamp_t time,
+			const struct timeval *now,
+			struct strbuf *timebuf)
 {
 	timestamp_t diff;
 	if (now->tv_sec < time) {
@@ -216,7 +216,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 
 		strbuf_reset(&timebuf);
 		gettimeofday(&now, NULL);
-		show_date_relative(time, tz, &now, &timebuf);
+		show_date_relative(time, &now, &timebuf);
 		return timebuf.buf;
 	}
 
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a0837371ab..aac4d542c2 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -16,7 +16,7 @@ static void show_relative_dates(const char **argv, struct timeval *now)
 
 	for (; *argv; argv++) {
 		time_t t = atoi(*argv);
-		show_date_relative(t, 0, now, &buf);
+		show_date_relative(t, now, &buf);
 		printf("%s -> %s\n", *argv, buf.buf);
 	}
 	strbuf_release(&buf);
-- 
2.20.1.842.g8986705066

