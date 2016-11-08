Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BA02022A
	for <e@80x24.org>; Tue,  8 Nov 2016 22:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbcKHWVb (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 17:21:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:40383 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbcKHWVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 17:21:30 -0500
Received: (qmail 1235 invoked by uid 109); 8 Nov 2016 22:21:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 22:21:30 +0000
Received: (qmail 24872 invoked by uid 111); 8 Nov 2016 22:21:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 17:21:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 17:21:27 -0500
Date:   Tue, 8 Nov 2016 17:21:27 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
 <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 08:38:55AM +0700, Duy Nguyen wrote:

> > Another approach is to have a config option to disallow symlinks to
> > destinations outside of the repository tree (I'm not sure if it should
> > be on or off by default, though).
> 
> Let's err on the safe side and disable symlinks to outside repo by
> default (or even all symlinks on .gitattributes and .gitignore as the
> first step)

Both of those are actually much harder than you might think.

For matching specific names, we have to deal with case-folding.  It's
easy to hit the common ones like ".GITIGNORE" with fspathcmp(). But if
this is actually protection against malicious repositories, we have to
match all of the horrible filesystem-specific junk that we did for
".git".

Symlinks are likewise tricky.  If we see that a symlink points to
"foo/../bar", then we don't know if it leaves the repository unless we
also look at "foo" to see if it is also a symlink. So you really end up
having to resolve the symlink yourself (and when checking out multiple
files, there's an ordering dependency).

I think it might be enough to check:

  - leading "../" tokens in the symlink's destination can be checked
    against the symlink's path. So "../foo" is OK for path "one/two",
    but not for path "one".

  - interior "../" can be disallowed entirely. Technically
    "foo/../bar/../baz" _can_ be a fine symlink destination, but why?
    It's identical to "baz" unless you are following a bunch of interior
    symlinks. And if those are interior symlinks, it's still confusing
    and unnecessarily obfuscated, and a good sign that somebody is
    trying to do something tricky.

So one reasonable fix might be to have a config option like
"core.saneSymlinks" that enforces both of those rules for _all_ symlinks
that we checkout to the working tree. And it could either refuse to
check them out, or replace them with a file containing the symlink
content (as we do on systems that don't support symlinks, IIRC).

It could even be off by default (for backwards compatibility, as there
really are uses for symlinks reaching out of the repository in some
cases), but people cloning untrusted repos could flip it on. That seems
like an improvement over the current state.

> What I learned from my changes in .gitignore is, if we have not
> forbidden something, people likely find some creative use for it. As
> long as it's can be turned on or off, i guess those minority will stay
> happy.

Yes, it's one of the fun things about working on a 10-year-old project.
:)

-Peff
