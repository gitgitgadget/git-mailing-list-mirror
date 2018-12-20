Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49DE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbeLTPSy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 10:18:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:46844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729938AbeLTPSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 10:18:54 -0500
Received: (qmail 32382 invoked by uid 109); 20 Dec 2018 15:18:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 15:18:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31410 invoked by uid 111); 20 Dec 2018 15:18:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 10:18:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 10:18:30 -0500
Date:   Thu, 20 Dec 2018 10:18:30 -0500
From:   Jeff King <peff@peff.net>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: A bug in git-add with GIT_DIR?
Message-ID: <20181220151830.GD27361@sigill.intra.peff.net>
References: <CAGHpTBKyBgPURYfuZgVwnskGSy9L1+3WMrYuPmziQ7VcGDkMcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGHpTBKyBgPURYfuZgVwnskGSy9L1+3WMrYuPmziQ7VcGDkMcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 10:37:21AM +0200, Orgad Shaneh wrote:

> I played around with t5403-post-checkout-hook, and noticed that its
> state is not exactly what I'd expect it to be.
> 
> The test setup is:
> echo Data for commit0. >a &&
> echo Data for commit0. >b &&
> git update-index --add a &&
> git update-index --add b &&
> tree0=$(git write-tree) &&
> commit0=$(echo setup | git commit-tree $tree0) &&
> git update-ref refs/heads/master $commit0 &&
> git clone ./. clone1 &&
> git clone ./. clone2 &&
> GIT_DIR=clone2/.git git branch new2 &&
> echo Data for commit1. >clone2/b &&
> GIT_DIR=clone2/.git git add clone2/b &&
> GIT_DIR=clone2/.git git commit -m new2
> 
> Now, the line before the last one executes git add clone2/b with GIT_DIR set.

When GIT_DIR is set but not GIT_WORK_TREE, the current directory is
taken as the working tree.

So that will find clone2/b (from the current directory, which is a real
file), and add an index entry with that path "clone2/b" and the sha1 of
that content.

But when commands are run from inside "clone2", they will naturally
treat "clone2" as the working tree. And since "clone2/b" does not exist
inside there, they will say "oops, it looks like this file has been
deleted".

> I'd expect that to add b inside clone2, but instead it adds an
> inexistent clone2/clone2/b, and if I stop at this line, then the
> status shows:

Sort of. It never sees the path "clone2/clone2/b", but the path in the
index coupled with the working tree being inside clone2 means that it
would look for such a file.

> On branch master
> Your branch is up to date with 'origin/master'.
> 
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
> 
>         new file:   clone2/b
> 
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   b
>         deleted:    clone2/b
> 
> Is this the intended behavior? It looks like that's not what the test
> meant to do anyway...

This is the expected behavior if you did "cd clone2 && git status".
Looking at the test, I don't think it quite meant to do this. It looks
like it predates "git -C", but for some reason did not want to "cd" in a
subshell.

I think it would be better written as:

  git -C clone2 add b &&
  git -C clone2 commit -m new2

or:

  (
	cd clone2 &&
	git add b &&
	git commit -m new2
  )

And ditto for all of the other uses of $GIT_DIR in that script. E.g.,
the ones that do:

  GIT_DIR=clone1/.git git checkout master

are likely writing the contents of clone1's master branch to the
_current_ directory (not the working tree in clone1).

> And if I change it to (cd clone2 && git add b), then the commits look
> reasonable, but step 6 fails.

You probably just need to update the other calls, too, so they all
match.

-Peff
