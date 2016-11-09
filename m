Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281FE2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754355AbcKIQpm (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 11:45:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:40749 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754347AbcKIQpm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 11:45:42 -0500
Received: (qmail 3409 invoked by uid 109); 9 Nov 2016 16:45:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 16:45:41 +0000
Received: (qmail 30188 invoked by uid 111); 9 Nov 2016 16:46:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 11:46:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 11:45:39 -0500
Date:   Wed, 9 Nov 2016 11:45:39 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161109164539.fn4c6fj3dyvceb7m@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
 <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
 <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
 <CACsJy8ASMBk+Yak7LyybANFYkoU_Poi1ZGY=ufKtq1vSkoYCXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ASMBk+Yak7LyybANFYkoU_Poi1ZGY=ufKtq1vSkoYCXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 04:22:12PM +0700, Duy Nguyen wrote:

> > Symlinks are likewise tricky.  If we see that a symlink points to
> > "foo/../bar", then we don't know if it leaves the repository unless we
> > also look at "foo" to see if it is also a symlink. So you really end up
> > having to resolve the symlink yourself (and when checking out multiple
> > files, there's an ordering dependency).
> 
> We do have this dependency problem right now (e.g. files A and
> .gitattributes are checked out at the same time and .gitattributes has
> some attribute on A). It looks like we resolve it by reading the index
> version at checkout time. We probably can do the same for gitattribute
> symlinks.

Right, but then we can't use filesystem functions like realpath() to do
the lookup. I guess we could do a pass after the checkout is done to
"fix" any out-of-tree symlinks we just created.

This is exactly the sort of complexity I was trying to avoid with my
original series. :)

If that isn't an option, I think I prefer something like the
core.saneSymlinks approach I mentioned. It has the additional bonus of
protecting not just git commands, but other commands that might inspect
the filesystem.

> > So one reasonable fix might be to have a config option like
> > "core.saneSymlinks" that enforces both of those rules for _all_ symlinks
> > that we checkout to the working tree. And it could either refuse to
> > check them out, or replace them with a file containing the symlink
> > content (as we do on systems that don't support symlinks, IIRC).
> 
> I wonder if anyone want core.saneSymlinks on, but they have some links
> that do not meet the above checks and still want to follow them
> anyway. One way to add such an exception is mark the path with an
> attribute "follow". Yeah I have a dependency loop :(

That could come later if somebody wants it, I think (especially if the
config option is not on by default). I have a feeling that callers will
either care about out-of-tree symlinks or not. Trusting the repository
to say "but these ones are OK" doesn't work for the paranoid ones, and
everybody else just assumes the repository is sane.

-Peff
