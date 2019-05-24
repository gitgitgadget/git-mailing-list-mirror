Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689DE1F462
	for <e@80x24.org>; Fri, 24 May 2019 06:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfEXGNy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:13:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387936AbfEXGNy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:13:54 -0400
Received: (qmail 24879 invoked by uid 109); 24 May 2019 06:13:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 06:13:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6351 invoked by uid 111); 24 May 2019 06:14:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 02:14:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 02:13:52 -0400
Date:   Fri, 24 May 2019 02:13:52 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [GSoC] How to protect cached_objects
Message-ID: <20190524061352.GB25694@sigill.intra.peff.net>
References: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 01:51:47PM -0300, Matheus Tavares Bernardino wrote:

> As one of my first tasks in GSoC, I'm looking to protect the global
> states at sha1-file.c for future parallelizations. Currently, I'm
> analyzing how to deal with the cached_objects array, which is a small
> set of in-memory objects that read_object_file() is able to return
> although they don't really exist on disk. The only current user of
> this set is git-blame, which adds a fake commit containing
> non-committed changes.
> 
> As it is now, if we start parallelizing blame, cached_objects won't be
> a problem since it is written to only once, at the beginning, and read
> from a couple times latter, with no possible race conditions.
> 
> But should we make these operations thread safe for future uses that
> could involve potential parallel writes and reads too?
> 
> If so, we have two options:
> - Make the array thread local, which would oblige us to replicate data, or
> - Protect it with locks, which could impact the sequential
> performance. We could have a macro here, to skip looking on
> single-threaded use cases. But we don't know, a priori, the number of
> threads that would want to use the pack access code.

It seems like a lot of the sha1-reading code is 99% read-only, but very
occasionally will require a write (e.g., refreshing the packed_git list
when we fail a lookup, or manipulating the set of cached mmap windows).

I think pthreads has read/write locks, where many readers can hold the
lock simultaneously but a writer blocks readers (and other writers).
Then in the common case we'd only pay the price to take the lock, and
not deal with contention. I don't know how expensive it is to take such
a read lock; it's presumably just a few instructions but implies a
memory barrier. Maybe it's worth timing?

-Peff
