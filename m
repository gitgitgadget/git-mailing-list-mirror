Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE2D1FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbcIOBN7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 21:13:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:43509 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933401AbcIOBN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 21:13:58 -0400
Received: (qmail 27116 invoked by uid 109); 15 Sep 2016 01:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 01:13:58 +0000
Received: (qmail 5983 invoked by uid 111); 15 Sep 2016 01:14:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 21:14:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 18:13:54 -0700
Date:   Wed, 14 Sep 2016 18:13:54 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] obj_hash: convert to a critbit tree
Message-ID: <20160915011353.l5lx6ltcn2zegbnx@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
 <20160914235633.gofr534hvslkclzm@sigill.intra.peff.net>
 <CAGZ79kb4_k=+O6pzQkZBGHQty+kdYTnQX_3110RNt097AVn+Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb4_k=+O6pzQkZBGHQty+kdYTnQX_3110RNt097AVn+Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 05:52:06PM -0700, Stefan Beller wrote:

> > So finding "1011" involves traversing the trie: down the "1"
> > side, then the "0" side, and then check that the rest
> > matches "11".
> 
> So we stop building a tree as soon as we hit a unique data
> element (i.e. if we stick to the idea of encoding the hash along the way,
> we would have needed another node each for "11" as well as "00"
> that points to NULL and the ending data respectively.
> 
> So we stop short as soon as we have a unique.
> 
> That makes insertion very easy, because as soon as we hit
> a unique, we'd just introduce a node and add the two uniques
> left and right. (Well what happens if we were to insert
> 101010111 and 101010101 ? Both have a long prefix,
> I suppose we'd have 7 nodes and then the distiguishing
> node for those 2.)

I think it actually can represent the interior sequence as a single
node. That's what the "critical" part of critbit is for; the critical
bit is the one where we diverge. But I'm not 100% sure that it's
implemented that way.

In practice, though, sha1 would give us a pretty full tree near the
front, so I'd expect each bit to be "critical".

> > It's possible that (2) would be better if instead of a
> > critbit tree, we used a "critbyte" tree. That would involve
> > fewer node traversals, at the cost of making each node
> > larger (right now the internal nodes store 2 pointer slots;
> > they'd have to store 256 to handle a full byte). I didn't
> > try it, but I suspect it would still be slower for the same
> > reasons.
> 
> I would expect to go for a crit-"variable-length" tree instead.
> 
> The reason for this is that a higher fan out seems to be more
> beneficial in the earlier stages, e.g. we could use critbyte trees
> for the first 1-3 layers in the tree as that will have good memory
> efficiency (all 256 slots filled), but will be faster than the critbit trees
> (one lookup instead of 8 conditional jumps).

Yeah, I suspect a hybrid approach may be a better tradeoff. I encourage
you to try and measure. :)

> I guess when trying to improve the hashsets, someone tried trees
> as a collision resolver?

I don't think so. hashmap.c uses a linked list, but obj_hash just does
linear probing. Both are linear, but the latter is more memory efficient
and especially has a more compact cache footprint when resolving
collisions. The downside of open probing like that is that it's very
hard to delete an entry, but we don't care about that for obj_hash.

I don't think that improving collision resolution would help that much
for obj_hash, though. The fact that quadratic probing and cuckoo hashing
didn't yield big benefits implies that we don't spend most of our time
on collisions in the first place (OTOH, my 9a414486d9f0 that you found
does help _only_ when there are collisions, so maybe I'm wrong).

> So maybe we could have some software sided cache for hot entries?
> (I imagine a data structure consisting of 2 hash sets here, one
> hashset containing
> the complete data set, and the other hashset is a very small hashset with e.g.
> just 256(?) entries that are an LRU cache for the cache entries.
> Though this sounds like we'd be trying to outsmart the hardware... Not sure
> I'd expect gains from that)

Yeah. Basically what we want is the reverse of a bloom filter: it's OK
to be wrong, but it most be wrong to say "it's not here" when it is, not
the other way around. And so that's basically...a cache of a smaller
data-structure in front of the larger one.

But given that the hash table is already O(1)-ish, it's hard to beat
that (because remember when you have a cache miss, you then have to do
an extra lookup in the full table anyway).

I did play around with stuff like that when I was coming up with
9a414486d9f0, but was never able to make it faster. Patches welcome, of
course.

> I guess we rather want to split up the data sets on the application
> side: i.e. instead of
> having so many objects, have hash sets for e.g. blobs, trees, commits separately
> and then use slightly different strategies there (different load factors?)

My gut is that would not make a big difference (and sometimes it would
be worse, because we don't know what the object type is, or we want to
make _sure_ that we don't have the object known as a different type).

> Unrelated note about hashmaps:
> I wonder if we rather want to give good initial estimates of the size
> as one improvement

My recollection is that the growth isn't really relevant. At least for
obj_hash, we do _way_ more lookups than insertions, so the only thing
that really matters is lookup speed.

But as with everything, if you can come up with improved numbers, I'm
happy to look at the patches. :)

-Peff
