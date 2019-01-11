Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78EF211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 16:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfAKQEP (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 11:04:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:33806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729359AbfAKQEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 11:04:15 -0500
Received: (qmail 493 invoked by uid 109); 11 Jan 2019 16:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 16:04:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10578 invoked by uid 111); 11 Jan 2019 16:04:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 11:04:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 11:04:12 -0500
Date:   Fri, 11 Jan 2019 11:04:12 -0500
From:   Jeff King <peff@peff.net>
To:     Samir Benmendil <me@rmz.io>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git rebase --exec cannot run git commands affecting other repos
Message-ID: <20190111160411.GD16754@sigill.intra.peff.net>
References: <20190110161904.23fwbrgg7blyx3nj@uh-nuc001>
 <xmqqlg3s2wu8.fsf@gitster-ct.c.googlers.com>
 <20190110214842.dfisujzv7psx2jqe@hactar.rmz.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110214842.dfisujzv7psx2jqe@hactar.rmz.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 09:48:42PM +0000, Samir Benmendil wrote:

> > If the user wants to work in a different repository, the
> > environments that tells Git about the original repository can be
> > unset to do so, which is a very much deliberately designed
> > behaviour, primarily to help those who run "git rebase" from a
> > subdirectory of the project.
> 
> When run in a directory that does not have ".git" repository directory, Git
> tries to find such a directory in the parent directories to find the top of
> the working tree.
> 
> That should be the case as well for `git rebase`, is it not?

Generally yes. But ".git" does not necessarily have to be connected. For
example, try this:

  # a separate worktree and repo
  mkdir worktree
  git init --bare repo.git
  git -C repo.git config core.bare false
  git -C repo.git config core.worktree "$PWD/worktree"

  # an unrelated repo we'll try to access
  git init unrelated

  # operate in the separated repo using $GIT_DIR to point to the repo
  export GIT_DIR=$PWD/repo.git
  cd worktree

  # rebase that tries to operate in another repository
  echo content >file
  git add file
  git commit -m file
  git rebase --root -x 'cd ../unrelated && git rev-parse --git-dir'

And in fact, this case behaves the same now or with older versions of
Git (because GIT_DIR would be set either way). Likewise the less exotic
"git --git-dir=something rebase", which would set GIT_DIR in the
environment. I think there are other cases, too, where we'd internally
set GIT_DIR during repo discovery, but I don't remember all of them
offhand.

So I think the reasoning at the time was along the lines of "scripts
already should not be relying on the absence of $GIT_DIR". That said, I
do think there's an argument to be made that it generally worked before
in many common setups, even if it was not bulletproof.

And I am not sure I could construct a case where setting $GIT_DIR when
it was not already set explicitly _helps_ the "exec" command (because
if searching from the working tree does not work, then the caller of
"git rebase" would had to have set $GIT_DIR itself).

-Peff
