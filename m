Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33FC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B673E20578
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgJ3O4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:56:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:42564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3O4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:56:05 -0400
Received: (qmail 7445 invoked by uid 109); 30 Oct 2020 14:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 14:56:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21848 invoked by uid 111); 30 Oct 2020 14:56:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 10:56:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 10:56:04 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 10/10] strmap: enable allocations to come from a
 mem_pool
Message-ID: <20201030145604.GJ3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <eca4f1ddbaa1cd8dc3fc64dbe9206af538cb317d.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eca4f1ddbaa1cd8dc3fc64dbe9206af538cb317d.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:50AM +0000, Elijah Newren via GitGitGadget wrote:

> For heavy users of strmaps, allowing the keys and entries to be
> allocated from a memory pool can provide significant overhead savings.
> Add an option to strmap_ocd_init() to specify a memory pool.

So this one interacts badly with my FLEXPTR suggestion.

I guess it provides most of the benefit that FLEXPTR would, because
we're getting both the entries and the strings from the mempool. Which
really ends up being an almost identical memory layout, since the
mempool presumably just gives you the N bytes for the string right after
the last thing you allocated, which would be the struct.

The only downside is that if you don't want to use the mempool (e.g.,
because you might actually strmap_remove() things), you don't get the
advantage.

I think we could fall back to a FLEXPTR when there's no mempool (or even
when there is, though you'd be on your own to reimplement the
computation parts of FLEXPTR_ALLOC). I'm not sure how ugly it would end
up.

I haven't used our mem_pool before, but the code all looks quite
straightforward to me. I guess the caller is responsible for
de-allocating the mempool, which makes sense. It would be nice to see
real numbers on how much this helps, but again, you might not have the
commits in the right order to easily find out.

-Peff
