Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B171F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBHTzC (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:55:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:38022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727324AbfBHTzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:55:01 -0500
Received: (qmail 16871 invoked by uid 109); 8 Feb 2019 19:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 19:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26990 invoked by uid 111); 8 Feb 2019 19:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 14:55:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 14:54:59 -0500
Date:   Fri, 8 Feb 2019 14:54:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20190208195459.GA32556@sigill.intra.peff.net>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
 <20180814223246.GA2379@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 10:28:12AM +0100, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Fri, 8 Feb 2019, Johannes Schindelin wrote:
> 
> > I just had a look at the patch you provided below (for some reason, my
> > previous search on public-inbox only turned up Gábor's mail to which you
> > responded).
> > 
> > Admittedly, I do not really understand all aspects of it, but it applies,
> > still, and I kicked off a stress test here:
> > 
> > 	https://dev.azure.com/git/git/_build/results?buildId=338
> > 
> > It seems that your patch fixes that t5570 flakiness on macOS, and more
> > importantly, addresses an important issue on macOS.
> > 
> > Will play a bit more with it and keep you posted.
> 
> Alas, I was fooled. *Fooled*, I say. Apparently the --stress option makes
> the script *succeed* when it fails?
> [...]
> So I am afraid that your patch does not fix the issue nor does it work
> around it.

I think that patch does the write_or_die conversion to handle EPIPE, but
it would still need to turn off SIGPIPE for the whole process.

So you'd also need to stick a:

  sigchain_push(SIGPIPE, SIG_IGN);

somewhere near the start of cmd_fetch(). (There may be a less
coarse-grained place to put it, but at this point I think we're just
trying to find out whether this approach even solves the problem).

-Peff
