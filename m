Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B311C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DF064E4B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhBQSSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:18:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhBQSR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:17:58 -0500
Received: (qmail 19369 invoked by uid 109); 17 Feb 2021 18:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 18:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6806 invoked by uid 111); 17 Feb 2021 18:17:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 13:17:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 13:17:16 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 8/8] builtin/repack.c: add '--geometric' option
Message-ID: <YC1drGrIEg0C7Zo5@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <d5561585c2221a9635eb0fc7a65298ee8a2b6348.1612411124.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5561585c2221a9635eb0fc7a65298ee8a2b6348.1612411124.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:59:25PM -0500, Taylor Blau wrote:

> Often it is useful to both:
> 
>   - have relatively few packfiles in a repository, and
> 
>   - avoid having so few packfiles in a repository that we repack its
>     entire contents regularly
> 
> This patch implements a '--geometric=<n>' option in 'git repack'. This
> allows the caller to specify that they would like each pack to be at
> least a factor times as large as the previous largest pack (by object
> count).
> 
> Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
> ..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
> With a geometric factor of 'r', it should be that:
> 
>   objects(Pi) > r*objects(P(i-1))
> 
> for all i in [1, n], where the packs are sorted by
> 
>   objects(P1) <= objects(P2) <= ... <= objects(Pn).

Just devil's advocating for a moment.

I think in this kind of geometric roll-up strategy, you want to imagine
that you are rolling up recent pushes but leaving untouched a good
"base" pack that you previously created.

And that will usually be true if you are doing the rollup based on
number of objects (or size, etc). But it won't always be (e.g., for some
reason somebody makes a very large push relative to the current
repository size). What happens when this assumption is violated?

In some ways, it is a good thing to drift away from this "base pack"
view of the world. If we're trying to amortize the per-object work done,
then we are better off rolling up the small things into the large,
regardless of where they came from.

But the base pack may also have other properties we want to retain. Two
I can think of:

  - it may have a .bitmap that we'll be throwing away, without
    generating a new one. I know that your end-game involves writing a
    midx with bitmaps that covers all of the packs, so this would become
    a non-issue in that strategy.

  - it may have been more carefully packed (e.g., with a larger window
    size, using "-f", etc) than the packs we got from pushes. We do
    _mostly_ retain the deltas when we roll up the packs, so it probably
    only has a small impact in practice (I'd expect in a few cases we'd
    throw away deltas because a pushed pack contains a duplicate of its
    base object that we added via --fix-thin).

So I suspect it's probably OK in practice. These cases would happen
rarely, and the impact would not be all that big. The bitmap thing I'd
worry the most about. As part of a larger strategy involving a midx it
is taken care of, but people using just this new feature may not realize
that. The bitmaps of course are "just" an optimization, but it's hard to
say how dire things are when they don't exist. For many situations,
probably not very dire. But I know that on our servers, when repos lack
bitmaps, people notice the performance degradation.

On the other hand, by definition this happens in a case where there are
more objects that have just been pushed (and are therefore not
bitmapped) than existed already. So you _already_ have a performance
problem either way until you get bitmap coverage of those new objects.

> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -165,6 +165,17 @@ depth is 4095.
>  	Pass the `--delta-islands` option to `git-pack-objects`, see
>  	linkgit:git-pack-objects[1].
>  
> +-g=<factor>::
> +--geometric=<factor>::
> +	Arrange resulting pack structure so that each successive pack
> +	contains at least `<factor>` times the number of objects as the
> +	next-largest pack.
> ++
> +`git repack` ensures this by determining a "cut" of packfiles that need to be
> +repacked into one in order to ensure a geometric progression. It picks the
> +smallest set of packfiles such that as many of the larger packfiles (by count of
> +objects contained in that pack) may be left intact.

I think we might need to make clear in the documentation how this
differs from other repacks, in that it is not considering reachability
at all. I like the term "roll up" to describe what is happening, but we
probably need to define that term clearly, as well.

Especially important, I think, is that we talk about what's happening
with loose objects, which are part of the rollup here. And IMHO we
should make clear that for now we include them all, without
consideration of their reachability, but that this may change in the
future.

Likewise, are there any options that are incompatible with "-g"? I have
to imagine that "--write-bitmap-index" would not work very well. I don't
know that we need to enumerate them all, but I'm wondering if a blanket
"this may not play well with other options" warning may be advisable.

> +static void split_pack_geometry(struct pack_geometry *geometry, int factor)
> [...]

I'll admit I didn't carefully think about the math of the progression
here. IMHO the exact split is the least interesting part of this whole
series (compared to the general idea of "rolling up some packs" versus a
whole repack). Between the comments and the tests, I'll assume it's
generally behaving as advertised. (I of course did look for any obvious
coding errors, but didn't see any).

-Peff
