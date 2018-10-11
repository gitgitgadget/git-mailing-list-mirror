Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E061F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeJKVsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:48:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:37242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727081AbeJKVsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:48:38 -0400
Received: (qmail 20088 invoked by uid 109); 11 Oct 2018 14:21:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 14:21:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30021 invoked by uid 111); 11 Oct 2018 14:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 10:20:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 10:21:12 -0400
Date:   Thu, 11 Oct 2018 10:21:12 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 5/7] commit/revisions: bookkeeping before refactoring
Message-ID: <20181011142112.GE27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <e86f30408240da12a52858f836134b037e85f7ae.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e86f30408240da12a52858f836134b037e85f7ae.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:33AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> There are a few things that need to move around a little before
> making a big refactoring in the topo-order logic:
> 
> 1. We need access to record_author_date() and
>    compare_commits_by_author_date() in revision.c. These are used
>    currently by sort_in_topological_order() in commit.c.
> 
> 2. Moving these methods to commit.h requires adding the author_slab
>    definition to commit.h.

The overall goal makes sense. Do we really need to define the whole slab
in the header file? We're going to end up with multiple copies of the
functions, since they're declared static in each file that includes
commit.h.

From what's here, I think you could get away with just:

  struct author_date_slab;
  void record_author_date(struct author_date_slab *author_date,
                          struct commit *commit);

in the header file. But presumably callers would eventually want to
allocate their own author dates. If that's all we need, then these days
you can do:

  declare_commit_slab(author_date, timestamp_t);

to get the type declaration.

If they really do need the functions accessible outside of commit.c,
then perhaps:

  define_shared_commit_slab(author_date, timestamp_t);

in commit.h, and:

  implement_shared_commit_slab(author_date, timestamp_t);

in commit.c (the type repetition is not too bad, as the compiler would
catch any mistakes).

The only downside of this approach is that we're less likely to be able
to inline element access (though "peek" is big enough that I'm not sure
it ends up inlined anyway).

> 3. The add_parents_to_list() method in revision.c performs logic
>    around the UNINTERESTING flag and other special cases depending
>    on the struct rev_info. Allow this method to ignore a NULL 'list'
>    parameter, as we will not be populating the list for our walk.

So now you can add_parents_to_list() without a list? That sounds
confusing. :)

Is it possible to split the function into two? Some
handle_uninteresting_parents() logic, and then an add_parents_to_list()
that calls that, but also adds to the list?

A cursory look at the function suggests it's actually kind of tricky.
Perhaps as an alternative, add_parents_to_list() could just get a more
descriptive name?

> ---
>  commit.c   | 11 ++++-------
>  commit.h   |  8 ++++++++
>  revision.c |  6 ++++--
>  3 files changed, 16 insertions(+), 9 deletions(-)

The patch itself seems straight-forward based on those explanations.

-Peff
