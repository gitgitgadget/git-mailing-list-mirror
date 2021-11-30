Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F38BC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhK3HYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:24:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:39974 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234350AbhK3HYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:24:52 -0500
Received: (qmail 11874 invoked by uid 109); 30 Nov 2021 07:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 07:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12382 invoked by uid 111); 30 Nov 2021 07:21:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 02:21:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 02:21:32 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Message-ID: <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
References: <20211130043946.19987-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130043946.19987-1-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 11:39:46PM -0500, Eric Sunshine wrote:

> The order in which the stdout and stderr streams are flushed is not
> guaranteed to be the same across platforms or `libc` implementations.
> This lack of determinism can lead to anomalous and potentially confusing
> output if normal (stdout) output is flushed after error (stderr) output.
> For instance, the following output which clearly indicates a failure due
> to a fatal error:
> 
>     % git worktree add ../foo bar
>     Preparing worktree (checking out 'bar')
>     fatal: 'bar' is already checked out at '.../wherever'
> 
> has been reported[1] on Microsoft Windows to appear as:
> 
>     % git worktree add ../foo bar
>     fatal: 'bar' is already checked out at '.../wherever'
>     Preparing worktree (checking out 'bar')
> 
> which may confuse the reader into thinking that the command somehow
> recovered and ran to completion despite the error.
> 
> Rather than attempting to address this issue on a case by case basis,
> address it by making vreportf() -- which is the heart of error-reporting
> functions die(), error(), warn(), etc. -- flush stdout before emitting
> the error message to stderr.

I left some thoughts on whether this flush is safe elsewhere in the
thread. But for this particular case, two things occur to me:

  - shouldn't status messages like this go to stderr anyway? I know some
    people follow the "unless it is an error, it should not to go
    stderr" philosophy. But I think in general our approach in Git is
    more "if it is the main output of the program, it goes to stdout; if
    it is chatter or progress for the user, it goes to stderr".

  - the reason it works consistently on glibc is that stdout to a
    terminal is line buffered by default, so the "preparing" line is
    flushed immediately. If that isn't the case on Windows, should we
    consider calling setlinebuf() preemptively when isatty(1)?

    That only covers most cases, of course (both to a terminal, or
    separated stdout/stderr). Even on Linux, if you do:

      git worktree add ../foo bar >out 2>&1

    you'll get the stderr result before stdout. That implies again to me
    that this kind of message really ought to be part of the stderr
    stream.

-Peff
