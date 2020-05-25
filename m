Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AEBC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4B92078B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbgEYJqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 05:46:11 -0400
Received: from echo.default.edsfctgx.uk0.bigv.io ([46.43.3.208]:21788 "EHLO
        echo.tratt.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389333AbgEYJqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 05:46:11 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 05:46:11 EDT
Received: by echo.tratt.net (Postfix, from userid 1000)
        id 5D21865EF; Mon, 25 May 2020 10:40:20 +0100 (BST)
Date:   Mon, 25 May 2020 10:40:19 +0100
From:   Laurence Tratt <laurie@tratt.net>
To:     git@vger.kernel.org
Subject: recurse-submodules can remove local changes when switching branches?
Message-ID: <20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net>
User-Agent: mutt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If one creates a new repository, makes a new branch, adds a submodule, makes
local changes to that submodule, then switches to another branch, it seems
that git can silently remove those local changes.

Here's an example (the repositories involved are irrelevant other than
they're small!):

  $ git clone https://github.com/ltratt/supuner/
  $ cd supuner
  $ git submodule add https://github.com/ltratt/extsmail extsmail
  $ git checkout --recurse-submodules -b b
  $ git commit -m "add submodule" .

At this point make a local change to extsmail/README.md and confirm that
git has noticed that something in the submodule has changed:

  $ git status
  On branch b
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
    (commit or discard the untracked or modified content in submodules)
          modified:   extsmail (modified content)

  no changes added to commit (use "git add" and/or "git commit -a")

then change branch (in the supuner repository, not extsmail!):

  $ git checkout --recurse-submodules master

The switch of branch succeeds without warning me that I have changes in my
submodule. But then:

  $ git status
  On branch master
  Your branch is up to date with 'origin/master'.

  nothing to commit, working tree clean

My local changes to the submodule have disappeared entirely.

Switching back to `b` does not restore my changes:

  $ git checkout --recurse-submodules b
  On branch b
  nothing to commit, working tree clean

This happens on 2.26.2 and the current master. AFAICS this only happens
because the master branch does not yet have the submodule registered in it.
If it does, "checkout --recurse-submodules" maintains my local changes in
the submodule across the branch switch.


Laurie
-- 
Personal                                             http://tratt.net/laurie/
Software Development Team                                http://soft-dev.org/
   https://github.com/ltratt              http://twitter.com/laurencetratt

