Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F2DC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A7524655
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKRCI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:08:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:33364 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKRCI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:08:27 -0500
Received: (qmail 20189 invoked by uid 109); 18 Nov 2020 02:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 02:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7419 invoked by uid 111); 18 Nov 2020 02:08:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 21:08:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 21:08:25 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
Message-ID: <20201118020825.GF650959@coredump.intra.peff.net>
References: <20201114084327.14891-1-martin.agren@gmail.com>
 <20201117021318.GA30463@coredump.intra.peff.net>
 <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
 <20201117225401.GA642410@coredump.intra.peff.net>
 <CAPig+cQnA_zqtjOu2OryM57jVMQeo32U3iBYVzxFkPnZ9Zd+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQnA_zqtjOu2OryM57jVMQeo32U3iBYVzxFkPnZ9Zd+cA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 06:07:07PM -0500, Eric Sunshine wrote:

> On Tue, Nov 17, 2020 at 5:55 PM Jeff King <peff@peff.net> wrote:
> > I actually wonder if it is time to drop HAVE_VARIADIC_MACROS completely.
> > They are in C99, and we have been introducing many other C99-isms. It
> > would be a minor cleanup to a few bits of code, which perhaps isn't
> > worth the risk. But I also have a vague memory of not being able to
> > implement some interfaces because we couldn't count on them.
> >
> > Poking around, 3689539127 (add helpers for allocating flex-array
> > structs, 2016-02-22) points out one such case. I think discussion of
> > BUG_ON() got blocked by that, too. Looks like we also discussed them in
> > the big "C99 weather balloon" thread:
> 
> There was also an idea[1] to use variadic macros to prevent `errno`
> from being clobbered in a case like this:
> 
>     die_errno(_("blah %s"), foobar());
> 
> In which, if foobar() changes `errno`, then die_errno() reports the wrong value.
> 
> [1]: https://lore.kernel.org/git/CAPig+cQKMxwadf9aGyC5ESa-vxDy9PzrYo+m+JaVQ3S=12PyQQ@mail.gmail.com/

Thanks, that's another good example. This _could_ be done conditionally
on HAVE_VARIADIC_MACROS, but it would mean on the non-variadic platform
that they'd see the wrong errno. I'm willing to give them worse BUG()
messages, but that may be going too far. :)

I still suspect there may be zero such platforms, which would mean
nobody is affected. But if that is the case, then we should just say so
and get rid of the HAVE_VARIADIC_MACROS flag entirely.

-Peff
