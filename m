Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D77208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeHHS0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:26:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:46784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727081AbeHHS0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:26:33 -0400
Received: (qmail 32572 invoked by uid 109); 8 Aug 2018 16:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 16:06:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26770 invoked by uid 111); 8 Aug 2018 16:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 12:06:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 12:06:12 -0400
Date:   Wed, 8 Aug 2018 12:06:12 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: Help with "fatal: unable to read ...." error during GC?
Message-ID: <20180808160612.GC1607@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 10:30:11AM -0400, Paul Smith wrote:

> I recently upgraded from Git 2.9.2 to 2.18.0 (note, I have no
> particular reason to believe this is related just passing info).  I'm
> running on Linux (64bit Ubuntu 18.04.1 but I've compiled Git myself
> from source, I'm not using the distro version).
> 
> I have a local repository I've been using for about two years (the
> .git/description file, which I don't use, has a TLM of July 31, 2016),
> with lots of worktrees being created/pruned/etc. during that time.
> 
> Note I'm doing all these operations in the 'main' repository, not in
> any of the worktrees.

Hrm, there was a pretty serious corruption bug in early versions of the
worktree code (IIRC, pruning would not consider detached HEADs from
other worktrees, and could drop that object).

> Yesterday, when I tried to fetch from my upstream I got a notification
> about GC needed.  Then GC failed with these errors (HEAD is set to
> master which is the same as origin/master):
> 
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'HEAD' references pruned commits
>   fatal: unable to read c104b8fb3631b5c54695206b2f73310c023c9963
>   error: failed to run repack

So that definitely looks like the corruption I'd expect from the
worktree bug, but...

> I ran a git fsck --full which showed me a lot of dangling commits and
> blobs, but no errors, no broken link messages, etc.

I'd have expected fsck to find it, too. However, looking at the code,
I'm not convinced that fsck is actually considering detached worktree
heads properly, either. Try:

  git rev-list --all --reflog --objects >/dev/null

which I know checks worktrees correctly. I'd expect that to fail.

If it does, then we need to narrow down which worktree is corrupt.
Perhaps something like:

  git worktree list |
  while read worktree head junk; do
	git rev-list --objects $head >/dev/null ||
	echo "$worktree seems corrupt"
  done

> I can't find that SHA anywhere: I looked in .git/objects, etc.  I also
> can't find any problems with my repo; obviously I haven't checked
> everything but I can show the git log back to the initial commit, all
> my stashes look fine, all my worktrees seem to be OK (git status etc.
> work fine in all of them).

"git status" might succeed if the corruption is further back in the
history.

> I would hate to have to throw this setup away since it has 23 stashes
> and 25 worktrees in various states that would be annoying to have to
> recreate... 

Definitely don't throw it away. I suspect you have a single corrupt
worktree, and everything else is fine.

-Peff
