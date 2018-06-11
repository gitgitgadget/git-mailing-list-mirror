Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A501F403
	for <e@80x24.org>; Mon, 11 Jun 2018 06:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeFKGIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 02:08:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753899AbeFKGIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 02:08:35 -0400
Received: (qmail 5821 invoked by uid 109); 11 Jun 2018 06:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 06:08:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13574 invoked by uid 111); 11 Jun 2018 06:08:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 02:08:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 02:08:33 -0400
Date:   Mon, 11 Jun 2018 02:08:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180611060832.GB28598@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
 <nycvar.QRO.7.76.6.1806092241180.77@tvgsbejvaqbjf.bet>
 <410f0fee-010c-c178-224c-e47ae0b0dda6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <410f0fee-010c-c178-224c-e47ae0b0dda6@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 12:44:25AM +0200, Johannes Sixt wrote:

> > I agree with Peff: this is something you as a user need to be aware of,
> > and need to make sure you configure your Git just like you want. As long
> > as this is a purely opt-in feature, it is useful and helpful.
> 
> The problem with this feature is not so much that it enables someone to do
> bad things, but that it is specifically targeted at recording *how users use
> Git*.

I think one issue here is that we are not looking at concrete patches.
So for instance, I've seen a claim that Git should never have a way to
turn on tracing all the time. But at GitHub we have found it useful to
have a config option to log the sha1 of every object that is dropped by
git-prune or by "repack -ad". It's helped both as a developer (tracking
down races or bugs in our code) and as an administrator (figuring out
where a corruption was introduced). It needs to be on all the time to be
useful, since the point is to have an audit trail to look at _after_ a
bad thing happens.

That's something we do completely on the server side; I don't think
there are any privacy or "spying" issues there. And I don't think it's a
huge maintenance burden. Inside the existing code, it's literally a
one-line "log this" (the log code itself is a hundred or so lines in its
own file).

Now most users probably don't care that much about this use case. And
I'm OK to apply it as a custom patch. But doesn't it seem like that's
something other people hosting Git repos might want? Or that the concept
might extend to other loggable items that _are_ interesting on the
client side?

That's why I think it is worth taking this step-by-step. Let's log more
things. Let's make enabling tracing more flexible. Those are hopefully
uncontentious and universally useful. If you want to draw the line on
"spying", then I think the right place to draw it is when somebody wants
to ship code to actually move those logs out of the user's control.

-Peff
