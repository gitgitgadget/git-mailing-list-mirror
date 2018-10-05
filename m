Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C39F1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFCWD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:22:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:43590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728139AbeJFCWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:22:03 -0400
Received: (qmail 24955 invoked by uid 109); 5 Oct 2018 19:21:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:21:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15121 invoked by uid 111); 5 Oct 2018 19:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:21:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:21:54 -0400
Date:   Fri, 5 Oct 2018 15:21:54 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone"
 due to commit graph
Message-ID: <20181005192154.GD17482@sigill.intra.peff.net>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
 <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
 <87ftxkh7bf.fsf@evledraar.gmail.com>
 <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:45:47AM -0400, Derrick Stolee wrote:

> My misunderstanding was that your proposed change to gc computes the
> commit-graph in either of these two cases:
> 
> (1) The auto-GC threshold is met.
> 
> (2) There is no commit-graph file.
> 
> And what I hope to have instead of (2) is (3):
> 
> (3) The commit-graph file is "sufficiently behind" the tip refs.
> 
> This condition is intentionally vague at the moment. It could be that we
> hint that (3) holds by saying "--post-fetch" (i.e. "We just downloaded a
> pack, and it probably contains a lot of new commits") or we could create
> some more complicated condition based on counting reachable commits with
> infinite generation number (the number of commits not in the commit-graph
> file).
> 
> I like that you are moving forward to make the commit-graph be written more
> frequently, but I'm trying to push us in a direction of writing it even more
> often than your proposed strategy. We should avoid creating too many
> orthogonal conditions that trigger the commit-graph write, which is why I'm
> pushing on your design here.
> 
> Anyone else have thoughts on this direction?

Yes, I think measuring "sufficiently behind" is the right thing.
Everything else is a proxy or heuristic, and will run into corner cases.
E.g., I have some small number of objects and then do a huge fetch, and
now my commit-graph only covers 5% of what's available.

We know how many objects are in the graph already. And it's not too
expensive to get the number of objects in the repository. We can do the
same sampling for loose objects that "gc --auto" does, and counting
packed objects just involves opening up the .idx files (that can be slow
if you have a ton of packs, but you'd want to either repack or use a
.midx in that case anyway, either of which would help here).

So can we really just take (total_objects - commit_graph_objects) and
compare it to some threshold?

-Peff
