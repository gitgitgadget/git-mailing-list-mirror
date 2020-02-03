Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E0BC33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514282080D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBCLLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:11:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:51188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727509AbgBCLLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 06:11:18 -0500
Received: (qmail 2032 invoked by uid 109); 3 Feb 2020 11:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 11:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23839 invoked by uid 111); 3 Feb 2020 11:19:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 06:19:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 06:11:17 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200203111117.GC4153124@coredump.intra.peff.net>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <20200131233434.GJ10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
 <20200203104730.GK10482@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203104730.GK10482@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 11:47:30AM +0100, SZEDER Gábor wrote:

> > -- snip --
> > diff --git a/commit-graph.c b/commit-graph.c
> > index a5d7624073f..af5c58833cf 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1566,7 +1566,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
> >  	num_commits = ctx->commits.nr;
> >  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
> > 
> > -	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> > +	if (ctx->split_opts &&
> > +	    ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> >  		while (g && (g->num_commits <= size_mult * num_commits ||
> >  			    (max_commits && num_commits > max_commits) ||
> >  			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
> > -- snap --
> 
> Yeah, that's what I noted below, but I'm not sure that this is the
> right solution.  Why doesn't cmd_fetch() call
> write_commit_graph_reachable() with a real 'split_opts' parameter in
> the first place?  Wouldn't it be better if it did?

It used to provide a "blank" split_opts until 63020f175f (commit-graph:
prefer default size_mult when given zero, 2020-01-02), which caused a
bug. That bug was since fixed, but the idea was to keep things
convenient for callers.

Whether that's a good idea or not I guess is up for debate, but it
certainly is what the commit-graph code has tried to provide for some
time. If we're not going to follow that in this new code, then we should
presumably also rip out all of the other "if (ctx->split_opts)" lines.

-Peff
