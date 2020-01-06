Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918ACC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9B2072C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFTjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:39:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:58150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726569AbgAFTjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:39:05 -0500
Received: (qmail 2430 invoked by uid 109); 6 Jan 2020 19:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 19:39:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24694 invoked by uid 111); 6 Jan 2020 19:44:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 14:44:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 14:39:03 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] fetch: set size_multiple in split_commit_graph_opts
Message-ID: <20200106193903.GB971477@coredump.intra.peff.net>
References: <pull.509.git.1577981654.gitgitgadget@gmail.com>
 <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 02, 2020 at 04:14:14PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In 50f26bd ("fetch: add fetch.writeCommitGraph config setting",
> 2019-09-02), the fetch builtin added the capability to write a
> commit-graph using the "--split" feature. This feature creates
> multiple commit-graph files, and those can merge based on a set
> of "split options" including a size multiple. The default size
> multiple is 2, which intends to provide a log_2 N depth of the
> commit-graph chain where N is the number of commits.
> 
> However, I noticed during dogfooding that my commit-graph chains
> were becoming quite large when left only to builds by 'git fetch'.
> It turns out that in split_graph_merge_strategy(), we default the
> size_mult variable to 2 except we override it with the context's
> split_opts if they exist. In builtin/fetch.c, we create such a
> split_opts, but do not populate it with values.
> 
> This problem is due to two failures:
> 
>  1. It is unclear that we can add the flag COMMIT_GRAPH_WRITE_SPLIT
>     with a NULL split_opts.
>  2. If we have a non-NULL split_opts, then we override the default
>     values even if a zero value is given.
> 
> Correct both of these issues. First, do not override size_mult when
> the options provide a zero value. Second, stop creating a split_opts
> in the fetch builtin.

Thanks, the explanation and fix (both parts) look good to me, modulo the
subject correction you already noted.

> ---
>  builtin/fetch.c | 4 +---
>  commit-graph.c  | 4 +++-

Is it worth covering this with a test?

I guess the non-fetch code paths for splitting already cover this pretty
well, and this is just about managing to get the right number into the
commit-graph code. So perhaps it isn't worth it.

-Peff
