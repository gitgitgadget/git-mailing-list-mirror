Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63CC33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F652080D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgAMSdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:33:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:35554 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728633AbgAMSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 13:33:15 -0500
Received: (qmail 31452 invoked by uid 109); 13 Jan 2020 18:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Jan 2020 18:33:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17216 invoked by uid 111); 13 Jan 2020 18:39:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2020 13:39:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Jan 2020 13:33:13 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
Message-ID: <20200113183313.GA2087@coredump.intra.peff.net>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
 <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
 <20200113170417.GK32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113170417.GK32750@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 06:04:17PM +0100, SZEDER Gábor wrote:

> After looking into it, the issue seems to be sending data to the
> broken diffFilter process.  So in that test the diff is "filtered"
> through 'echo too-short', which exits real fast, and doesn't read its
> standard input at all (well, apart from e.g. the usual kernel
> buffering that might happen on a pipe between the two processes).
> Making sure that the diffFilter process reads all the data before
> exiting, i.e. changing it to:
> 
>   test_config interactive.diffFilter "cat >/dev/null ; echo too-short" &&
> 
> made the test reliable, with over 2000 --stress repetitions, and that
> with only a single "y" on 'git add's stdin.

Yeah, I agree the test should be changed. What you wrote above was my
first thought, too, but I think "sed 1d" is actually a more realistic
test (and is shorter and one fewer process).

> Now, merely tweaking the test is clearly insufficient, because we not
> only want the test to be realiable, but we want 'git add' to die
> gracefully when users out there mess up their configuration.

I also agree that it would be nice to deal with this for real-world
cases. I suspect it's not something that would come up a lot, though.

> Ignoring SIGPIPE can surely accomplish that, but I'm not sure about
> the scope.  I mean your patch seems to ignore SIGPIPE basically for
> almost the whole 'git add -(i|p)' process, but perhaps it should be
> limited only to the surroundings of the pipe_command() call running
> the diffFilter, and be done as part of the next patch adding the 'if
> (diff_filter)' block.

The scope there is probably OK in practice. In my opinion SIGPIPE is
usually _not_ what the behavior we want. If we're carefully checking our
write() return values, then we'd get EPIPE in such an instance and
behave appropriately. And if we're not checking our write() return
values, that's generally a bug that ought to be fixed.

The big exception is when we are writing copious output to stdout (or
the pager) via printf() or similar, and want to die rather than continue
writing output nobody will see. But I don't think git-add really counts
as generating a lot of output, where EPIPE could prevent us from doing
useless work (unlike, say, git-log).

> Furthermore, I'm worried that by simply ignoring SIGPIPE we might just
> ignore a more fundamental issue in pipe_command(): shouldn't that
> function be smart enough not to write() to a fd that has no one on the
> other side to read it in the first place?!

Maybe. As you noted below, checking for POLLERR is racy. Seeing that we
"can" write to an fd and doing it to discover what write() returns
(whether error or not) doesn't seem like the worst strategy. If the
caller cares about pipe death, then it needs to be handling SIGPIPE
anyway.

I really wish there was a way to set a handler for SIGPIPE that tells
_which_ descriptor caused it. Because I think logic like "die if it was
fd 1, ignore and let write() return EPIPE otherwise" is the behavior
we'd like. But I don't think there's a portable way to do so.

I've been tempted to say that we should just ignore SIGPIPE everywhere,
and convert even copious-output programs like git-log to just check for
errors (they could probably even just check ferror(stdout) for each
commit we output, if we didn't want to touch every printf call).

-Peff
