Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFAEC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3196260F36
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhKBLiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:38:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:51312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhKBLiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 07:38:11 -0400
Received: (qmail 2423 invoked by uid 109); 2 Nov 2021 11:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 11:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4317 invoked by uid 111); 2 Nov 2021 11:35:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Nov 2021 07:35:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Nov 2021 07:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] strbuf_addftime(): handle "%s" manually
Message-ID: <YYEihoLbEGi44dDb@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
 <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g>
 <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
 <xmqq1r3zd9k5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r3zd9k5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 11:18:02AM -0700, Junio C Hamano wrote:

> > diff --git a/strbuf.c b/strbuf.c
> > index b22e981655..8b8b1900bc 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -1019,6 +1019,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> >  			strbuf_addstr(&munged_fmt, "%%");
> >  			fmt++;
> >  			break;
> > +		case 's':
> > +			strbuf_addf(&munged_fmt, "%"PRItime,
> > +				    tm_to_time_t(tm) -
> > +				    3600 * (tz_offset / 100) -
> > +				    60 * (tz_offset % 100));
> > +			fmt++;
> > +			break;
> 
> In show_date(), we start from UNIX time and go to "struct tm" using
> either the system gmtime_r() (after adjusting the value with the tz
> offset of the original timestamp) or localtime_r() (when we are
> trying to show the value in our local timestamp), but this codepath
> needs to undo that.  Our tm_to_time_t() indeed is basic but should
> work correctly on a broken down UTC.  So the caller needs to further
> compensate for the tz offset.

This made me wonder how things interact with format-local. There's some
subtlety, but I think all is well.

I hadn't planned to work further on this, but now having thought about
it some more, it seemed worth capturing that and putting the finishing
touches on a real commit.

-- >8 --
Subject: [PATCH] strbuf_addftime(): handle "%s" manually

The strftime() function has a non-standard "%s" extension, which prints
the number of seconds since the epoch. But the "struct tm" we get has
already been adjusted for a particular time zone; going back to an epoch
time requires knowing that zone offset. Since strftime() doesn't take
such an argument, round-tripping to a "struct tm" and back to the "%s"
format may produce the wrong value (off by tz_offset seconds).

Since we're already passing in the zone offset courtesy of c3fbf81a85
(strbuf: let strbuf_addftime handle %z and %Z itself, 2017-06-15), we
can use that same value to adjust our epoch seconds accordingly.

Note that the description above makes it sound like strftime()'s "%s" is
useless (and really, the issue is shared by mktime(), which is what
strftime() would use under the hood). But it gets the two cases for
which it's designed correct:

  - the result of gmtime() will have a zero offset, so no adjustment is
    necessary

  - the result of localtime() will be offset by the local zone offset,
    and mktime() and strftime() are defined to assume this offset when
    converting back (there's actually some magic here; some
    implementations record this in the "struct tm", but we can't
    portably access or manipulate it. But they somehow "know" whether a
    "struct tm" is from gmtime() or localtime()).

This latter point means that "format-local:%s" actually works correctly
already, because in that case we rely on the system routines due to
6eced3ec5e (date: use localtime() for "-local" time formats,
2017-06-15). Our problem comes when trying to show times in the author's
zone, as the system routines provide no mechanism for converting in
non-local zones. So in those cases we have a "struct tm" that came from
gmtime(), but has been manipulated according to our offset.

The tests cover the broken round-trip by formatting "%s" for a time in a
non-system timezone. We use the made-up "+1234" here, which has two
advantages. One, we know it won't ever be the real system zone (and so
we're actually testing a case that would break). And two, since it has a
minute component, we're testing the full decoding of the +HHMM zone into
a number of seconds. Likewise, we test the "-1234" variant to make sure
there aren't any sign mistakes.

There's one final test, which covers "format-local:%s". As noted, this
already passes, but it's important to check that we didn't regress this
case. In particular, the caller in show_date() is relying on localtime()
to have done the zone adjustment, independent of any tz_offset we
compute ourselves. These should match up, since our local_tzoffset() is
likewise built around localtime(). But it would be easy for a caller to
forget to pass in a correct tz_offset to strbuf_addftime(). Fortunately
show_date() does this correctly (it has to because of the existing
handling of %z), and the test continues to pass. So this one is just
future-proofing against a change in our assumptions.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h         |  1 +
 date.c          |  2 +-
 strbuf.c        | 14 +++++++++++++-
 t/t0006-date.sh |  4 ++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index eba12487b9..aa6f380d10 100644
--- a/cache.h
+++ b/cache.h
@@ -1588,6 +1588,7 @@ timestamp_t approxidate_careful(const char *, int *);
 timestamp_t approxidate_relative(const char *date);
 void parse_date_format(const char *format, struct date_mode *mode);
 int date_overflows(timestamp_t date);
+time_t tm_to_time_t(const struct tm *tm);
 
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
diff --git a/date.c b/date.c
index c55ea47e96..84bb4451c1 100644
--- a/date.c
+++ b/date.c
@@ -9,7 +9,7 @@
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
  */
-static time_t tm_to_time_t(const struct tm *tm)
+time_t tm_to_time_t(const struct tm *tm)
 {
 	static const int mdays[] = {
 	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
diff --git a/strbuf.c b/strbuf.c
index b22e981655..a569b99ab9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1006,7 +1006,12 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 
 	/*
 	 * There is no portable way to pass timezone information to
-	 * strftime, so we handle %z and %Z here.
+	 * strftime, so we handle %z and %Z here. Likewise '%s', because
+	 * going back to an epoch time requires knowing the zone.
+	 *
+	 * Note that tz_offset is in the "[-+]HHMM" decimal form; this is what
+	 * we want for %z, but the computation for %s has to convert to number
+	 * of seconds.
 	 */
 	for (;;) {
 		const char *percent = strchrnul(fmt, '%');
@@ -1019,6 +1024,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			strbuf_addstr(&munged_fmt, "%%");
 			fmt++;
 			break;
+		case 's':
+			strbuf_addf(&munged_fmt, "%"PRItime,
+				    tm_to_time_t(tm) -
+				    3600 * (tz_offset / 100) -
+				    60 * (tz_offset % 100));
+			fmt++;
+			break;
 		case 'z':
 			strbuf_addf(&munged_fmt, "%+05d", tz_offset);
 			fmt++;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 6b757d7169..794186961e 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -63,6 +63,10 @@ check_show 'format-local:%%z' "$TIME" '%z'
 check_show 'format:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 16:13:20'
 check_show 'format-local:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 09:13:20' '' EST5
 
+check_show 'format:%s' '123456789 +1234' 123456789
+check_show 'format:%s' '123456789 -1234' 123456789
+check_show 'format-local:%s' '123456789 -1234' 123456789
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
 check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-- 
2.34.0.rc0.612.g98bfd90890

