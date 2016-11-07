Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5632022A
	for <e@80x24.org>; Mon,  7 Nov 2016 21:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbcKGVBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 16:01:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:39894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbcKGVBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 16:01:10 -0500
Received: (qmail 9940 invoked by uid 109); 7 Nov 2016 21:01:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 21:01:09 +0000
Received: (qmail 15961 invoked by uid 111); 7 Nov 2016 21:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 16:01:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 16:01:07 -0500
Date:   Mon, 7 Nov 2016 16:01:07 -0500
From:   Jeff King <peff@peff.net>
To:     Diggory Hardy <lists@dhardy.name>
Cc:     git@vger.kernel.org
Subject: Re: git push remote syntax
Message-ID: <20161107210107.d6c7ihmi5npwm76i@sigill.intra.peff.net>
References: <1613741.x6i0st30av@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1613741.x6i0st30av@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 01:49:40PM +0000, Diggory Hardy wrote:

> One thing I find a little frustrating about git is that the syntax needed 
> differs by command. I wish the 'remote/branch' syntax was more universal:

The reason it's not is that "remote/branch" refers to a branch in your
local repository. Whereas fetch/push want a single remote, and then one
or more refspecs. They often _look_ the same in simple cases, but the
latter covers a lot of cases not handled by the former.

For example:

  # no configured remote nor remote tracking branch at all
  git pull git://host/repo.git master

  # multiple branches for an octopus merge
  git pull origin branchA branchB

  # refspecs
  git pull origin devel:tmp

It's possible that we could have some kind of do-what-I-mean syntax for
the command-line options, though. It wouldn't have to cover every
esoteric case, but could cover the common ones and expand into the more
complete syntax. E.g., if we made:

  git pull origin/master

behave as if you said:

  git pull origin master

that would cover many uses. There are still some corner cases, though:

  - you could have a remote with a slash in it; presumably we would
    check that first and fallback to the DWIM behavior

  - These commands only handle a single remote at once, so something
    like:

      git pull origin/foo other-remote/bar

    is nonsensical. We'd have to catch and disallow multiple remotes.
    Probably we could only kick in the DWIM when there is a single
    argument (otherwise you're just repeating the remote name over and
    over, at which point you might as well use the "remote [refspec...]"
    syntax.

It seems like it's probably do-able.

I'm still undecided on whether it is a good idea or not. In one sense,
it does unify the syntax you use to refer to a remote branch. But it
also blurs the meanings. Normally "origin/master" refers only to your
local refs/remotes copy of what is on the remote, but this is blurring
the line. It's not clear to me if that reduces confusion (because you
don't have to care about that line anymore), or if it increases it
(because sometimes it _does_ matter, and somebody who doesn't learn the
difference between the two will get bitten later. Plus now there are
multiple ways of spelling the same thing).

> > git pull myremote/somebranch
> complains about the syntax; IMO it should either pull from that branch (and 
> merge if necessary) or complain instead that pulling from a different branch 
> is not supported (and suggest using merge).

Reading this, I wonder if I've misinterpreted your request. It sounds
like you want this to be the same as:

  git merge myremote/somebranch

which is at least consistent in the use of "remote/branch" syntax. But
weird, because you're asking "pull" not to pull. Or another way to think
of it is that "git pull foo/bar" effectively becomes "git pull .
foo/bar". Which seems like it may be potentially error-prone, especially
if you use slashes in your remote names.

-Peff
