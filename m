Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E43C83F11
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 00:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjH2Awl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjH2AwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 20:52:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9311C
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 17:52:09 -0700 (PDT)
Received: (qmail 3270 invoked by uid 109); 29 Aug 2023 00:52:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 00:52:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6608 invoked by uid 111); 29 Aug 2023 00:52:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 20:52:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 20:52:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/22] commit-graph: mark unused data parameters in
 generation callbacks
Message-ID: <20230829005208.GB3876652@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214739.GF3831137@coredump.intra.peff.net>
 <ZO0uq25DV6MIvG6q@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZO0uq25DV6MIvG6q@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 07:32:59PM -0400, Taylor Blau wrote:

> On Mon, Aug 28, 2023 at 05:47:39PM -0400, Jeff King wrote:
> > The compute_generation_info code uses function pointers to abstract the
> > get/set generation operations. Some callers don't need the extra void
> > data pointer, which should be annotated to appease -Wunused-parameter.
> 
> I think just the callbacks initialized by compute_topological_levels()
> (i.e, get_topo_level() and set_topo_level()) care about the ctx
> parameter.
> 
> I think that we can go a bit further, though. The other caller in
> compute_generation_numbers() assigns data to the argument ctx it takes
> in, but neither of its callbacks get_generation_from_graph_data() and
> set_generation_v2() use the data parameter, as is implied by the the
> existence of this patch.
> 
> So I think that we could drop the assignment to data entirely like so,
> applied on top of this patch:
> 
> --- 8< ---
> diff --git a/commit-graph.c b/commit-graph.c
> index 0aa1640d15..eb3e27b720 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1587,7 +1587,6 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  		.commits = &ctx->commits,
>  		.get_generation = get_generation_from_graph_data,
>  		.set_generation = set_generation_v2,
> -		.data = ctx,
>  	};
> 
>  	if (ctx->report_progress)
> --- >8 ---

Yeah, I didn't dig too much in the caller. I could see an argument for
leaving it, in that it might be the "least surprise" for somebody who
later wants to look at the ctx variable from those callbacks. But since
all they get is a void pointer, anybody writing that code would have to
go back to the caller to see what is passed in as "data" anyway.

So I think it is safe to add this cleanup. I'm going to re-roll to
simplify the first patch a bit, so I'll add this in as well. Thanks.

-Peff
