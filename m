Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B877C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BA261248
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhE1Upb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 May 2021 16:45:31 -0400
Received: from botech.co.uk ([81.187.226.106]:46058 "EHLO chimp.botech.co.uk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhE1Upb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:45:31 -0400
X-Greylist: delayed 1773 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 16:45:30 EDT
Received: from botech.co.uk ([81.187.226.106] helo=[192.168.4.5])
        by chimp.botech.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tpr.ll@botech.co.uk>)
        id 1lmis8-0005Pm-Ez
        for git@vger.kernel.org; Fri, 28 May 2021 21:14:20 +0100
From:   "Tim Renouf (open source)" <tpr.ll@botech.co.uk>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: bug report: git checkout deletes worktree file even though it is
 excluded by sparse-checkout
Message-Id: <F58C0A40-A1B4-4B47-A8EA-20FEAB011B0D@botech.co.uk>
Date:   Fri, 28 May 2021 21:14:20 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

I have a bug report: git checkout deletes a worktree file even though it is excluded by sparse-checkout, even if it is dirty.

Watch this (starting in an empty directory):

$ git init
Initialised empty Git repository in /mnt/amd/home/trenouf/amd/tmp/git/.git/
$ echo file1 >file1; echo file2 >file2
$ git add file1 file2
$ git commit -m"commit 1"
[master (root-commit) 4f7035d] commit 1
 2 files changed, 2 insertions(+)
 create mode 100644 file1
 create mode 100644 file2
$ git rm file2
rm 'file2'
$ git commit -m"rm file2"
[master d025c99] rm file2
 1 file changed, 1 deletion(-)
 delete mode 100644 file2
$ git checkout master~1
HEAD is now at 4f7035d commit 1
$ git sparse-checkout set /file1
$ ls
file1
$ echo dirty >file2
$ ls
file1  file2
$ git checkout master
Previous HEAD position was 4f7035d commit 1
Switched to branch 'master'
$ ls
file1

I set up sparse-checkout to include only file1, not file2. file2 is now not in the worktree, even though it is in the commit I am checked out at. Then I create file2 with arbitrary content. Then a git checkout switching to the commit where file2 is removed also deletes it from the worktree.

I assert that file2 should be left untouched by that checkout, because it is excluded by sparse-checkout. I guess file2 had its skip-worktree bit set before the checkout that removed it from the index; that should stop it being deleted in the worktree.

To be clear, I expect that last “ls” to still show “file1  file2”.

Thank you for your attention if you have got this far.

-tpr

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.8.0-53-generic #60~20.04.1-Ubuntu SMP Thu May 6 09:52:46 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

