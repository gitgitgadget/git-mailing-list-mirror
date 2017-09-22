Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF419202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 05:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdIVFrw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 01:47:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:46664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751637AbdIVFrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 01:47:51 -0400
Received: (qmail 32226 invoked by uid 109); 22 Sep 2017 05:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 05:47:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1426 invoked by uid 111); 22 Sep 2017 05:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 01:48:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 01:47:48 -0400
Date:   Fri, 22 Sep 2017 01:47:48 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
Message-ID: <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
References: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 05:48:38PM +0100, Ramsay Jones wrote:

> diff --git a/cache.h b/cache.h
> index a916bc79e..a0e3e362c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1243,8 +1243,8 @@ static inline unsigned int hexval(unsigned char c)
>   */
>  static inline int hex2chr(const char *s)
>  {
> -	int val = hexval(s[0]);
> -	return (val < 0) ? val : (val << 4) | hexval(s[1]);
> +	unsigned int val = hexval(s[0]);
> +	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
>  }

Ironically, the unsigned return from hexval() comes from internally
converting the signed char in hexval_table. And then we again return it
as a signed int from hex2chr().

Would it make sense to return a signed int from hexval()? That would
make hex2chr just work as it tries to above. I admit that shifting
signed values is a little funny, but it should be fine here since we
know they're no larger than 8 bits in the first place.

As an aside, I also see some uses of hexval() that don't appear to be
quite as rigorous in checking for invalid characters. A few
unconditionally shift the first nibble and assume that there will still
be high bits set. I think that's generally true for twos-complement
negative numbers, but isn't shifting off the left side of a signed
integer undefined behavior?

And mailinfo's decode_q_segment() does not seem to check for errors at
all.

Handling those is getting far off your original patch, but I'm having
trouble figuring out if it's saner for us to consistently stick to
all-signed or all-unsigned here.

-Peff
