Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF041F424
	for <e@80x24.org>; Sun, 24 Dec 2017 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbdLXOyb (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 09:54:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:46532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751029AbdLXOya (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 09:54:30 -0500
Received: (qmail 13277 invoked by uid 109); 24 Dec 2017 14:54:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Dec 2017 14:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3659 invoked by uid 111); 24 Dec 2017 14:54:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 24 Dec 2017 09:54:57 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Dec 2017 09:54:28 -0500
Date:   Sun, 24 Dec 2017 09:54:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor out
 rewrite_file())
Message-ID: <20171224145427.GG23648@sigill.intra.peff.net>
References: <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
 <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
 <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
 <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net>
 <c50ac174-15bd-60bc-490c-d231e3eb501d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c50ac174-15bd-60bc-490c-d231e3eb501d@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 10:01:45AM +0100, Johannes Sixt wrote:

> > Yeah, I have mixed feelings on that. I think it does make the control
> > flow less clear. At the same time, what I found was that handlers like
> > die/ignore/warn were the thing that gave the most reduction in
> > complexity in the callers.
> 
> Would you not consider switching over to C++? With exceptions, you get the
> error context without cluttering the API. (Did I mention that
> librarification would become a breeze? Do not die in library routines: not a
> problem anymore, just catch the exception. die_on_error parameters? Not
> needed anymore. Not to mention that resource leaks would be much, MUCH
> simpler to treat.)

I threw this email on my todo pile since I was traveling when it came,
but I think it deserves a response (albeit quite late).

It's been a long while since I've done any serious C++, but I did really
like the RAII pattern coupled with exceptions. That said, I think it's
dangerous to do it half-way, and especially to retrofit an existing code
base. It introduces a whole new control-flow pattern that is invisible
to the existing code, so you're going to get leaks and variables in
unexpected states whenever you see an exception.

I also suspect there'd be a fair bit of in converting the existing code
to something that actually compiles as C++.

So if we were starting the project from scratch and thinking about using
C++ with RAII and exceptions, sure, that's something I'd entertain[1]
(and maybe even Linus has softened on his opinion of C++ these days ;) ).
But at this point, it doesn't seem like the tradeoff for switching is
there.

-Peff

[1] I'd also consider Rust, though I'm not too experienced with it
    myself.
