Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563DB1F406
	for <e@80x24.org>; Thu, 21 Dec 2017 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdLUJr4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 04:47:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:44706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750884AbdLUJrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 04:47:52 -0500
Received: (qmail 25029 invoked by uid 109); 21 Dec 2017 09:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Dec 2017 09:47:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18595 invoked by uid 111); 21 Dec 2017 09:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 21 Dec 2017 04:48:17 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Dec 2017 04:47:49 -0500
Date:   Thu, 21 Dec 2017 04:47:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171221094749.GA23160@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
 <20171208104722.GD4939@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
 <20171208220046.GA26270@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
 <20171210142309.GA19453@sigill.intra.peff.net>
 <xmqq4lox57c9.fsf@gitster.mtv.corp.google.com>
 <20171215104101.GA11637@sigill.intra.peff.net>
 <xmqqmv2kq66p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv2kq66p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 08:58:22AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think (4) and (5) are the only things that actually change the
> > behavior in a meaningful way. But they're a bit more hacky and
> > repetitive than I'd like. Especially given that I'm not really sure
> > we're solving an interesting problem. I'm happy enough with the patch as
> > shown, and I do not recall anybody complaining about the current
> > behavior of these options.
> 
> OK.  Thanks for thinking it through.

I took one final look at this, wondering if it ought to follow the
"write to BUILD-OPTIONS only if set" pattern that some other variables
do. But I think that just ends up more confusing, because of the way we
use the variable from both the Makefile and test-lib.sh. So it makes
this work:

  make
  make -C t TEST_SHELL_PATH=whatever

but not quite this:

  make TEST_SHELL_PATH=one
  make -C t TEST_SHELL_PATH=two

because in the second case, we use "two" to invoke the test script, but
a "--tee" re-exec would use "one". Which is pretty subtle.

I really wish there was a way for a shell script to find out which
interpreter it was currently using, but I couldn't come up with a
portable way to do so (on some systems, /proc/$$/exe works, but that's
obviously not something we should count on).

So anyway. I think I'm OK with the series as-is.

-Peff
