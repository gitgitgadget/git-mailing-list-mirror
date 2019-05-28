Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BF51F462
	for <e@80x24.org>; Tue, 28 May 2019 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfE1Vfc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:35:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726673AbfE1Vfc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:35:32 -0400
Received: (qmail 5796 invoked by uid 109); 28 May 2019 21:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 21:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18536 invoked by uid 111); 28 May 2019 21:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 17:36:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 17:35:30 -0400
Date:   Tue, 28 May 2019 17:35:30 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
Message-ID: <20190528213529.GG24650@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121301.GD11212@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
 <20190524063955.GD25694@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 01:06:21PM +0200, Johannes Schindelin wrote:

> > Or do you prefer having a one-liner? I'd rather come up with a more
> > generic helper to cover this case, that can run any command and compare
> > it to a single argument (or stdin). E.g.,:
> >
> >   test_cmp_cmd no-conflict git log -1 --format=%s
> >
> > or
> >
> >   test_cmp_cmd - git foo <<-\EOF
> >   multi-line
> >   expectation
> >   EOF
> 
> I guess that you and me go into completely opposite directions here. I
> want something *less* general. Because I want to optimize for the
> unfortunate times when a test fails and most likely somebody else than the
> original author of the test case is tasked with figuring out what the heck
> goes wrong.
> 
> You seem to want to optimize for writing test cases. Which I find -- with
> all due respect -- the wrong thing to optimize for. It is already dirt
> easy to write new test cases. But *good* test cases (i.e. easy to debug
> ones)? Not so much.

Hmm. I too want the test output to be useful to people other than the
test author. But I find the output from test_cmp perfectly fine there.
My first step in digging into a failure is usually to look at what
commands the test is running, which generally makes it obvious why we
are expecting one thing and seeing another (or at least, just as obvious
as a hand-written message).

So to me the two are equal on that front, which makes me want to go with
the thing that is shorter to write, as it makes it more likely the test
writer will write it. The _worst_ option IMHO is a straight-up use of
"test" which provides no output at all in the test log of what value we
_did_ see. That requires the person looking into the failure to re-run
the test, which is hard if it's a remote CI, or if the failure does not
always reproduce.

-Peff
