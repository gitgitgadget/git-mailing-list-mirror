Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770A31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfFSTIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:08:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:44422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726332AbfFSTIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:08:47 -0400
Received: (qmail 11821 invoked by uid 109); 19 Jun 2019 19:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 19:05:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8390 invoked by uid 111); 19 Jun 2019 19:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 15:09:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 15:08:45 -0400
Date:   Wed, 19 Jun 2019 15:08:45 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
Message-ID: <20190619190845.GD28145@sigill.intra.peff.net>
References: <20190619094630.32557-1-pclouds@gmail.com>
 <20190619102601.24913-1-avarab@gmail.com>
 <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 07:51:00PM +0700, Duy Nguyen wrote:

> > Wheras mine fixes e.g. the same issue for:
> >
> >     parallel 'git fetch {}' ::: $(git remote)
> >
> > Ditto for you running a "git" command and your editor running a
> > "fetch" at the same time.
> 
> You could sort of avoid the problem here too with
> 
> parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
> git gc --auto
> 
> It's definitely simpler, but of course we have to manually add
> --no-auto-gc in everywhere we need, so not quite as elegant.

This has the added advantage that the gc is deterministically run only
once after all of the fetches. Whereas any locking scheme is going to
run it randomly for at least _one_ of the fetches, but there may be
other fetches afterwards.

In a sense it might not matter, because any fetches which complete after
the auto-gc finishes would either trigger a new auto-gc or not. And if
not, then one could argue that it wasn't necessary.

But as a general rule, the cost of gc scales with the repo size, not
with the number of unpacked objects. So it's more efficient to stick as
many updates as you can into a single gc; the cost is running a gc at
all, not the incremental cost of including the new fetches. Or put
another way, by leaving some fetches from this round of commands out of
the gc, we will require another expensive gc sooner.

> Actually you could already do that with 'git -c gc.auto=false fetch', I guess.

Yeah. I wrote my other response before reading this part of the thread,
but IMHO Ævar's example argues even more for "git --no-auto-gc".

-Peff
