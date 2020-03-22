Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69218C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC8A20724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCVTWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:22:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726137AbgCVTWf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 15:22:35 -0400
Received: (qmail 30534 invoked by uid 109); 22 Mar 2020 19:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 19:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2698 invoked by uid 111); 22 Mar 2020 19:32:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 15:32:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 15:22:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
Message-ID: <20200322192234.GC671552@coredump.intra.peff.net>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <20200322095137.GB635598@coredump.intra.peff.net>
 <CAP8UFD1mCXvcfUQxY4uMEPEjZp8+yPwu6SgTmZBEH6GR=8ixSA@mail.gmail.com>
 <5baf9f4c-9ce0-0384-1113-431038c2a646@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5baf9f4c-9ce0-0384-1113-431038c2a646@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 12:45:29PM -0400, Derrick Stolee wrote:

> >> I have mixed feelings on this. I do like making things less arcane for
> >> users. But are we locking in a behavior for --partial that we might not
> >> want to live with forever? I.e., the current thinking for partial clones
> >> is to fetch no blobs at all, get all commits and trees, apply sparse
> >> filters, and then fault in the blobs we need. But imagine we later grow
> >> the ability to easily avoid fetching all of the trees. Would we regret
> >> having the simple name "--partial" taken?
> > 
> > I agree with that. Something like "--filter-blobs" for
> > "--filter=blob:none" and perhaps "--filter-blobs=<size>" for
> > "--filter=blob:limit=<size>" might be worth it though.
> 
> Thanks for the perspective on this. The --filter-blobs[=<size>] should
> be less likely to collide with an alternative definition of "partial".

Yes, though I wonder if it's really that big an improvement over
"--filter=blob:none".

> While we are thinking in this space, what if we had a "partial-clone"
> builtin? It could be a light wrapper around "git clone" where
> 
>   git partial-clone [--limit=<size>] [options] <url> [<dir>]
> 
> would do the same thing as
> 
>   git clone --filter=blob:[none|limit=<size>] [options] <url> [<dir>]
> 
> Just spit-balling here.

I think that just shifts my concern out to the other command; i.e.,
would we later want the partial-clone command to behave differently.
And introducing a wrapper creates a weird non-orthogonality where it's
not necessary. I _do_ think a wrapper could make sense when it's doing
substantially different things, or multiple steps that don't belong in
the original program (e.g., the way Scalar works).

> In the meantime, I'll work to adjust my patches to only be the
> documentation of the --filter option.

Thanks, that seems like an obvious and easy improvement.

-Peff
