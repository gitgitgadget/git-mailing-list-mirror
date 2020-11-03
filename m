Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F3CC388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB0C20674
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKCQYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:24:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:46278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgKCQYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:24:31 -0500
Received: (qmail 6538 invoked by uid 109); 3 Nov 2020 16:24:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 16:24:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2186 invoked by uid 111); 3 Nov 2020 16:24:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 11:24:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 11:24:30 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] strmap: enable allocations to come from a
 mem_pool
Message-ID: <20201103162430.GF444466@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <eca4f1ddbaa1cd8dc3fc64dbe9206af538cb317d.1602549650.git.gitgitgadget@gmail.com>
 <20201030145604.GJ3277724@coredump.intra.peff.net>
 <CABPp-BEY5R79WGsMB1y1MEbcvw8EF5-ADxvDPzL+Hn-PiyobsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEY5R79WGsMB1y1MEbcvw8EF5-ADxvDPzL+Hn-PiyobsA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 12:31:13PM -0700, Elijah Newren wrote:

> > I think we could fall back to a FLEXPTR when there's no mempool (or even
> > when there is, though you'd be on your own to reimplement the
> > computation parts of FLEXPTR_ALLOC). I'm not sure how ugly it would end
> > up.
> 
> Yeah, we'd need a mempool-specific reimplementation of FLEXPTR_ALLOC
> with the mempool, and just avoid using it at all whenever
> strdup_strings was 0.  Seems slightly ugly, but maybe it wouldn't be
> too bad.  I could look into it.

It looks like you went this route (fall back to FLEXPTR) in the re-roll
you posted. I haven't looked at it carefully yet, but I suspect it will
be just fine to me (I probably would have accepted "no, it makes the
code too ugly; if you want efficiency use a mempool" as well, but I'll
see how ugly it turned out. ;) ).

> Anyway, at the time I
> put the mempool into strmaps and made use of it in relevant places,
> one of my rebase testcases saw an almost 5% reduction in overall
> execution time.  I'm sure it would have been over 5% if I had
> reordered it to come after my final rename optimization.

Thanks, it's nice to have a ballpark like that. It might be worth
putting it into the commit message, even if it's hand-wavy:

  This seemed to provide about 5% speedup for some rebase test cases I
  ran. Unfortunately you can't just time this commit and its parent,
  since we aren't yet actually using strmap in the code yet.

But again, I think the main value of that is during review, so if it
doesn't make it into the commit message, I'm OK.

-Peff
