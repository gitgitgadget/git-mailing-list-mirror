Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BCC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D73C610D1
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhIPPBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:01:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:49058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235474AbhIPPBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:01:53 -0400
Received: (qmail 7304 invoked by uid 109); 16 Sep 2021 15:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 15:00:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4752 invoked by uid 111); 16 Sep 2021 15:00:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 11:00:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 11:00:30 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] tree-diff: fix leak when not HAVE_ALLOCA_H
Message-ID: <YUNcDsMkSPhIsFoI@coredump.intra.peff.net>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916085523.68581-1-carenas@gmail.com>
 <20210916085523.68581-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916085523.68581-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 01:55:22AM -0700, Carlo Marcelo Arenas Belón wrote:

> b8ba412bf7 (tree-diff: avoid alloca for large allocations, 2016-06-07)
> adds a way to route some bigger allocations out of the stack and free
> them through the addition of two conveniently named macros, but leaves
> the calls to free the xalloca part, which could be also in the heap,
> if the system doesn't HAVE_ALLOCA_H (ex: macOS and other BSD).
> 
> Add the missing free call, xalloca_free(), which is a noop if we
> allocated memory in the stack frame, but a real free() if we
> allocated in the heap instead, and while at it, change the expression
> to match in both macros for ease of readability.

Thanks, this is definitely my bug introduced by b8ba412bf7 and this is
the right fix.

I continue to find the whole xalloca() thing pretty gross, and doubly so
now that there are _two_ layers of "maybe alloca(), and maybe malloc()"
logic (one in xalloca(), and one in this FAST_ARRAY stuff).

We should definitely take this fix to address the immediate problem, but
I wonder if this size logic should be pushed into xalloca to make this
kind of problem harder. Of course this is the only caller, so it might
not matter much either way.

(I'd also be really happy to see it go away entirely, as alloca() is a
foot-gun in the first place. But I think it did make things slightly
faster. It might be worth re-measuring).

-Peff
