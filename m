Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4C51F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfHIDFd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:05:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:38668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729490AbfHIDFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:05:33 -0400
Received: (qmail 6731 invoked by uid 109); 9 Aug 2019 03:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Aug 2019 03:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26529 invoked by uid 111); 9 Aug 2019 03:08:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 23:08:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 23:05:31 -0400
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
Message-ID: <20190809030531.GA14576@sigill.intra.peff.net>
References: <20190808035935.30023-1-phil.hord@gmail.com>
 <CABPp-BFH++aJinkzg+qsZDRN6R5-E8LPCG_u+udZLW6o0MGBug@mail.gmail.com>
 <CABURp0p5xbsq+8UsFerMAY8EG-ndXgd19EUsHOgQG-dnDnTAgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0p5xbsq+8UsFerMAY8EG-ndXgd19EUsHOgQG-dnDnTAgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 08, 2019 at 04:43:16PM -0700, Phil Hord wrote:

> > I also get really slow times on a repo with ~20,000 tags (though order
> > ~3 minutes rather than ~30, probably due to having an SSD on this
> > machine) -- but ONLY IF the refs are packed first (git pack-refs
> > --all).  If the refs are loose, it's relatively quick to delete a
> > dozen thousand or so tags (order of a few seconds).  It might be worth
> > mentioning in the commit message that this only makes a significant
> > difference in the case where the refs are packed.
> 
> I'm also using an SSD but I still see about 10 tags per second being
> deleted with the current code (and packed-refs).  I see that I'm
> CPU-bound, so I guess most of the time is spent searching through
> .git/packed-refs.  Probably it will run faster as it progresses. I
> guess the 18,000 branches in my repo keep me on the wrong end of O(N).

Right, deleting individually from packed-refs is inherently quadratic,
because each deletion has to rewrite the entire file. So if you delete
all (or the majority of them), that's O(n^2) individual entry writes.

The loose case is just touching the filesystem for each entry (and the
refs code is smart enough not to bother rewriting packed-refs if the
entry isn't present there). That _can_ be slow if you have a lot of
entries in the same directory (because some filesystems are particularly
bad at this).

So the actual backing storage speed isn't really that important. All the
time goes to copying the same packed-refs entries over and over, whether
they hit the disk or not.

Your solution (using a single transaction) is definitely the right one
(and probably should apply to "branch -d", too). That's what we did long
ago for update-ref, and I think nobody ever really noticed for the
porcelain commands because they don't tend to be used for such bulk
changes.

> But it should have occurred to me while I was in the code that there
> is a different path for unpacked refs which could explain my previous
> speeds.  I didn't think I had any unpacked refs, though, since every
> time I look in .git/refs for what I want, I find it relatively empty.
> I see 'git pack-refs --help' says that new refs should show up loose,
> but I can't say that has happened for me.  Maybe a new clone uses
> packed-refs for *everything* and only newly fetched things are loose.
> Is that it?  I guess since I seldom fetch tags after the first clone,
> it makes sense they would all be packed.

Right, a fresh clone always writes all of its entries as packed refs.
It used to be done by hand, but it happens in a special "initial
transaction" method these days, since 58f233ce1e
(initial_ref_transaction_commit(): function for initial ref creation,
2015-06-22).

> > In constrast, it appears that `git update-ref --stdin` is fast
> > regardless of whether the refs are packed, e.g.
> >    git tag -l feature/* | sed -e 's%^%delete refs/tags/%' | git
> > update-ref --stdin
> > finishes quickly (order of a few seconds).
> 
> Nice!  That trick is going in my wiki for devs to use on their VMs.
> Thanks for that.

Please do encourage people to use for-each-ref instead of the "tag -l"
porcelain, as the latter is subject to change. My usual bulk deletion
command is:

  git for-each-ref --format='delete %(refname)' refs/tags/feature/ |
  git update-ref --stdin

-Peff
