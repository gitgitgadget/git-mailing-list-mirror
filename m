Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF59EC875B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbjIGVGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIGVGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:06:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6A1BCB
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:06:39 -0700 (PDT)
Received: (qmail 29076 invoked by uid 109); 7 Sep 2023 21:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 21:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31386 invoked by uid 111); 7 Sep 2023 21:06:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 17:06:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 17:06:38 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Message-ID: <20230907210638.GB941945@coredump.intra.peff.net>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2023 at 10:03:02AM +0000, Phillip Wood via GitGitGadget wrote:

>     rebase -i: ignore signals when forking subprocesses
>     
>     Having written this I started thinking about what happens when we fork
>     hooks, merge strategies and merge drivers. I now wonder if it would be
>     better to change run_command() instead - are there any cases where we
>     actually want git to be killed when the user interrupts a child process?

I think that would be quite surprising in most cases, as the user may
not be aware when or if a sub-program is in use.

Imagine that you're running a script which runs git-commit in a loop,
which in turn runs "gc --auto", which in turn runs a pre-auto-gc hook.
You want to stop it, so you hit ^C, which sends SIGINT to all of the
processes.

I think most people would expect the whole process chain to stop
immediately. But in your proposal, we'd kill the hook only. That kind-of
propagates up to "gc --auto" (which says "OK, the hook says don't run").
And then that doesn't really propagate to git-commit, which ignores the
exit code of gc and continues on, running the post-commit hook and so
on. And then outer loop of the script continues, invoking the next
commit, and so on. To actually quit you have to hit ^C several times
with the right timing (the exact number of which is unknown to you, as
it depends on the depth of the process chain).

I think this really comes down to: does the user perceive the child
process as the current "main" process running in the foreground? For
most run-command invocations, I would say no. For something like running
an editor, the answer is more clearly yes.

For something like sequencer "exec" commands, I think it really depends
on what the command is doing. If it is "git commit --amend", then that
is going to open an editor and take over the terminal. If it is "make",
then probably not. But it may be OK to do here, just because we know
that a signal exit from the child will be immediately read and
propagated by the sequencer machinery (assuming the child dies; if it
blocks SIGINT, too, then now you cannot interrupt it at all!).

In the classic Unix world, I think the solution here is setsid(),
process groups, and controlling terminals. One example in your commit
message is the sequencer kicking off git-commit, which kicks off an
editor. The user hits ^C then, and the sequencer is killed. But I think
your patch is papering over the deeper bug. In 913ef36093
(launch_editor: ignore terminal signals while editor has control,
2012-11-30), we did this same "ignore INT" trick. But I think the right
solution is actually to start the editor in its own process group, and
let it be the foreground of the terminal. And then a ^C while the editor
is running would not only not hit git-commit, but it would not hit any
sequencer or other intermediate processes above it.

I've never done it before, but from my reading we basically want to do
(in the forked process before we exec):

  setsid();
  open("/dev/tty");

But of course none of that probably has any meaning on Windows. I'm not
sure if there are analogous concepts there we could access with
alternate code, or if it would need to be a totally different strategy.

-Peff
