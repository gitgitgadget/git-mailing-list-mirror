Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DD720248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfDOVf6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726696AbfDOVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:35:58 -0400
Received: (qmail 1600 invoked by uid 109); 15 Apr 2019 21:35:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Apr 2019 21:35:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6212 invoked by uid 111); 15 Apr 2019 21:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Apr 2019 17:36:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2019 17:35:56 -0400
Date:   Mon, 15 Apr 2019 17:35:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190415213556.GB28128@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 14, 2019 at 12:01:10AM +0200, René Scharfe wrote:

> >> As we already link to the zlib library, we can perform the compression
> >> without even requiring gzip on the host machine.
> >
> > Very cool. It's nice to drop a dependency, and this should be a bit more
> > efficient, too.
> 
> Getting rid of dependencies is good, and using zlib is the obvious way to
> generate .tgz files. Last time I tried something like that, a separate gzip
> process was faster, though -- at least on Linux [1].  How does this one
> fare?

I'd expect a separate gzip to be faster in wall-clock time for a
multi-core machine, but overall consume more CPU. I'm slightly surprised
that your timings show that it actually wins on total CPU, too.

Here are best-of-five times for "git archive --format=tar.gz HEAD" on
linux.git (the machine is a quad-core):

  [before, separate gzip]
  real	0m21.501s
  user	0m26.148s
  sys	0m0.619s

  [after, internal gzwrite]
  real	0m25.156s
  user	0m25.059s
  sys	0m0.096s

which does show what I expect (longer overall, but less total CPU).

Which one you prefer depends on your situation, of course. A user on a
workstation with multiple cores probably cares most about end-to-end
latency and using all of their available horsepower. A server hosting
repositories and receiving many unrelated requests probably cares more
about total CPU (though the differences there are small enough that it
may not even be worth having a config knob to un-parallelize it).

> Doing compression in its own thread may be a good idea.

Yeah. It might even make the patch simpler, since I'd expect it to be
implemented with start_async() and a descriptor, making it look just
like a gzip pipe to the caller. :)

-Peff
