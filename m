Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D556ECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 14:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIQOp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIQOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 10:45:56 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493830550
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 07:45:54 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id c9so36566580ybf.5
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 07:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OFBWJHPAwsinAlrWY+l0hruzk75UB05dCJgNsBmtrXs=;
        b=WSYiZo/cdcO5cK7NJvOLte7wQd1/M/gE7jaaucVoE1i3hKz46t2pvSZ1Jk9sk8/bch
         5RMvjU1Mv9iWQBLOK/KcC20GHX+cnJAC8AxgSDLC2yAAybqn9TstGVlkbxp60B4XvtZV
         M7QyNJ4Z++35r3y7kVMKGFefg58BKQJFsSouCdIOW2DH0zd0gcn9Ir35s+N3CznLcBYc
         OEoOt8KxC5Wvv6LlDYLXusuzJq5BjrmCHVfgwAzUph4ktKHur7kNpjXBeQw+iT0CYMqI
         oi84pIR+ADWbHbUP4SwHJfF0q8fopGSIr42l/XuZSiIXnNCzkfdF87MiRMEinaoFBNl1
         oWEQ==
X-Gm-Message-State: ACrzQf06HwKvtBp7cT41XVGN1vSYfjPuxf0aVD3UnzrFN68Sg+ObcmmP
        zVNTcaPxtJDWdSheAE0Sax3b1dLDIlXLp0dZoOlhq4X/OLM=
X-Google-Smtp-Source: AMsMyM6dChkTmElEQVQfU4CyyRD+HNYc62LHCxCBpeJlrPVXqE0PaDvrn4u7vYNZqStP/dVvkBvC6hWa6KDjWeM9zFY=
X-Received: by 2002:a25:a26a:0:b0:6ae:a723:f721 with SMTP id
 b97-20020a25a26a000000b006aea723f721mr8571220ybi.200.1663425953247; Sat, 17
 Sep 2022 07:45:53 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sat, 17 Sep 2022 16:45:17 +0200
Message-ID: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
Subject: [BUG] fixup commit is dropped during rebase if subject = branch name
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
  dir=rebase-fixup-subject-equals-branch-name
  mkdir $dir
  cd $dir
  git init --initial-branch=main
  git commit -m init --allow-empty
  git tag init

  # failure
  seq 1 3 >> bar && git add bar && git commit -m main
  git tag -f x
  seq 4 6 >> bar && git add bar && git commit -m bar
  seq 7 9 >> bar && git add bar && git commit --fixup :/main
  git -c sequence.editor=: rebase --autosquash --interactive x
  git diff ORIG_HEAD


What did you expect to happen? (Expected behavior)
Identical results as
  # normal
  git reset --hard init
  seq 1 3 >> bar && git add bar && git commit -m main
  git tag -f x
  seq 4 6 >> bar && git add bar && git commit --fixup :/main
  seq 7 9 >> bar && git add bar && git commit -m bar
  git -c sequence.editor=: rebase --autosquash --interactive x
  git diff ORIG_HEAD
except for the order of the commits.

What happened instead? (Actual behavior)
The fixup commit was dropped from the rebase-todo.

What's different between what you expected and what actually happened?
The HEAD is a fixup of a commit with the same subject as the branch
name. It is being rebased on top of the commit it is intended to
fixup, so it should be *picked*. Instead, it is dropped from the
rebase-todo. I expected the autosquash feature to work equally,
independently of the subject and the current branch name.

Anything else you want to add:
This appears to only occur if the subject is equal to the branch being
rebased. I didn't check if this occurs if there is simply 'a'
reference with an identical name in the repository (I'm guessing no).

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.3.windows.1
cpu: x86_64
built from commit: c4992d4fecabd7d111726ecb37e33a3ccb51d6f1
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Users\erik\Git\usr\bin\bash.exe


[Enabled Hooks]


-- 
Erik Cervin-Edin
