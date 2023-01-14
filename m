Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F293CC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjANJqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 04:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjANJpy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 04:45:54 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558507AB6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 01:45:51 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p12so11991380qkm.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZQv4iCk/NzYstquZtUC7hzlz82PUyu+juGcd/SLPWk=;
        b=RazRPsd0fYD9CQDSrepG7mpOE3JBy8KV7E0ivkj3IEzrReaES/INn1hYVv/8UFgmco
         BoR04rHNToVgk2NYuFVFISNN7A5K2CEwTabf/8Lc62IMYz3bbOo1QtrBNmdCvK5+2Ne0
         mwJ1eiRlzsJaBWL4wTcJeKHB4hl+Kja14mWY0p1ByCQzLiWtnHLr1gG+iLODo8j4L4g6
         e1dyEAjTiVsAGmpwpeXRP5M99H6YjjhJOxWgMk4Qu6YYs/QZHsaZJo6OZ9sIttSjVrny
         1jGvZ+5HYswPrs8B0OdL6wGiR9dflDVxAOe1wlZ/c5zATJVbE7YE2k9YX5g+lUabeDWV
         Qndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZQv4iCk/NzYstquZtUC7hzlz82PUyu+juGcd/SLPWk=;
        b=OEwqP4OyGC84jsVnJpU/UhUUUzl7N0KBZJM+5HISDo5KOSo9lAoyAiI66kJnvyI170
         Gc0vRyfYyDC8biYgi6yp/i++7eUqz/GT4SJ3DNf2bH7+mDvXLE3+bubCfbhbXcSPrwfD
         PQaLAvtGxohLn+njwQ1/bGEr6zevEAv9XJZ0vdA5dz5XXX0coNupS8Si3DBm029a9u8F
         +bGtB8MydYGo5+GR3YR6oG7tBXtGS3N7xUnLNQd7v4G9sK8eQ6VtHHA60iNrOeJTbttm
         /rBr0QQOq2y4rSj3peho4v9OrjPOUsOIOsW8B4RJLhV2tGCim1z9zxyhcoUPYoc4OeqZ
         oM+A==
X-Gm-Message-State: AFqh2kpmTYWKvtvFIJr99VVAUW43ZhwHYVwXv4U2dVbP/0paR0zcvEqR
        kOvDvrrrqSomKtvQmwcjlKmgk9L2OGq6UEIpjViB1gbXku6vlg==
X-Google-Smtp-Source: AMrXdXsLT/uEhj8m46n6/hEncwGZYB6SiMkYik2OK4IMuMZqaumksi3E2XuuzxpiMK/xP1e2bbyGJEHjSsd3s5P+6UA=
X-Received: by 2002:a05:620a:22e6:b0:705:ade9:5656 with SMTP id
 p6-20020a05620a22e600b00705ade95656mr1750661qki.708.1673689550303; Sat, 14
 Jan 2023 01:45:50 -0800 (PST)
MIME-Version: 1.0
From:   Jinwook Jeong <vustthat@gmail.com>
Date:   Sat, 14 Jan 2023 18:45:34 +0900
Message-ID: <CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com>
Subject: bugreport: "git checkout -B" allows checking out one branch across
 multiple worktrees
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. `cd` into any git repo that has at least one commit.
2. Identify the current branch, say main
3. $ git branch foo # a new branch
4. $ git worktree add ../new_worktree foo
5. $ cd ../new_worktree
6. $ git checkout -B master HEAD


What did you expect to happen? (Expected behavior)

git prints out "Fatal: 'main' is already checked out at ..." (or
similar message that informs me that I'm not allowed to doubly
checkout one branch)


What happened instead? (Actual behavior)

The new_worktree successfully changes its current branch to master,
which is already held by another worktree.


Anything else you want to add:

https://www.git-scm.com/docs/git-checkout#Documentation/git-checkout.txt-emgitcheckoutem-b-Bltnew-branchgtltstart-pointgt

According to the documentation, "git checkout -B BRANCH START" is the
transactionally equivalent of:

  git branch -f BRANCH START
  git checkout BRANCH

When I ran the first command in place of the step 6 of the above
reproducing procedure, git refused to carry on;
I suppose that this is the intended behavior for "git checkout -B".


[System Info]
git version:
git version 2.39.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Sun Nov  6 23:31:13
PST 2022; root:xnu-8020.240.14~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
