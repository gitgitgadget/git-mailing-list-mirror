Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760241F667
	for <e@80x24.org>; Fri, 11 Aug 2017 00:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbdHKAR3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 20:17:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:35634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751492AbdHKAR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 20:17:28 -0400
Received: (qmail 4777 invoked by uid 109); 11 Aug 2017 00:17:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 00:17:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12124 invoked by uid 111); 11 Aug 2017 00:17:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 20:17:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 20:17:26 -0400
Date:   Thu, 10 Aug 2017 20:17:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170811001726.tmgascordtw4ksiz@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708101111080.11175@virtualbox>
 <20170810213348.g4lue3j4uz6qapal@sigill.intra.peff.net>
 <xmqqshgz1319.fsf@gitster.mtv.corp.google.com>
 <20170810230902.wnzoiaxdaus74a5i@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810230902.wnzoiaxdaus74a5i@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 07:09:02PM -0400, Jeff King wrote:

> The first is "should we eventually drop support for antiquated versions
> of dependencies?". And the argument in favor is the one I was making
> here: besides lowering maintenance cost, it is more honest to our users
> about what to expect[1].

As usual, I forgot all my footnotes.

[1] When I've talked about keeping expectations reasonable, I'm a lot
    less interested in "oops, I built Git and this particular feature
    didn't work". It's easy to write that off as "well, you have an old
    version of curl, patches welcome". I'm much more concerned about
    security issues. Curl is network-facing. Leaving aside security
    vulnerabilities in curl itself (which hopefully distros with 10-year
    support periods would fix), I wouldn't be surprised if there are
    bad interactions possible due to our tangle of ifdefs.

    One way to address that would be more careful auditing. But then
    that goes back to the cost/benefit thing.

> One is to do it by date and what dependencies are in long-term OS
> releases, and then compare that to the benefit. Requiring curl 7.11.1
> still keeps us working back to rhel4, which was already end-of-lifed
> completely after a 12 year run. Bumping to 7.16.0 drops rhel4 and rhel5,
> the latter of which is in its final "barely supported" phase after 10
> years. But it gives us a bit more bang for our buck by making CURL_MULTI
> uconditional[2].  Requiring 7.19.4 actually doesn't drop any more rhel
> releases. So by that metric, we might as well go there.

[2] The line-count change from dropping CURL_MULTI isn't _too_ exciting.
    But a lot of the tangled design of our http code revolves around
    the abstractions we've introduced. I have a feeling that it will
    enable further cleanups as we move forward (OTOH, a lot of the worst
    parts of our design are because of _using_ curl_multi for dumb http,
    which of course hardly anyone does these days. But I have a feeling
    if I suggested removing that, people would really scream).

-Peff
