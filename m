Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA550C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiLFBVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFBVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:21:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90E1F63A
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:21:42 -0800 (PST)
Received: (qmail 11213 invoked by uid 109); 6 Dec 2022 01:21:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 01:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15929 invoked by uid 111); 6 Dec 2022 01:21:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 20:21:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 20:21:41 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y46ZJUsyp8UW5rFW@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g>
 <Y46M4oksPQkqwmTC@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y46M4oksPQkqwmTC@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 07:29:22PM -0500, Taylor Blau wrote:

> On Tue, Dec 06, 2022 at 08:57:21AM +0900, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > In git.git, it is sometimes common to write something like:
> > >
> > >     T *ptr;
> > >     CALLOC_ARRAY(ptr, 1);
> > >
> > > ...but that is confusing, since we're not initializing an array.
> >
> > Given that "man calloc" tells us that calloc takes two parameters,
> >
> >     void *calloc(size_t nmemb, size_t size);
> >
> > I personally find CALLOC() that takes only a single parameter and is
> > capable only to allocate a single element array very much confusing.
> 
> Hmm. I have always considered "calloc" a mental shorthand for "zero
> initialize some bytes on the heap". It seemed like you were in favor of
> such a change in:
> 
>     https://lore.kernel.org/git/xmqq8rl8ivlb.fsf@gitster.g/
> 
> ...but it's entirely possible that I misread your message, in which case
> I would not be sad if you dropped this patch on the floor since I don't
> feel that strongly about it.

I think the weird thing about calloc is that it does _two_ things
compared to malloc: zero-ing, and doing an implicit nmemb*size
multiplication.

So you can think of "allocate this one element and zero it" as "calloc,
but don't multiply" or as "malloc, but zero". Naming it CALLOC() is
thinking of it as the former. If we think of it as the latter it could
perhaps be MALLOCZ() or something. I don't know if that name is too
subtle or not. We have xmemdupz(), which is basically the same thing;
it's only a zero-terminator, but that is because we are writing non-zero
bytes in the rest of it. Mostly I'd worry that it is easy to glance past
the "Z".

-Peff
