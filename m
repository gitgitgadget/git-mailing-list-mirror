Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA08E1F462
	for <e@80x24.org>; Tue, 28 May 2019 20:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfE1Ukz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:40:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:40368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726492AbfE1Uky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:40:54 -0400
Received: (qmail 4004 invoked by uid 109); 28 May 2019 20:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 20:40:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17684 invoked by uid 111); 28 May 2019 20:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 16:41:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 16:40:52 -0400
Date:   Tue, 28 May 2019 16:40:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brendan Boerner <bboerner.biz@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 'git stash list' => Segmentation fault
Message-ID: <20190528204051.GA24650@sigill.intra.peff.net>
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet>
 <20190528063451.GG7946@sigill.intra.peff.net>
 <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 02:56:13PM -0500, Brendan Boerner wrote:

> Unfortunately not a lot in the stack trace.
> [...]
> (gdb) bt
> #0  0x00007fd321805fdf in ?? ()
> #1  0x0000000000000000 in ?? ()

I'll say. :)

I'd suspect either:

  1. Your git isn't built with debugging symbols. Is it possible to
     build from source? The default CFLAGS if you just run "make" should
     be enough, then you can run it straight out of the build directory
     as "$YOUR_BUILD_DIR/bin-wrappers/git".

  2. It's not the main git binary that's segfaulting. Most commands are
     built-ins of that binary these days, but a few are not. We should
     be able to figure out which command is having a problem from the
     trace output, but...

> 14:52:22.633448 run-command.c:643       trace: run_command: git-stash list
> Segmentation fault (core dumped)
> Segmentation fault (core dumped)
> Segmentation fault (core dumped)

I'd have expected to see more sub-commands here. And it's weird that
there are _three_ segfaults. Which version of Git is this? In the
upcoming release stash is written in C, but from the trace output it
looks like this is the old shell-script version (which is what I was
assuming, but I just want to double check).

Is it possible that your shell is segfaulting? Does "gdb /bin/sh core"
reveal anything more useful (a long shot, I know; it probably doesn't
have symbols either)?

> Do you need the whole repo or would bits of it suffice e.g. index?

Probably the whole thing. "stash list" wouldn't generally look at
the index at all. It should just be doing a "git log" on the reflog
entries found in .git/logs/refs/stash. But...

> 14:52:25.040053 git.c:419               trace: built-in: git log
> '--format=%gd: %gs' -g --first-parent -m refs/stash --
> 14:52:26.436274 run-command.c:643       trace: run_command: unset
> GIT_PAGER_IN_USE; LESS=FRX LV=-c less
> stash@{0}: On devel: NYFL optimization
> stash@{1}: On GL285: gl285

We can see that the "log" command actually works! The segfaults seem not
to derail the command from actually performing its task. So what
processes are actually segfaulting?

Maybe "strace -o trace.out -f git stash list" would be instructive. You
should be able to find the segfaulting process in that trace, and then
can grep for that PID to see what it was doing (especially what command
was exec'd, and possibly what it was doing right before the segfault).

I can also help picking through the strace output if you're comfortable
sending it off-list (it's likely to be much too large to send on-list
anyway).

-Peff
