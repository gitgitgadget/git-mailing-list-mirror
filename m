Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84BF207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbdD0UKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:10:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:41313 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752615AbdD0UKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:10:02 -0400
Received: (qmail 20029 invoked by uid 109); 27 Apr 2017 20:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 20:09:59 +0000
Received: (qmail 8699 invoked by uid 111); 27 Apr 2017 20:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 16:10:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 16:09:57 -0400
Date:   Thu, 27 Apr 2017 16:09:57 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Stryker <rstryker@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: 30min Script in git 2.7.4 takes 22+ hrs in git 2.9.3
Message-ID: <20170427200956.ssubj74fkxxi6wjk@sigill.intra.peff.net>
References: <CA+Up40iusByn-R55=2=2Ae8KH1mkj4hGF_E9dX3vn1vboyMwMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+Up40iusByn-R55=2=2Ae8KH1mkj4hGF_E9dX3vn1vboyMwMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 12:36:54PM -0400, Robert Stryker wrote:

> The problem:  the script takes 30 minutes for one environment
> including git 2.7.4, and generates a repo of about 30mb.   When run by
> a coworker using git 2.9.3, it takes 22+ hours and generates a 10gb
> repo.
> 
> Clearly something here is very wrong. Either there's a pretty horrible
> regression or my idea is a pretty bad one ;)

The large size makes me think that you're getting an auto-gc in the
middle that is exploding the unreachable objects into loose storage.
This can happen when objects are ready to be pruned, but Git holds on to
them for a grace periods (2 weeks by default) as a precaution against
simultaneous use.

Try doing:

  git config gc.auto 0

in the repositories before the slow step. Or alternatively, try:

  git config gc.pruneExpire now

which will continue to do the auto-gc, but throw away unreachable
objects immediately.

Or alternatively, we're failing to run gc at all and just getting tons
of loose objects that need packed. What does running "git gc --auto" say
if you run it in the slow repository? Does it improve the disk space
problem?

Even if one of those helps, I'd still like to know why the gc behavior
changed between the two versions. The best way to do that is via
git-bisect.

You should be able to do:

  # make sure you can compile git from source
  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  make

  git bisect start
  git bisect good v2.7.4
  git bisect bad v2.9.3

  # for each commit bisect dumps you at, run your test. The bin-wrappers
  # part is important, because it sets up the environment to run
  # sub-programs from the built version. And as pull is a shell script,
  # the problem is likely in a sub-program.
  /path/to/git/bin-wrappers/git pull ...

  # And then mark whether it was fast or slow. You obviously don't need
  # to run the program to completion; just enough to decide if it's fast
  # or slow (which might be better done by observing disk space rather
  # than timing).
  git bisect good ;# or "bad" if it was slow

It's going to be tedious even if it takes 30 minutes per iteration. It
might be worth trying to adjust the test case for smaller repos. :)

It may also be worth trying the test with the latest tip of "master".
v2.9.3 is several versions behind, and it's possible that something may
have been fixed since then (nothing comes immediately to mind, but it's
worth a shot).

-Peff
