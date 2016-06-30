Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FAA1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbcF3JXi (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:23:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbcF3JXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:23:37 -0400
Received: (qmail 32595 invoked by uid 102); 30 Jun 2016 09:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:23:39 -0400
Received: (qmail 6827 invoked by uid 107); 30 Jun 2016 09:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:23:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:23:34 -0400
Date:	Thu, 30 Jun 2016 05:23:34 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/9] Report bugs consistently
Message-ID: <20160630092333.GB24964@sigill.intra.peff.net>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
 <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606301041380.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606301041380.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 10:42:37AM +0200, Johannes Schindelin wrote:

> > > The vast majority of error messages in Git's source code which report a
> > > bug use the convention to prefix the message with "BUG:".
> > 
> > Good thing to do.
> > 
> > But if we were to review and apply a 200+ line patch, I wonder if we
> > want to go one step further to allow us to write
> > 
> >     BUG("killed-file %s not found", name);
> > 
> > instead.
> 
> If the idea is to make it easier to find, I would wager a guess that
> 'die("BUG:' would be just as good a search term. Even better, I think,
> because 'BUG' would also match comments.

I have been tempted to switch to BUG(), because it would make it easy to
call abort() and get a coredump (and therefore a stack trace). On the
other hand:

  - we could always trigger such behavior in die() by looking for "BUG:" in
    the output string. :)

  - it's also sometimes useful to get a stack trace from a regular
    non-bug die(). So maybe something optional like:

      if (git_env_bool("GIT_ABORT_ON_DIE", 0))
              abort();

    would be helpful (since you have to turn it on ahead of time, you
    could also just run the program under gdb, of course; however, I
    sometimes find that it's hard to get gdb where you want it because
    git spawns so many sub-programs. Or maybe I just need to get better
    at using gdb's child-following options).

The other thing BUG() would get us is that we could turn it into a macro
(on systems with vararg macros) and report things like __FILE__ and
__LINE__.  In practice, though our BUG messages are unique enough that
there is no problem finding the source.

-Peff
