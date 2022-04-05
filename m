Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C03DC4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiDEJyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347103AbiDEJqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:01 -0400
Received: from st43p00im-zteg10061901.me.com (st43p00im-zteg10061901.me.com [17.58.63.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F35714B
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1649151141;
        bh=+Xb04E00xs9tOhK2alZ9qkz6VyHpVtaUN/UtJkgzSII=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=pjoAW14snPexVU7Qo/B860PQTY5y+zvshXL6n+36HOVEW6l8M8SI+DLwEMbucIAU/
         vpTmnhRPaei3nsgexg2mrsMl51SBvFkmWevCIaOj/UxDL+H7w4q3IVMMNkSeKrb93T
         Zmea/vuetFINj/xlL88LxWnGOJ9G0uq5iBfWEx6oNCcxq9zde04gEiGDPQuzZQs46j
         NsCKEp2k6pzfSwz07crCMV62b+4tbVHjR8WhSzO8ckhOa0MbxR2FmQXQMPzXByQkQC
         IIzhUrplj2itCJcrZ/XF4CscTDmDxnyCzvk7B3+Vw22HsYKVzovTbwumA0YQ1HN0sd
         Jq+Ck8m4194zg==
Received: from max-mbp-1449.fritz.box (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPS id 5B6C1540409
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:32:21 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: 'stash push' fails after 'add -N'
Message-Id: <1E62EF4D-1D9C-494F-832D-EDE7A10EC665@icloud.com>
Date:   Tue, 5 Apr 2022 11:32:19 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=899 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2204050056
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following commands:
```
#!/bin/bash
git init workDir
cd workDir
git commit -m first --allow-empty
touch a
git add --intent-to-add a
git stash push --include-untracked
```

What did you expect to happen? (Expected behavior)
I tried to stash my changes after adding a file with `git add =
--intent-to-add`.
I expected the stash operation to succeed.


What happened instead? (Actual behavior)
The stash operation fails with the following output:
```
error: Entry 'a' not uptodate. Cannot merge.
Cannot save the current worktree state
```
Also, I find the error message very confusing.

It seems inconsistent whether git considers files added with
`--intent-to-add` as tracked or untracked.
Running `git status` after the commands above will show "Changes not
staged for commit: new file: a".
If I run the following commands after the commands above:
```
touch b
git add b
git stash push -S
git stash pop --index
git rm -f b
```
`git status` will now report the file `a` as untracked.

What's different between what you expected and what actually happened?
I expected `git stash push` to succeed instead of failing.

Anything else you want to add:
I tested this on git 2.35.1 and 2.21.0, which are both affected.

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
not run from a git repository - no hooks to show=
