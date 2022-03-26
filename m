Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DBDC433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiCZOZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiCZOZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 10:25:06 -0400
Received: from ms11p00im-qufo17291301.me.com (ms11p00im-qufo17291301.me.com [17.58.38.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70613D1E
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1648304607;
        bh=arZ1GeT/ApYxSYtjCKSEgmTwuuiUJ0779hl1axTGTbI=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=iuOOzkqDzAfx5fkcnnLroMMpTVRj9SdiC/n9qPhSTmU9YoRJ4Qz66guy1Q/Ob024W
         bXz/nkdpXLxaet1T2e9mTqHDu69OdzjmowLSdWp6S8NhQjxOkZSz5QT7Q98NP62B7Z
         eIQkaudU5KTtInJjytqkZ8+BWE5WEcv64fbXIOoEUwBZzSJexVgHLVPdN0vgUIo5CL
         7rhm7gl7zVmodQdzar0lsJ8JbVYFhbhN+W5x0NiheSOwr6JMv2u1OtWyOu6YnXvxgn
         4oPmzJW1xT/F9jKoV3sYURJKgnF1JFizUX2EsixwJeWChcgODuS+XkQdYFAp1NfNQD
         PDzc5CTPrNjyQ==
Received: from max-mbp-1449.fritz.box (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291301.me.com (Postfix) with ESMTPS id 3E9FE940251
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 14:23:27 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_733E63F4-252D-47A2-93F3-DB3AC49531BF"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: fast forward merge anomaly, 'commit' after 'reset --soft' can produce
 new commit with same hash as before
Message-Id: <1BD801F4-B2BA-4D6C-A450-5EEB14E8A58A@icloud.com>
Date:   Sat, 26 Mar 2022 15:23:24 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2203260092
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_733E63F4-252D-47A2-93F3-DB3AC49531BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following script with and without the sleep command.
```
#!/bin/bash
git -c init.defaultBranch=3Dmaster init
git config user.email "e@mail.com"
git config  user.name "Name"
git commit -m init --allow-empty
git checkout -b otherBranch
git commit -a --allow-empty -m first
git checkout master
git merge --ff otherBranch
git notes add -m foo
# sleep 2
git reset --soft HEAD~1
git commit -a --allow-empty -m first
git notes add -f -m bar
git log --graph --abbrev-commit --decorate --all
git checkout otherBranch
git notes show
```

What did you expect to happen? (Expected behavior)
I expected that the sleep command will not affect the behavior of the =
script.

What happened instead? (Actual behavior)
Without the sleep command, the note attached to the HEAD of otherBranch =
contains the message "bar" (most of the time).
With the sleep command, the note attached to the HEAD of otherBranch =
contains the message "foo".=20

What's different between what you expected and what actually happened?
Without the sleep command, the last commit will have the same commit id =
as the HEAD before the reset.
Because of this collision, we can not attach notes to HEAD of the master =
and the HEAD of otherBranch independently.

Anything else you want to add:
I tested this on git 2.35.1, 2.30.2 and 2.21.0, and they are all =
affected.=20
I attached the console output of the script with and without the sleep =
command to this mail.

[System Info]
git version:
git version 2.35.1
cpu: x86_64
built from commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show

--Apple-Mail=_733E63F4-252D-47A2-93F3-DB3AC49531BF
Content-Disposition: attachment;
	filename=output-sleep.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="output-sleep.txt"
Content-Transfer-Encoding: 7bit

warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test/state.ff/.git/
[master (root-commit) c298c33] init
Switched to a new branch 'otherBranch'
[otherBranch ae621d9] first
Switched to branch 'master'
Updating c298c33..ae621d9
Fast-forward
[master 1681165] first
* commit 1681165 (HEAD -> master)
| Author: Name <e@mail.com>
| Date:   Sat Mar 26 13:35:57 2022 +0000
| 
|     first
| 
| Notes:
|     bar
|   
| * commit be3204c (refs/notes/commits)
| | Author: Name <e@mail.com>
| | Date:   Sat Mar 26 13:35:57 2022 +0000
| | 
| |     Notes added by 'git notes add'
| | 
| * commit aff6c5b
|   Author: Name <e@mail.com>
|   Date:   Sat Mar 26 13:35:55 2022 +0000
|   
|       Notes added by 'git notes add'
|   
| * commit ae621d9 (otherBranch)
|/  Author: Name <e@mail.com>
|   Date:   Sat Mar 26 13:35:55 2022 +0000
|   
|       first
|   
|   Notes:
|       foo
| 
* commit c298c33
  Author: Name <e@mail.com>
  Date:   Sat Mar 26 13:35:55 2022 +0000
  
      init
Switched to branch 'otherBranch'
foo

--Apple-Mail=_733E63F4-252D-47A2-93F3-DB3AC49531BF
Content-Disposition: attachment;
	filename=output-no-sleep.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="output-no-sleep.txt"
Content-Transfer-Encoding: quoted-printable

warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test/state.ff/.git/
[master (root-commit) 2cd4638] init
Switched to a new branch 'otherBranch'
[otherBranch e803e0a] first
Switched to branch 'master'
Updating 2cd4638..e803e0a
Fast-forward
[master e803e0a] first
Overwriting existing notes for object =
e803e0a4625722bd00efc5ff39b0d70b55ecae30
* commit e803e0a (HEAD -> master, otherBranch)
| Author: Name <e@mail.com>
| Date:   Sat Mar 26 13:35:47 2022 +0000
|=20
|     first
|=20
| Notes:
|     bar
|=20
* commit 2cd4638
  Author: Name <e@mail.com>
  Date:   Sat Mar 26 13:35:47 2022 +0000
 =20
      init
 =20
* commit 21e0b57 (refs/notes/commits)
| Author: Name <e@mail.com>
| Date:   Sat Mar 26 13:35:47 2022 +0000
|=20
|     Notes added by 'git notes add'
|=20
* commit a3da577
  Author: Name <e@mail.com>
  Date:   Sat Mar 26 13:35:47 2022 +0000
 =20
      Notes added by 'git notes add'
Switched to branch 'otherBranch'
bar

--Apple-Mail=_733E63F4-252D-47A2-93F3-DB3AC49531BF--
