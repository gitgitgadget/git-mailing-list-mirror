Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5B11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeHMVng (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:43:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:53466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730043AbeHMVng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:43:36 -0400
Received: (qmail 11662 invoked by uid 109); 13 Aug 2018 19:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 19:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12474 invoked by uid 111); 13 Aug 2018 19:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 15:00:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 15:00:06 -0400
Date:   Mon, 13 Aug 2018 15:00:06 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
Message-ID: <20180813190005.GB10013@sigill.intra.peff.net>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org>
 <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
 <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 05:33:59AM +0200, Christian Couder wrote:

> >> +     memcpy(&sha_core, oid->hash, sizeof(uint64_t));
> >> +     rl->hash += sha_core;
> >
> > Hmm, so the first 64-bits of the oid of each ref that is part of
> > this island is added together as a 'hash' for the island. And this
> > is used to de-duplicate the islands? Any false positives? (does it
> > matter - it would only affect performance, not correctness, right?)
> 
> I would think that a false positive from pure chance is very unlikely.
> We would need to approach billions of delta islands (as 2 to the power
> 64/2 is in the order of billions) for the probability to be
> significant. GitHub has less than 50 millions users and it is very
> unlikely that a significant proportion of these users will fork the
> same repo.
> 
> Now if there is a false positive because two forks have exactly the
> same refs, then it is not a problem if they are considered the same,
> because they are actually the same.

Right, the idea is to find such same-ref setups to avoid spending a
pointless bit in the per-object bitmap. In the GitHub setup, it would be
an indication that two people forked at exactly the same time, so they
have the same refs and the same delta requirements. If one of them later
updates, that relationship would change at the next repack.

I don't know that we ever collected numbers for how often this happens.
So let me see if I can dig some up.

On our git/git repository network, it looks like we have ~14k forks, and
~4k are unique by this hashing scheme. So it really is saving us
10k-bits per bitmap. That's over 1k-byte per object in the worst case.
There are ~24M objects (many times what is in git.git, but people push
lots of random things to their forks), so that's saving us up to 24GB in
RAM. Of course it almost certainly isn't that helpful in practice, since
we copy-on-write the bitmaps to avoid the full cost per object. But I
think it's fair to say it is helping (more numbers below).

The distribution of buckets itself looks pretty power-law-ish from
eyeballing it. The biggest one has 92 forks, and then it trails off
quickly to smaller numbers, and then eventually a long tail of
singletons.

The numbers for torvalds/linux are similar. There are ~23k forks, only
~8k of which are unique. rails/rails has 12k/17k unique. So there's some
fluctuation, but the notion that there will be a bunch of identical
forks seems solid.

If you're curious what the actual memory usage is for a repack of
git/git, here are some rough numbers from eyeballing RSS via "top" while
watching the repack progress meter (I didn't want to do a full valgrind
run because it's S-L-O-W):

  - after loading the islands, we're at ~3GB RSS. Some of that is shared
    (the mmap'd packed-refs file is 1GB by itself), but probably 1-1.5GB
    is real heap, likely from the gigantic fork list.

  - we grow to around 6GB RSS before starting "counting objects". I
    think this is largely prepare_revision_walk(), since we're making
    "struct commit" objects for all the ref tips (and this is mmap-ing
    packfiles, too, which counts against our RSS)

  - by the time "counting objects" is done, we're at ~10GB. We're not
    yet running with Duy's memory-slimming for pack-objects, so it's
    100+ bytes per object_entry. Which means we're probably only
    spending a GB or so on island bitmaps, but at this point we've only
    marked commits and root-trees.

  - By the time "propagating island marks" is done, we'll have marked
    all the trees and blobs, and RSS is up to ~11GB.

So all in all (and I'd emphasize this is extremely rough) I think it
probably costs about 2GB for the feature in this particular case. But
you need much more to repack at this size sanely anyway.

If I were doing this patch series from scratch, I might implement the
fork de-duping and copy-on-write bits successively so I could take good
measurements of how much they help (and brag about it in the commit
messages). But I don't know if it's worth untangling now or not.

-Peff
