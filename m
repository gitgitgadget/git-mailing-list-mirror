Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133A11F576
	for <e@80x24.org>; Wed, 28 Feb 2018 11:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeB1LLY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 06:11:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751899AbeB1LLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 06:11:23 -0500
Received: (qmail 24225 invoked by uid 109); 28 Feb 2018 11:11:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 11:11:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1041 invoked by uid 111); 28 Feb 2018 11:12:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 06:12:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 06:11:21 -0500
Date:   Wed, 28 Feb 2018 06:11:21 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180228111121.GA8925@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
 <20180228101757.GA11803@sigill.intra.peff.net>
 <CACsJy8Bg_oNj7mJ2PE5AWQ2awf434R9fHXQq-OxA3_0wJN16vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bg_oNj7mJ2PE5AWQ2awf434R9fHXQq-OxA3_0wJN16vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 05:58:50PM +0700, Duy Nguyen wrote:

> > Yeah, the per object memory footprint is not great. Around 100 million
> > objects it becomes pretty ridiculous. I started to dig into it a year or
> > three ago when I saw such a case, but it turned out to be something that
> > we could prune.
> 
> We could? What could we prune?

Sorry, I just meant that my 100 million-object case turned out not to
need all those objects, and I was able to prune it down. No code fixes
came out of it. ;)

> > The torvalds/linux fork network has ~23 million objects,
> > so it's probably 7-8 GB of book-keeping. Which is gross, but 64GB in a
> > server isn't uncommon these days.
> 
> I wonder if we could just do book keeping for some but not all objects
> because all objects simply do not scale. Say we have a big pack of
> many GBs, could we keep the 80% of its bottom untouched, register the
> top 20% (mostly non-blobs, and some more blobs as delta base) for
> repack? We copy the bottom part to the new pack byte-by-byte, then
> pack-objects rebuilds the top part with objects from other sources.

Yes, though I think it would take a fair bit of surgery to do
internally. And some features (like bitmap generation) just wouldn't
work at all.

I suspect you could simulate it, though, by just packing your subset
with pack-objects (feeding it directly without using "--revs") and then
catting the resulting packfiles together with a fixed-up header.

At one point I played with a "fast pack" that would just cat packfiles
together. My goal was to make cases with 10,000 packs workable by
creating one lousy pack, and then repacking that lousy pack with a
"real" repack. In the end I abandoned it in favor of fixing the
performance problems from trying to make a real pack of 10,000 packs. :)

But I might be able to dig it up if you want to experiment in that
direction.

> They are 32 bytes per entry, so it should take less than object_entry.
> I briefly wondered if we should fall back to external rev-list too,
> just to free that memory.
> 
> So about 200 MB for those objects (or maybe more for commits). Add 256
> MB delta cache on top, it's still a bit far from 1.7G. There's
> something I'm still missing.

Are you looking at RSS or heap? Keep in mind that you're mmap-ing what's
probably a 1GB packfile on disk. If you're under memory pressure that
won't all stay resident, but some of it will be counted in RSS.

> Pity we can't do the same for 'struct object'. Most of the time we
> have a giant .idx file with most hashes. We could look up in both
> places: the hash table in object.c, and the idx file, to find an
> object. Then those objects that are associated with .idx file will not
> need "oid" field (needed to as key for the hash table). But I see no
> way to make that change.

Yeah, that would be pretty invasive, I think. I also wonder if it would
perform worse due to cache effects.

-Peff
