Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD82C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2838364DA5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBPQDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:03:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhBPQDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:03:08 -0500
Received: (qmail 13711 invoked by uid 109); 16 Feb 2021 16:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 16:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26039 invoked by uid 111); 16 Feb 2021 16:02:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 11:02:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 11:02:23 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvsj2Teym2K06wa@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
 <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
 <YCvoQBhmCeeR9Cup@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvoQBhmCeeR9Cup@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 10:44:00AM -0500, Taylor Blau wrote:

> On Tue, Feb 16, 2021 at 09:54:24AM -0500, Jeff King wrote:
> > This is all on Linux, of course. Perhaps other systems with slower
> > syscalls may be more impacted.
> 
> I timed it on macOS, which (as you know) I don't use for daily
> development, but it's a useful testbed from time to time.
> 
> On your branch, 'git check-attr -a' took 193.4ms with O_NOFOLLOW, and
> 245.3ms without. After touching every .gitattributes file, those numbers
> shot up to 340.9ms and 346.6ms, respectively.
> 
> (All numbers on linux.git, of course).

That seems...really weird. Your "after touching every file" case is
slightly slower, which is totally expected. But why would the _before_
case be so different? It should have made exactly one extra lstat()
call, and replaced a bunch of open(NOFOLLOW) calls with lstat() (and if
those were so expensive, we'd have presumably seen it in the "touching
every file" case which is running _both_ syscalls).

Can you double-check your initial timings?

> There isn't an apples-to-apples comparison between my numbers and yours
> (since my laptop is much slower than yours), but the relative numbers
> are quite clear that only doing a single syscall is worth it in the
> non-pathological case.

I guess in a sense it doesn't matter that much how macos performs. If it
has O_NOFOLLOW, then it's a no-brainer to use it. The bigger question
is: how many platforms don't have it, and what are _their_ syscalls like
(and are they niche enough that we can accept a small slowdown)?

The obvious one we'd care the most about is Windows, but I still hold
out hope that there's some equivalent mechanism there we can use.

-Peff
