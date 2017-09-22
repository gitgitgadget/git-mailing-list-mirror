Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1037A202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdIVQER (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:04:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752013AbdIVQEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:04:16 -0400
Received: (qmail 25321 invoked by uid 109); 22 Sep 2017 16:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 16:04:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4189 invoked by uid 111); 22 Sep 2017 16:04:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 12:04:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 12:04:14 -0400
Date:   Fri, 22 Sep 2017 12:04:14 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170922160413.nbqhmszvdfrvz3u4@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <c474bf47-5049-1425-d03c-2417eb53549e@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c474bf47-5049-1425-d03c-2417eb53549e@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 01:42:10AM -0500, Daniel Santos wrote:

> > But taking the index lock may conflict with other operations
> > in the repository. Especially ones that the user is doing
> > themselves, which _aren't_ opportunistic. In other words,
> > "git status" knows how to back off when somebody else is
> > holding the lock, but other commands don't know that status
> > would be happy to drop the lock if somebody else wanted it.
> 
> Interestingly, this usually slaps me when performing an _interactive_
> rebase.  It occurred to me that if I'm performing an interaction
> operation, it doesn't seem unreasonable for git wait up to 125ms or so
> for the lock and then prompting the user to ask if they want to continue
> waiting for the lock.

Yes, lock timeouts would help with this situation, though not eliminate
it entirely (and we've been adding some lock timeouts in a few places
for related situations).

We generally avoid prompting, especially when a command can just be
reissued. It sounds like "git rebase" gets into a funny state if it
cannot grab the index lock. That's something that should be fixed. Even
if it bails, you should be able to move forward with "rebase --continue"
or similar.

> That is not necessarily the case.  I don't actually know git on the
> inside, but I would ask you to consider a read-write lock and a hybrid
> of one and three.
> 
> I don't know what dotlocks are, but I'm certain that you can implement a
> rw lock using lock files and no other IPC, although it does increase the
> complexity.  The way this works is that `git status' acquires a read
> lock and does its thing.  If it has real changes, instead of discarding
> them it attempts to upgrade to a write lock.  If that fails, you throw
> it away, otherwise you write them and release.

By dotlocks, I just mean our strategy of creating O_EXCL "index.lock"
files.

You're right that it can be done using two such locks, and communicating
via the lockfile contents. So my "impossible" was overstating it. I do
stand by my contention that it's much more complex than the existing
scheme. :)

More importantly, though, it changes the locking contract completely
between old and new versions (and between other implementations).
There's probably only a small minority of users who might use two
implementations to simultaneously access the same repository, but it is
a use case we try to support. I think we'd have to require a
repository-version bump to tell programs to use the new scheme.

-Peff
