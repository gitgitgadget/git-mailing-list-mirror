Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419221F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeJIKaa (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:30:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:46910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725749AbeJIKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:30:30 -0400
Received: (qmail 7879 invoked by uid 109); 9 Oct 2018 03:15:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 03:15:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10448 invoked by uid 111); 9 Oct 2018 03:14:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Oct 2018 23:14:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Oct 2018 23:15:42 -0400
Date:   Mon, 8 Oct 2018 23:15:42 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181009031542.GD6250@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <20181005183904.GV23446@localhost>
 <20181005190216.GB17482@sigill.intra.peff.net>
 <20181005195413.GX23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005195413.GX23446@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:54:13PM +0200, SZEDER Gábor wrote:

> Runtimes tend to fluctuate quite a bit more on Travis CI compared to
> my machine, but not this much, and it seems to be consistent so far.
> 
> After scripting/querying the Travis CI API a bit, I found that from
> the last 100 static analysis build jobs 78 did actully run 'make
> coccicheck' [1], avaraging 470s for the whole build job, with only 4
> build job exceeding the 10min mark.
> 
> I had maybe 6-8 build jobs running this patch over the last 2-3 days,
> I think all of them were over 15min.  (I restarted some of them, so I
> don't have separate logs for all of them, hence the uncertainty.)

So that's really weird and counter-intuitive, since we should be doing
strictly less work. I know that spatch tries to parallelize itself,
though from my tests, 1.0.4 does not. I wonder if the version in Travis
differs in that respect and starts too many threads, and the extra time
is going to contention and context switches.

Have you tried passing "-j1" to spatch? My 1.0.4 does not even recognize
it.

That seems like a pretty unlikely explanation to me, but I am having
trouble coming up with another one.

I guess the other plausible thing is that the extra memory is forcing us
into some slower path. E.g., a hypervisor may even be swapping,
unbeknownst to the child OS, and it gets accounted in the child OS as
"boy, that memory load was really slow", which becomes used CPU.

That actually sounds more credible to me.

-Peff
