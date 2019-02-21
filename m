Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8651F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBUNHT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:07:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:52466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725820AbfBUNHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:07:19 -0500
Received: (qmail 19994 invoked by uid 109); 21 Feb 2019 13:07:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:07:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12023 invoked by uid 111); 21 Feb 2019 13:07:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:07:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:07:17 -0500
Date:   Thu, 21 Feb 2019 08:07:17 -0500
From:   Jeff King <peff@peff.net>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: "Submodule registered for path" output with config aliases mixed
 in
Message-ID: <20190221130717.GB20536@sigill.intra.peff.net>
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
 <20190221021825.GB488342@genre.crustytoothpaste.net>
 <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
 <20190221041756.GA28389@sigill.intra.peff.net>
 <CABUeae81zRSZrAce86R7OQgGFoc3R1Lk2X8Ujg4ZPUAGVVSknw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABUeae81zRSZrAce86R7OQgGFoc3R1Lk2X8Ujg4ZPUAGVVSknw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 11:53:12AM +0100, Mateusz Loskot wrote:

> On Thu, 21 Feb 2019 at 05:17, Jeff King <peff@peff.net> wrote:
> > On Thu, Feb 21, 2019 at 10:47:45AM +0700, Duy Nguyen wrote:
> >
> > > > > I managed to identify where that garbage injections come from:
> > > > > from git aliases I've got configured [1]
> > > > >
> > > > > Could anyone explain what is happening here?
> > > > > Is there anything wrong with my ~/.gitconfig [1] ?
> > > >
> > > > I see the right behavior on my system (Debian amd64/sid) with
> > > > 2.21.0.rc0.258.g878e2cd30e and with master. I've built with ASan and
> > > > don't see any memory warnings on my system.
> > >
> > > I ran valgrind yesterday (gentoo amd64) and didn't find the problem
> > > either even though it clearly looked like some dangling pointers. I
> > > also audited this code and couldn't find anything obviously wrong. My
> > > only suspicion is maybe some strange getenv() behavior on Windows
> > > (_if_ the super prefix is used, but I can't see how...) and that's
> > > just a dead end for me.
> >
> > Certainly we fixed a bunch of getenv() problems in the upcoming 2.21
> > release, including 8aac69038f (get_super_prefix(): copy getenv() result,
> > 2019-01-11).
> >
> > Mateusz, can you try with the one of the v2.21.0 release candidates (or
> > the current tip of "master")?
> 
> Jeff, I have just tried git version 2.21.0.rc2.windows.1 and
> I no longer see the problem.
> It seems like a bug in earlier version indeed, that has been fixed now.

Great, thanks for confirming.

Junio, Johannes: I don't know if there were particular plans to pick up
those getenv() fixes for "maint", but if we're going to do a v2.20.2, it
might be worth it.  It's also possible that it's just due to ca1b411648
(mingw: safe-guard a bit more against getenv() problems, 2019-02-15),
but I'd consider that to be maint-worthy as well.

It may be that we just don't do a v2.20.2, though, since v2.21 is so
close to release.

-Peff
