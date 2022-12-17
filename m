Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127CC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 16:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLQQE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 11:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLQQEH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 11:04:07 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998DF02D
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 08:01:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m29so7618478lfo.11
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbUCDigQrDEAWXrlIcVg/o4BfpXVvvWMcAFow8QvRAE=;
        b=DcmY3znBfTV8u60BpLIrus4o2lNA4reZhRZqhmopPczT+MZCx5S79g/W6hOj+wygTK
         Ka44ZpMeAFzdT9jYrSALegUkRFYXAC/Pkdfb7iRT1lJtz5K8Y9gKaTHLlYaf0tChpUAl
         aYtS+2/0QoaSOWZBVe4epQE0oAs4zTRrtl32Q65uUyAFImdJKHihogJUmSMFjS9Z6baD
         E5gFXpWlp0KR2IX7Qo5UboGO6UZeXYW27ZBUa8SASRxfjOT1VD7v9c6DD3IrCB6w5CEj
         Fs60jDedv4yForfkIBqVYZT0VYPNg/kDAfM6Y5cA/ir2C02H8vNzn4VHKbqe+T2uOADd
         vnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbUCDigQrDEAWXrlIcVg/o4BfpXVvvWMcAFow8QvRAE=;
        b=hTJiX2PSdxk2HS/FZNJ8iRBIPC/UDdg1kbkHbDCGEM2+7cuAcqyC1EH6Z1wnI717+Y
         NlsJMjCMs1MSUWtBNVkTQW24H3Fkt2U6aA+3wmVwkYgCcgmRbLraW4eEEqqSjxc3+3tk
         vBaaIBwOHUEb9oRw7UsrwcVC9zYt38crE7XcV71tb1H1d5fp6jzB2HqKVi30saS9yohw
         0ixkrQwCO0zAiae3DmlhiLNjhk7vhZZHYrn5ufE4v6qcjJlxcxLK2HPeN+IotveVFDZ6
         qPh+8Az6+c/94ETThWWKZJrrAuOFHQ3B0ro/AdGxXHAPujtZFIBvWzkEMVmaEzrHsaUD
         eIfA==
X-Gm-Message-State: ANoB5pkZDenXmfG81GQDRxI+FXxr8/ICDPMgFv8lJQlBErnIm0rNqiXG
        2wmpgIZUcYDJHz1bQ5zufL9vzrp2yPTPkAEqMVMSMsZH4xs=
X-Google-Smtp-Source: AA0mqf6X5wOJbztcfInM+sJNwTc+LBnO0B84xF1CdwB34dnxk9anzR37o7qKv8URxvL6XLS3mLjQ9mN+IlcfgPDjuc4=
X-Received: by 2002:a05:6512:3f9a:b0:4b4:bcaf:5713 with SMTP id
 x26-20020a0565123f9a00b004b4bcaf5713mr26263389lfa.103.1671292886132; Sat, 17
 Dec 2022 08:01:26 -0800 (PST)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Sat, 17 Dec 2022 19:00:49 +0300
Message-ID: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
Subject: https://github.com/rust-lang/rust is not bisectable
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. It seems that either "git bisect" has a bug, either repo at
https://github.com/rust-lang/rust is broken.

(Keep in mind that Rust project has somehow custom git setup:
https://doc.rust-lang.org/nightly/clippy/development/infrastructure/sync.html#patching-git-subtree-to-work-with-big-repos
)

So, here are steps to reproduce. I use fresh debian sid with git 2.39.0.

root@f6ca188fd101:/# git clone https://github.com/rust-lang/rust
Cloning into 'rust'...
remote: Enumerating objects: 2107155, done.
remote: Counting objects: 100% (145/145), done.
remote: Compressing objects: 100% (79/79), done.
remote: Total 2107155 (delta 73), reused 102 (delta 64), pack-reused 2107010
Receiving objects: 100% (2107155/2107155), 1009.95 MiB | 2.74 MiB/s, done.
Resolving deltas: 100% (1647434/1647434), done.
Updating files: 100% (38754/38754), done.
root@f6ca188fd101:/# cd rust

Now let's notice that commit 7175c499ecc32cb3ff713be0bbac9fd12990a34e
has word "bootstrap" in file "compiler/rustc_target/src/abi/mod.rs",
but commit 49c2279ef658d8732597c4da93897d84838f3df5 (master as of
2022-12-17) - does not.

Also, let's notice that 7175c499ecc32cb3ff713be0bbac9fd12990a34e is an
ancestor of 49c2279ef658d8732597c4da93897d84838f3df5. (Everywhere I
say that X is an ancestor of Y, I mean that X can be found in "git log
Y", in other words "git log Y | grep -q '^commit X' " returns true.)

Now let's find the first commit, which doesn't contain "bootstrap" in
that file in this interval. Let's do it using "git bisect".

root@f6ca188fd101:/rust# git bisect start
status: waiting for both good and bad commits
root@f6ca188fd101:/rust# git bisect good
7175c499ecc32cb3ff713be0bbac9fd12990a34e
status: waiting for bad commit, 1 good commit known
root@f6ca188fd101:/rust# git bisect bad 49c2279ef658d8732597c4da93897d84838f3df5
Bisecting: 23901 revisions left to test after this (roughly 15 steps)
[26562973b3482a635416b2b663a13016d4d90e20] Auto merge of #13653 -
VannTen:fix/doc-typo-vim-lsp, r=Veykril

Okay, so "git bisect" gave us commit
26562973b3482a635416b2b663a13016d4d90e20. And here I see a bug:
7175c499ecc32cb3ff713be0bbac9fd12990a34e is NOT ancestor of
26562973b3482a635416b2b663a13016d4d90e20! But I think "git bisect"
should give us some commit between "good" and "bad", so presumably
"good" should be an ancestor of the commit returned by "git bisect".

-- 
Askar Safin
