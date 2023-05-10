Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C7AC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjEJUSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjEJUSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 16:18:07 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 13:18:06 PDT
Received: from ci74p00im-qukt09082502.me.com (ci74p00im-qukt09082502.me.com [17.57.156.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888D2D66
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1683749326;
        bh=q9xJnqq2Q0wNvSdeiVVN8I7Su48RVyh/5inWm4q7G8Q=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=gvRQ8JIcW1zNpCfLmSqaA1XZZKiXQPlHEyPEeGkFXFqkcvWpR3g7kGRNbjJpTA7lV
         ysUS6c0Xqv/xdcCULU2k1/qqDB/Jj112dcpoi4n6if3r7LHVcHuTfTRfKZ4xMHJuo4
         83zViQWbuxnfjvaxfN5d7nrGuAYLOx0UzjYwJWBuJBTTllANiMknvnZbOvCZ4NUuy4
         ywX5k7ow0jgq6zd2C7ElQQsioQE2/TARd6aKoq6FX5wAixR9qz6EQsGf82bgwJb/ue
         0xInJNaCELW1AWg7a/gRrkK9uFuCc13dW97nc4wG7RVEXmJt1F8jkPxgfw/A/bv5rA
         vW32Ko5k65Gxg==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09082502.me.com (Postfix) with ESMTPSA id E1BE311C0219
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:08:45 +0000 (UTC)
From:   Christopher Fretz <cfretz@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: git rebase --root bug
Message-Id: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
Date:   Wed, 10 May 2023 14:08:34 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
X-Proofpoint-GUID: co2nA7KpqqASAKfPVeO4pm4KN6Lh4yiy
X-Proofpoint-ORIG-GUID: co2nA7KpqqASAKfPVeO4pm4KN6Lh4yiy
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2305100163
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Run an interactive, root, rebase, select one or more commits to edit, =
and then leave the repo in the rebase state for long
enough that the "onto" commit expires out of the reflog and gets gc'd.

An example set of commands to immediately reproduce the issue can be =
seen below:
  $ mkdir git_test

  $ cd git_test

  $ git init
  Initialized empty Git repository in =
/Users/cfretz/working/git_test/.git/

  $ git commit --allow-empty -m 'root commit'
  [master (root-commit) 01edd93] root commit

  $ git rebase -i --root
  Stopped at 01edd93...  root commit # empty
  You can amend the commit now, with

    git commit --amend

  Once you are satisfied with your changes, run

    git rebase --continue

  $ git reflog expire --expire-unreachable=3Dnow --all

  $ git gc --prune=3Dnow
  Enumerating objects: 2, done.
  Counting objects: 100% (2/2), done.
  Writing objects: 100% (2/2), done.
  Total 2 (delta 0), reused 0 (delta 0), pack-reused 0

  $ git rebase --continue
  fatal: could not parse 10796537ce108c36191d52368250f403afede30b

What did you expect to happen? (Expected behavior)
Git should consider the "onto" commit to be referenced from the ongoing =
rebase, and refuse to gc it, even during a --root
rebase.

What happened instead? (Actual behavior)
Git gcs the "onto" commit, breaking the ongoing rebase; after this, no =
rebase commands work, and your only option is git rebase --quit.
The only way I've discovered to fix this without git rebase --quit is =
running scary commands to manually create a new dummy "onto" commit,
and then overwrite the onto file in the git directory; I'm not confident =
that this doesn't somehow cause subtle problems that aren't
immediately obvious.

What's different between what you expected and what actually happened?
Git gcs the onto commit and leaves the repo in a broken state. Without =
manual intervention to fix the .git directory, or hard bailing out of
the rebase, the repository appears broken. A user less familiar with git =
would likely just delete the repo, reclone, and start entirely from
scratch.

Anything else you want to add:
The way I originally encountered this issue was by leaving a repo in the =
rebase state for multiple weeks, coming back to the repo to finish the
work, and then having the repo broken by a background gc job. I assume =
the fundamental problem here is that the "onto" commit during a --root
rebase isn't actually a part of the new history, and is just =
"synthesized" to remove edge cases, and so git sees it as unreachable =
during the gc.
=46rom one perspective, it might be argued that this is "expected" =
behavior given the above, but given the severity of the failure I think =
this should
be considered a bug, and I think git should just unconditionally =
consider the "onto" commit as _always_ being reachable; it's not obvious =
to me why
this wouldn't work. My apologies if this bug has already been fixed in a =
later version of git. Thanks!

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:42:11 =
PST 2023; root:xnu-8792.81.3~2/RELEASE_X86_64 x86_64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]=
