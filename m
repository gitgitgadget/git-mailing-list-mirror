Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25BD1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 09:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdFGJNM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 05:13:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdFGJNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 05:13:10 -0400
Received: (qmail 12176 invoked by uid 109); 7 Jun 2017 09:13:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 09:13:09 +0000
Received: (qmail 31627 invoked by uid 111); 7 Jun 2017 09:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 05:13:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jun 2017 05:13:08 -0400
Date:   Wed, 7 Jun 2017 05:13:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] date: use localtime() for "-local" time formats
Message-ID: <20170607091307.2vh2eevgaljxu7ha@sigill.intra.peff.net>
References: <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 07, 2017 at 04:17:29AM -0400, Jeff King wrote:

> > Duplicates strbuf_expand to a certain extent, but not too badly, I
> > think.  Leaves the door open for letting strftime handle the local
> > case.
> 
> I guess you'd plan to do that like this in the caller:
> 
>   if (date->local)
> 	tz_name = NULL;
>   else
> 	tz_name = "";
> 
> and then your strftime() doesn't do any %z expansion when tz_name is
> NULL.

And here's a patch that handles the local case.

-- >8 --
Subject: [PATCH] date: use localtime() for "-local" time formats

When we convert seconds-since-epochs timestamps into a
broken-down "struct tm", we do so by adjusting the timestamp
according to the correct timezone and then using gmtime() to
break down the result. This means that the resulting struct
"knows" that it's in GMT, even though the time it represents
is adjusted for a different zone. The fields where it stores
this data are not portably accessible, so we have no way to
override them to tell them the real zone info.

For the most part, this works. Our date-formatting routines
don't pay attention to these inaccessible fields, and use
the the same tz info we provided for adjustment. The one
exception is when we call strftime(), whose %z and %Z
formats reveal this hidden timezone data.

We can't make this work in the general case, as there's no
portable function for setting an arbitrary timezone. But for
the special case of the "-local" formats, we can just skip
the adjustment and use localtime() instead of gmtime(). This
makes --date=format-local:%Z work correctly, showing the
local timezone instead of an empty string.

This patch adds three tests:

  1. We check that format:%Z returns an empty string. This
     isn't what we'd want ideally, but it's important to
     confirm that it doesn't produce nonsense (like GMT when
     we are formatting another zone entirely).

  2. We check that format-local:%Z produces "UTC", which is
     the value of $TZ set by test-lib.sh.

  3. We check that format-local actually produces the
     correct time for zones other than UTC. If we made a
     mistake in the adjustment logic (say, applying the tz
     adjustment even though we are about to call
     localtime()), it wouldn't show up in the second test,
     because the offset for UTC is 0.

     We use the EST5 zone, which is already used elsewhere
     in the script, so is assumed to be available
     everywhere.

     However, this test _doesn't_ check %Z. That expansion
     produces an abbreviation which may not be portable
     across systems (on my system it expands as just "EST").
     Technically "UTC" could suffer from the same problem,
     but presumably it's universal enough to be relied upon.

Signed-off-by: Jeff King <peff@peff.net>
---
 date.c          | 14 ++++++++++++--
 t/t0006-date.sh | 20 ++++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

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
index 42d4ea61e..3be6692bb 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,9 +31,18 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_success $4 "show date ($format:$time)" '
+	prereqs=$4
+	zone=$5
+	test_expect_success $prereqs "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
-		test-date show:$format "$time" >actual &&
+		(
+			if test -n "$zone"
+			then
+				TZ=$zone
+				export $TZ
+			fi &&
+			test-date show:"$format" "$time" >actual
+		) &&
 		test_cmp expect actual
 	'
 }
@@ -51,6 +60,13 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 check_show raw-local "$TIME" '1466000000 +0000'
 check_show unix-local "$TIME" '1466000000'
 
+check_show "format:%Y-%m-%d %H:%M:%S %z (%Z)" "$TIME" \
+	   '2016-06-15 16:13:20 +0200 ()'
+check_show format-local:"%Y-%m-%d %H:%M:%S %z (%Z)" "$TIME" \
+	   '2016-06-15 14:13:20 +0000 (UTC)'
+check_show format-local:"%Y-%m-%d %H:%M:%S %z" "$TIME" \
+	   '2016-06-15 09:13:20 -0500' '' EST5
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
 check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-- 
2.13.1.664.g1b5a21ec3

