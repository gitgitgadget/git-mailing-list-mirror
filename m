Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E3B1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfJAPHa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 11:07:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726309AbfJAPHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 11:07:30 -0400
Received: (qmail 12294 invoked by uid 109); 1 Oct 2019 15:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 01 Oct 2019 15:07:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12420 invoked by uid 111); 1 Oct 2019 15:10:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Oct 2019 11:10:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Oct 2019 11:07:29 -0400
From:   Jeff King <peff@peff.net>
To:     Ali Utku Selen <auselen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] shallow.c: Don't free unallocated slabs
Message-ID: <20191001150729.GI10875@sigill.intra.peff.net>
References: <20190930233310.19287-1-auselen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930233310.19287-1-auselen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 01, 2019 at 01:33:10AM +0200, Ali Utku Selen wrote:

> Fix possible segfault when cloning a submodule shallow.

Thanks. Just looking at the context, this is clearly the right thing to
be doing.

> It is possible to have unallocated slabs in shallow.c's commit_depth
> for a shallow submodule with many commits.

Yeah, the trick here is that we may over-allocate the slab list but not
fill all of the entries. This is really an internal implementation
detail of how the slab code works. It would be nice if callers didn't
have to care about it. Perhaps we ought to have a slab foreach()
function that encapsulates this, which would let this caller do
something like:

  commit_depth_foreach(&depths, free_commit_depth);
  commit_depth_clear(&depths);

But since this is the only place that looks into the slab in this way,
I'm happy to take your much simpler fix in the meantime.

> Easiest way to reproduce this I found was changing COMMIT_SLAB_SIZE to
> 32 and run t7406-submodule-update.sh. Segfault happens in case 50:
> "submodule update clone shallow submodule outside of depth"

It would be nice to have a test, but I suspect it would be kind of
expensive, since it requires 512kb+ of entries (and would obviously be
depending on this arbitrary internal value). Given the simplicity of the
fix, I think we can live without it.

-Peff
