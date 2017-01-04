Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6692205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 07:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933752AbdADHBP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 02:01:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:34985 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933920AbdADHBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 02:01:13 -0500
Received: (qmail 1253 invoked by uid 109); 4 Jan 2017 07:01:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 07:01:10 +0000
Received: (qmail 30142 invoked by uid 111); 4 Jan 2017 07:01:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 02:01:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2017 02:01:08 -0500
Date:   Wed, 4 Jan 2017 02:01:08 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, j6t@kdbg.org, pclouds@gmail.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
Message-ID: <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
 <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
 <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 04, 2017 at 07:56:02AM +0100, Torsten Bögershausen wrote:

> On 04.01.17 01:48, Jeff King wrote:
> > On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
> > 
> >> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
> >> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
> > 
> > Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what's
> > what all other similar functions will be using.
> > 
> > The only problem was that we were redefining the macro. So maybe:
> > 
> >   #ifndef MAXSYMLINKS
> >   #define MAXSYMLINKS 5
> >   #endif
> > 
> > would be a good solution?
> Why 5  ? (looking at the  20..30 below)
> And why 5 on one system and e.g. on my Mac OS
> #define MAXSYMLINKS     32  

I mentioned "5" because that is the current value of MAXDEPTH. I do
think it would be reasonable to bump it to something higher.

> Would the same value value for all Git installations on all platforms make sense?
> #define GITMAXSYMLINKS 20

I think it's probably more important to match the rest of the OS, so
that open("foo") and realpath("foo") behave similarly on the same
system. Though I think even that isn't always possible, as the limit is
dynamic on some systems.

I think the idea of the 20-30 range is that it's small enough to catch
an infinite loop quickly, and large enough that nobody will ever hit it
in practice. :)

-Peff
