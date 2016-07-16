Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6228C2018F
	for <e@80x24.org>; Sat, 16 Jul 2016 15:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbcGPPIn (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 11:08:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:45972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751606AbcGPPIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 11:08:42 -0400
Received: (qmail 26323 invoked by uid 102); 16 Jul 2016 15:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 11:08:42 -0400
Received: (qmail 26234 invoked by uid 107); 16 Jul 2016 15:09:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 11:09:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jul 2016 11:08:36 -0400
Date:	Sat, 16 Jul 2016 11:08:36 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
Message-ID: <20160716150835.GA24374@sigill.intra.peff.net>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox>
 <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
 <alpine.DEB.2.20.1607161507250.28832@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607161507250.28832@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 03:30:45PM +0200, Johannes Schindelin wrote:

> > >> +     ; include if $GIT_DIR is /path/to/foo/.git
> > >> +     [include "gitdir:/path/to/foo/.git"]
> > >> +             path = /path/to/foo.inc
> > >
> > > I find this way to specify a conditional unintuitive. Reading
> > > "gitdir:/path/to/foo/.git" suggests to me that the Git dir is *re-set*,
> > > not that this is a condition.
> > 
> > Well.. to me it's no different than [remote "foo"] to apply stuff to "foo".
> 
> Except that "include" is an imperative and "remote" is not.

In the very original version of config includes, I had planned out:

  [include-if "...some condition..."]
  path = ...

Later, since "[include ...]" had no other meaning, I think it got
shortened in discussion. But it would be easy to accept include-if (or
even accept either, for maximum confusion :) ).

> Quite frankly, this conditional business scares me. If you introduce it
> for [include], users will want it for every config setting. And the
> current syntax is just not up to, say, making user.name conditional on
> anything.

They already have it for every config setting with this. The reason to
add it to [include] and not as a general syntax is that you can put
user.name into your included file, and then conditionally include it.

That is not as nice as "if this then that" in a single file, but it is
backwards compatible with the existing syntax, and is probably fine in
practice. Each included file becomes a "profile" of multiple settings
that you apply.

> As an alternative solution to your problem, you could of course avoid all
> conditional includes. Simply by adding the include.path settings
> explicitly to the configs that require them. Now, that would make reasoning
> and trouble-shooting simple, wouldn't it?
> 
> And the most beautiful aspect of it: no patch needed.

And you can just "cat" the included files directly into your
.git/config. We don't even need include.path. Or ~/.gitconfig, for that
matter. But sometimes dynamic things are convenient.

-Peff
