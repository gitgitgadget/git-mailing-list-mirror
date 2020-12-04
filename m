Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1EDC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965B322CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgLDUut (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:50:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:52176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbgLDUut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:50:49 -0500
Received: (qmail 705 invoked by uid 109); 4 Dec 2020 20:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 20:50:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16173 invoked by uid 111); 4 Dec 2020 20:50:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 15:50:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 15:50:08 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
Message-ID: <X8qhAO6uUDgHjP7S@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
 <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
 <X8qfRDsfLYTDL3HV@coredump.intra.peff.net>
 <05c616b0-138a-3e30-5a71-4ba9fb26e6ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05c616b0-138a-3e30-5a71-4ba9fb26e6ef@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 03:47:43PM -0500, Derrick Stolee wrote:

> > So before we were counting distinct commits, checking that our count
> > fits, and then _ignoring_ that count in order to create the actual list
> > of commits, and then checking that the actual list's count fits. We only
> > need one of those checks, and the important one is the one from the
> > actual list (they _should_ match, but due to the bug, they sometimes
> > didn't).
> > 
> > My "not likely to happen in practice" is not about the quality of the
> > check, but rather that being off by one would never matter in practice.
> > 
> > Does that make more sense?
> Makes sense to me. No need to change this patch at all.

I brushed up the commit message a bit to make those points clearer:

 7:  bbccccdc5c !  7:  23420dbd1b commit-graph: drop count_distinct_commits() function
    @@ Commit message
         the count are:
     
           - check if our count will overflow our data structures. But the limit
    -        there is 2^31 commits, so it's not likely to happen in practice.
    +        there is 2^31 commits, so while this is a useful check, the
    +        off-by-one is not likely to matter.
     
           - pre-allocate the array of commit pointers. But over-allocating by
    -        one isn't a problem.
    +        one isn't a problem; we'll just waste a few extra bytes.
     
         The bug would be easy enough to fix, but we can observe that neither of
    -    those steps is necessary. We'll check the count of the commit array
    -    after we build it anyway, so checking at this point is redundant. And we
    -    use ALLOC_GROW() when building the commit array, so there's no need to
    -    preallocate it (it's possible that doing so is slightly more efficient,
    -    but if we care we can just optimistically allocate one slot for each
    -    oid; I didn't bother here).
    +    those steps is necessary.
    +
    +    After building the actual commit array, we'll likewise check its count
    +    for overflow. So the extra check of the distinct commit count here is
    +    redundant.
    +
    +    And likewise we use ALLOC_GROW() when building the commit array, so
    +    there's no need to preallocate it (it's possible that doing so is
    +    slightly more efficient, but if we care we can just optimistically
    +    allocate one slot for each oid; I didn't bother here).
     
         So count_distinct_commits() isn't doing anything useful. Let's just get
         rid of that step.

-Peff
