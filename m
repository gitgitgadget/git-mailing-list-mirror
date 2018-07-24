Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2151F597
	for <e@80x24.org>; Tue, 24 Jul 2018 04:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGXFcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 01:32:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388236AbeGXFcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 01:32:11 -0400
Received: (qmail 28677 invoked by uid 109); 24 Jul 2018 04:27:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 04:27:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24444 invoked by uid 111); 24 Jul 2018 04:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 00:27:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 00:27:40 -0400
Date:   Tue, 24 Jul 2018 00:27:40 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180724042740.GB13248@sigill.intra.peff.net>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 07:03:16PM +0200, Duy Nguyen wrote:

> > > Try bumping core.deltaBaseCacheLimit to see if that has any impact. It's
> > > 96MB by default.
> > >
> > > There may also be some possible work in making it more aggressive about
> > > storing the intermediate results. I seem to recall from past
> > > explorations that it doesn't keep everything, and I don't know if its
> > > heuristics have ever been proven sane.
> 
> Could we be a bit more flexible about cache size? Say if we know
> there's 8 GB memory still available, we should be able to use like 1
> GB at least (and that's done automatically without tinkering with
> config).

I have mixed feelings on that kind of auto-scaling for caches. Git isn't
always the only program running (or maybe you even have several git
operations running at once). So in many cases you'd want a more holistic
view of the system, and what resources are available.

The OS already does OK scheduling CPU and the block cache for our mmap'd
files. I don't know if there's a way to communicate with it about this
kind of cache. I guess asking "what memory is free" is one way to do
that. But it's not always the best answer (because we might be happy
trade off some block cache, etc). On the other hand, that would always
give us a conservative value, so if we picked min(96MB, free_mem /
nr_cpu) or something, that might be an OK rule of thumb.

-Peff
