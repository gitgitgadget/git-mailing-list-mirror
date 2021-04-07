Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B65C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBDC61108
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355660AbhDGTha (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:37:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:43644 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345628AbhDGTh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:37:29 -0400
Received: (qmail 17516 invoked by uid 109); 7 Apr 2021 19:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 19:37:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22259 invoked by uid 111); 7 Apr 2021 19:37:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 15:37:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 15:37:18 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
Message-ID: <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 07:10:43PM +0700, Bagas Sanjaya wrote:

> I request that git gc should have --repack-arguments option. The value
> of this option should be passed to git repack.

I think in general we prefer to make individual options configurable,
rather than having a blanket "pass along these options" argument, for
two reasons:

  - some options may cause the sub-program to behave unexpectedly. E.g.,
    if you put "-a" in the repack-arguments, that may be subverting
    git-gc's assumptions about how repack will behave

  - arguments are a list, not a string. So you have to provide some
    mechanism for splitting them (presumably on whitespace, but what if
    we need quoting)?

> The use case is when I have very large repos (such as GCC and Linux kernel)
> on a server with small RAM (1-2 GB). When doing gc on such repo, the repack
> step may hang because git-repack have to create single large packfile which
> can be larger than available memory (RAM+swap), so it must be necessary to
> do git repack --window-memory=<desired memory usage> --max-pack-size=<desired
> pack size> to create split and smaller packs instead.
> 
> There should also git config item gc.repackArguments, which have the same
> effect as git gc --repack-arguments, with the option takes precedence over
> the config.

You can set pack.windowMemory in your config already, to solve the first
part.

You can also set pack.packSizeLimit for the latter, though I do not
recommend it. It will not help with memory usage (neither while
repacking nor for later commands). We do mmap() the resulting packfiles,
but we rely on the operating system to manage the actual in-RAM working
set (but that is also true with multiple packfiles; we are happy to map
several of them at once). And it may make your on-disk size much larger.
We don't allow deltas between on-disk packs, which means some objects
which could be stored as deltas won't be. That in turn hurts on a
memory-starved system because we'll need more block cache to perform the
same task. It also results in extra CPU when serving fetches or pushing,
since we'll try to find new deltas between the packs on the fly.

-Peff
