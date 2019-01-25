Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0A21F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfAYTvK (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:51:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:49332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725778AbfAYTvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:51:10 -0500
Received: (qmail 6390 invoked by uid 109); 25 Jan 2019 19:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Jan 2019 19:51:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9610 invoked by uid 111); 25 Jan 2019 19:51:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 25 Jan 2019 14:51:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2019 14:51:07 -0500
Date:   Fri, 25 Jan 2019 14:51:07 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct
 repository_format`
Message-ID: <20190125195107.GA6520@sigill.intra.peff.net>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com>
 <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net>
 <CAN0heSoNvTVfC6A8fFK83u4TBX3sLaTJ_NqKwkCZORiCKdVwcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoNvTVfC6A8fFK83u4TBX3sLaTJ_NqKwkCZORiCKdVwcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 08:24:35PM +0100, Martin Ågren wrote:

> On Wed, 23 Jan 2019 at 06:57, Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Jan 22, 2019 at 10:45:48PM +0100, Martin Ågren wrote:
> >
> > > Call `clear_...()` at the start of `read_...()` instead of just zeroing
> > > the struct, since we sometimes enter the function multiple times. This
> > > means that it is important to initialize the struct before calling
> > > `read_...()`, so document that.
> >
> > This part is a little counter-intuitive to me. Is anybody ever going to
> > pass in anything except a struct initialized to REPOSITORY_FORMAT_INIT?
> 
> I do update all users in git.git, but yeah, out-of-tree users and
> in-flight topics would segfault.
> 
> > If so, might it be kinder for read_...() to not assume anything about
> > the incoming struct, and initialize it from scratch? I.e., not to use
> > clear() but just do the initialization step?
> 
> I have some vague memory from going down that route and giving up. Now
> that I'm looking at it again, I think we can at least try to do
> something. We can make sure that "external" users that call into setup.c
> are fine (they'll leak, but won't crash). Out-of-tree users inside
> setup.c will still be able to trip on this. I don't have much spare time
> over the next few days, but I'll get to this.
> 
> Or we could accept that we may leak when we end up calling `read()`
> multiple times (I could catch all leaks now, but new ones might sneak in
> after that) and come back to this after X months, when we can perhaps
> afford to be a bit more aggressive.
> 
> I guess we could just rename the struct to have the compiler catch
> out-of-tree users...

I'm less worried about out-of-tree users, and more concerned with just
having a calling convention that matches usual conventions (and is
harder to get wrong).

It's a pretty minor point, though, so I can live with it either way.

-Peff
