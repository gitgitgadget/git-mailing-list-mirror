Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8317C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAC221D79
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgIKRwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:52:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54694 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgIKRwS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:52:18 -0400
Received: (qmail 2570 invoked by uid 109); 11 Sep 2020 17:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 17:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5398 invoked by uid 111); 11 Sep 2020 17:52:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 13:52:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 13:52:16 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200911175216.GA2693949@coredump.intra.peff.net>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 11:24:00AM -0400, Taylor Blau wrote:

> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 17405c73a9..81a2e65903 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -67,6 +67,12 @@ this option is given, future commit-graph writes will automatically assume
>  that this option was intended. Use `--no-changed-paths` to stop storing this
>  data.
>  +
> +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> +enforced. Commits whose filters are not calculated are stored as a
> +length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
> +Overrides the `commitGraph.maxNewFilters` configuration.

The BFXL chunk doesn't exist anymore in this iteration, right?

I wondered about having a user-facing "-1" here. My gut feeling is that
we usually use "0" to mean "no limit" in other places, and it probably
make sense to be consistent. It does look like we use both, though, and
I'm having trouble formulating a grep pattern to find examples that
doesn't produce a lot of noise.

These are "0 is no limit":

  pack.windowMemory
  pack.deltaCacheSize
  git-daemon --max-connections

These are "-1 is no limit":

  git-grep --max-depth
  rev-list --max-parents (I think?)

So I dunno. It's a pretty minor thing, but I think it's good to aim for
consistency, and since this is user-facing we won't be able to change it
later.

-Peff
