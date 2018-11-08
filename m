Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFB51F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKHLCD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:02:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:44330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728256AbeKHLCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:02:02 -0500
Received: (qmail 19695 invoked by uid 109); 8 Nov 2018 01:29:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Nov 2018 01:29:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20909 invoked by uid 111); 8 Nov 2018 01:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 20:28:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 20:29:01 -0500
Date:   Wed, 7 Nov 2018 20:29:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        andals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
Message-ID: <20181108012901.GB10148@sigill.intra.peff.net>
References: <20181104181026.8451-1-pclouds@gmail.com>
 <20181106171637.15562-1-pclouds@gmail.com>
 <871s7y6qs9.fsf@evledraar.gmail.com>
 <20181106221118.GA9975@sigill.intra.peff.net>
 <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
 <xmqqh8gs9zh3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8gs9zh3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 09:36:56AM +0900, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > There is still one thing to settle. "revert -m1" could produce
> > something like this
> >
> >     This reverts commit <SHA1>, reversing
> >     changes made to <SHA2>.
> 
> I do not think it is relevant, with or without multiple parents, to
> even attempt to read this message.
> 
> The description is not meant to be machine readable/parseable, but
> is meant to be updated to describe the reason why the reversion was
> made for human readers.  Spending any cycle to attempt interpreting
> it by machines will give a wrong signal to encourage people not to
> touch it.  Instead we should actively encourage people to take that
> as the beginning of their description.
> 
> I even suspect that an update to that message to read something like
> these
> 
> 	"This reverts commit <SHA-1> because FILL IN THE REASONS HERE"
> 
> 	"This reverts commit <SHA-1>, reversing changes made to
> 	 <SHA-1>, because FILL IN THE REASONS HERE"

Yeah, that was the point I was trying to make earlier today in this
thread. I really think of this as a human-readable message.

But as far as how this impacts the addition of a trailer: once we have a
machine-readable "Reverts:", people naturally may want to know about
"Reverts" for older commits. Our options are:

  1. say "sorry, there was no machine-readable version back then"

  2. try to parse our "This reverts" message and normalize it into
     "Reverts" for their benefit.

Before introducing the new footer, it's worth thinking about the
end-game here. If we do (1), then people may want to parse themselves.
They are stuck parsing both the old and new (to handle old and new
commits). We could make life a little easier on them if we included
_both_ the English text and the machine-readable version. And then if
they just chose to parse the English, it would work for old and new.

But I guess that is really just a losing battle, if we consider the
English to be changeable. And doing it ourselves in (2) is really just
pushing that losing battle onto ourselves.

So if we are comfortable with saying that this is a new feature to have
the machine-readable trailer version, and there isn't a robust way to
get historical revert information (because there really isn't[1]), then
I think we can just punt on any kind of trailer-normalization magic.

-Peff

[1] Thinking back on reverts I have done, they are often _not_
    straight-up reverts. For example, I may end up dropping half of a
    commit, but leaving some traces of it in place in order to build up
    the correct solution on top (i.e., fixing whatever problem caused me
    to revert in the first place). I list those as "this is morally a
    revert of 1234abcd...", which is definitely not machine readable. ;)
