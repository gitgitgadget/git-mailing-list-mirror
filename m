Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF5C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F48208C9
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgH1HDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:03:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:43334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1HDg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 03:03:36 -0400
Received: (qmail 23231 invoked by uid 109); 28 Aug 2020 07:03:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 07:03:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3681 invoked by uid 111); 28 Aug 2020 07:03:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 03:03:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 03:03:35 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
Message-ID: <20200828070335.GB2105050@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <20200821201648.GH1165@coredump.intra.peff.net>
 <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 02:33:54PM -0700, Elijah Newren wrote:

> However, there's an important difference here between what I've done
> and what you've suggested for hashmap: my method did not deallocate
> hashmap->table in hashmap_clear() and then use lazy initialization.
> In fact, I think not deallocating the table was part of the charm --
> the table had already naturally grown to the right size, and because
> the repository has approximately the same number of paths in various
> commits, this provided me a way of getting a table preallocated to a
> reasonable size for all merges after the first (and there are multiple
> merges either when recursiveness is needed due to multiple merge
> bases, OR when rebasing or cherry-picking a sequence of commits).
> This prevented, as hashmap.h puts it, "expensive resizing".
> 
> So, once again, my performance ideas might be clashing with some of
> your desires for the API.  Any clever ideas for resolving that?

If the magic is in pre-sizing the hash, then it seems like the callers
ought to be feeding the size hint. That does make a little more work for
them, but I think there's real value in having consistent semantics for
"clear" across our data structures.

However, one cheat would be to free the memory but retain the size hint
after a clear. And then if we lazy-init, grow immediately to the hint
size. That's more expensive than a true reuse, because we do reallocate
the memory. But it avoids the repeated re-allocation during growth.

It may also be a sign that we should be growing the hash more
aggressively in the first place. Of course all of this is predicated
having some benchmarks. It would be useful to know which part actually
provided the speedup.

-Peff
