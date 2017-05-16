Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49AE1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdEPRhc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:37:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:52831 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEPRhc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:37:32 -0400
Received: (qmail 20344 invoked by uid 109); 16 May 2017 17:37:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 17:37:29 +0000
Received: (qmail 30587 invoked by uid 111); 16 May 2017 17:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 13:38:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 13:37:27 -0400
Date:   Tue, 16 May 2017 13:37:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516173727.5zstcg2g5bradhcf@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
 <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
 <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
 <CA+zRj8XLQiTmiVbsJZ7XjdW4bQvMSJpCtKW8xx5JvMKOhBDmLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+zRj8XLQiTmiVbsJZ7XjdW4bQvMSJpCtKW8xx5JvMKOhBDmLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:21:51AM -0700, Eric Rannaud wrote:

> On Tue, May 16, 2017 at 9:59 AM, Eric Rannaud <eric.rannaud@gmail.com> wrote:
> > When I use "git rebase --exec <cmd>" I'm basically writing a "foreach
> > commit in range { <cmd> }" in my shell. Same idea with git bisect run.
> >
> > A transparent optimization that tries execve() then falls back to the
> > user's shell sounds like a good idea.
> 
> One issue with the execve-else-shell optimization is that sometimes a
> binary exists that will shadow an exported function or a shell
> builtin:
> 
>   git rebase --exec true master^^  # OK but in fact this runs /usr/bin/true

Yeah, this is the builtin thing I mentioned elsewhere. I think it's
pretty rare to run a builtin with no arguments and care about the
behavior differences.

> /usr/bin/time requires an argument. Even though the bash builtin time
> runs fine without argument.
> 
>   $ time
> 
>   real    0m0.000s
>   user    0m0.000s
>   sys     0m0.000s

I've run into the "time" distinction even when running things from the
shell, because the time builtin is special. E.g.:

  $ time true
  real	0m0.000s
  user	0m0.000s
  sys	0m0.000s

  $ (echo foo | time true) 2>&1
  0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 1136maxresident)k
  0inputs+0outputs (0major+61minor)pagefaults 0swaps

So to some degree, depending on builtins versus external commands
(especially when you're round-tripping through another program running a
second shell) is going to have some surprises.

> But if the optimization is applied to more complex commands, then we
> will have problems. For instance, the builtin echo supports \E, but
> /usr/bin/echo doesn't support it.

No, it shouldn't. If any of

     |&;<>()$`\\\"' \t\n*?[#~=%

appear in the string, we always run the shell.

> In any case, the manpage says --exec <cmd> and "<cmd> will be
> interpreted as one or more shell commands.", it doesn't say "--exec
> <executable>".

Right, it's clearly supposed to use the shell, or behave as if the shell
were invoked (within reason).

-Peff
