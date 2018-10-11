Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00041F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 15:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJKXCy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 19:02:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726562AbeJKXCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 19:02:54 -0400
Received: (qmail 23292 invoked by uid 109); 11 Oct 2018 15:35:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 15:35:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31171 invoked by uid 111); 11 Oct 2018 15:34:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 11:34:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 11:35:11 -0400
Date:   Thu, 11 Oct 2018 11:35:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
Message-ID: <20181011153510.GF27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:36AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When running a command like 'git rev-list --topo-order HEAD',
> Git performed the following steps:
> [...]
> In the new algorithm, these three steps correspond to three
> different commit walks. We run these walks simultaneously,

A minor nit, but this commit message doesn't mention the most basic
thing up front: that its main purpose is to introduce a new algorithm
for topo-order. ;)

It's obvious in the context of reviewing the series, but somebody
reading "git log" later may want a bit more. Perhaps:

  revision.c: implement generation-based topo-order algorithm

as a subject, and/or an introductory paragraph like:

  The current --topo-order algorithm requires walking all commits we
  are going to output up front, topo-sorting them, all before
  outputting the first value. This patch introduces a new algorithm
  which uses stored generation numbers to incrementally walk in
  topo-order, outputting commits as we go.

Other than that, I find this to be a wonderfully explanatory commit
message. :)

> The walks are as follows:
> 
> 1. EXPLORE: using the explore_queue priority queue (ordered by
>    maximizing the generation number), parse each reachable
>    commit until all commits in the queue have generation
>    number strictly lower than needed. During this walk, update
>    the UNINTERESTING flags as necessary.

OK, this makes sense. If we know that everybody else in our queue is at
generation X, then it is safe to output a commit at generation greater
than X.

I think this by itself would allow us to implement "show no parents
before all of its children are shown", right? But --topo-order promises
a bit more: "avoid showing commits no multiple lines of history
intermixed".

I guess also INFINITY generation numbers need more. For a real
generation number, we know that "gen(A) == gen(B)" implies that there is
no ancestry relationship between the two. But not so for INFINITY.

> 2. INDEGREE: using the indegree_queue priority queue (ordered
>    by maximizing the generation number), add one to the in-
>    degree of each parent for each commit that is walked. Since
>    we walk in order of decreasing generation number, we know
>    that discovering an in-degree value of 0 means the value for
>    that commit was not initialized, so should be initialized to
>    two. (Recall that in-degree value "1" is what we use to say a
>    commit is ready for output.) As we iterate the parents of a
>    commit during this walk, ensure the EXPLORE walk has walked
>    beyond their generation numbers.

I wondered how this would work for INFINITY. We can't know the order of
a bunch of INFINITY nodes at all, so we never know when their in-degree
values are "done". But if I understand the EXPLORE walk, we'd basically
walk all of INFINITY down to something with a real generation number. Is
that right?

But after that, I'm not totally clear on why we need this INDEGREE walk.

> 3. TOPO: using the topo_queue priority queue (ordered based on
>    the sort_order given, which could be commit-date, author-
>    date, or typical topo-order which treats the queue as a LIFO
>    stack), remove a commit from the queue and decrement the
>    in-degree of each parent. If a parent has an in-degree of
>    one, then we add it to the topo_queue. Before we decrement
>    the in-degree, however, ensure the INDEGREE walk has walked
>    beyond that generation number.

OK, this makes sense to make --author-date-order, etc, work. Potentially
those numbers might have no relationship at all with the graph
structure, but we promise "no parent before its children are shown", so
this is really just a tie-breaker after the topo-sort anyway. As long as
steps 1 and 2 are correct and produce a complete set of commits for one
"layer", this should be OK.

I guess I'm not 100% convinced that we don't have a case where we
haven't yet parsed or considered some commit that we know cannot have an
ancestry relationship with commits we are outputting. But it may have an
author-date-order relationship.

(I'm not at all convinced that this _is_ a problem, and I suspect it
isn't; I'm only suggesting I haven't fully grokked the proof).

> ---
>  object.h   |   4 +-
>  revision.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  revision.h |   2 +
>  3 files changed, 194 insertions(+), 8 deletions(-)

I'll pause here on evaluating the actual code. It looks sane from a
cursory read, but there's no point in digging further until I'm sure I
fully understand the algorithm. I think that needs a little more brain
power from me, and hopefully discussion around my comments above will
help trigger that.

-Peff
