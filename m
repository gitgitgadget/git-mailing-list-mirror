Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BF7C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhKVRoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:44:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:36436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhKVRoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:44:23 -0500
Received: (qmail 21799 invoked by uid 109); 22 Nov 2021 17:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 17:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21778 invoked by uid 111); 22 Nov 2021 17:41:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 12:41:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 12:41:15 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZvWO6MaZwTA86gc@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
 <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
 <211122.861r38yuun.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211122.861r38yuun.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 06:10:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I think a better approach is to just die early and not fallback if the
> user's pager setting is broken. I.e. let's not second-guess their
> explicit configuration, trust it, and if it doesn't work die() or
> error().
> 
> We do fallback on emitting to stdout, so perhaps there's a reason to do
> more exhaustive fallbacks here, I'm not really sure about the above.

I suspect this fallback-to-stdout does not kick in very much in
practice. It only kicks in when start_command() fails, which means
either:

  - some OS-level error with fork, pipe(), etc

  - execve() failed to find the program (we detect this even over fork()
    with a magic protocol between the parent and child)

The second case is the more interesting one for a fallback, but it only
works if we aren't running the pager through a shell. And we do set
use_shell, so it kicks in at all only because of our "skip the shell"
optimization when the command looks simple.

So this falls back:

  $ GIT_PAGER=does-not-exist git log -1 --pretty=format:foo
  error: cannot run does-not-exist: No such file or directory
  foo

but this does not:

  $ GIT_PAGER='does-not-exist --arg' git log -1 --pretty=format:foo
  does-not-exist --arg: 1: does-not-exist: not found

In the non-fallback case we just send all output (including stderr!) to
a dead pipe (and probably die with SIGPIPE, though it's racy).

So we may be better to just die() immediately when pager setup fails.
That naturally fixes this bug, too. ;)

Of course if we are going to do more exhaustive fallback, then it is
going in the opposite direction. But I tend to agree that we should
stick to what the user told us to do, and fail if it's not possible.

-Peff
