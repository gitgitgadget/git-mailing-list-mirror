Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BCC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC6E2076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJ3Nld (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 09:41:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:42486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3Nld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 09:41:33 -0400
Received: (qmail 7102 invoked by uid 109); 30 Oct 2020 13:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 13:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21417 invoked by uid 111); 30 Oct 2020 13:41:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 09:41:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 09:41:31 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/10] hashmap: introduce a new hashmap_partial_clear()
Message-ID: <20201030134131.GD3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <061ab45a9bdae5352f62fa6e81bb21ae5c94b8df.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <061ab45a9bdae5352f62fa6e81bb21ae5c94b8df.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:44AM +0000, Elijah Newren via GitGitGadget wrote:

> merge-ort is a heavy user of strmaps, which are built on hashmap.[ch].
> reset_maps() in merge-ort was taking about 12% of overall runtime in my
> testcase involving rebasing 35 patches of linux.git across a big rename.
> reset_maps() was calling hashmap_free() followed by hashmap_init(),
> meaning that not only was it freeing all the memory associated with each
> of the strmaps just to immediately allocate a new array again, it was
> allocating a new array that wasy likely smaller than needed (thus

s/wasy/was/

> resulting in later need to rehash things).  The ending size of the map
> table on the previous commit was likely almost perfectly sized for the
> next commit we wanted to pick, and not dropping and reallocating the
> table immediately is a win.
> 
> Add some new API to hashmap to clear a hashmap of entries without
> freeing map->table (and instead only zeroing it out like alloc_table()
> would do, along with zeroing the count of items in the table and the
> shrink_at field).

This seems like a reasonable optimization to make, and doesn't make the
API significantly more complicated. I'd expect the allocation of actual
entry objects to dwarf the table allocation, but I guess:

  - you'll deal with the individual entries later using a mempool

  - it's not just the allocation, but the re-insertion of the entries as
    we grow

It would be nice if we had some actual perf numbers to report here, so
we could know exactly how much it was buying us. But I guess things are
a bit out-of-order there. You want to do this series first and then
build merge-ort on top as a user. We could introduce the basic data
structure first, then merge-ort, and then start applying optimizations
with real-world measurements. But I'm not sure it's worth the amount of
time you'd have to spend to reorganize in that way.

>  hashmap.c | 39 +++++++++++++++++++++++++++------------
>  hashmap.h | 13 ++++++++++++-

The implementation itself looks correct to me. I already mentioned my
thoughts on naming in patch 1.

-Peff
