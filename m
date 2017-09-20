Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742D020A28
	for <e@80x24.org>; Wed, 20 Sep 2017 02:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdITC2l (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 22:28:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:44270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751283AbdITC2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 22:28:40 -0400
Received: (qmail 31156 invoked by uid 109); 20 Sep 2017 02:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 02:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10128 invoked by uid 111); 20 Sep 2017 02:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 22:29:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 22:28:38 -0400
Date:   Tue, 19 Sep 2017 22:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170920022838.tlkb5qlmctlstqb6@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
 <20170919134552.7845f021@twelve2.svl.corp.google.com>
 <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
 <xmqqzi9qp2hq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi9qp2hq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 10:45:05AM +0900, Junio C Hamano wrote:

> >> > +#else
> >> > +#define UNLEAK(var)
> >> 
> >> I think this should be defined to be something (for example, "do {}
> >> while (0)"), at least so that we have compiler errors when UNLEAK(var)
> >> is used incorrectly (for example, without the semicolon) when
> >> SUPPRESS_ANNOTATED_LEAKS is not defined.
> >
> > Seems reasonable.
> 
> Hmph, I am not so sure about this one.  But I agree that the
> semicolon must go.

I thought we had run into some issues with a compiler or linter
complaining about null statements before. But they _are_ pretty common,
so maybe I'm mis-remembering (or maybe it was something like the if/else
conditional you showed earlier).

At any rate, I think Jonathan's point is that writing:

  UNLEAK(foo)

will silently pass in a normal build, and only much later will somebody
run a leak-checking build and see the compile error.

Of course people adding UNLEAK()s are likely to be compiling leak-check
builds to confirm that they've silenced the warning, so maybe it's not
that important a case to catch.

-Peff
