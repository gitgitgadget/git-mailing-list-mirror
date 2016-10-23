Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5099920229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbcJWJLt (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:11:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33133 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbcJWJLt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:11:49 -0400
Received: (qmail 9992 invoked by uid 109); 23 Oct 2016 09:11:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 09:11:48 +0000
Received: (qmail 17006 invoked by uid 111); 23 Oct 2016 09:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 05:12:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2016 05:11:46 -0400
Date:   Sun, 23 Oct 2016 05:11:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
Message-ID: <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 11:00:48AM +0200, René Scharfe wrote:

> Overflow is defined for unsigned integers, but not for signed ones.
> Make the ring buffer index in sha1_to_hex() unsigned to be on the
> safe side.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Hard to trigger, but probably even harder to diagnose once someone
> somehow manages to do it on some uncommon architecture.

Indeed. If we are worried about overflow, we would also want to assume
that it wraps at a multiple of 4, but that is probably a sane
assumption.

> diff --git a/hex.c b/hex.c
> index ab2610e..8c6c189 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -76,7 +76,7 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
>  
>  char *sha1_to_hex(const unsigned char *sha1)
>  {
> -	static int bufno;
> +	static unsigned int bufno;
>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>  	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>  }

I wonder if just truncating bufno would be conceptually simpler (albeit
longer):

  bufno++;
  bufno &= 3;
  return sha1_to_hex_r(hexbuffer[bufno], sha1);

You could also write the second line like:

  bufno %= ARRAY_SIZE(hexbuffer);

which is less magical (right now the set of buffers must be a power of
2). I expect the compiler could turn that into a bitmask itself.

I'm fine with any of the options. I guess you'd want a similar patch for
find_unique_abbrev on top of jk/no-looking-at-dotgit-outside-repo.

-Peff
