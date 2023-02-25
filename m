Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68EC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBYOOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOOU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:14:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF8113C4
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:14:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r18so1971291wrx.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677334457;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFCnhyRatgGschL7d/nIE3KIKEGTyWTg113CATpdIaY=;
        b=JPQ2+GDWFFoROqI5yfcnWKHVeTJufPdYTXvypSCFUGGiaOF2rFUyE/4UlHSGYfBYC5
         CdQaPrWzRTkGScDkugkMVmvG1hvZ0gFLIvL33RwLHgZdSq7sOfXWm4Q2DP2BCmHbqItx
         RFCH0kVK0U0/2y6nbtVNjOwFUTic1R1CiEZ8hS0odR5S2LOzDqNMP8hBlfrd+NAnp1z5
         GmRE4JVMUxXz9pw5mVUFNr/QvlEeLNRAF2yVsVObci3+3bUteusIQIn86NcejhPB/hNe
         5ODgWPfjQdQ2AUbRSYL4s/sWRQY8TVc8Y5O8fNYSdVMzo5vlnzv9rR2eJ/IMbolpVhb1
         IVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677334457;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFCnhyRatgGschL7d/nIE3KIKEGTyWTg113CATpdIaY=;
        b=5LLldaSLJnRKye1pZ6JU5oNHng2bzCcuWX7/r4Wsht4Ed0Ki92Db5nBZxgoVp+iSHE
         QBIfI2aHf9e7cwS3r8ONX+uM4v/JfEzvy0YVaAyKcgMs0ihgR9JFoqCIVHU6N15BJO+W
         bmkpvRcn499xGAL1g1L14IwokGn3f9OQO3haRIP7j3yc9a0FpOLdpMsRUdJfUql/lOwX
         AAROVIODr04elIbGfxt6YMi0r9p+R9lXsxf84BYGUtbF2gP6j6GWqRvvav2Pji7ml813
         R/Y5mX7kq2xutxctEm45dVlLv09KO8hWpl2gNEIPW4amlNsv8NdlCAQlmY/U6JdsQpWw
         Z85A==
X-Gm-Message-State: AO0yUKWGef2q/C5oCTBiZsxbhgkKF8XfCpyHyiae904EzPvVH7537bMr
        DsUxQ5iSfY/oBQKdrqE/skk=
X-Google-Smtp-Source: AK7set/m03ec+w1rAu0ehxIM8sbCY1wMapDCWOU0UTKDWI1UysvTSl46KpD/gW+YrXy5q2QtW/zBeQ==
X-Received: by 2002:a05:6000:191:b0:2c8:a44a:bf25 with SMTP id p17-20020a056000019100b002c8a44abf25mr2378069wrx.50.1677334457250;
        Sat, 25 Feb 2023 06:14:17 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5267000000b002c8ed82c56csm1853705wrc.116.2023.02.25.06.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:14:16 -0800 (PST)
Subject: [PATCH v4 0/4] fix die_if_checked_out() when ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Message-ID: <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Date:   Sat, 25 Feb 2023 15:14:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v3, two errors in 4/4 have been fixed:
  - "checkout -" must be done before "branch -d"
  - "branch -D" instead of "branch -d" because "shared" is a non-merged
    branch.

Also, '||:' has been used to chain commands in the test_when_finished()
block.

Rubén Justo (4):
  worktree: introduce is_shared_symref()
  branch: fix die_if_checked_out() when ignore_current_worktree
  rebase: refuse to switch to a branch already checked out elsewhere (test)
  switch: reject if the branch is already checked out elsewhere (test)

 branch.c          | 14 +++++++----
 t/t2060-switch.sh | 29 ++++++++++++++++++++++
 t/t3400-rebase.sh | 14 +++++++++++
 worktree.c        | 63 +++++++++++++++++++++++------------------------
 worktree.h        |  6 +++++
 5 files changed, 89 insertions(+), 37 deletions(-)

Range-diff against v3:
1:  40b5ea54d3 = 1:  22d0944aad worktree: introduce is_shared_symref()
2:  2f1479b354 = 2:  e7ba7b6fdd branch: fix die_if_checked_out() when ignore_current_worktree
3:  81a5b619c3 = 3:  8de8319d0e rebase: refuse to switch to a branch already checked out elsewhere (test)
4:  6559e58344 ! 4:  27d6ae2755 switch: reject if the branch is already checked out elsewhere (test)
    @@ t/t2060-switch.sh: test_expect_success 'tracking info copied with autoSetupMerge
      
     +test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
     +	test_when_finished "
    -+		git worktree remove wt1 &&
    -+		git worktree remove wt2 &&
    -+		git branch -d shared
    -+		git checkout -
    ++		git worktree remove wt1 ||:
    ++		git worktree remove wt2 ||:
    ++		git checkout - ||:
    ++		git branch -D shared ||:
     +	" &&
     +	git checkout -b shared &&
     +	test_commit shared-first &&
-- 
2.39.2
