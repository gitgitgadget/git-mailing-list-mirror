Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9720E207DF
	for <e@80x24.org>; Thu, 15 Sep 2016 06:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbcIOGrH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 02:47:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756934AbcIOGrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 02:47:06 -0400
Received: (qmail 13936 invoked by uid 109); 15 Sep 2016 06:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 06:47:05 +0000
Received: (qmail 7067 invoked by uid 111); 15 Sep 2016 06:47:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 02:47:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 23:47:02 -0700
Date:   Wed, 14 Sep 2016 23:47:02 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
Message-ID: <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
References: <20160915020141.32000-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160915020141.32000-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 07:01:41PM -0700, Stefan Beller wrote:

>  According to Jeff, sending patches that don't get accepted is the new hype!

It is what all the cool kids are doing. Unfortunately, it does not save
you from nitpicky reviews...;)

>  	first = i = hash_obj(sha1, obj_hash_size);
> +	clock_gettime(CLOCK_MONOTONIC, &time1);
>  	while ((obj = obj_hash[i]) != NULL) {
>  		if (!hashcmp(sha1, obj->oid.hash))
>  			break;
> @@ -98,6 +131,9 @@ struct object *lookup_object(const unsigned char *sha1)
>  		if (i == obj_hash_size)
>  			i = 0;
>  	}
> +	clock_gettime(CLOCK_MONOTONIC, &time2);
> +	diff(&time1, &time2, &t_diff);
> +	add_time_to(&caching, &t_diff);
>  	if (obj && i != first) {

I don't think this is actually measuring the time spent on collisions.
It's measuring the time we spend in hashcmp(), but that includes the
non-collision case where we find it in the first hashcmp.

Measuring _just_ the collisions is more like the patch below. In my
measurements it's more like 30ms, compared to 10s for all of the
hashcmps.

So we really aren't dealing with collisions, but rather just verifying
that our hash landed at the right spot. And _any_ data structure is
going to have to do that. If you want to make it faster, I'd try
optimizing hashcmp (and you can see why the critbit tree was slower; if
we spend so much time just on hashcmp() to make sure we're at the right
key, then making that slower with a bunch of branching is not going to
help).

I notice we still open-code hashcmp. I get a slight speedup by switching
it to memcmp(). About 2.5%, which is similar to what I showed in

  http://public-inbox.org/git/20130318073229.GA5551@sigill.intra.peff.net/

a few years ago (though it's more pronounced as a portion of the whole
now, because we've optimized some of the other bits).

The main driver there was memcmp() improvements that went into glibc
2.13 several years ago. It might be time to start assuming that memcmp()
beats our open-coded loop.

It may also be possible to really micro-optimize it on some platforms,
because we know the size in advance (I'd kind of expect the compiler to
do that, but if we're ending up in glibc memcmp then it sounds like it
is not the case).

-Peff
