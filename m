Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C6C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310E6207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFPM0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:26:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:32966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPM0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:26:00 -0400
Received: (qmail 21420 invoked by uid 109); 16 Jun 2020 12:25:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 12:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12645 invoked by uid 111); 16 Jun 2020 12:25:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 08:25:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 08:25:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
Message-ID: <20200616122559.GA666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
 <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com>
 <xmqqwo4di49l.fsf@gitster.c.googlers.com>
 <731205c8-7d4b-d87a-17d1-520fdec7375d@gmail.com>
 <nycvar.QRO.7.76.6.2006141055510.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006141055510.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 10:57:41AM +0200, Johannes Schindelin wrote:

> > >> Why adding yet another environment variable instead of relying only on a
> > >> config option?  I understand it's for the tests, but can't we add a
> > >> shell function in test-lib.sh (and friends) that tries to read
> > >> `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> > >> `core.defaultBranchName'?
> > >
> > > Can you produce such a patch that does it cleanly?  My knee jerk
> > > reaction is that I would suspect that you end up having to touch
> > > many places in the t/ scripts, but if you prove otherwise, that
> > > would certainly be appreciated.
> > >
> > > And no,
> > >
> > >     git () { command git -c core.defaultBranchName=master "$@" }
> > >
> > > is not an acceptable solution.
> > >
> >
> > I wanted to to do something like this:
> >
> >   if test -n "$GIT_TEST_DEFAULT_BRANCH_NAME";
> >   then
> >       git config core.defaultBranchName "$GIT_TEST_DEFAULT_BRANCH_NAME"
> >   fi
> >
> > But since we do not have a repository to store the config, it won't
> > work.  Sorry for the noise.
> 
> We actually would have `~/.gitconfig` because `HOME` is set to `t/trash
> directory.<test-name>/`.
> 
> However, that would cause all kinds of issues when test scripts expect the
> directory to be pristine, containing only `.git/` but not `.gitconfig`.

Putting:

  GIT_CONFIG_PARAMETERS="'core.defaultBranchName=...'"

into the environment would work (and yes, you need the single quotes
embedded in the variable), and solves all of the complaints above.
Further "git -c" invocations properly append to it. But:

  - there are a few tests which explicitly tweak that variable

  - it technically changes any tests of "-c" because now we'd never
    cover the case where we start without the variable defined

I think baking in a special environment variable like you have is not so
bad. If this did become too common a pattern, though (special test-only
environment variables that do have a separate config option), I wouldn't
be opposed to a GIT_TEST_CONFIG_PARAMETERS which takes precedence over
other config, and comes with a big warning label that it shouldn't be
relied upon outside the test suite. That's equally ugly to
GIT_TEST_DEFAULT_BRANCH_NAME, but at least solves the problem once for
all of them. I'm just not sure we have enough "all of them" to make it
worth doing.

-Peff
