Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86D2207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbcI0FwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 01:52:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbcI0FwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:52:05 -0400
Received: (qmail 18542 invoked by uid 109); 27 Sep 2016 05:52:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 05:52:05 +0000
Received: (qmail 12079 invoked by uid 111); 27 Sep 2016 05:52:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 01:52:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 01:52:02 -0400
Date:   Tue, 27 Sep 2016 01:52:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: refactor code to decide fallback encoding
Message-ID: <20160927055202.4ucddki3xkns45om@sigill.intra.peff.net>
References: <20160927012211.9378-1-gitster@pobox.com>
 <20160927012211.9378-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160927012211.9378-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 06:22:10PM -0700, Junio C Hamano wrote:

> @@ -501,17 +516,9 @@ char *reencode_string_len(const char *in, int insz,
>  
>  	conv = iconv_open(out_encoding, in_encoding);
>  	if (conv == (iconv_t) -1) {
> -		/*
> -		 * Some platforms do not have the variously spelled variants of
> -		 * UTF-8, so let's fall back to trying the most official
> -		 * spelling. We do so only as a fallback in case the platform
> -		 * does understand the user's spelling, but not our official
> -		 * one.
> -		 */
> -		if (is_encoding_utf8(in_encoding))
> -			in_encoding = "UTF-8";
> -		if (is_encoding_utf8(out_encoding))
> -			out_encoding = "UTF-8";
> +		in_encoding = fallback_encoding(in_encoding);
> +		out_encoding = fallback_encoding(out_encoding);
> +

This comment is interesting. We're concerned about a platform knowing
"utf8" but not "UTF-8". When we fallback, we do it for both the input
and output encodings, because we don't know which may have caused the
problem. So is it possible that we improve one case but break the other?

With just UTF-8, I don't think so. That could only be the case with
something like "utf8 -> utf-8" because they both become "UTF-8". So
either it improves the situation or not (because we either understand
UTF-8 or not).

But once we introduce other fallbacks, then "utf8 -> latin1" may become
"UTF-8 -> iso8859-1". A system that knows only "utf8" and "iso8859-1"
_could_ work if we turned the knobs individually, but won't if we turn
them both at once. Worse, a system that knows only "UTF-8" and "latin1"
works now, but would break with your patches.

I'm not convinced it's worth worrying about, though. The existence of
such a system is theoretical at this point. I'm not even sure how common
the "know about utf8 but not UTF-8" thing is, or if we were merely being
overly cautious.

-Peff
