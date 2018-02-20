Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D211F404
	for <e@80x24.org>; Tue, 20 Feb 2018 03:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeBTDuT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 22:50:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:57778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932410AbeBTDuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 22:50:19 -0500
Received: (qmail 25715 invoked by uid 109); 20 Feb 2018 03:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 03:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11175 invoked by uid 111); 20 Feb 2018 03:51:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 22:51:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 22:50:16 -0500
Date:   Mon, 19 Feb 2018 22:50:16 -0500
From:   Jeff King <peff@peff.net>
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Is there any way to "interrupt" a rebase?
Message-ID: <20180220035016.GA17967@sigill.intra.peff.net>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 11:35:25AM -0800, Hilco Wijbenga wrote:

> git rebase --onto base-branch HEAD~7
> commit A --> conflicts
> ... lots of work ...
> commit B --> conflicts
> ... lots of work ...
> commit C (Git handles conflicts)
> commit D (no conflict)
> commit E --> conflicts
> ... er, that should have been fixed in commit C
> 
> How do I keep all the work I did for commits A and B? I get the
> impression that rerere does not help here because I did not finish the
> rebase succesfully (and that makes perfect sense, of course). Is there
> a way at this point in the rebase to "go back" to commit C (so without
> "git rebase --abort")?

rerere should help, since the resolutions are stored when you run "git
commit". Of course, sometimes there are changes outside of the
conflicted regions that are necessary.

One thing you can do is to repeat the rebase, but simply pick the
resolved state at each step. E.g.:

  # remember the failed attempt; you could also store the sha1 in an
  # environment variable, or even store individual commits.
  git tag failed

  # now abort and retry the rebase
  git rebase --abort
  git rebase -i

  # we should have stopped on commit A with conflicts. Now we can say
  # "make the tree just like the other time we saw A".
  git checkout failed~4 -- .

  # or if you want to review the changes, try this:
  git checkout -p failed~4

And so on. You visit each commit as before, but you can always grab your
previous work (or parts of it, with pathspec limiting or "-p") instead
of repeating the work.

I often do something like this for complicated merges (e.g., of two
long-running branches). I try the merge first, only to find that some
preparatory steps would make it a lot easier. So I commit the merged
result (even sometimes half-finished), "reset --hard" back to the
original, do the early steps, and then re-merge. And then I "checkout
-p" to pick my work out of the earlier failed attempt.

> (Surely, it's not as simple as doing a "git reset --hard
> sha-of-commit-C" is it?)

Not quite that simple, but that's another approach. If you "git reset
--hard" you'll lose D and E, since the rebase has already applied them.
But you could then replay them manually, like this:

  # go back to C and fix it
  git reset --hard C
  fix fix fix
  git commit --amend -m 'fixed C'

  # now replay the other commits on top
  git cherry-pick D
  git cherry-pick E

  # and then continue on with any other rebased patches
  git rebase --continue

-Peff
