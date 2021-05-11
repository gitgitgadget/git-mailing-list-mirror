Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E668C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB3561621
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEKRz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:55:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKRz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:55:26 -0400
Received: (qmail 23825 invoked by uid 109); 11 May 2021 17:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 17:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25928 invoked by uid 111); 11 May 2021 17:54:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 13:54:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 13:54:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YJrEy8IPi+PFWuzT@coredump.intra.peff.net>
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 03:04:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> appears under -O3 (but not -O2). This makes the build pass under
> DEVELOPER=1 without needing a DEVOPTS=no-error.
> 
> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
> clang 7.0.1-8+deb10u2. We've had this warning since
> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
> 
> As noted in [2] this warning happens because the compiler doesn't
> assume that errno must be non-zero after a failed syscall. Let's work
> around it as suggested in that analysis. We now return -1 ourselves on
> error, and save away the value of errno in a variable the caller
> passes in.

Thanks, I think this describes the problem nicely.

> On Tue, May 11 2021, Junio C Hamano wrote:
> 
> > What's the concensus if any on this topic?
> 
> Having read Johannes's comments I think it's still most readable to
> just return -1 unconditionally. The resulting code isn't weird, I'd
> argue that it's a better pattern to save away errno like this, but the
> commit messages notes that we're working around a GCC bug.

Agreed. Returning "-1" is the usual style in our code base. And while I
think the original code is correct, I did have to go double-check the C
standard to confirm that it's so.

I slightly disagree with the notion that gcc's behavior is a bug. It
seems more like a lack of feature (it does not have any way to annotate
this special property of errno). But that is neither here nor there for
your patch, and really a matter of opinion. :)

> > In any case, this needs to be signed off before it gets carved into
> > our history.
> 
> Done, and also changed the variable name to minimize the size of the
> diff. A shorter name allowed for less re-flowing of lines.

It's quite short. I'm OK with it for a static-local function with few
callers like this, though.

-Peff
