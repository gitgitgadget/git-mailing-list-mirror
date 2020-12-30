Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DDC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE0720756
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 21:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgL3Vnc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 30 Dec 2020 16:43:32 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:25098 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Vnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 16:43:31 -0500
Received: from mbpdemarianne2.home ([90.8.188.225])
        by mwinf5d69 with ME
        id Alhn240014sDK1m03lhq1M; Wed, 30 Dec 2020 22:41:50 +0100
X-ME-Helo: mbpdemarianne2.home
X-ME-Auth: bGVvLmxhbnRlcml0QG9yYW5nZS5mcg==
X-ME-Date: Wed, 30 Dec 2020 22:41:50 +0100
X-ME-IP: 90.8.188.225
From:   LeSeulArtichaut <leseulartichaut@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [Bug report] Git gets stuck in rebase mode
Message-Id: <ECF77241-0631-45D6-8B79-4250EE777A5D@gmail.com>
Date:   Wed, 30 Dec 2020 22:41:44 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

I tried to rebase a branch, say `master`, onto a commit that does not exist in my local repository, say `37b52f3b750b11b9ef60db118f737a66af3bf242`:
`git rebase master 37b52f3b750b11b9ef60db118f737a66af3bf242`

- The branch has to be valid (e.g. `git rebase foo 37b52f3b750b11b9ef60db118f737a66af3bf242` doesn’t reproduce the bug)
- The commit SHA has to be a full SHA (e.g. `git rebase master 37b52f3b750b11b9ef60db118f737a66af3bf2 #42` doesn’t reproduce the bug)

Repro "from scratch":
```zsh
mkdir git-bug
cd git-bug
git init
touch foo.txt
git add foo.txt
git commit -m 'Initial commit'
git rebase master 37b52f3b750b11b9ef60db118f737a66af3bf242
```

What did you expect to happen? (Expected behavior)
Git either successfully applies the rebase or gives an error.

What happened instead? (Actual behavior)
```
error: Could not read 37b52f3b750b11b9ef60db118f737a66af3bf242
fatal: Invalid symmetric difference expression b91ebd8a08983ed5c27a3946821be02a39f99b3c…37b52f3b750b11b9ef60db118f737a66af3bf242
```

Git then instead gets « stuck » in rebase mode (i.e. a `.git/rebase-merge` directory exists), with the following visible effects:
 - `git status` kind of gets confused:
```bash
$ git status
On branch master
git-rebase-todo is missing.
No commands done.
No commands remaining.
You are currently editing a commit during a rebase.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

nothing to commit, working tree clean
```
 - powerlevel10k displays a `rebase-i` state
 - `git rebase --continue` and `git rebase --abort` fail:
```bash
$ git rebase --continue
error: could not open '.git/rebase-merge/git-rebase-todo': No such file or directory
$ git rebase --abort
fatal: unable to read tree 37b52f3b750b11b9ef60db118f737a66af3bf242
```

This disappears by deleting the `.git/rebase-merge` directory.

What's different between what you expected and what actually happened?
I didn’t expect Git to stay stuck in rebase. After the failure in the `rebase` command, the `.git/rebase-merge` directory should be deleted.


[System Info]
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Nov 10 00:10:30 PST 2020; root:xnu-6153.141.10~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
