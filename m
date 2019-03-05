Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F27F202BB
	for <e@80x24.org>; Tue,  5 Mar 2019 04:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfCEEvm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:51:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:38854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbfCEEvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:51:42 -0500
Received: (qmail 816 invoked by uid 109); 5 Mar 2019 04:51:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:51:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28734 invoked by uid 111); 5 Mar 2019 04:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:51:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:51:40 -0500
Date:   Mon, 4 Mar 2019 23:51:40 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190305045140.GH19800@sigill.intra.peff.net>
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com>
 <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 05:12:59PM +0700, Duy Nguyen wrote:

> On Sun, Mar 3, 2019 at 2:18 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> > One thing I am still worried about is if we are sure that adding
> > parallelism is likely to get us a significant performance improvement
> > or not. If the performance of this code is bounded by disk or memory
> > access, then adding parallelism might not bring any benefit. (It could
> > perhaps decrease performance if memory locality gets worse.) So I'd
> > like some confirmation either by running some tests or by experienced
> > Git developers that it is likely to be a win.
> 
> This is a good point. My guess is the pack access consists of two
> parts: deflate zlib, resolve delta objects (which is just another form
> of compression) and actual I/O. The former is CPU bound and may take
> advantage of multiple cores. However, the cache we have kinda helps
> reduce CPU work load already, so perhaps the actual gain is not that
> much (or maybe we could just improve this cache to be more efficient).
> I'm adding Jeff, maybe he has done some experiments on parallel pack
> access, who knows.

Sorry, I don't have anything intelligent to add here. I do know that
`index-pack` doesn't scale well with more cores. I don't think I've ever
looked at adding parallel access to the packs themselves. I suspect it
would be tricky due to a few global variables (the pack windows, the
delta cache, etc).

> The second good thing from parallel pack access is not about utilizing
> processing power from multiple cores, but about _not_ blocking. I
> think one example use case here is parallel checkout. While one thread
> is blocked by pack access code for whatever reason, the others can
> still continue doing other stuff (e.g. write the checked out file to
> disk) or even access the pack again to check more things out.

I'm not sure if it would help much for packs, because they're organized
to have pretty good cold-cache read-ahead behavior. But who knows until
we measure it.

I do suspect that inflating (and delta reconstruction) done in parallel
could be a win for git-grep, especially if you have a really simple
regex that is quick to search.

-Peff
