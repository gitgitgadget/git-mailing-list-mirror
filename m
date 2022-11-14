Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D1C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiKNWb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiKNWbV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:31:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A61193D5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:31:19 -0800 (PST)
Received: (qmail 15518 invoked by uid 109); 14 Nov 2022 22:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Nov 2022 22:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14608 invoked by uid 111); 14 Nov 2022 22:31:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Nov 2022 17:31:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Nov 2022 17:31:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 1/2] pack-bitmap.c: remove unnecessary
 "open_pack_index()" calls
Message-ID: <Y3LBtl+x2rCzsoIh@coredump.intra.peff.net>
References: <cover.1668063122.git.dyroneteng@gmail.com>
 <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
 <Y3K7TEpB8EzczjTb@coredump.intra.peff.net>
 <Y3K9zVx7L9K85NrE@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3K9zVx7L9K85NrE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 05:14:37PM -0500, Taylor Blau wrote:

> OK, so with 10K packs, we see about a 1.6-fold improvement, which is
> definitely substantial.
> 
> On a fresh clone of git.git, repeating your experiment with only 1K
> packs (which is definitely a number of packs that GitHub sees in
> under-maintained repositories), the runtime goes from 25.3ms -> 20.9ms
> on my machine, or about a 1.2-fold improvement.
> 
> So definitely smaller, but even at 1/10th the number of packs from your
> experiment, still noticeable.

Interesting. I had tried it initially with 1000 and the improvements were
much smaller. I just did it again, though, and got the same 20% speedup.
I'm not sure what I screwed up earlier (I may have been confused by the
timestamp/sorting issue; I only realized it was important midway through
looking into this).

> >   - this probably isn't helping anybody much in the real world, as
> >     evidenced by the contortions I had to go through to set up the
> >     situation (and which would be made much better by repacking, which
> >     would also speed up non-bitmap operations).
> 
> Per above, I'm not sure I totally agree ;-). 1K packs is definitely an
> extreme amount of packs, but not out-of-this-world. It probably would
> show up in carefully-picked graphs, but not in "overall git rev-list
> time" or something as broad/noisy as that.

Yeah, I agree that 1k is a lot more compelling. The big impractical
thing I think is that if the bitmapped pack is older (and it usually
is), then we'd often open all the other packs anyway:

  - if the start of the traversal is in the bitmapped pack, then we
    fruitlessly open each of the others looking for the object (since
    the bitmapped one will come last in the reverse-chronological
    sorting)

  - if it isn't in the bitmapped pack, then we'll end up opening all
    those other packs anyway to fill out the bitmap (since by definition
    it can't be included in the on-disk bitmaps)

So I'd be surprised if it ever mattered in the real world. Though again,
I think the new code is less surprising in general, and could matter if
we changed other things (e.g., if we prioritized lookups in a pack with
a .bitmap).

-Peff
