Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76345C77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjEEVXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEEVXY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:23:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE341A8
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:23:23 -0700 (PDT)
Received: (qmail 4694 invoked by uid 109); 5 May 2023 21:23:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 21:23:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4323 invoked by uid 111); 5 May 2023 21:23:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 17:23:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 17:23:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230505212322.GA3321533@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLQfMtIGcZHNERE@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFLQfMtIGcZHNERE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 05:22:04PM -0400, Taylor Blau wrote:

> > OK, I understand the use case you're trying to support, and your
> > approach mostly makes sense. But there are two things I was surprised by
> > in the implementation:
> >
> >   1. Does this need to be tied to cruft packs? The same logic would
> >      apply to "repack -A" which turns objects loose (of course you
> >      probably don't want to do that in the long term for performance
> >      reasons, but it's conceptually the same thing; see below).
> >
> >   2. Why is there a separate walk distinct from the one that rescues
> >      recent-but-unreachable objects?
> 
> > Conceptually it seems to me that the simplest and most flexible way to
> > think of this new feature is: pretend these objects are recent enough to
> > be kept in the grace period, even though their mtimes do not qualify".
> >
> > And then everything else would just fall out naturally. Am I missing
> > something?
> 
> I originally shied away from it, thinking that I wouldn't want to do an
> expensive walk with all of the recent objects during a non-pruning
> repack.
>
> The two code paths are quite different in practice. In the pruning case,
> we add only new objects from the kept packs and then start our traversal
> there. In the non-pruning case, we just do
> `add_objects_in_unpacked_packs()` which is really just a call to
> `for_each_packed_object()`.

Right, that's what I'd expect. I think you are describing a cruft-pack
world here (because you say "kept packs"), but the traditional "repack
-k" versus "repack -A" is similar (if we are not doing something special
with recent objects, then there is no need to figure out what they
reach; we can just add them all).

> So it gets tricky when you have a pack.extraCruftTips program and want
> to invoke it in a non-pruning case. You could do something like:
> 
>   - call enumerate_and_traverse_cruft_objects() *always*, either because
>     we were doing a pruning GC, or calling it after
>     `enumerate_cruft_objects()` (in the non-pruning case)
> 
>   - ensure that enumerate_and_traverse_cruft_objects() is a noop when
>     (a) cruft_expiration is set to zero, and (b) there are no
>     pack.extraCruftTips programs specified

I'm not sure why you'd need to traverse, though. If we are in "-k" mode,
we are keeping everything anyway (so I don't even see the point of
asking the helper about extra tips). And all of those objects that are
not reachable from the regular traversal are by definition "cruft" and
go into the cruft pack.

Maybe I don't understand what you mean by "non-pruning" here.

-Peff
