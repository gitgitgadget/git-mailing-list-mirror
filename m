Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96091F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbcIAV6R (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:58:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:36810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754329AbcIAV6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:58:15 -0400
Received: (qmail 559 invoked by uid 109); 1 Sep 2016 21:58:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 21:58:15 +0000
Received: (qmail 19750 invoked by uid 111); 1 Sep 2016 21:58:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 17:58:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 17:58:10 -0400
Date:   Thu, 1 Sep 2016 17:58:10 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: `make profile-install` fails in 2.9.3
Message-ID: <20160901215810.ez47lqwmfmahyvc7@sigill.intra.peff.net>
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
 <20160901200700.GA8254@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160901200700.GA8254@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2016 at 09:07:00PM +0100, Thomas Gummerer wrote:

> > Related problem: `t3700-add.sh` currently fails in 2.9.3. I can
> > provide more debug information if you don't already know this problem.
> 
> I noticed this problem as well, when I'm compiling with USE_NSEC = 1
> in my config.mak.

I can replicate this even without USE_NSEC with my stress-tester[1].
That makes sense why it would show up with the profiling run; git runs
slower and therefore increases the chances of crossing the 1-second
boundary and losing the race.

[1] https://github.com/peff/git/blob/meta/stress

> Tracking this problem down a bit, it happens because the --chmod=[+-]x
> option introduced in 4e55ed32 ("add: add --chmod=+x / --chmod=-x
> options") only works if the file on disk is modified.  When the test
> was changed to work on one single file, instead of doing chmod=+x on
> one file and chmod=-x on another file in b38ab197c ("t3700: merge two
> tests into one"), this test started breaking when the mtime of the
> file and the index file weren't the same (in other words, if the file
> was not racily clean and thus was not smudged).

That certainly sounds buggy. A less racy way of verifying this is just:

  # guarantee not-racy state
  echo content >file
  test-chmtime -60 file
  git add file

  # now check --chmod; file will still be 100644!
  git add --chmod=+x file
  git ls-files -s

> One possible fix for the test is to smudge the entry as showed below,
> though I'm not sure it's the right fix.  The other way I can think of
> is to change the file in the index regardless of whether the file was
> changed in some other way before issuing the git add command, as that
> might fit the user expectation better.  Thoughts?

Yeah, I think we should _always_ act on the --chmod, no matter if the
file is racy or not, or whether it has a content change or not. I.e.,
the race is not the problem, but rather the behavior of 4e55ed32. Your
second proposal there sounds more like the right approach.

-Peff
