Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F59F201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdEPEJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:09:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdEPEJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:09:04 -0400
Received: (qmail 30830 invoked by uid 109); 16 May 2017 04:09:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 04:09:02 +0000
Received: (qmail 24343 invoked by uid 111); 16 May 2017 04:09:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 00:09:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 00:08:59 -0400
Date:   Tue, 16 May 2017 00:08:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516040859.pzkm2ewbmri47rcp@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
 <20170516035357.2wutcd2tyax4tjyn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516035357.2wutcd2tyax4tjyn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:53:57PM -0400, Jeff King wrote:

> My /bin/sh isn't bash, but I should be able to build with
> SHELL_PATH=/bin/bash to reproduce. But I can't:
> 
>    $ bash
>    $ foo() { echo >&2 "in foo"; }
>    $ export -f foo
>    $ bash -c foo
>    in foo
> 
>    $ strace -f 2>&1 git.compile rebase -x 'foo;' HEAD^ | grep foo
>    Executing: foo;
>    [pid  1788] execve("/bin/bash", ["/bin/bash", "-c", "foo;", "foo;"], [/* 60 vars */] <unfinished ...>
>    foo;: foo: command not found
> 
> So I'm not sure why the direct "bash -c" can find it, but somehow the
> variable doesn't make it through to the "bash -c" at the lower level.
> Replacing "foo;" with "env" shows the environment, but BASH_FUNC_foo
> isn't set in it. I'm not sure where it's getting eaten, though.

Hmph. It looks like "dash" eats it. My "git.compile" above is a symlink
to /path/to/git/bin-wrappers/git. But it looks like our Makefile isn't
smart enough to rebuild bin-wrappers when you switch SHELL_PATH, so it
will had "/bin/sh" in it. Which points to dash on my machine. And
indeed, dash seems to wipe the environment:

  $ foo() { echo >&2 "in foo"; }
  $ export -f foo
  $ bash -c foo
  in foo
  $ dash -c "bash -c foo"
  bash: foo: command not found

I wonder if it's related to ShellShock protections, or if dash just
rejects variable names with the "%" in them or something. Anyway. That
explains why I had trouble reproducing. Using bash consistently as my
shell lets me reproduce Eric's results. And doing the semicolon trick
does make it work again.

So I feel confident that I've analyzed the problem correctly, at least.

-Peff
