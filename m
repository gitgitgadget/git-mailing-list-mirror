Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835B21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeIDVED (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:04:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:38330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726312AbeIDVED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:04:03 -0400
Received: (qmail 17634 invoked by uid 109); 4 Sep 2018 16:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Sep 2018 16:38:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4388 invoked by uid 111); 4 Sep 2018 16:38:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Sep 2018 12:38:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2018 12:38:08 -0400
Date:   Tue, 4 Sep 2018 12:38:08 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180904163807.GA23572@sigill.intra.peff.net>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
 <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 06:13:36PM +0200, Duy Nguyen wrote:

> > > Doh, of course. I even thought about this issue and dug all the way into
> > > reopen_lock_file(), but for some reason temporarily forgot that O_WRONLY
> > > does not imply O_TRUNC.
> > >
> > > Arguably this should be the default for reopen_lockfile(), as getting a
> > > write pointer into an existing file is not ever going to be useful for
> > > the way Git uses lockfiles. Opening with O_APPEND could conceivably be
> > > useful, but it's pretty unlikely (and certainly not helpful here, and
> > > this is the only caller). Alternatively, the function should just take
> > > open(2) flags.
> > >
> > > At any rate, I think this perfectly explains the behavior we're seeing.
> >
> > Thanks all for digging this down (I am a bit jealous to see that I
> > seem to have missed all this fun over the weekend X-<).
> 
> And just to be clear I'm looking forward to a patch from Jeff to fix
> this since he clearly put more thoughts on this than me. With commit.c
> being the only user of reopen_lock_file() I guess it's even ok to just
> stick O_TRUNC in there and worry about O_APPEND when a new caller
> needs that.

That's the way I'm leaning to. The fix is obviously a one-liner, but I
was hoping to construct a minimal test case. I just haven't gotten
around to it yet.

The bug is ancient, so I don't think it's important for v2.19.

-Peff
