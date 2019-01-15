Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F511F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfAOTRQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:17:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:37268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729440AbfAOTRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:17:16 -0500
Received: (qmail 24367 invoked by uid 109); 15 Jan 2019 19:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12544 invoked by uid 111); 15 Jan 2019 19:17:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:17:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:17:14 -0500
Date:   Tue, 15 Jan 2019 14:17:14 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
Message-ID: <20190115191714.GD4886@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <20190111221539.GB10188@sigill.intra.peff.net>
 <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com>
 <20190112102635.GA16633@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 03:05:50PM +0100, Johannes Schindelin wrote:

> > But certainly it would not be the first such instance in our code base.
> 
> Just because a lot of our code has grown historically does not mean that
> we need to add code that shares the same shortcomings. FREE_AND_NULL() was
> not available for a long time, after all, so it is understandable that we
> did not use it back then. But it is available now, so we no longer have an
> excuse to add less defensive code.

Fair enough. I am happy to start using FREE_AND_NULL() consistently if
nobody things it's too opaque (or that it creates confusion that we
somehow expect to look at the variable again and need it to be NULL). I
think the compiler should generally be able to optimize out the NULL
assignment in most cases anyway.

> > In theory a static analyzer should easily be able to figure out such a
> > problem, too, so maybe it is not worth being defensive about.
> 
> How often do you run a static analyzer?

Stefan was routinely running coverity, though I haven't seen results in
a while. I think we should make sure that continues, as it did turn up
some useful results (and a lot of cruft, too, but on the whole I have
found it useful).

I also count gcc as a static analyzer, since it can and does point out
many simple problems. I don't know that it can point out an obvious
user-after-free like this, though.

That said....

> My point being: if we can prevent future mistakes easily, and it does not
> add too much code churn, why not just do it. No need to rely on fancy
> stuff that might not even be available on your preferred platform.

Yeah, I do agree (which is why I included it in the patch ;) ).

-Peff
