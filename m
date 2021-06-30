Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0264C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DA161D81
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhF3CoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:44:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232222AbhF3CoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:44:03 -0400
Received: (qmail 22278 invoked by uid 109); 30 Jun 2021 02:41:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:41:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1198 invoked by uid 111); 30 Jun 2021 02:41:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:41:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:41:34 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] map_loose_object_1: attempt to handle ENOMEM from
 mmap
Message-ID: <YNvZ3lA6J8DIx2r4@coredump.intra.peff.net>
References: <20210629081108.28657-1-e@80x24.org>
 <20210629081108.28657-3-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210629081108.28657-3-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 08:11:06AM +0000, Eric Wong wrote:

> This benefits unprivileged users who lack permissions to raise
> the `sys.vm.max_map_count' sysctl and/or RLIMIT_DATA resource
> limit.
> 
> Multi-threaded callers to map_loose_object_1 (e.g. "git grep")
> appear to guard against thread-safety problems.  Other
> multi-core aware pieces of code (e.g. parallel-checkout) uses
> child processes

This one makes me slightly more nervous than the last, because we don't
know if somebody higher up the call stack might be expecting to use that
window again.

I _think_ this one is OK, because we would never read a loose object in
the process of reading a packed one. I thought we might in some rare
cases with corruption (e.g., B is a delta against A; we fail to read A
because it's corrupt, so we look elsewhere for a copy). I don't think
the current code is quite that clever, though. If B were corrupted, we'd
look elsewhere for a duplicate, but that logic doesn't apply in the
middle of a delta resolution (even though there are corruption cases it
would help recover from).

So I don't think this is introducing any bugs. But it worries me a bit
that it creates an opportunity for a subtle and hard-to-trigger
situation if we do change seemingly-unrelated code.

But looking more carefully at unuse_one_window(), I think the worst case
is a slight performance drop, as we unmap the window and then re-map
when somebody higher up the call-stack needs it again. My real worry was
that we could trigger a case where somebody was holding onto a pointer
to the bytes. But I think use_pack() will mark those bytes via
inuse_cnt, and then unuse_one_window() will never drop a window that has
a non-zero inuse_count.

So in that sense all of your patches should be correct without thinking
too hard no them. Sure, a performance drop from having to re-map the
window later isn't great, but if the alternative in each case is calling
die(), it's a strict improvement.

-Peff
