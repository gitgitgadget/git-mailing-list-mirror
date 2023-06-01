Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB4C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 21:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjFAV0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFAV0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 17:26:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114DE61
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 14:26:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b064451d3so120484585a.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adamj.eu; s=google; t=1685654785; x=1688246785;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cOqzu42uMWQMNgVLrvWCsCUKJ7je2G1GBW4EQIzcIpg=;
        b=k1qGjRQlPnL9WDNjt4Egt1xv1jgAxChqHAA5SOSlp8e/ko9oWZSv7ZX0gNXHnc8GE4
         IZ8ZZWT+8K1JGV1t6vgDrKDf3wNAHF1az4yGHDtIt3hDiKRhkJ7Om3IijesBlOlKM/2M
         vHZyxgtYis2GjJBtZfW+bTbLzC7+0TPlGCmdJOTo/eoGk7iZgnMaH7TNGvNQybHL9vHn
         wvUgOu1mo4pb8dVyUlZykdjdbxzB+vuCssv6fDUpoqSY7jstlig4bzFvk3JV2xao/LuU
         qct/C0pitV3cY2njg1OhfBgFuH8PMfdIDeocVN4PvP6JBVOeKgeN7Mrvw8OFXAoRfIb4
         BLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685654785; x=1688246785;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOqzu42uMWQMNgVLrvWCsCUKJ7je2G1GBW4EQIzcIpg=;
        b=Jx1bWxy+I4MGYYpsSLkrfldWWMWwKToHy3AZpo98M8Tn+IgX+mRtIueN9OMO3+mNuS
         jxDara0Tnqnypvtq2PJi/+5maLntMUXe2YJejF0y2/mtyP+8QpT1HVBgZaZAcqtaFLfb
         dIkcMy0h3LWNpDAUwH4hX3w57xPquGluTtlLqXfDsGTjfv4sRLd9YBXKkzwtUWOqILVI
         2hoh+rqerBC/UWPzojNnn9I5RXu55CnZD+xSLgPpT0q43TLelAvwu98l7V0IoRRIErlX
         vOUIwzsXEK9vGOf86HfJyHvh+IMgJpMrt2K0keXDVVwSRWKppSI3vdYf2sj7TUxxeWqY
         Pw1w==
X-Gm-Message-State: AC+VfDzYACZ/xCZ0QaVhbhnVkmJJSnLxaw6XVHrIwtZ3kcqmtg1uC4KR
        EX7gbTEtBt/ATuj/8uoyUwlLdvAPe5eUjkhbWIC9cF2S/ZIS7Q==
X-Google-Smtp-Source: ACHHUZ5MmD3aVqbYTC7FMIZYFxdKIgoNNOKl2d63H5wHBHd1lX7haVDWAwSacRf6Kd2QHihFqxjLz5PvG8Jf6jPQeIM=
X-Received: by 2002:a05:6214:f0c:b0:625:aa48:fb72 with SMTP id
 gw12-20020a0562140f0c00b00625aa48fb72mr12429118qvb.60.1685654784640; Thu, 01
 Jun 2023 14:26:24 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Johnson <me@adamj.eu>
Date:   Thu, 1 Jun 2023 22:26:13 +0100
Message-ID: <CAMyDDM3DFyru6zph4qqf_QoaOeezvYkT7SmwinCfJNnFsnuRjQ@mail.gmail.com>
Subject: Bug: 'git stash --staged' crashes with binary files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stage a binary file and run 'git stash --staged'. The stash is created but
the command fails to remove changes from the index:

$ echo -n "\0" >file

$ git add file

$ git stash --staged
Saved working directory and index state WIP on main: e7911b6 Whatever
error: cannot apply binary patch to 'file' without full index line
error: file: patch does not apply
Cannot remove worktree changes

$ git status
...
Changes to be committed:
        new file:   file

The "remove from the index" step seems not to be binary-compatible.

The below patch adds a reproducing test.

diff --git t/t3903-stash.sh t/t3903-stash.sh
index 376cc8f4ab..5e3ea64f38 100755
--- t/t3903-stash.sh
+++ t/t3903-stash.sh
@@ -392,6 +392,13 @@ setup_stash()
     git stash pop &&
     test bar,bar4 = $(cat file),$(cat file2)
 '
+test_expect_success 'stash --staged with binary file' '
+    echo -n "\0" >file &&
+    git add file &&
+    git stash --staged &&
+    git stash pop &&
+    test "\0" = $(cat file)
+'

 test_expect_success 'dont assume push with non-option args' '
     test_must_fail git stash -q drop 2>err &&
