Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4081F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbcJTMbP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 08:31:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:60003 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbcJTMbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 08:31:15 -0400
Received: (qmail 6744 invoked by uid 109); 20 Oct 2016 12:31:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 12:31:13 +0000
Received: (qmail 26387 invoked by uid 111); 20 Oct 2016 12:31:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 08:31:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 08:31:11 -0400
Date:   Thu, 20 Oct 2016 08:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610201154070.3264@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610201154070.3264@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 12:17:33PM +0200, Johannes Schindelin wrote:

> If you want to know just how harmful this reliance on shell scripting is
> to our goal of keeping Git portable: already moving from Linux to MacOSX
> costs you roughly 3x as long to run the build & test (~12mins vs ~36mins
> for GCC, according to https://travis-ci.org/git/git/builds/159125647).

Wait, shell scripts are slow on MacOS now?

Perhaps, but it seems more likely that one or more of the following is
true:

  - setup of the OS X VM takes longer (it does; if you click-through to
    the test results, you'll see that the "make test" step goes from
    647s on Linux to 1108s on MacOS. That's much worse, but not even
    twice as slow, let alone 3x).

  - Travis Linux and OSX VMs do not have identical hardware. Looking at
    https://docs.travis-ci.com/user/ci-environment/, it appears that
    Linux containers get twice as many cores.

  - Git performance on Linux may be better than MacOS. The test suite is
    very filesystem-heavy because it creates and destroys a lot of files
    and repositories. If the kernel vfs performance is worse, it's
    likely to show up in the test suite (especially if the issue is
    latency and you aren't doing it massively in parallel).

    I don't have a real way to measure that, but it seems like a
    plausible factor.

So that sucks that the MacOS Travis build takes a half hour to run. But
I don't think that shell scripting is the culprit.

> So the only thing that would really count as an improvement would be to
> change the test suite in such a manner that it relies more on helpers in
> t/helper/ and less on heavy-duty shell scripting.
> 
> Of course, if you continue to resist (because the problem is obviously not
> affecting you personally, so why would you care), I won't even try to find
> the time to start on that project.

I'm not sure what you mean by "resist". The tests suite has been a set
of shell scripts for over a decade. As far as I know there is not
currently a viable alternative. If you have patches that make it faster
without negatively impact the ease of writing tests, I'd be happy to see
them.  If you have more t/helper programs that can eliminate expensive
bits of the shell scripts and speed up the test run, great. If you have
some other proposal entirely, I'd love to hear it.  But I do not see
that there is any proposal to "resist" at this point.

I'm also not entirely convinced that the test suite being a shell script
is the main culprit for its slowness. We run git a lot of times, and
that's inherent in testing it. I ran the whole test suite under
"strace -f -e execve". There are ~335K execs. Here's the breakdown of
the top ones:

$ perl -lne '/execve\("(.*?)"/ and print $1' /tmp/foo.out | sort | uniq -c | sort -rn | head
 152271 /home/peff/compile/git/git
  57340 /home/peff/compile/git/t/../bin-wrappers/git
  16865 /bin/sed
  12650 /bin/rm
  11257 /bin/cat
   9326 /home/peff/compile/git/git-sh-i18n--envsubst
   9079 /usr/bin/diff
   8013 /usr/bin/wc
   5924 /bin/mv
   4566 /bin/grep

Almost half are running git itself. Let's assume that can't be changed.
That leaves ~180K of shell-related overhead (versus the optimal case,
that the entire test suite becomes one monolithic program ;) ).

Close to 1/3 of those processes are just invoking the bin-wrapper
script to set up the EXEC_PATH, etc. I imagine it would not be too hard
to just do that in the test script. In fact, it looks like:

  make prefix=/wherever install
  GIT_TEST_INSTALLED=/wherever/bin make test

might give you an immediate speedup by skipping bin-wrappers entirely.

The rest of it is harder. I think you'd have to move the test suite to a
language like perl that can do more of that as builtins (I'm sure you'd
enjoy the portability implications of _that_).  It would almost be
easier to build a variant of the shell that has sed, rm, cat, and a few
others compiled in.

-Peff

PS I haven't kept up with all of this POSIX-layer stuff that's been
   announced in Windows the past few months. Is it a viable path forward
   that would have better performance (obviously not in the short term,
   but where we may arrive in a few years)?
