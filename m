Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYSPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 14:15:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726809AbeJYSPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 14:15:45 -0400
Received: (qmail 4161 invoked by uid 109); 25 Oct 2018 09:43:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 09:43:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15434 invoked by uid 111); 25 Oct 2018 09:43:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 05:43:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 05:43:46 -0400
Date:   Thu, 25 Oct 2018 05:43:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
Message-ID: <20181025094345.GA18794@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
 <20181011153510.GF27312@sigill.intra.peff.net>
 <1c0eb7d3-7f31-9377-d42f-4ac2f36ac26a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c0eb7d3-7f31-9377-d42f-4ac2f36ac26a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 12:21:44PM -0400, Derrick Stolee wrote:

> > > 2. INDEGREE: using the indegree_queue priority queue (ordered
> > >     by maximizing the generation number), add one to the in-
> > >     degree of each parent for each commit that is walked. Since
> > >     we walk in order of decreasing generation number, we know
> > >     that discovering an in-degree value of 0 means the value for
> > >     that commit was not initialized, so should be initialized to
> > >     two. (Recall that in-degree value "1" is what we use to say a
> > >     commit is ready for output.) As we iterate the parents of a
> > >     commit during this walk, ensure the EXPLORE walk has walked
> > >     beyond their generation numbers.
> > I wondered how this would work for INFINITY. We can't know the order of
> > a bunch of INFINITY nodes at all, so we never know when their in-degree
> > values are "done". But if I understand the EXPLORE walk, we'd basically
> > walk all of INFINITY down to something with a real generation number. Is
> > that right?
> > 
> > But after that, I'm not totally clear on why we need this INDEGREE walk.
> 
> The INDEGREE walk is an important element for Kahn's algorithm. The final
> output order is dictated by peeling commits of "indegree zero" to ensure all
> children are output before their parents. (Note: since we use literal 0 to
> mean "uninitialized", we peel commits when the indegree slab has value 1.)
> 
> This walk replaces the indegree logic from sort_in_topological_order(). That
> method performs one walk that fills the indegree slab, then another walk
> that peels the commits with indegree 0 and inserts them into a list.

I guess my big question here was: if we have generation numbers, do we
need Kahn's algorithm? That is, in a fully populated set of generation
numbers (i.e., no INFINITY), we could always just pick a commit with the
highest generation number to show.

So if we EXPLORE down to a real generation number in phase 1, why do we
need to care about INDEGREE anymore? Or am I wrong that we always have a
real generation number (i.e., not INFINITY) after EXPLORE? (And if so,
why is exploring to a real generation number a bad idea; presumably
it's due to a worst-case that goes deeper than we'd otherwise need to
here).

> [...]

Everything else you said here made perfect sense.

-Peff
