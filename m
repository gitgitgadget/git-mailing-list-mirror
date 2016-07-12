Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28DA2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 07:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbcGLHjR (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 03:39:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43320 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbcGLHjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 03:39:17 -0400
Received: (qmail 20425 invoked by uid 102); 12 Jul 2016 07:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 03:39:18 -0400
Received: (qmail 5707 invoked by uid 107); 12 Jul 2016 07:39:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 03:39:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 03:39:12 -0400
Date:	Tue, 12 Jul 2016 03:39:12 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712073912.GA26431@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607120927410.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 09:30:28AM +0200, Johannes Schindelin wrote:

> On Mon, 11 Jul 2016, Junio C Hamano wrote:
> 
> > Those who care about 32-bit builds need to start building and
> > testing 'next' and 'master' regularly, or similar breakages are
> > bound to continue happening X-<.
> 
> Please note that "unsigned long" is 32-bit even on 64-bit Windows.

Yeah, that was part of the reason my run-time test checked
sizeof(unsigned long), and not any kind of "are we 64-bit?" compiler
options or output. So the "64BIT" prereq is actually a bit of a
misnomer; it is really "is your ULL 64-bit, because that's what we use
for time". :-/

> FWIW I have this monster patch as a starting point (I plan to work more on
> this today):

Cool! Thanks for working on this.

I suspect we should still do something about skipping those tests,
though, if only because the v2.9.x maint track is broken, and switching
to time_t is a sufficiently large change that we probably don't want it
for maint (it _seems_ like it shouldn't cause any problems, but I'm
wondering if we might inadvertently trigger funny issues around
signedness or something).

> From b65de5a56e18b038d432ba828d7714880b8e285c Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Tue, 12 Jul 2016 09:09:07 +0200
> Subject: [PATCH] HOTFIX: use time_t wherever appropriate
> 
> Git's source code assumes that unsigned long is at least as precise as
> time_t. Well, Git's source code is wrong.

Another problem with "unsigned long" is that we cannot handle times
older than 1970. Assuming most systems are sane enough to have a signed
time_t these days, this would fix that problem as well.

-Peff
