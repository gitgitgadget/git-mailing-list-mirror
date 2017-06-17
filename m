Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1940B20282
	for <e@80x24.org>; Sat, 17 Jun 2017 12:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbdFQMd5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 08:33:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:42014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752902AbdFQMd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 08:33:57 -0400
Received: (qmail 20223 invoked by uid 109); 17 Jun 2017 12:33:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 12:33:56 +0000
Received: (qmail 13946 invoked by uid 111); 17 Jun 2017 12:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 08:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jun 2017 08:33:54 -0400
Date:   Sat, 17 Jun 2017 08:33:54 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec
 and lazy parsing of refspecs
Message-ID: <20170617123354.xolqjqdvofjtksll@sigill.intra.peff.net>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
 <xmqqa857wqay.fsf@gitster.mtv.corp.google.com>
 <CAM0VKj=1DiPZzGot34Ar9SQR8VWV8ugvzFhAMibnZ8d-4F+1QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=1DiPZzGot34Ar9SQR8VWV8ugvzFhAMibnZ8d-4F+1QA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2017 at 02:25:39PM +0200, SZEDER Gábor wrote:

> >>   - The same information is stored twice, wasting memory.
> >
> > True (but a few hundred bytes is nothing among friends ;-)
> 
> Indeed.  Even in my repos with close to 10k remotes the amount of
> memory wasted by the duplicated refspecs is not an problem, there are
> more pressing issues there.

This is sort of a side note, but I'm curious why you need 10k remotes.

We used to do this at GitHub as part of our fork storage (the shared
repository had each fork as a remote). We fixed the quadratic issues
like d0da003d5 (use a hashmap to make remotes faster, 2014-07-29). But
even the linear work to read the config is noticeable (and hits you on
every command, even ones that don't care about remotes).  Now instead we
pass the refspecs directly to fetch whenever move objects between the
storage repos. They were the same for every remote anyway (and I'd guess
that is true, too, of your 10k remotes).

-Peff
