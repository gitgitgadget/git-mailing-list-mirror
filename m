Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6960D1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 20:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfIZUX2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 16:23:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727868AbfIZUX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 16:23:28 -0400
Received: (qmail 18930 invoked by uid 109); 26 Sep 2019 20:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 20:23:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3302 invoked by uid 111); 26 Sep 2019 20:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 16:25:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 16:23:27 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: [BUG/PATCH 0/5] t4214: cleanup and demonstrate graph bug
Message-ID: <20190926202326.GA16664@sigill.intra.peff.net>
References: <cover.1569407150.git.liu.denton@gmail.com>
 <20190925170902.GA11547@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925170902.GA11547@dentonliu-ltm.internal.salesforce.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 10:09:02AM -0700, Denton Liu wrote:

> On Wed, Sep 25, 2019 at 03:26:57AM -0700, Denton Liu wrote:
> > I tried my hand at fixing the bug but in the hour I spent going at it, I
> > couldn't fix the logic up. The buggy logic is in graph.c:
> > graph_draw_octopus_merge() in case anyone is interested.
> 
> I guess for the record, this was the final patch that I ended up with.
> Two issues with it, though: 
> 
> 1. It assumes that there can be no parallel paths on the right side,
> which I'm not sure is a correct assumption.
> 
> 2. It _still_ fails my last proposed test case.
> 
> -- >8 --
> 
> diff --git a/graph.c b/graph.c
> index f53135485f..f9395a2327 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -881,8 +881,7 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>  	/*
>  	 * In both cases, commit_index corresponds to the edge labeled "0".
>  	 */
> -	int first_col = graph->commit_index + dashless_parents
> -	    - parent_in_old_cols;
> +	int first_col = graph->num_new_columns - dashful_parents;
>  
>  	int i;
>  	for (i = 0; i < dashful_parents; i++) {

Hmm. Looking at the broken case from "git log -2 --graph 74c7cfa875", I
see that added_cols is "4", which is right (we had 2 lines coming in,
and then with the 5 parents that becomes 6). But one of those lines is
already counted as "dashless". We account for that with
parent_in_old_cols, which is 1, and subtract that way from first_col.
That works for the diagram in the code:

           | *---.
           | |\ \ \
           |/ / / /
           x 0 1 2

where one of the parent lines is collapsing back to the left. But not
for this more mundane case:

  | *-----.   commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
  | |\ \ \ \  Merge: fc54a9c30c 9e30dd7c0e c4b83e618f 660265909f b28858bf65
  | | | | | | 

where we go straight down. I'm not sure I've fully grasped it, but it
feels like that distinction is the source of the off-by-one. I'm not
sure how to tell the difference here, though. I think it relies on the
next commit on the left-hand line being the same as the first parent (or
maybe any parent?).

If I remove the use of parent_in_old_cols entirely, the merge looks
right, but the "collapsing" one is broken (and t4214 fails).

By the way, a useful trick I stumbled on to look at the coloring across
many such merges:

  git log --graph --format=%h --color | grep -A2 -e - | less -S

It looks like every octopus in git.git is colored wrong (because they're
the non-collapsing type).

-Peff
