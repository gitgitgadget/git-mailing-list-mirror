Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4901F576
	for <e@80x24.org>; Wed, 28 Feb 2018 10:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeB1KSA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 05:18:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:40418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752096AbeB1KR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 05:17:59 -0500
Received: (qmail 20701 invoked by uid 109); 28 Feb 2018 10:17:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 10:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 538 invoked by uid 111); 28 Feb 2018 10:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 05:18:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 05:17:57 -0500
Date:   Wed, 28 Feb 2018 05:17:57 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180228101757.GA11803@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228092722.GA25627@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 04:27:22PM +0700, Duy Nguyen wrote:

> linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
> consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
> all apps nearly unusuable (granted the problem is partly Linux I/O
> scheduler too). So I wonder if we can reduce pack-objects memory
> footprint a bit.

Yeah, the per object memory footprint is not great. Around 100 million
objects it becomes pretty ridiculous. I started to dig into it a year or
three ago when I saw such a case, but it turned out to be something that
we could prune. The torvalds/linux fork network has ~23 million objects,
so it's probably 7-8 GB of book-keeping. Which is gross, but 64GB in a
server isn't uncommon these days.

I think laptops repacking the kernel are probably one of the worst cases
(leaving aside the awful Windows repository, but my impression is that
they simply can't do a full repack at all there).

> This demonstration patch (probably breaks some tests) would reduce the
> size of struct object_entry from from 136 down to 112 bytes on
> x86-64. There are 6483999 of these objects, so the saving is 17% or
> 148 MB.

136 x 6.5M objects is only about 800MB. I suspect a big chunk of the
rest is going to the object structs we create when doing the internal
rev-list traversal. And those duplicate the 20-byte sha1s at the very
least.

I don't know if it would be a good idea to free them after the
traversal, though. We do use them again later in the bitmap case. On the
other hand, we could probably do so for the non-bitmap case. And even
for the bitmap case, the primary value in keeping them around is that
the parent pointers will already be cached. So it might make sense to
free the blobs and trees (though it might be tricky; the commits have
pointers to the trees).

It also doesn't help with peak memory usage, because you'll have the
full to_pack list and all of the "struct object" in memory together at
one point.

Another option would be to somehow replace the pack_idx_entry with a
reference to a "struct object". That would let us at least avoid storing
the 20-byte oid twice.

> If we go further, notice that nr_objects is uint32_t, we could convert
> the three pointers
> 
> 	struct object_entry *delta;
> 	struct object_entry *delta_child;
> 	struct object_entry *delta_sibling;
> 
> to
> 
> 	uint32_t delta;
> 	uint32_t delta_child;
> 	uint32_t delta_sibling;
> 
> which saves 12 bytes (or another 74 MB). 222 MB total is plenty of
> space to keep some file cache from being evicted.

Yeah, that seems like low-hanging fruit. I'd also note that we don't
actually use all of the fields during the whole process. I think some of
those delta fields are only used for a short time. So we might be able
to reduce peak memory if there are some mutually exclusive bits of each
entry (and even if there's some overlap, we'd reduce the length of time
we'd need to be at peak).

> Is it worth doing this? The struct packing makes it harder to read
> (and more fragile too). I added some more artifical limit like max
> depth of 2^11. But I think 4096+ depth is getting unreasonable.

I'm OK with a limit like 4096, as long as we notice when we hit the
limit and behave reasonably. I think the algorithm in
break_delta_chains() may temporarily store up to uint32_t depth. But I
think we won't ever write anything into cur->depth larger than the
max-depth limit. So it would probably be sufficient to just check that
the --depth argument is reasonably sized and complain otherwise.

I do agree this makes things a bit harder to read, but I think the
benefits are pretty measurable. And may make a real usability difference
on a large repository.

-Peff
