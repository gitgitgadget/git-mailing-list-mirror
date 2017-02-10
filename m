Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863341FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdBJQbm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 11:31:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753349AbdBJQbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 11:31:41 -0500
Received: (qmail 13872 invoked by uid 109); 10 Feb 2017 16:05:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 16:05:00 +0000
Received: (qmail 5398 invoked by uid 111); 10 Feb 2017 16:04:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 11:04:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 11:04:58 -0500
Date:   Fri, 10 Feb 2017 11:04:58 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
Message-ID: <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702101647340.3496@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702101647340.3496@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 04:49:02PM +0100, Johannes Schindelin wrote:

> > I think this is only half the story. A heavy-sha1 workload is faster,
> > which is good. But one of the original reasons to prefer blk-sha1 (at
> > least on Linux) is that resolving libcrypto.so symbols takes a
> > non-trivial amount of time. I just timed it again, and it seems to be
> > consistently 1ms slower to run "git rev-parse --git-dir" on my machine
> > (from the top-level of a repo).
> > 
> > 1ms is mostly irrelevant, but it adds up on scripted workloads that
> > start a lot of git processes.
> 
> You know my answer to that. If scripting slows things down, we should
> avoid it in production code. As it is, scripting slows us down. Therefore
> I work slowly but steadily to get rid of scripting where it hurts most.

Well, yes. My question is more "what does it look like on normal Git
workloads?". Are you trading off an optimization for your giant 450MB
index workload (which _also_ could be fixed by trying do the slow
operation less, rather than micro-optimizing it) in a way that hurts
people working with more normal sized repos?

For instance, "make BLK_SHA1=Yes test" is measurably faster for me than
"make BLK_SHA1= test".

I'm open to the argument that it doesn't matter in practice for normal
git users. But it's not _just_ scripting. It depends on the user's
pattern of invoking git commands (and how expensive the symbol
resolution is on their system).

-Peff
