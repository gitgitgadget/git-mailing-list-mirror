Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23DFC7EE24
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFCSSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFCSSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 14:18:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88389B9
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 11:18:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so6946211a12.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1685816315; x=1688408315;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNB5bfypuiPn+JbDlGqToRzEkP5cljurNYHkeiszCKo=;
        b=aCp9Ovr4UAkTlH2onA5oVOSepHSblqnmAPKtld7xnpFkS26+soSaftLhdtagO8B8Wq
         Ih9/cfSAeh1c/xC07e8Hv/5WmoJfTeqZx3DcNlgXgx0SaD5ipYHBmrYzLpnKEetn5n8J
         2H/vcpXw6hFxvSurv8BHQOmuY/NzsVF9d0a+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685816315; x=1688408315;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNB5bfypuiPn+JbDlGqToRzEkP5cljurNYHkeiszCKo=;
        b=UwhOz5BloZv0EgFANYZX4JYXZ6CCzjTSqnRFXMtdPo+2Pb0zDiis9dm2U0G7IN7K5y
         EYB3pzU9I/4fUMdBbTev/oEK2rmfSOieaw/Cf0VSJRblHyA/XImzg3A3yixAb7UUdJQZ
         NuEjx+R+RFnMjAf6wYA1gixn8s4vkJdCqA+XhHmaLvRmWmshW8999mkGrNCw5ArgBHRB
         W48mdl3glkqaiwX0uxRHpFd6mO22t6KH+Nj8ybQUnBs/azWjVLgk/kQLEPYDnRqSZU1a
         pdPprL1X6YfJ9I6d4k26oWctIOPNZttLCzhKMH7cxqsSmHRlSaJdKqBxKD9DSOxXiVgo
         F0XA==
X-Gm-Message-State: AC+VfDzbFlCS0EDmSZOmKFsU+lqYicSCNatUieAjFhabKno8cxYBOfiJ
        OMFrFRQvA8KbJKWq5AOExYe/2uDIKe8OZCKW8Ycr
X-Google-Smtp-Source: ACHHUZ54bBbPt03nVfXeNCW0gsQGTp8L7qb6T5kpZCkdNx+/e8f+fyY0tYCU8jA3KbeNRPPGlE/FNQ==
X-Received: by 2002:a05:6402:50ce:b0:510:e8dc:f2a7 with SMTP id h14-20020a05640250ce00b00510e8dcf2a7mr6040505edb.7.1685816314672;
        Sat, 03 Jun 2023 11:18:34 -0700 (PDT)
Received: from smtpclient.apple (2a02-a210-21c2-5f80-8ccd-9cd6-fe1e-5deb.cable.dynamic.v6.ziggo.nl. [2a02:a210:21c2:5f80:8ccd:9cd6:fe1e:5deb])
        by smtp.gmail.com with ESMTPSA id d13-20020a05640208cd00b0051643d71ce9sm1484167edz.26.2023.06.03.11.18.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jun 2023 11:18:34 -0700 (PDT)
From:   Fedor Bocharov <fedor.bocharov@jetbrains.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
Message-Id: <2B864C9E-9693-49F2-AE50-CB56DE872AB9@jetbrains.com>
Date:   Sat, 3 Jun 2023 20:18:23 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. create commit in master (default branch)
2. amend it
3. send commit to the upstream via pull request
4. after commit is merged into the upstream, execute `git pull =
--rebase=3Dmerges --ff --autostash`
5. run git status

What did you expect to happen? (Expected behavior)
Git will print repository status

What happened instead? (Actual behavior)
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index =
(547842 > 54)
error: git died of signal 6

What's different between what you expected and what actually happened?
I don't expect git to come into broken state after executing ordinary =
commands.

Anything else you want to add:
I have this options set in the config:
core.fsmonitor=3Dtrue
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.ignorecase=3Dtrue
core.precomposeunicode=3Dtrue
core.fsmonitor=3Dtrue
core.fscache=3Dfalse
core.preloadindex=3Dtrue
core.multipackindex=3Dtrue
core.splitindex=3Dtrue
core.untrackedcache=3Dtrue
submodule.active=3D.
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master
status.showuntrackedfiles=3Dall

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Mon Apr 24 20:52:24 =
PDT 2023; root:xnu-8796.121.2~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

