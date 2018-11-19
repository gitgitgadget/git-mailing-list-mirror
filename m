Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36CD1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeKSVFg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 16:05:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:44198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727707AbeKSVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 16:05:36 -0500
Received: (qmail 1357 invoked by uid 109); 19 Nov 2018 10:42:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 10:42:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16369 invoked by uid 111); 19 Nov 2018 10:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 05:41:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 05:42:20 -0500
Date:   Mon, 19 Nov 2018 05:42:20 -0500
From:   Jeff King <peff@peff.net>
To:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>
Cc:     git@vger.kernel.org
Subject: Re: how often do you check in and with what tool(s)?
Message-ID: <20181119104220.GA26549@sigill.intra.peff.net>
References: <5a1201d47ba5$34281790$9c7846b0$@abilitybusinesscomputerservices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a1201d47ba5$34281790$9c7846b0$@abilitybusinesscomputerservices.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 06:04:15PM -0500, _g e r r y _ _l o w r y _ wrote:

> Examples:
> 
> {me, extreme often, Windows}  very granular, with a brief yet appropriate comment [like narrating a story] per commit-i change a few
> lines of code,
> Alt+Tab to Git Bash, Git Add/Commit,
> Alt+Tab back to some coding tool (example LINQPad).
> [generally, i check in one source file before moving to the next source file]
> 
> 
> {not me, very extreme seldom} in some project, not at all granular, in batches such as 50 of 75 files that have been modified, all
> are checked in with a single detailed comment as to the overall purpose of the batched changes.
> 
> 
> QUESTION:  how often do you check in and with what tool(s)?

I think the more important thing is not how often you commit, but that
your final product of commits is reasonably split to communicate a
logical flow to the proposed changes. That organization helps reviewers
understand what's going on, but it also helps me convince myself that
the direction is good (and that each individual change is necessary and
correct). I get there through a combination of:

  - breaking the problem down ahead of time into logical steps, then
    committing after each step is done. E.g., if I'm writing a feature
    in foo.c that's going to need infrastructure from bar.c, it's pretty
    clear the patch series is going to look something like:

      - refactor bar.c into reusable bits
      - start using reusable bits in foo.c

    Take as an example the recent object-cache series I did in:

      https://public-inbox.org/git/20181112144627.GA2478@sigill.intra.peff.net/

    I knew I needed to make the existing object-cache code from the
    alternates struct available more universally, so I did that first
    and then finally in patch 8 I could make use of it in the new spot.

  - committing when you discover a new logical breakpoint. This is
    mostly intuition, but is often obvious. Say you're refactoring bar.c
    into reusable bits, and you realize there are three distinct bits of
    factoring.

    Going back to that real-world example above, I found there were a
    bunch of discrete steps: renaming the struct (patch 3), refactoring
    path creation (patch 5), unifying the alt/non-alt cases (patch 6),
    and then providing the cache helpers (patch 7).

    Those mostly became clear as I was doing the work.

  - similarly, you might stumble over unrelated or tangential issues. In
    that same series, I noticed an existing bug, whose fix became patch
    1. That was definitely _not_ where I started, but as soon as I saw
    that bug, I probably did a "git add -p && git commit" to file it
    away (even with a lousy commit message, and then later I went back
    and polished it with "rebase -i").

  - if you're lucky that all happens linearly. But most of the time it
    doesn't. It's usually more like a rabbit hole, where you know you're
    trying to get to point X, and trying to get there reveals all the
    other problems. So at any given time during a series like that, my
    working tree is a mess of related half-finished changes. I'll
    periodically break that down into rough patches with "add -p" and
    commit.

    Those intermediate results often have minor compilation problems
    (because of ordering issues, or maybe the whole state I had when I
    broke it down didn't work yet, but I could start to see the chunks).
    So then I take a pass with "rebase -i" ("rebase -x 'make test'" is
    especially helpful here) and get something sensible.

So in response to your original question, I commit as often as once a
minute, or as rarely as a big chunk at the end of a day. :)

But in the latter case, I'm almost always going back to convert it into
a series of commits that each represent probably no more than a half
hour of work (and that could be read in much less time).

-Peff
