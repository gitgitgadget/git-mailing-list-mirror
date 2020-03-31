Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61155C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C120675
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgCaJej (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:34:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:56652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726488AbgCaJej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 05:34:39 -0400
Received: (qmail 23443 invoked by uid 109); 31 Mar 2020 09:34:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Mar 2020 09:34:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28143 invoked by uid 111); 31 Mar 2020 09:44:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2020 05:44:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Mar 2020 05:34:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
Message-ID: <20200331093437.GA7274@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003302027240.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003302027240.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 08:39:08PM +0200, Johannes Schindelin wrote:

> > So my perspective was the opposite of yours: "return" is the officially
> > sanctioned way to exit early from a test snippet, and "exit" only
> > happens to work because of the undocumented fact that lazy prereqs
> > happen in a subshell. But it turns out neither was documented. :)
> 
> Can a subshell inside a function cause a `return` from said function? I
> don't think so, but let's put that to a test:
> [...]
> To me, the fact that that `return` does not return from the function, but
> only exits the subshell, in my mind lends more credence to the idea that
> `exit` is more appropriate in this context than `return`.

Hmm, yeah, I was wrong about it actually returning from the function.
Thanks for demonstrating.  Returning from just the subshell in the case
of lazy_prereq is OK for our purposes, since the exit value of the
subshell is taken as the result of the prereq check (and in turn becomes
the return value of that function anyway).

But it does make more sympathetic to the idea that "exit" is appropriate
here. Especially given the prodding below (which you can skip to the
last paragraph if you're not interested in shell arcana):

> For shiggles, I also added that `$?` because I really, _really_ wanted to
> know whether my reading of GNU Bash's documentation was correct, and it
> appears I was mistaken: apparently `return` used outside a function does
> _not_ cause a non-zero exit code.

I think the issue may be in the definition of "outside a function".

If we really are at the top-level outside of a function, then return
gives a non-zero exit but _doesn't_ return in bash:

  $ bash -c 'return 2; echo inside=$?'; echo outside=$?
  bash: line 0: return: can only `return' from a function or sourced script
  inside=1
  outside=0

So even though we asked to return 2, it gave us a generic "1" return
code and continued executing (and then outside=0 because the echo was
successful).

And that's true even in a subshell (not we moved "outside" into the bash
process so we can see that it keeps going):

  $ bash -c '(return 2; echo inside=$?); echo outside=$?'
  bash: line 0: return: can only `return' from a function or sourced script
  inside=1
  outside=0

But if we actually _are_ inside a function, even inside a subshell, then
return "works", by stopping execution in the subshell and returning the
value we asked (in your example we got "0" because you didn't specify a
value for "return", so it just propagated the exit code of the earlier
"echo").

  $ bash -c 'f() { (return 2; echo inside=$?); echo outside=$?; }; f'
  outside=2

It's just a bit odd (to me) that it still runs the rest of the function.

Dash behaves a bit more sensibly with an out-of-function return, just
returning from the script:

  $ dash -c 'return 2; echo inside=$?'; echo outside=$?
  outside=2

and with a subshell, it returns only from that subshell:

  $ dash -c '(return 2; echo inside=$?); echo outside=$?'
  outside=2

So inside a subshell-in-a-function, it behaves exactly the same
(returning from the subshell but not the function).

I think the behavior of both shells is fine for our purposes. We _are_
in a function, so as long as we return from the subshell immediately
we're happy. But given the oddities in how bash behaves, and the fact
that POSIX says:

  If the shell is not currently executing a function or dot script, the
  results are unspecified.

it may be better to stay away from the question entirely.

-Peff
