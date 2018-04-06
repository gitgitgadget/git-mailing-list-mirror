Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFAE1F42D
	for <e@80x24.org>; Fri,  6 Apr 2018 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDFVkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:40:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:56566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751532AbeDFVkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:40:09 -0400
Received: (qmail 29775 invoked by uid 109); 6 Apr 2018 21:40:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:40:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30153 invoked by uid 111); 6 Apr 2018 21:41:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:41:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:40:07 -0400
Date:   Fri, 6 Apr 2018 17:40:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
Message-ID: <20180406214006.GE7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87fu4hwgfa.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180403132717.GC18824@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1804031758160.5026@qfpub.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804031758160.5026@qfpub.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 06:00:05PM +0200, Johannes Schindelin wrote:

> > But if we're at the point of creating custom C builtins for
> > busybox/dash/etc, you should be able to create a primitive for "read
> > this using buffered stdio, other processes be damned, and return one
> > line at a time".
> 
> Well, you know, I do not think that papering over the root cause will make
> anything better. And the root cause is that we use a test framework
> written in Unix shell.

I'm not entirely convinced of this. My earlier numbers show that we
spend a lot of time actually running Git. But that's not because we're
written in shell, but because the stable interface to Git is running
individual processes.

So we can unit-test wildmatch or similar in a single C program, but I
think we inherently need to run "git init" a lot of times.

Now I think there's reason to doubt some of my numbers. I was counting
exec's, and non-exec forks due to subshells, etc, may be important. So I
claim only that I remain unconvinced that we are certain of the root
cause.

At any rate, I would be happy to see more study into this. If we can
create a measurable speedup for an existing script, that might give us a
blueprint for speeding up the whole suite.

-Peff
