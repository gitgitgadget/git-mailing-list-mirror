Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D539C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhKUSnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 13:43:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:35886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbhKUSnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 13:43:08 -0500
Received: (qmail 17658 invoked by uid 109); 21 Nov 2021 18:40:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Nov 2021 18:40:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5371 invoked by uid 111); 21 Nov 2021 18:40:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 13:40:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 13:40:02 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <YZqSgu4XjPWnURju@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211024170349.GA2101@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 24, 2021 at 07:03:49PM +0200, SZEDER Gábor wrote:

> > What makes us expect that the "git log" invocation should trigger a
> > SIGPIPE in the first place?
> 
> A misunderstanding, perhaps, because those 'git log' commands with
> their early-exiting pagers rarely trigger SIGPIPE.

I happened to be looking in this area today[1], and I think it turns out
not to be "rarely", but rather "never" for some of the tests.

The test in question sets the pager to "does-not-exist". But in that
case we will realize immediately via run-command.c that we could not run
the pager, and will not even redirect our stdout to it.

For example, doing this:

  GIT_PAGER=does-not-exist git -c alias.foo='!yes' -p foo

will never get SIGPIPE; it will just write infinitely to the original
stdout, and return success.

Whereas this:

  GIT_PAGER=false git -c alias.foo='!yes' -p foo

will reliably get SIGPIPE. But even if we used it (with a while loop to
instead of "yes" address the portability concern), the tests in t7006
would still be wrong, because they are sending test-terminal's output to
a closed pipe (so we'd still see SIGPIPE regardless of Git's behavior).
They should be sending test_terminal's output to a file or /dev/null.

It seems like this thread stalled. Ævar, were you planning to fix these
tests?

It's not too hard to swap out a "yes" as I showed above, but it further
confuses the trace2 output, because now we have the child yes (or its
shell equivalent) exiting as well.

The non-child "log --stdin" example I gave earlier in the thread avoids
that, but the fifo hackery is so horrible that I'd just as soon avoid
it. I guess yet another option is a builtin which produces infinite
output. Perhaps:

  oid=$(git rev-parse HEAD)
  while true; do echo $oid; done |
  test_terminal git -p cat-file --batch-check

That's guaranteed to get SIGPIPE eventually if the pager stops reading.
I seem to recall that test_terminal's handling of stdin is somewhat
broken, though, and would probably get in our way[2]. Possibly we could
just rip it out, as nobody is relying on it (they can't be, because it's
broken).

-Peff

[1] https://lore.kernel.org/git/YZqSBlvzz2KgOMnJ@coredump.intra.peff.net/

[2] https://lore.kernel.org/git/20190520125016.GA13474@sigill.intra.peff.net/
