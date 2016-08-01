Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FBE1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbcHAVh3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:37:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751090AbcHAVh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:37:27 -0400
Received: (qmail 19119 invoked by uid 102); 1 Aug 2016 21:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:36:35 -0400
Received: (qmail 18320 invoked by uid 107); 1 Aug 2016 21:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:37:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 17:36:31 -0400
Date:	Mon, 1 Aug 2016 17:36:31 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Tauner <stefan.tauner@gmx.at>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
Message-ID: <20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
 <20160616095947.GA15988@sigill.intra.peff.net>
 <0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 31, 2016 at 06:39:35PM +0200, Stefan Tauner wrote:

> > There are some output formats that will wrap lines, but by default,
> > filter-branch should not be using them (and I could not reproduce the
> > issue in a simple test). Can you show us what your commit-filter looks
> > like?
> 
> Thanks for your answer. I have tried to reproduce it in other (newly
> created) repositories but failed. However, it seems to relate to some
> kind of persistent paging setting, is that possible?
> git config -l does not show anything suspicious.
> 
> The following commands produce paged output:
> git show hash
> git show --pretty=%B
> git log hash^..hash
> Commit message in gitk
> 
> 
> These do NOT produce paged output:
> git patch hash^..hash
> Commit message in gitg 0.2.7

What is "git patch"? An alias for "format-patch?".

> This is the script I tried to use to reproduce the problem:
> 
> #!/bin/bash
> export LC_ALL=C
> input=$(cat)
> echo "===========================
> $input
> ===========================" >> /tmp/paging_bug.txt
> git commit-tree "$@" -m "$input"

Can you be more specific about the input you're feeding to git and the
output you're seeing?

For instance, if I do:

  git init
  echo content >file
  git add file
  git commit -m "$(perl -e 'print join(" ", 1..100)')"

I get a commit message with one long unwrapped line, which I can view
via git-log, etc. Now if I try to run filter-branch on that:

  git filter-branch --commit-filter '
	input=$(cat)
	{
		echo "===================="
		echo $input
		echo "===================="
	} >>/tmp/paging_bug.txt
	git commit-tree "$@" -m "$input"
  '

then the commit remains unchanged, and paging_bug shows one long line.
What am I missing?

(I wondered at first if the extra "cat" and "-m" could be messing up
whitespace for you, but it should not, as the quoting around "$input"
should preserve things like newlines. And anyway, the bug in that case
would be the _opposite_; I'd expect it to stuff everything onto a single
line rather than breaking lines).

-Peff
