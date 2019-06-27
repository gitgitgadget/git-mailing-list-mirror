Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E501F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfF0F5l (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:57:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:52012 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfF0F5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:57:41 -0400
Received: (qmail 7840 invoked by uid 109); 27 Jun 2019 05:57:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jun 2019 05:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4637 invoked by uid 111); 27 Jun 2019 05:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Jun 2019 01:58:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2019 01:57:39 -0400
Date:   Thu, 27 Jun 2019 01:57:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
Message-ID: <20190627055739.GA9322@sigill.intra.peff.net>
References: <20190627052515.GA21207@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190627052515.GA21207@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:25:15AM -0400, Jeff King wrote:

> Taylor and I noticed a slowdown in p1451 between v2.20.1 and v2.21.0. I
> was surprised to find that it bisects to bbb15c5193 (fsck: reduce word
> legos to help i18n, 2018-11-10).
> 
> The important part, as it turns out, is the switch to using fprintf_ln()
> instead of a regular fprintf() with a "\n" in it. Doing this:
> [...]
> on top of the current tip of master yields this result:
> 
>   Test                                             HEAD^             HEAD                  
>   -----------------------------------------------------------------------------------------
>   1451.3: fsck with 0 skipped bad commits          9.78(7.46+2.32)   8.74(7.38+1.36) -10.6%
>   1451.5: fsck with 1 skipped bad commits          9.78(7.66+2.11)   8.49(7.04+1.44) -13.2%
>   1451.7: fsck with 10 skipped bad commits         9.83(7.45+2.37)   8.53(7.26+1.24) -13.2%
>   1451.9: fsck with 100 skipped bad commits        9.87(7.47+2.40)   8.54(7.24+1.30) -13.5%
>   1451.11: fsck with 1000 skipped bad commits      9.79(7.67+2.12)   8.48(7.25+1.23) -13.4%
>   1451.13: fsck with 10000 skipped bad commits     9.86(7.58+2.26)   8.38(7.09+1.28) -15.0%
>   1451.15: fsck with 100000 skipped bad commits    9.58(7.39+2.19)   8.41(7.21+1.19) -12.2%
>   1451.17: fsck with 1000000 skipped bad commits   6.38(6.31+0.07)   6.35(6.26+0.07) -0.5% 

Ah, I think I see it.

See how the system times for HEAD^ (with fprintf_ln) are higher? We're
flushing stderr more frequently (twice as much, since it's unbuffered,
and we now have an fprintf followed by a putc).

I can get similar speedups by formatting into a buffer:

diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..07ce9b9178 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -880,8 +880,22 @@ int printf_ln(const char *fmt, ...)
 
 int fprintf_ln(FILE *fp, const char *fmt, ...)
 {
+	char buf[1024];
 	int ret;
 	va_list ap;
+
+	/* Fast path: format it ourselves and dump it via fwrite. */
+	va_start(ap, fmt);
+	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+	if (ret < sizeof(buf)) {
+		buf[ret++] = '\n';
+		if (fwrite(buf, 1, ret, fp) != ret)
+			return -1;
+		return ret;
+	}
+
+	/* Slow path: a normal fprintf/putc combo */
 	va_start(ap, fmt);
 	ret = vfprintf(fp, fmt, ap);
 	va_end(ap);

But we shouldn't have to resort to that. We can use setvbuf() to toggle
buffering back and forth, but I'm not sure if there's a way to query the
current buffering scheme for a stdio stream. We'd need that to be able
to switch back correctly (and to avoid switching for things that are
already buffered).

I suppose it would be enough to check for "fp == stderr", since that is
the only unbuffered thing we'd generally see.

And it may be that the code above is really not much different anyway.
For an unbuffered stream, I'd guess it dumps an fwrite() directly to
write() anyway (since by definition it does not need to hold onto it,
and nor is there anything in the buffer ahead of it).

Something like:

  char buf[1024];
  if (fp == stderr)
	setvbuf(stream, buf, _IOLBF, sizeof(buf));

  ... do fprintf and putc ...

  if (fp == stderr)
	setvbuf(stream, NULL, _IONBF, 0);

feels less horrible, but it's making the assumption that we were
unbuffered coming into the function. I dunno.

-Peff
