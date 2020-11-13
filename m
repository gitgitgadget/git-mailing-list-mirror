Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B39C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D304120936
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 04:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKME5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 23:57:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:56882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKME5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 23:57:01 -0500
Received: (qmail 23710 invoked by uid 109); 13 Nov 2020 04:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 04:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6060 invoked by uid 111); 13 Nov 2020 04:57:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 23:57:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 23:57:00 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
Message-ID: <20201113045700.GA743619@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
 <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 06:47:09PM +0100, Martin Ågren wrote:

> > A .bitmap file may have a "name hash cache" extension, which puts a
> > sequence of uint32_t bytes (one per object) at the end of the file. When
> 
> s/bytes/values/, perhaps?

Yeah, definitely.

> > we see a flag indicating this extension, we blindly subtract the
> > appropriate number of bytes from our available length. However, if the
> > .bitmap file is too short, we'll underflow our length variable and wrap
> > around, thinking we have a very large length. This can lead to reading
> > out-of-bounds bytes while loading individual ewah bitmaps.
> 
> > +               uint32_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
> 
> Hmm. If `sizeof(size_t)` is 8, then this multiplication can't possibly
> overflow. A huge value of `num_objects` (say, 0xffffffff) would give a
> huge return value (0xffffffff<<2) which would be truncated (0xfffffffc).
> I think?

Yeah, `cache_size` should absolutely be a `size_t`. If you have more
than a billion objects, obviously your cache is going to be bigger than
that. But most importantly, somebody can _claim_ to have a huge number
of objects and foil the size checks by wrapping around.

> Do we want a `u32_mult()`?

Nah, we should be doing this as a size_t in the first place. There are
similar problems with the .idx format, btw. I have a series to deal with
that which I've been meaning to post.

> > +               unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
> 
> The addition should be ok or mmap has failed on us. Do we know that we
> have room for the final hash there so that the subtraction is ok? Yes,
> from the previous commit, we know we have room for the header, which is
> even larger. But that's cheating a bit -- see below.

Yeah, I agree this ought to be checking the minimum size against the
header _plus_ the trailer.

I think the previous patch is actually where it goes wrong. The original
was checking for a minimum of:

  if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)

which is the header plus the trailer. We want to readjust for the
MAX_RAWSZ part of the header, so it should be:

  size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
  if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)

> > +                       if (index->map + header_size + cache_size > index_end)
> > +                               return error("corrupted bitmap index file (too short to fit hash cache)");
> > +                       index->hashes = (void *)(index_end - cache_size);
> > +                       index_end -= cache_size;
> 
> If the header size we're adding is indeed too large, the addition in the
> check would be undefined behavior, if I'm not mistaken. In practical
> terms, with 32-bit pointers and a huge size, we'd wrap around, decide
> that everything is ok and go on to do the same erroneous subtraction as
> before.
> 
> Maybe shuffle a few things over from the left to the right to only make
> subtractions that we know are ok:
> 
>   if (cache_size > index_end - index->map - header_size)

Yes, I agree this should be done as a subtraction as you showed to avoid
integer overflow.

> But I don't think we can fully trust those subtractions. We're
> subtracting the size of two hashes (one in the header, one in the
> footer), but after the previous patch, we only know that there's room
> for one. So probably the previous patch could go
> 
>   +       /*
>   +        * Verify that we have room for the header and the
>   +        * trailing checksum hash, so we can safely subtract
>   +        * their sizes from map_size. We can afford to be
>   +        * a bit imprecise with the error message.
>   +        */
>   -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
>   +       if (index->map_size < header_size + the_hash_algo->rawsz)
> 
> I *think* I've got most of my comments here somewhat right, but I could
> easily have missed something.

Right. I think that's right, and the previous patch is just buggy.

-Peff
