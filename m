Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244AC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B9861D70
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhF3CdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:33:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhF3CdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:33:07 -0400
Received: (qmail 22260 invoked by uid 109); 30 Jun 2021 02:30:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:30:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1160 invoked by uid 111); 30 Jun 2021 02:30:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:30:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:30:37 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] use_pack: attempt to handle ENOMEM from mmap
Message-ID: <YNvXTf6PG2zhbjdh@coredump.intra.peff.net>
References: <20210629081108.28657-1-e@80x24.org>
 <20210629081108.28657-2-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210629081108.28657-2-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 08:11:05AM +0000, Eric Wong wrote:

> Since use_pack() can already safely munmap packs to respect
> core.packedGitLimit, attempt to gracefully handle ENOMEM
> errors the same way by unmapping a window and retrying.
> 
> This benefits unprivileged users who lack permissions to raise
> the `sys.vm.max_map_count' sysctl and/or RLIMIT_DATA resource
> limit.
> 
> I've also verified it is safe to release a pack here by
> unconditionally calling unuse_one_window() before
> xmmap_gently():
> 
> 	--- a/packfile.c
> 	+++ b/packfile.c
> 	@@ -649,6 +649,7 @@ unsigned char *use_pack(struct packed_git *p,
> 					&& unuse_one_window(p))
> 					; /* nothing */
> 				do {
> 	+				unuse_one_window(p);
> 					win->base = xmmap_gently(NULL, win->len,
> 						PROT_READ, MAP_PRIVATE,
> 						p->pack_fd, win->offset);

I don't find that test-diff all that compelling, because we don't know
which window will get unused. I.e., if there is one that will get racily
unused, we might not hit it. I think it would be a lot more interesting
for finding problems if it did:

  while (unuse_one_window(p)) ;

to clear them all.

That said, I think this must be obviously correct because the code above
will potentially have just called unuse_one_window(p) already. So at
least if not obviously correct, no more buggy than the previous code. :)

-Peff
