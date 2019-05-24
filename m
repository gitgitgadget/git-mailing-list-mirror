Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C5B1F609
	for <e@80x24.org>; Fri, 24 May 2019 07:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfEXHY3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 03:24:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388982AbfEXHY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 03:24:29 -0400
Received: (qmail 25653 invoked by uid 109); 24 May 2019 07:24:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 07:24:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6885 invoked by uid 111); 24 May 2019 07:25:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 03:25:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 03:24:26 -0400
Date:   Fri, 24 May 2019 03:24:26 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190524072426.GG25694@sigill.intra.peff.net>
References: <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
 <1e0d216b-5e68-faff-883c-778a04f55bde@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e0d216b-5e68-faff-883c-778a04f55bde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 08:53:56AM -0400, Derrick Stolee wrote:

> > I spent a while thinking and experimenting with this tonight. The result
> > is the patch below. Ævar, do you still have a copy of the repo that
> > misbehaved? I'd be curious to see how it fares.
> 
> This patch caught my attention, and I think I understand some of the issues
> at hand. I'm not well-versed specifically in Git's bitmap implementation.
> The fundamental ideas are there, but my perspective is biased by my own
> independent bitmap implementation for Azure Repos. What worked there may not
> work at all here.

Thanks for looking at this. There are a lot of short-comings in the
current bitmap implementation, so if there's a better way to do things,
I'm not opposed to moving to a new format. :)

> > Finding the right trees to explore is a little tricky with bitmaps.  In
> > a normal traversal, we consider the "edges" to be worth exploring.
> > I.e., the places where an UNINTERESTING commit is the parent of an
> > interesting one.
> 
> This is the "commit frontier" which I bring up again below.

Right. I actually had trouble coming up with a succinct way of
describing this, and stole the definition from your recent blog post. ;)

> > But with bitmaps, we don't have that information in the same way,
> > because we're trying to avoid walking the commits in the first place. So
> > e.g., in a history like this:
> > 
> >   A--B--C
> >       \
> >        D
> > 
> > Let's imagine we're computing "C..D", and that D has a bitmap on disk
> > but C does not.
> 
> (As I read your discussion below, I'm confused. For "C..D", C is a have
> and D is a want. We should explore all the haves _first_, then walk the
> wants, right?)

I think I may have confused things by starting my description with a
hypothetical combined want/have walk. To take a step back: the problem
we were discussing is that we spend a lot of time reading trees to fill
in the "have" bitmap, even though most of those objects are unlikely to
be in the "want" in the first place (only the frontier trees are really
useful).

The current code does indeed fill the "have" bitmap first (so that while
walking "want", it can avoid walking down paths whose bits we know we're
going to clear eventually anyway). But we can't know the frontier if we
completely fill the "have" bitmap first. We have to walk both sides
together, looking for the frontier.

> > When we visit D, we'll see that it has a bitmap, fill in
> > the results in our cumulative "want" bitmap, and then stop walking its
> > parents (because we know everything they could tell us already).
> 
> I may be misreading something, but we would construct _a_ bitmap for C
> by walking its reachable objects until hitting a bitmap we know about.
> Perhaps A or B have a bitmap to start the construction. If we never
> construct a bitmap for C, then we don't know what to remove from the "D"
> bitmap to show the difference.

Yes, and that's how the current code works. If we walk back to B and it
has a bitmap, we can stop walking there and just OR in its bitmap, and
look at the trees for any intermediate commits (in this case just C) to
fill in the rest.

The problem is that we don't have a bitmap for every commit. So you can
imagine a history like this:

  A_1 -- A_2 -- ... -- A_1000 -- B -- C
                                   \
				    D

where we have a bitmap _only_ for D. Filling in the accurate and true
bitmap for C requires walking a thousand commits (and their trees!),
when the non-bitmap algorithm would find the frontier at B and call that
good enough.

> If "C" is not even in the bitmap pack, then we don't use bitmaps for
> this calculation because of this condition:
> 
>         /*
>          * if we have a HAVES list, but none of those haves is contained
>          * in the packfile that has a bitmap, we don't have anything to
>          * optimize here
>          */
>         if (haves && !in_bitmapped_pack(bitmap_git, haves))
>                 goto cleanup;

Right, but it may be in the pack but without a bitmap. We don't store a
bitmap for every commit. The idea was to save space, but select some key
commits that let us generally find a bitmap with a small amount of
walking. And most of the time it works fine. But in some cases, we seem
to find pathological cases where we do quite a lot of walking.

As I said earlier in the thread, I suspect our commit selection is not
great. It's mostly some heuristics we threw together in 2013, and I
don't think it was tested very thoroughly. So fixing that may be a
simpler approach.

What I was wondering here was whether we could get an easy fix based on
the same frontier ideas that the non-bitmap walk uses.

> I'm of the opinion that the old method was better. It followed a very clear
> three-step process:
> 
>  1. Compute the "haves" bitmap.
> 
>  2. Compute the "wants" bitmap, but don't explore into the "haves" bitmap.
> 
>  3. Subtract the "haves" bitmap from the "wants" (in case we added bits to
>     the wants before they were in the haves).

Right, this is _way_ simpler. But it necessarily means spending effort
to find the complete "haves", because we don't know which parts are
useful.

> But there is hope in your idea to improve some cases. As noted, we give up
> if all of the haves are not in the bitmapped pack. By starting with a
> commit walk, we can find the "commit frontier," which is the set of commits
> that are explored by paint_down_to_common(). In this case, the set {B, C, D}.
> 
> After walking commits and finding a set of UNINTERESTING commits, we could
> look for any UNINTERESTING commits that have bitmaps (or simply are in the
> bitmapped pack) and use those to see our "haves" bitmap. So, if B has a
> bitmap, but C is too new for the bitmap, then we can still create the haves
> based on B and then take a bitmap diff "D minus B".

But doing that commit walk to find the frontier negates part of the
purpose of using the bitmaps, which is avoiding even walking commits.
Going back to a variant of our example:

  A -- B -- C_1 -- .. -- C_1000
        \
	 D_1 -- .. -- D_1000

If we have a bitmap at C_1000 and D_1000, we don't have to walk any
commits at all. But finding the frontier requires walking 2000 commits.

Is there a way to find it with just bitmaps? You can certainly find the
intersection, but you don't have any idea which of the many shared
commits is the merge base. Of course in this example you don't actually
care about the frontier (you have the full answer immediately). But how
do you decide which way to optimize: try to avoid walking commits to
get a quick answer from bitmaps, or prefer to walk some commits to find
the frontier and avoid opening too many trees?

-Peff
