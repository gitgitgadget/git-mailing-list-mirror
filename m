Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3491F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeCLX7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:59:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:54792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932376AbeCLX7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:59:09 -0400
Received: (qmail 14508 invoked by uid 109); 12 Mar 2018 23:59:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:59:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19202 invoked by uid 111); 13 Mar 2018 00:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 20:00:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:59:07 -0400
Date:   Mon, 12 Mar 2018 19:59:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     csilvers <csilvers@cs.stanford.edu>, avarab@gmail.com,
        jrnieder@gmail.com, drizzd@aon.at, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Message-ID: <20180312235907.GG1968@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <E1ea4Ui-0005qJ-3s@theory.stanford.edu>
 <20180303051516.GE27689@sigill.intra.peff.net>
 <63e9c6a8-4efc-6f86-f355-1ec40dd674e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63e9c6a8-4efc-6f86-f355-1ec40dd674e4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 09:45:27AM -0400, Derrick Stolee wrote:

> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index 8dcc2ed058..4d674e86d5 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -404,6 +404,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
> >   	memset(&array, 0, sizeof(array));
> > +	filter->with_commit_tag_algo = 1;
> >   	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
> >   	if (filter->verbose)
> > 
> > drops my run of "git branch -a --contains HEAD~100" from 8.6s to
> > 0.4s on a repo with ~1800 branches. That sounds good, but on a repo with
> > a smaller number of branches, we may actually end up slower (because we
> > dig further down in history, and don't benefit from the multiple-branch
> > speedup).
> 
> It's good to know that we already have an algorithm for the multi-head
> approach. Things like `git branch -vv` are harder to tease out because the
> graph walk is called by the line-format code.

Yeah, the ahead/behind stuff will need some work. Part of it is just
code structuring. We know ahead of time which branches (and their
upstreams) are going to need this ahead/behind computation, so we should
be able to do collect them all for a single call.

But I'm not sure if a general multi-pair ahead/behind is going to be
easy. I don't have even experimental code for that. :)

We have a multi-pair ahead/behind command which we use at GitHub, but it
does each pair separately. It leans heavily on reachability bitmaps, so
the main advantage is that it's able to amortize the cost of loading the
bitmaps (both off disk, but also we sometimes have to walk to complete
the bitmaps).

-Peff
