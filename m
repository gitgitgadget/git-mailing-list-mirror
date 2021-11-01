Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C8C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56BA600D4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 04:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhKAEGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 00:06:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhKAEGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 00:06:30 -0400
Received: (qmail 30408 invoked by uid 109); 1 Nov 2021 04:03:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Nov 2021 04:03:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15858 invoked by uid 111); 1 Nov 2021 04:03:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Nov 2021 00:03:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Nov 2021 00:03:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: timezone related bug of git
Message-ID: <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
 <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcznldobz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 31, 2021 at 11:46:40AM -0700, Junio C Hamano wrote:

> Dongsheng Song <dongsheng.song@gmail.com> writes:
> 
> > Thank you for the clarification, it's really a disappointing answer.
> 
> The situation may be disappointing, but I found the answer eminently
> clear and helpful.

The most disappointing thing IMHO is the lousy state of system-level
date routines. ;)

I have some patches working towards allowing timestamps before 1970, and
the system routines are quite unreliable (both in giving insufficient
portable interfaces, but also just doing weird things with negative
values).

> > Perhaps the manual needs to be clearer about this limitation.
> 
> Sounds like we have a volunteer ;-)?

Yeah, I'd be happy if somebody wanted to note this in the manual. But if
anybody wants to pursue manually intercepting %s, I think the patch
below might point them in the right direction.

I won't be at all surprised if it has funny corner cases. Our
tm_to_time_t() is pretty basic and hacky. We can't use mktime() because
it only handles the current system timezone. OTOH, I think the tz_offset
we're undoing here originally came from comparing mktime() versus
tm_to_time_t() via local_time_tzoffset(), so it could be cancelling out
any bugs exactly. :)

So maybe the code below is sufficient, but we'd probably at least want
some tests on top. Maybe something somebody interested would like to
pick up and run with?

---
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
index b22e981655..8b8b1900bc 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1019,6 +1019,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
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
