Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BBF52018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbcF0Qae (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:30:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:33315 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751721AbcF0Qac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:30:32 -0400
Received: (qmail 28453 invoked by uid 102); 27 Jun 2016 16:30:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:30:31 -0400
Received: (qmail 9004 invoked by uid 107); 27 Jun 2016 16:30:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:30:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 12:30:29 -0400
Date:	Mon, 27 Jun 2016 12:30:29 -0400
From:	Jeff King <peff@peff.net>
To:	Greg Werbin <ourobourbon@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Segfault during a big messy rebase
Message-ID: <20160627163029.GB4430@sigill.intra.peff.net>
References: <loom.20160627T084323-107@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <loom.20160627T084323-107@post.gmane.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 06:51:26AM +0000, Greg Werbin wrote:

> I was in the middle of a big messy rebase when the following
> happened:
> 
> $ git rebase --continue
> /usr/local/Cellar/git/2.9.0/libexec/git-core/git-rebase--interactive:
> line 238: 60305 
> Segmentation fault: 11  "$@"
> Could not commit staged changes.

Can you reproduce this segfault if you run the rebase again?

It's hard to tell what command even had a problem (one can guess "git
commit" from the message). Running it with GIT_TRACE=1 would show more
details.

The simplest way to debug a segfault is generally to get a core file and
ask gdb for the backtrace. On Linux, that is generally:

  # turn on cores; most modern distros turn them off by default
  ulimit -c unlimited

  # run your command
  git rebase ...

  # now find the core file; it's dumped in the cwd of the command
  # that segfaulted, which is probably either .git or the top of the
  # worktree
  core=$(find . -name core)

  # and then ask gdb for the backtrace
  gdb -ex backtrace git $(core)

I see you have /usr/local/Cellar, which IIRC is a homebrew thing. Some
of those commands may need adjusting on OS X.

-Peff
