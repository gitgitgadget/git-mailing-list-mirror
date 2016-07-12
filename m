Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83571FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbcGLPQj (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:16:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:43499 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755034AbcGLPQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:16:39 -0400
Received: (qmail 7378 invoked by uid 102); 12 Jul 2016 15:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:16:33 -0400
Received: (qmail 3451 invoked by uid 107); 12 Jul 2016 15:16:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:16:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 11:16:30 -0400
Date:	Tue, 12 Jul 2016 11:16:30 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712151630.GE613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 07:34:14AM -0700, Junio C Hamano wrote:

> > Git's source code assumes that unsigned long is at least as precise as
> > time_t. Well, Git's source code is wrong.
> > ...
> 
> That is correct.  As people mentioned downthread already, "unsigned
> long" has two problems, it may not be wide enough, and it cannot
> represent time before the epoch.
> 
> But moving the internal time representation used in various fields
> like commit->date to time_t is likely to be a wrong thing to do,
> because the first problem with "unsigned long", i.e. "may not be
> wide enough", is not limited to "not wide enough to hold time_t".
> It also includes "it may not be wide enough to hold time somebody
> else recorded in existing objects".

But that's a problem no matter what size we choose. The ascii format in
the commit objects is arbitrary-length, so somebody can always overflow
it. So even with intmax_t we have to clamp it to a sentinel value at
some point. IMHO we are better off to do so at parse time, and then have
consistent sizes through the rest of the code base, without worrying
about juggling intmax_t to time_t truncation in multiple places.

IOW, I think we probably interact with the system time libraries more
often than we parse (and it's easy to wrap the parsing in a function,
but there are a lot of system time functions).

-Peff
