Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BF32018F
	for <e@80x24.org>; Tue, 19 Jul 2016 02:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbcGSChs (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 22:37:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35230 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbcGSChr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 22:37:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DA82018B;
	Tue, 19 Jul 2016 02:37:46 +0000 (UTC)
Date:	Tue, 19 Jul 2016 02:37:46 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, norm@dad.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, l.s.r@web.de,
	git@vger.kernel.org
Subject: Re: [PATCH] pager: disable color when pager is "more"
Message-ID: <20160719023746.GA3420@plume>
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
 <alpine.DEB.2.20.1607180922580.28832@virtualbox>
 <20160718091907.GA13588@starla>
 <20160718131653.GC19751@sigill.intra.peff.net>
 <xmqq8twylv8y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8twylv8y.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> > On Mon, Jul 18, 2016 at 09:19:07AM +0000, Eric Wong wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> > On Sun, 17 Jul 2016, norm@dad.org wrote:
> >> > > 'git diff' outputs escape characters which clutter my terminal. Yes, I
> >> > > can sed them out, but then why are they there?
> >> > 
> >> > Those are most likely the ANSI sequences to add color. Can you call Git
> >> > with the --no-color option and see whether the escape characters go away?
> >> 
> >> Norm: do you have PAGER=more set by any chance?
> >> Perhaps changing it to "less" will allow you to preserve colors.
> >> 
> >> I saw a similar or identical problem during my vacation in
> >> FreeBSD-land.  Perhaps the out-of-the-box experience can be
> >> improved:
> >> 
> >> -----8<-----
> >> Subject: [PATCH] pager: disable color when pager is "more"
> >
> > This is the tip of a smaller iceberg. See
> >
> >   http://public-inbox.org/git/52D87A79.6060600%40rawbw.com/t/#u
> >
> > for more discussion, and some patches that fix more cases (like "LESS"
> > without "R", or "more" that _does_ understand "R"). I think it was
> > discarded as being a little too intimate with the details of pagers, but
> > it does suck that the out-of-the-box experience on FreeBSD is not good.
> > Maybe we should revisit it.

Yes; I'd prefer not to get too intimate with the details of
pagers, either, and I think we should err on the side of
monochrome for systems we do not know much about.

> Yup, the three-patch series at
> 
>     http://public-inbox.org/git/20140117041430.GB19551%40sigill.intra.peff.net/

I am not a fan of adding #ifdefs for platform-specific things;
so I prefer starting with my original patch to disable colors
for "more".  (or, even disable colors for everything which
is not "less" or "lv")
 
> would be a safe starting point that is low-impact.  I think what
> ended up being discarded was a more elaborate side topic that
> started from exploring the possibility of checking if LESS has 'R'
> in it to see if it is possible to help people with LESS that does
> not allow coloring explicitly exported.

Heh... (see below)

> I do not think the approach in the same thread suggested by Kyle
> 
>   http://public-inbox.org/git/62DB6DEF-8B39-4481-BA06-245BF45233E5%40gmail.com/
> 
> is too bad, either.

I like Kyle's suggestion, and I think that can be a good
transition from your original patch to move pager
configuration into the build:

https://public-inbox.org/git/xmqq61piw4yf.fsf@gitster.dls.corp.google.com/

I've updated just that and pushed just that to the "pager-build"
topic of git://bogomips.org/git-svn

So I'd prefer we drop the later automatic header generation
changes that got squashed into later iterations.


Unfortunately, it looks like that all got lost in Jeff's
13-patch "makefile refactoring" topic starting at:

https://public-inbox.org/git/20140205174823.GA15070@sigill.intra.peff.net/

Yeah, we tend to get sidetracked :x
