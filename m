Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D424C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D693061246
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJVSeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:44620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbhJVSeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:34:18 -0400
Received: (qmail 22807 invoked by uid 109); 22 Oct 2021 18:31:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Oct 2021 18:31:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21143 invoked by uid 111); 22 Oct 2021 18:31:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Oct 2021 14:31:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Oct 2021 14:31:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXMDm3ZzgE1UGSwk@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
 <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
 <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
 <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
 <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
 <211022.86h7d9kzgt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211022.86h7d9kzgt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 12:51:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Yes, the same numbers are noted in the 7/8 commit message. I.e. it's
> slower on -j1, but faster with higher -j<n> numbers.
> 
> Aside from any changes I'm proposing here it seems rather pointless to
> me to optimize the runtime of -j1 runs.
> 
> I think we use those in e.g. CI, so of course if they become *really*
> slow it will matter, but the purpose of this change is to make hacking
> on git easier, both in terms of runtime and discovering what the
> Makefile is doing wih V=1.
> 
> I think anyone hacking on git is going to be on a system with -j2 at
> least. So again, separate from these specific changes, if we've got a
> change that speeds up -jN runs at the cost of a -j1 run that seems like
> good thing.

It seems weird to me to assume that all of our processors are available
to build command-list.h. In most cases you are not running "make -j16
command-list.h", but rather "make -j16", and those other processors are
doing useful things, like say, building actual C code.

So counting CPU time is the interesting thing, because every cycle you
save there gets used for other work. And "make -j1" just brings
wall-clock and CPU time together.

-Peff
