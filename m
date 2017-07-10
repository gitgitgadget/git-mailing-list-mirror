Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A80A20357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbdGJRo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:44:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:35824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754490AbdGJRo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:44:56 -0400
Received: (qmail 28336 invoked by uid 109); 10 Jul 2017 17:44:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 17:44:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7666 invoked by uid 111); 10 Jul 2017 17:45:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:45:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 13:44:54 -0400
Date:   Mon, 10 Jul 2017 13:44:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
Message-ID: <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
 <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 10:35:24AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You can already build and test with ASan by doing:
> >
> >   make CFLAGS=-fsanitize=address test
> >
> > but there are a few slight annoyances:
> >
> >   1. It's a little long to type.
> >
> >   2. It override your CFLAGS completely. You'd probably
> >      still want -O2, for instance.
> >
> >   3. It's a good idea to also turn off "recovery", which
> >      lets the program keep running after a problem is
> >      detected (with the intention of finding as many bugs as
> >      possible in a given run). Since Git's test suite should
> >      generally run without triggering any problems, it's
> >      better to abort immediately and fail the test when we
> >      do find an issue.
> 
> Unfortunately I do not think Comparing between versions in
> https://gcc.gnu.org/onlinedocs, it appears that -fsanitize-recover
> is not configurable for folks still with GCC 4.x series, and this
> patch is not very useful unless you disable the recovery for the
> purpose of running our tests as you said X-<.

I didn't actually dig into the history of gcc support at all. Back in
the 4.x time-frame I tried using ASan and couldn't get it to work at
all. I ended up just always building with clang (which from my
mostly-ignorant view seems to to be the primary platform for ASan
development).

Since this is an optional build that doesn't need to be available
everywhere, I'd actually be fine with saying "just use clang". But as
far as I can tell, gcc seems to work fine these days. I consider this
mostly a best-effort tool.

I'm also not sure of the behavior without -fno-sanitize-recover. I think
ASan may barf either way. The commit message for my config.mak from a
year or two ago claims that the problem was actually with UBSan. It
would be useful in the long run for that to work, too.

-Peff
