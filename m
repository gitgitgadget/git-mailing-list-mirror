Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C4D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfCCRTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:19:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:36648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfCCRTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:19:53 -0500
Received: (qmail 13535 invoked by uid 109); 3 Mar 2019 17:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16562 invoked by uid 111); 3 Mar 2019 17:20:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:20:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:19:51 -0500
Date:   Sun, 3 Mar 2019 12:19:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190303171951.GD23811@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 09:05:24PM +0100, Johannes Schindelin wrote:

> > That seems reasonable (regardless of whether it is in a script or in the
> > Makefile). Another option is to use -maxdepth, but that involves
> > guessing how deep people might actually put header files.
> 
> It would also fail to work when somebody clones an unrelated repository
> that contains header files in the top-level directory into the Git
> worktree. I know somebody like that: me.

Good point.

By the way, "make hdr-check" already fails for me on master, as I do not have
libgcrypt installed, and it unconditionally checks sha256/gcrypt.h.

I wonder if this actually does point to hdr-check needing to be smarter
about checking the headers that are actually used in compilation on your
platform. Or if that file should just be added to the set of excluded
headers.

> > We should be able to add back $(GENERATED_H) as appropriate. I see you
> > did it for the non-computed-dependencies case. Couldn't we do the same
> > for $(LOCALIZED_C) and $(CHK_HDRS)?
> 
> As you figured out, CHK_HDRS *specifically* excludes the generated
> headers, and as I pointed out: LOCALIZED_C includes $(GENERATED_H)
> explicitly.
> 
> So I think we're good on that front.

Yeah, agreed.

> > > Likewise, we no longer include not-yet-tracked header files in `LIB_H`.
> > 
> > I think that's probably OK.
> 
> It does potentially make developing new patches more challenging. I, for
> one, do not immediately stage every new file I add, especially not header
> files. But then, I rarely recompile after only editing such a new header
> file (I would more likely modify also the source file that includes that
> header).
> 
> So while I think this issue could potentially cause problems only *very*
> rarely, I think that it would be a really terribly confusing thing if it
> happened.
> 
> But I probably worry too much about it?

I think it's not ideal, but it's probably an acceptable tradeoff. The
LIB_H list is used for three things:

  - hdr-check, which I'd think would generally be run periodically on a
    full tree to catch any new header breakages. But I dunno, maybe
    people want to run it as soon as they've written new code.

  - the .po generation, which generally is a separate workflow from
    writing new header files

  - the header-dependency fallback code. This is definitely the place
    where somebody just adding a new header file and running "make"
    might get bitten. But it only kicks in for ancient, crappy compilers
    that don't do dependency computation; so I think most developers
    would not be using it. (this is your cue to explain to me how
    some workflow involving MSVC does not compute dependencies, and
    I'm unknowingly dismissing a large portion developers ;) ).

-Peff
