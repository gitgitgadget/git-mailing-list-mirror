Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611FE20401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdFONwT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:52:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdFONwT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:52:19 -0400
Received: (qmail 29907 invoked by uid 109); 15 Jun 2017 13:52:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:52:18 +0000
Received: (qmail 23272 invoked by uid 111); 15 Jun 2017 13:52:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:52:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:52:17 -0400
Date:   Thu, 15 Jun 2017 09:52:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] date: use localtime() for "-local" time formats
Message-ID: <20170615135216.2jfsrjpicku6zxv3@sigill.intra.peff.net>
References: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we convert seconds-since-epochs timestamps into a
broken-down "struct tm", we do so by adjusting the timestamp
according to the known offset and then using gmtime() to
break down the result. This means that the resulting struct
"knows" that it's in GMT, even though the time it represents
is adjusted for a different zone. The fields where it stores
this data are not portably accessible, so we have no way to
override them to tell them the real zone info.

For the most part, this works. Our date-formatting routines
don't pay attention to these inaccessible fields, and use
the same tz info we provided for adjustment. The one
exception is when we call strftime(), whose %Z format
reveals this hidden timezone data.

We solved that by always showing the empty string for %Z.
This is allowed by POSIX, but not very helpful to the user.
We can't make this work in the general case, as there's no
portable function for setting an arbitrary timezone (and
anyway, we don't have the zone name for the author zones,
only their offsets).

But for the special case of the "-local" formats, we can
just skip the adjustment and use localtime() instead of
gmtime(). This makes --date=format-local:%Z work correctly,
showing the local timezone instead of an empty string.

The new test checks the result for "UTC", our default
test-lib value for $TZ. Using something like EST5 might be
more interesting, but the actual zone string is
system-dependent (for instance, on my system it expands to
just EST). Hopefully "UTC" is vanilla enough that every
system treats it the same.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't have a Windows system to test this on, but from the output Dscho
provided earlier, I believe this should pass.

 date.c          | 14 ++++++++++++--
 t/t0006-date.sh |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 558057733..1fd6d6637 100644
--- a/date.c
+++ b/date.c
@@ -70,6 +70,12 @@ static struct tm *time_to_tm(timestamp_t time, int tz)
 	return gmtime(&t);
 }
 
+static struct tm *time_to_tm_local(timestamp_t time)
+{
+	time_t t = time;
+	return localtime(&t);
+}
+
 /*
  * What value of "tz" was in effect back then at "time" in the
  * local timezone?
@@ -214,7 +220,10 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
-	tm = time_to_tm(time, tz);
+	if (mode->local)
+		tm = time_to_tm_local(time);
+	else
+		tm = time_to_tm(time, tz);
 	if (!tm) {
 		tm = time_to_tm(0, 0);
 		tz = 0;
@@ -246,7 +255,8 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
-		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz, "");
+		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
+				mode->local ? NULL : "");
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 9f81bec7a..7ac9466d5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -56,6 +56,7 @@ check_show unix-local "$TIME" '1466000000'
 check_show 'format:%z' "$TIME" '+0200'
 check_show 'format-local:%z' "$TIME" '+0000'
 check_show 'format:%Z' "$TIME" ''
+check_show 'format-local:%Z' "$TIME" 'UTC'
 check_show 'format:%%z' "$TIME" '%z'
 check_show 'format-local:%%z' "$TIME" '%z'
 
-- 
2.13.1.766.g6bea926c5
