Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377E91F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 12:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbdIFMjt (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 08:39:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:58508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753087AbdIFMjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 08:39:45 -0400
Received: (qmail 15938 invoked by uid 109); 6 Sep 2017 12:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 12:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21531 invoked by uid 111); 6 Sep 2017 12:40:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 08:40:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 08:39:43 -0400
Date:   Wed, 6 Sep 2017 08:39:43 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/10] towards clean leak-checker output
Message-ID: <20170906123943.335degmzmokqrd7p@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
 <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
 <CAN0heSrz=tVHj13X+yHJpAR=5o7j8EqbBdw8hvrhcnhbA04QAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrz=tVHj13X+yHJpAR=5o7j8EqbBdw8hvrhcnhbA04QAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 10:41:51PM +0200, Martin Ågren wrote:

> FWIW, this series (combined with the other series you mentioned) makes
> t0000 and t0001 pass for me with gcc/clang. There are actually some
> leaks in t0000, they're just silently being reported to stderr, since
> the exit statuses from git are hidden by pipes. Maybe you're already
> aware of it. Depending on your definition of "running clean" it might be
> out of scope for this series, which is of course still very interesting
> and enlightening as it stands.

Yeah, I saw those. I don't think they're worth hunting down at this
point. It's quite probable that the same leaks are exercised elsewhere,
and we'll catch them later.

Once the whole test suite runs without reporting any leaks via abort(),
I'll feel more compelled to start grepping stderr for other cases. :)

> One is in cmd_show (you did mention git show) where we leak data in rev.
> The other is some use of strdup. I can't immediately figure out how to
> get a useful stacktrace (you mentioned this as well) and it's past
> bed-time here. I'll try to play more with this tomorrow.

I think I got funny truncated stack traces with just LSAN that went away
with ASAN, but I didn't dig. If you try that, remember that:

  - Technically just SANITIZE=address turns on the leak detector, but
    you need "leak" in the string to turn on the UNLEAK() magic. So use
    "SANITIZE=address,leak".

  - You'll have to set ASAN_OPTIONS=abort_on_error=1 in the environment
    manually to enable leak detection.

Once the test suite passes with leak detection on, I think we'd probably
do both of those automatically (but until then they make ASAN by itself
unusable).

> Note for self: getting rid of all pipes would probably also help flush
> out a few leaks (or "introduce" them, depending on your viewpoint).

Agreed. These leaks are really just a special form of bug. Those pipes
could be hiding other bugs, too. But again, I'm not too concerned. The
places that pipe git are doing so because they are not meant to be
testing that particular command (and it should generally be covered
elsewhere).

-Peff
