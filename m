Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4854201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdEPDZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdEPDZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:25:08 -0400
Received: (qmail 27007 invoked by uid 109); 16 May 2017 03:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 03:25:06 +0000
Received: (qmail 24006 invoked by uid 111); 16 May 2017 03:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 23:25:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 23:25:04 -0400
Date:   Mon, 15 May 2017 23:25:04 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:08:39AM -0700, Eric Rannaud wrote:

> It used to be possible to run a sequence like:
> 
>   foo() { echo X; }
>   export -f foo
>   git rebase --exec foo HEAD~10
> 
> Since upgrading to 2.13.0, I had to update my scripts to run:
> 
>   git rebase --exec "bash -c foo" HEAD~10

Interesting. The "exec" string is still run with a shell. E.g.:

  $ git rebase --exec 'for i in 1 2 3; do echo >&2 $i; done' HEAD~5
  Executing: for i in 1 2 3; do echo >&2 $i; done
  1
  2
  3
  Executing: for i in 1 2 3; do echo >&2 $i; done
  1
  2
  3
  [...and so on...]

I wonder if this is falling afoul of the optimization in run-command's
prepare_shell_cmd() to skip shell invocations for "simple" commands.

E.g., if I do:

   strace -fe execve git rebase -x foo HEAD^ 2>&1 | grep foo

I see:

   ...
   Executing: foo
   [pid 21820] execve("foo", ["foo"], [/* 57 vars */]) = -1 ENOENT (No such file or directory)
   fatal: cannot run foo: No such file or directory

But if I were to add a shell meta-character, like this:

   strace -fe execve git rebase -x 'foo;' HEAD^ 2>&1 | grep foo

then I see:

  ...
  Executing: foo;
  [pid 22569] execve("/bin/sh", ["/bin/sh", "-c", "foo;", "foo;"], [/* 57 vars */]) = 0
  foo;: 1: foo;: foo: not found

So I suspect if you added an extraneous semi-colon, your case would work
again (and that would confirm for us that this is indeed the problem).

> I'm not sure if this was an intended change. Bisecting with the
> following script:
> [...]
> It points to this commit:
>
> commit 18633e1a22a68bbe8e6311a1039d13ebbf6fd041 (refs/bisect/bad)
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Thu Feb 9 23:23:11 2017 +0100
>
>     rebase -i: use the rebase--helper builtin

The optimization in run-command is very old, but the switch to
rebase--helper presumably moved us from doing that exec in the actual
shell script to doing it via the C code.

Which means your exported-function technique has been broken for _most_
of Git all along, but it just now affected this particular spot.

I'm not sure how to feel about it. In the face of exported functions, we
can never do the shell-skipping optimization, because we don't know how
the shell is going to interpret even a simple-looking command. And it is
kind of a neat trick. But I also hate to add extra useless shell
invocations for the predominantly common case that people aren't using
this trick (or aren't even using a shell that supports function
exports).

One hack would be to look for BASH_FUNC_* in the environment and disable
the optimization in that case. I think that would make your case Just
Work. It doesn't help other oddball cases, like:

  - you're trying to run a shell builtin that behaves differently than
    its exec-able counterpart

  - your shell has some other mechanism for defining commands that we
    would not find via exec. I don't know of one offhand. Obviously $ENV
    could point to a file which defines some, but for most shells would
    not read any startup files for a non-interactive "sh -c" invocation.

-Peff
