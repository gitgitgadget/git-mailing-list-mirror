Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACD11F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeJRC2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:28:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:43768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727014AbeJRC2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:28:23 -0400
Received: (qmail 7729 invoked by uid 109); 17 Oct 2018 18:31:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:31:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21944 invoked by uid 111); 17 Oct 2018 18:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:30:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:31:25 -0400
Date:   Wed, 17 Oct 2018 14:31:25 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
Message-ID: <20181017183125.GE28326@sigill.intra.peff.net>
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 11:00:03AM -0700, Elijah Newren wrote:

> Digging in, almost all the time was CPU-bound and spent in
> add_missing_tags()[2].  If I'm reading the code correctly, it appears
> that function loops over each tag, calling in_merge_bases_many() once
> per tag.  Thus, for his case, we were potentially walking all of
> history of the main branch 2.5k times.  That seemed rather suboptimal.
> 
> Before attempting to optimize, I decided to try out the commit-graph
> with a version of git from pu.  While I expected a speed-up, I was a
> bit suprised that it was a factor of over 100; dropping the time for
> local dry-run push[2] to sub-second.  A quick look suggests that
> commit-graph doesn't fix the fact that we call in_merge_bases_many() N
> times from add_missing_tags() and thus likely need to do N merge base
> computations, it just makes each of the N much faster.  So, perhaps
> there's still another scaling issue we'll eventually need to address,
> but for now, I'm pretty excited about commit-graph.

Yeah, I think this case would probably still benefit from an all-points
traversal. This want to be basically the same as what "git tag --merged"
is doing, I would think (see ref-filter.c:do_merge_filter).

  As an aside, it looks like do_merge_filter uses prepare_revision_walk(),
  which IIRC means that it is susceptible to wrong answers due to
  clock skew (basically because of the use of commit timestamps for
  traversal order). This seems like another place where generation
  numbers could make a quiet improvement.

-Peff
