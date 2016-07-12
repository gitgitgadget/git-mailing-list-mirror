Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84051FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbcGLP0v (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:26:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:43515 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755133AbcGLP0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:26:50 -0400
Received: (qmail 7864 invoked by uid 102); 12 Jul 2016 15:26:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:26:50 -0400
Received: (qmail 3581 invoked by uid 107); 12 Jul 2016 15:27:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:27:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 11:26:46 -0400
Date:	Tue, 12 Jul 2016 11:26:46 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160712152646.GF613@sigill.intra.peff.net>
References: <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox>
 <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox>
 <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox>
 <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607121243470.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 12:47:06PM +0200, Johannes Schindelin wrote:

> > Not so fast; it cuts both ways.
> > 
> > People who want multiple worktrees with branches checked out to work
> > in would want to do per-worktree things like bisection, which needs
> > tons more state than we'd be comfortable having directly under
> > $GIT_DIR (e.g. they may also want "git merge" or "git pull", which
> > would use MERGE_HEAD and FETCH_HEAD that are per-worktree and not
> > under refs/; "git bisect" would want to mark number of commits to
> > denote the perimeter of the area of the history being bisected and
> > they live refs/bisect/).
> 
> Sure, `git bisect` would need to realize that it is running in a worktree
> separate from the original one and use a different ref.

I am mostly a bystander in all of these worktree discussions, but your
comment here makes a lot of sense to me. We currently have a global ref
namespace, but the current proposals seem to want to slice it on
invisible lines into per-worktree and global bits, where "refs/bisect"
is no longer a global name. But we could also retain a global view, and
just let worktrees carve out their own portion of the namespace
("refs/worktree/foo/bisect", or even organize it by application area,
"refs/bisect/foo/bad", etc).

Besides being conceptually simpler in the code (global reachability Just
Works, because you see all of the refs), it would also let you access
individual refs between worktrees if you wanted. So for example, if you
are bisecting in worktree "foo", you can access its results from another
worktree with "git show bisect/foo/bad".

Likewise for other per-worktree items. If we used refs/MERGE_HEAD and
refs/worktree/foo/MERGE_HEAD, then you could access them independently
by using the fully qualified names.

The only downside I see is that the existing names are sometimes
well-known. I wonder if we could simply add:

  refs/worktree/<your-worktree>/%s

to the dwim ref-lookup when a command is running in a worktree.

-Peff
