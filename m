Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9EF1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 21:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeKHGfH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 01:35:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:43996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726932AbeKHGfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 01:35:06 -0500
Received: (qmail 9560 invoked by uid 109); 7 Nov 2018 21:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 21:02:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18107 invoked by uid 111); 7 Nov 2018 21:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 16:02:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 16:02:56 -0500
Date:   Wed, 7 Nov 2018 16:02:56 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        andals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
Message-ID: <20181107210256.GC30078@sigill.intra.peff.net>
References: <20181104181026.8451-1-pclouds@gmail.com>
 <20181106171637.15562-1-pclouds@gmail.com>
 <871s7y6qs9.fsf@evledraar.gmail.com>
 <20181106221118.GA9975@sigill.intra.peff.net>
 <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 04:30:38PM +0100, Duy Nguyen wrote:

> > Could we help the reading scripts by normalizing old and new output via
> > interpret-trailers, %(trailers), etc?
> >
> > I think "(cherry picked from ...)" is already considered a trailer by
> > the trailer code. If the caller instructs us to, we could probably
> > rewrite it to:
> >
> >   Cherry-picked-from: ...
> >
> > in the output. Then the end-game is that scripts should just use
> > interpret-trailers, etc, and old and new commits will Just Work.
> 
> There is still one thing to settle. "revert -m1" could produce
> something like this
> 
>     This reverts commit <SHA1>, reversing
>     changes made to <SHA2>.
> 
> My proposal produces this
> 
>     Reverts: <SHA1>^2
> 
> And I can't really convert the former to latter without accessing
> object database (probably not a good idea?) to check if SHA2 is the
> second parent of SHA1. So either
> 
>  - I access object database anyway
>  - Generate just "Reverts: <SHA1>" (i.e. losing info) with interpret-trailers
>  - Change Reverts: tag to a different output format, or maybe use two
> tags instead.

IMHO the revert case is way less interesting for automated parsing. In a
workflow like Git's, cherry-picks aren't very common, but there _are_
workflows where there's a lot of cherry-picking between dev/release
branches, and automated analysis is useful there. Whereas for revert,
it's almost always a human-scale thing. A commit was bad, so you revert
it. The annotation is useful if you're digging, but it's not generally
going to be a fundamental part of a workflow. And it's not really any
different than fixing a bug later.

And I think that's reflected in the way we just casually stick the
reverted oid in the human-readable part of the commit message (and the
lack of any tools to parse it).

So IMHO it would be OK to treat this less carefully than the cherry-pick
case.

-Peff
