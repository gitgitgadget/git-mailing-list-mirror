Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCAC04EBE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C90B20B1F
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgJHPxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:53:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:53838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgJHPxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:53:05 -0400
Received: (qmail 29440 invoked by uid 109); 8 Oct 2020 15:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 15:53:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24896 invoked by uid 111); 8 Oct 2020 15:53:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 11:53:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 11:53:04 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] commit-graph: ignore duplicates when merging layers
Message-ID: <20201008155304.GA2823778@coredump.intra.peff.net>
References: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
 <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 03:04:39PM +0000, Derrick Stolee via GitGitGadget wrote:

> Since the root cause for producing commit-graph layers with these
> duplicate commits is currently unknown, it is difficult to create a test
> for this scenario. For now, we must rely on testing the example data
> graciously provided in [1]. My local test successfully merged layers,
> and 'git commit-graph verify' passed.

Yeah, that is unfortunate. We could synthetically create such a graph
file, but I'm not sure if it's worth the trouble.

> @@ -2023,17 +2023,27 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {
> -			die(_("unexpected duplicate commit id %s"),
> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
> +			/*
> +			 * Silently ignore duplicates. These were likely
> +			 * created due to a commit appearing in multiple
> +			 * layers of the chain, which is unexpected but
> +			 * not invalid. We should make sure there is a
> +			 * unique copy in the new layer.
> +			 */

You mentioned earlier checking tha the metadata for the duplicates was
identical. How hard would that be to do here?

>  		} else {
>  			unsigned int num_parents;
>  
> +			ctx->commits.list[dedup_i] = ctx->commits.list[i];
> +			dedup_i++;
> +

This in-place de-duping is much nicer than what was in v1. There's still
a slight cost to the common case when we have no duplicates, but it's
minor (just an extra noop self-assignment of each index).

-Peff
