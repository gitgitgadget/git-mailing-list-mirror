Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4379720133
	for <e@80x24.org>; Sun,  5 Mar 2017 11:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbdCELgX (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 06:36:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:38788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdCELgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 06:36:22 -0500
Received: (qmail 4108 invoked by uid 109); 5 Mar 2017 11:36:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 11:36:21 +0000
Received: (qmail 10845 invoked by uid 111); 5 Mar 2017 11:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 06:36:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Mar 2017 06:36:19 -0500
Date:   Sun, 5 Mar 2017 06:36:19 -0500
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
References: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 09:08:40PM +0100, Vegard Nossum wrote:

> > At a glance, looks like range_set_copy() is using
> > sizeof(struct range_set) == 12, but
> > range_set_init/range_set_grow/ALLOC_GROW/REALLOC_ARRAY is using
> > sizeof(rs->range) == 8.
> 
> Attached patch seems to fix it -- basically, range_set_copy() is trying
> to copy more than it should. It was uncovered with the test case from
> Allan's commit because it's creating enough ranges to overflow the
> initial allocation on 32-bit.

Ugh, yeah, that is definitely a bug.

> diff --git a/line-log.c b/line-log.c
> index 951029665..cb0dc1110 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -43,7 +43,7 @@ void range_set_release(struct range_set *rs)
>  static void range_set_copy(struct range_set *dst, struct range_set *src)
>  {
>  	range_set_init(dst, src->nr);
> -	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
> +	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range));

I think "sizeof(*dst->ranges)" is probably an even better fix, as it
infers the type of "dst". But these days we have COPY_ARRAY() to make it
even harder to get this kind of thing wrong.

I grepped for 'memcpy.*sizeof' and found one other case that's not a
bug, but is questionable.

Of the "good" cases, I think most of them could be converted into
something more obviously-correct, which would make auditing easier. The
three main cases I saw were:

  1. Ones which can probably be converted to COPY_ARRAY().

  2. Ones which just copy a single object, like:

       memcpy(&dst, &src, sizeof(dst));

     Perhaps we should be using struct assignment like:

       dst = src;

     here. It's safer and it should give the compiler more room to
     optimize. The only downside is that if you have pointers, it is
     easy to write "dst = src" when you meant "*dst = *src".

  3. There were a number of alloc-and-copy instances. The copy part is
     the same as (2) above, but you have to repeat the size, which is
     potentially error-prone. I wonder if we would want something like:

       #define ALLOC_COPY(dst, src) do { \
         (dst) = xmalloc(sizeof(*(dst))); \
	 COPY_ARRAY(dst, src, 1); \
       while(0)

     That avoids having to specify the size at all, and triggers a
     compile-time error if "src" and "dst" point to objects of different
     sizes.

     I suspect our friendly neighborhood coccinelle wizards could cook
     up a conversion.

-Peff
