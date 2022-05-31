Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E686C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbiEaUZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbiEaUZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 16:25:51 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 May 2022 13:25:48 PDT
Received: from blitiri.xlumurb.eu (blitiri.xlumurb.eu [51.159.35.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E62562E7
        for <git@vger.kernel.org>; Tue, 31 May 2022 13:25:48 -0700 (PDT)
Message-ID: <eb2d8ce45e556afd81216746f190bc5c883cdb81.camel@xlumurb.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xlumurb.eu; s=mail;
        t=1654028334; bh=vyK8wG+QNMVeSiVKvJHMQGtbc95ApZemKmnNLmX6Gu0=;
        h=Subject:From:To:Date;
        b=mVnM0ISiUf4AXVJ9Syz29u3byXXg0QsTP1ynKZj8f0dHDKYII2v/5MPCS+xPGnWYq
         3AZaRVdSqE1sBZNKJIOTV3TpFg8Hh6p1O6hxr3XXi6AFEGoFyd/wwkxn8dzlK9Omnq
         HLv32aN87JdTPQ9HQ9Ay2or15JG97LDfSvc6p1po=
Subject: git pull --recurse-submodules wipes uncommitted submodule changes
 without warning
From:   Guillaume Girol <symphorien@xlumurb.eu>
To:     git@vger.kernel.org
Date:   Tue, 31 May 2022 22:18:54 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your
issue)

The repository has a submodule bar.
In the current checkout, bar has new commits, but this is not commited:

----------------------------

$ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-
forwarded.
  (use "git pull" to update your local branch)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   bar (new commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	git-bugreport-2022-05-31-2142.txt

no changes added to commit (use "git add" and/or "git commit -a")

----------------------------

There is one commit to pull. It affects a file in the superproject, but
not the submodule.

The issue arises with:

$ git pull --recurse-submodule=3Don-demand --no-rebase

What did you expect to happen? (Expected behavior)

The file affected by the pulled commit is modified, but the submodule
is left untouched.
The output of git status should look like:

----------------------------

$ git status
On branch master
Your branch up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   bar (new commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	git-bugreport-2022-05-31-2142.txt

no changes added to commit (use "git add" and/or "git commit -a")

----------------------------

What happened instead? (Actual behavior)

--------------------------

$  git pull --recurse-submodule=3Don-demand --no-rebase
Updating 67627dd..80f5c51
Fast-forward
 foo | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
Submodule path 'bar': checked out
'ef3c0711fedca48b0b43aadfd01b7bb94b519a13'

$  git status
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	git-bugreport-2022-05-31-2142.txt

nothing added to commit but untracked files present (use "git add" to
track)

-----------------------

my uncommitted changes to the submodule have been wiped, and the commit
of the pulled revision was checked out.

What's different between what you expected and what actually happened?

When there are uncommitted changes to a file foo in a repo, and that I
`git pull` a commit that does not affect this file foo, git pull does
not wipe my changes to `foo`. I expect the same for submodules. If
there is a conflict, I am told about it and nothing is wiped either.


Anything else you want to add:

git pull is able to detect conflicts on submodules, so why not non-
conflicts on submodules?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/0d3wgx8x6dxdb2cpnq105z23hah07z7l-bash-5.1-
p16/bin/bash
uname: Linux 5.15.39 #1-NixOS SMP Thu May 12 10:30:34 UTC 2022 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /run/current-system/sw/bin/zsh


[Enabled Hooks]

