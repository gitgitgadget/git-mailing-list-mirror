Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9823A1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJFCCV (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:02:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:43534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728044AbeJFCCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:02:20 -0400
Received: (qmail 24199 invoked by uid 109); 5 Oct 2018 19:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:02:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14911 invoked by uid 111); 5 Oct 2018 19:01:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:01:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:02:16 -0400
Date:   Fri, 5 Oct 2018 15:02:16 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005190216.GB17482@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <20181005183904.GV23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005183904.GV23446@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 08:39:04PM +0200, SZEDER Gábor wrote:

> > It should still be a net win, since the total CPU seems to drop by a
> > factor of 3-4.
> 
> Well, that's true when you have unlimited resources... :)  or it's
> true even then, when I have just enough resources, but not much
> contention.  After all, Coccinelle doesn't have to parse the same
> header files over and over again.  However, on Travis CI, where who
> knows how many other build jobs are running next to our static
> analysis, it doesn't seem to be the case.
> 
> On current master with an additional 'time' in front:
> 
>   time make --jobs=2 coccicheck
>   <...>
>   695.70user 50.27system 6:27.88elapsed 192%CPU (0avgtext+0avgdata 91448maxresident)k
>   5976inputs+2536outputs (42major+18411888minor)pagefaults 0swaps
> 
>   https://travis-ci.org/szeder/git/jobs/437733874#L574
> 
> With this patch, but without -j2 to fit into 3GB:
> 
>   960.50user 22.59system 16:23.74elapsed 99%CPU (0avgtext+0avgdata 1606156maxresident)k
>   5976inputs+1320outputs (26major+4548440minor)pagefaults 0swaps
> 
>   https://travis-ci.org/szeder/git/jobs/437734003#L575
> 
> Note that both the runtime and the CPU time increased. (and RSS, of
> course)

I'm not sure what to make of those results. Was the jump in CPU _caused_
by the patch, or does it independently fluctuate based on other things
happening on the Travis servers?

I.e., in the second run, do we know that the time would not have
actually been worse with the first patch?

-Peff
