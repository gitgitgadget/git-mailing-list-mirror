Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7F8203EA
	for <e@80x24.org>; Tue, 20 Dec 2016 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933805AbcLTQpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:45:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:59009 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754758AbcLTQp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:45:29 -0500
Received: (qmail 2151 invoked by uid 109); 20 Dec 2016 16:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 16:45:28 +0000
Received: (qmail 5639 invoked by uid 111); 20 Dec 2016 16:46:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 11:46:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Dec 2016 11:45:26 -0500
Date:   Tue, 20 Dec 2016 11:45:26 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
Message-ID: <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
 <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
 <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
 <alpine.DEB.2.20.1612201511480.54750@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612201511480.54750@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 03:12:35PM +0100, Johannes Schindelin wrote:

> > On Dec 19, 2016, at 09:45, Johannes Schindelin wrote:
> > 
> > >ACK. I noticed this problem (and fixed it independently as a part of a
> > >huge patch series I did not get around to submit yet) while trying to
> > >get Git to build correctly with Visual C.
> > 
> > Does this mean that Dscho and I are the only ones who add -DNDEBUG for
> > release builds?  Or are we just the only ones who actually run the test
> > suite on such builds?
> 
> It seems you and I are for the moment the only ones bothering with running
> the test suite on release builds.

I wasn't aware anybody actually built with NDEBUG at all. You'd have to
explicitly ask for it via CFLAGS, so I assume most people don't.
Certainly I never have when deploying to GitHub's cluster (let alone my
personal use), and I note that the Debian package also does not.

So from my perspective it is not so much "do not bother with release
builds" as "are release builds even a thing for git?".  One of the
reasons I suggested switching the assert() to a die("BUG") is that the
latter cannot be disabled. We generally seem to prefer those to assert()
in our code-base (though there is certainly a mix). If the assertions
are not expensive to compute, I think it is better to keep them in for
all builds. I'd much rather get a report from a user that says "I hit
this BUG" than "git segfaulted and I have no idea where" (of course I
prefer a backtrace even more, but that's not always an option).

I do notice that we set NDEBUG for nedmalloc, though if I am reading the
Makefile right, it is just for compiling those files. It looks like
there are a ton of asserts there that _are_ potentially expensive, so
that makes sense.

-Peff
