Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD36C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE56206BE
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGFVOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:14:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:50242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFVOF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 17:14:05 -0400
Received: (qmail 13740 invoked by uid 109); 6 Jul 2020 21:14:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2020 21:14:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19931 invoked by uid 111); 6 Jul 2020 21:14:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jul 2020 17:14:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jul 2020 17:14:03 -0400
From:   Jeff King <peff@peff.net>
To:     trygveaa@gmail.com
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] Wait for child on signal death for aliases to
 externals
Message-ID: <20200706211403.GB85133@coredump.intra.peff.net>
References: <20200704221839.421997-1-trygveaa@gmail.com>
 <20200704221839.421997-2-trygveaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200704221839.421997-2-trygveaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 05, 2020 at 12:18:38AM +0200, trygveaa@gmail.com wrote:

> From: Trygve Aaberge <trygveaa@gmail.com>
> 
> The previous commit fixed this only for aliases to builtins, this commit
> does the same for aliases to external commands. While the previous
> commit fixed a regression, I don't think this has ever worked properly.
> 
> Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>

Usually when I find myself saying "the previous commit" and "does the
same" in a commit message, it's a good indication that it might be worth
combining the two commits into one. But in this case I think you're
right to keep them separate; the other one was a regression fix, and
this would be a change in behavior.

But it might be worth explaining more what the user-visible behavior
we're trying to solve is.

> I can't say for sure if this will have any unintended side effects, so
> if someone with more knowledge about it can check/verify it, that would
> be great.

Let's try to break down what differences the user might see.

The original is using the full run_command(), so we'd always be waiting
for the alias command to finish before exiting under normal
circumstances. The only difference is that now when die due to a signal,
we'd wait then, too.

And that only matters if:

  - we've spawned a pager that doesn't die due to the signal, and we
    want to wait until it has finished. However, that seems to work
    already for me in a quick test of:

      $ git -p -c alias.foo='!echo foo; sleep 10; echo bar' foo
      ^C

    where the pager keeps running (because it ignores the signal), and
    the main git process doesn't exit either (because it's waiting for
    the pager to finish)

    I think this case is different than the one fixed by 46df6906f3
    (execv_dashed_external: wait for child on signal death, 2017-01-06)
    because the pager is spawned by the main Git process (so it knows to
    wait), rather than the child dashed-external.

    I guess to recreate that you'd need to trigger the pager inside the
    alias itself, like:

      $ git -c alias.foo='!{ echo foo; sleep 10; echo bar; } | less' foo
      ^C

    which does exhibit the annoying behavior (we exit, and pgrp loses
    the tty session leader bit, and the pager gets EIO).

  - the child for some reason decides not to respect the signal.
    Obviously running a pager is one reason it would decide to do so,
    and we'd be improving the behavior there. I have trouble imagining a
    case where waiting for it would do the _wrong_ thing. I.e., if I do:

      $ git -c alias.foo='!trap "echo got signal" INT; sleep 5' foo

    it probably does make sense for us to continue to wait on that alias
    to complete (I'm not sure what anyone would try to accomplish with
    that, but waiting seems like the least-astonishing thing to me).

So I think this is moving in the right direction.

However, there is one weirdness worth thinking about. Because the
wait_after_clean feature relies on actually trying to clean the child,
Git will actually send a signal to the alias shell. For a signal, we'll
try to pass along the same signal, so it just means the shell will get
SIGINT twice in this case (or more likely, they'll race and we'll ignore
the duplicate signal while the child is in its own handler).

We'd likewise send a signal if we hit a normal exit(), but we shouldn't
do so because we're already blocked waiting for the child to exit.

But a more interesting case is if somebody sends the parent git process
a signal but _not_ the child (e.g., kill -TERM). Then we'd pass SIGTERM
along to the child. I'd venture to say that's _probably_ the right thing
to do, if only because it's exactly what we do for a dashed external as
well.

Sorry that ended up so long-winded, but my conclusion is: this is doing
the right thing. We should probably embed some of that discussion in the
commit message, but I think the simplest argument is just: this is what
we do for external commands we run, so treating shell aliases the same
in terms of passing along signals makes things simple and consistent.

-Peff
