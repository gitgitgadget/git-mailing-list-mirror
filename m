Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBEF203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbcGVTvy (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:51:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:48828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbcGVTvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:51:52 -0400
Received: (qmail 22252 invoked by uid 102); 22 Jul 2016 19:51:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:51:52 -0400
Received: (qmail 9330 invoked by uid 107); 22 Jul 2016 19:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:52:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 15:51:49 -0400
Date:	Fri, 22 Jul 2016 15:51:49 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] date: add "unix" format
Message-ID: <20160722195149.GF19648@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722195105.GA19542@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We already have "--date=raw", which is a Unix epoch
timestamp plus a contextual timezone (either the author's or
the local). But one may not care about the timezone and just
want the epoch timestamp by itself. It's not hard to parse
the two apart, but if you are using a pretty-print format,
you may want git to show the "finished" form that the user
will see.

We can accomodate this by adding a new date format, "unix",
which is basically "raw" without the timezone.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 4 ++++
 builtin/blame.c                    | 3 +++
 cache.h                            | 3 ++-
 date.c                             | 8 ++++++++
 t/t0006-date.sh                    | 2 ++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3ec75d4..8b1c946 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -751,6 +751,10 @@ format. Note that the `-local` option does not affect the
 seconds-since-epoch value (which is always measured in UTC), but does
 switch the accompanying timezone value.
 +
+`--date=unix` shows the date as a Unix epoch timestamp (seconds since
+1970).  As with `--raw`, this is always in UTC and therefore `-local`
+has no effect.
++
 `--date=format:...` feeds the format `...` to your system `strftime`.
 Use `--date=format:%c` to show the date in your system locale's
 preferred format.  See the `strftime` manual for a complete list of
diff --git a/builtin/blame.c b/builtin/blame.c
index 8fec0e1..cb08127 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2625,6 +2625,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	case DATE_RAW:
 		blame_date_width = sizeof("1161298804 -0700");
 		break;
+	case DATE_UNIX:
+		blame_date_width = sizeof("1161298804");
+		break;
 	case DATE_SHORT:
 		blame_date_width = sizeof("2006-10-19");
 		break;
diff --git a/cache.h b/cache.h
index 2bf97cc..dd587b2 100644
--- a/cache.h
+++ b/cache.h
@@ -1224,7 +1224,8 @@ struct date_mode {
 		DATE_ISO8601_STRICT,
 		DATE_RFC2822,
 		DATE_STRFTIME,
-		DATE_RAW
+		DATE_RAW,
+		DATE_UNIX
 	} type;
 	const char *strftime_fmt;
 	int local;
diff --git a/date.c b/date.c
index 4c7aa9b..a996331 100644
--- a/date.c
+++ b/date.c
@@ -177,6 +177,12 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
 
+	if (mode->type == DATE_UNIX) {
+		strbuf_reset(&timebuf);
+		strbuf_addf(&timebuf, "%lu", time);
+		return timebuf.buf;
+	}
+
 	if (mode->local)
 		tz = local_tzoffset(time);
 
@@ -792,6 +798,8 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_NORMAL;
 	if (skip_prefix(format, "raw", end))
 		return DATE_RAW;
+	if (skip_prefix(format, "unix", end))
+		return DATE_UNIX;
 	if (skip_prefix(format, "format", end))
 		return DATE_STRFTIME;
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 482fec0..c0c9108 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -46,8 +46,10 @@ check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
 check_show short "$TIME" '2016-06-15'
 check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
+check_show unix "$TIME" '1466000000'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 check_show raw-local "$TIME" '1466000000 +0000'
+check_show unix-local "$TIME" '1466000000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-- 
2.9.2.512.gc1ef750
