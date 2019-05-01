Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC781F453
	for <e@80x24.org>; Wed,  1 May 2019 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEASSK (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:18:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:46030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726019AbfEASSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:18:09 -0400
Received: (qmail 23319 invoked by uid 109); 1 May 2019 18:18:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:18:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20805 invoked by uid 111); 1 May 2019 18:18:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:18:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:18:07 -0400
Date:   Wed, 1 May 2019 14:18:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190501181807.GC4109@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
 <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
 <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
 <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
 <05e97774-5dd1-7224-940f-e50558118d93@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e97774-5dd1-7224-940f-e50558118d93@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 07:45:05PM +0200, René Scharfe wrote:

> > But since the performance is still not quite on par with `gzip`, I would
> > actually rather not, and really, just punt on that one, stating that
> > people interested in higher performance should use `pigz`.
> 
> Here are my performance numbers for generating .tar.gz files again:
> 
> master, using gzip(1):
>   Time (mean ± σ):     16.683 s ±  0.451 s    [User: 20.230 s, System: 0.375 s]
>   Range (min … max):   16.308 s … 17.852 s    10 runs
> 
> using zlib sequentially:
>   Time (mean ± σ):     19.898 s ±  0.228 s    [User: 19.825 s, System: 0.073 s]
>   Range (min … max):   19.627 s … 20.355 s    10 runs
> 
> using zlib asynchronously:
>   Time (mean ± σ):     17.300 s ±  0.198 s    [User: 20.825 s, System: 0.356 s]
>   Range (min … max):   17.042 s … 17.638 s    10 runs
> 
> using a gzip-lookalike:
>   Time (mean ± σ):     17.256 s ±  0.299 s    [User: 20.380 s, System: 0.294 s]
>   Range (min … max):   16.940 s … 17.804 s    10 runs
> 
> The last two have comparable system time, ca. 1% more user time and
> ca. 5% longer duration.  The second one has much better system time
> and 2% less user time and 19% longer duration.  Hmm.

I think the start_async() one seems like a good option. It reclaims most
of the (wall-clock) performance, isn't very much code, and doesn't leave
any ugly user-visible traces.

I'd be fine to see it come later, though, on top of the patches Dscho is
sending. Even though changing to sequential zlib is technically a change
in behavior, the existing behavior wasn't really planned. And given the
wall-clock versus CPU time tradeoff, it's not entirely clear that one
solution is better than the other.

> > And who knows, maybe nobody will complain at all about the performance?
> 
> Probably.  And popular tarballs would be cached anyway, I guess.

At GitHub we certainly do cache the git-archive output. We'd also be
just fine with the sequential solution. We generally turn down
pack.threads to 1, and keep our CPUs busy by serving multiple users
anyway.

So whatever has the lowest overall CPU time is generally preferable, but
the times are close enough that I don't think we'd care much either way
(and it's probably not worth having a config option or similar).

-Peff
