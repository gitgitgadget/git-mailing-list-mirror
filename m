Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C93C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhLGUFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhLGUFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:05:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A24C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:02:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 137so236311wma.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dOzbPlnOf0sJZcy83R7gmTCywg+xWgmJOi5KLYDOc0E=;
        b=hbKabwalyjSmG2ZUpLkwdAq/q3oQUmN2aTrzYKYrsEPQBqnSQSQnYDLIQX+0yrE5c0
         Wpr8bkQDLHUO5xcvZgmQmkJcoSlL0duFy1FwNmebOKvQrNhp7hDdU0DeMghaD0SFts7V
         eSMdy4VNaNgSg1oSdL9SWVjPQ1zAv8NZ8sM3KUmQia7+/2VjcsEc38s38Tx1WiAkQB+c
         ZUdj9Ae/jiNY7TDbosw6KuXoBNZzbT5DNPUO9kNdrR53zhg5JIRuL/tdzJCKPLYsqBH8
         IGLc8szVY/EyBcYcc0M1P52S2BCFhDhMtqyYQVXQhcqwscdSIMd8NKGy/Mem6b6FSTlQ
         XgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dOzbPlnOf0sJZcy83R7gmTCywg+xWgmJOi5KLYDOc0E=;
        b=1303XaQ8X5qL79qLKdKCcgXgsaW6i70zgjNFSXFByjVtBDZifjSz4+7+vhDzF0x4Sv
         Hhlav2ol8cgmW5NuExkcSp/chv1qs4IPYiLJDrO8wcqP3J7qjd1U50oFOa+U+/y19+af
         +84d3RuKmKNPOXb2cNgAvTt8LI6SF023m71Fpdxng6wZQTEba5y3S3q6SwjXekbxIXDc
         W9yWvR8I2NUSBY/Y+vBZTGuhSIC9lJj28paH10TPWc3j93bHXYGceVtPp1lrAzWyhPWj
         rJEqNa3HFLWv2ow4OOMzQ6SCqeUGft8j9LSgj436pZnhcecrF0t//sZtTHMQIw+l2T8t
         3akw==
X-Gm-Message-State: AOAM5317pa1fTT5CuAbhIctgNVL6yrIrEP7JLLxANnvj5RZhYp46DJoN
        0Grh25ALJM2fiSWYhpYXHAehd1pZaek=
X-Google-Smtp-Source: ABdhPJxegdi8rNtlbWTROKGF6JV0TGZShVghU5XIdmy3h/oJvaLTywf8pWHFEPfqivCfNeg0/bqx3g==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr9672247wmp.4.1638907337797;
        Tue, 07 Dec 2021 12:02:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm775544wra.9.2021.12.07.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:02:17 -0800 (PST)
Message-Id: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:02:13 +0000
Subject: [PATCH 0/3] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues with parsing sparse-checkout patterns when
core.sparseCheckoutCone is enabled but the sparse-checkout file itself
contains patterns that don't match the cone mode format.

The first patch fixes a segfault first reported in [1]. The other two
patches are from an earlier submission [2] that never got picked up and I
lost track of. There was another patch involving 'git sparse-checkout init
--cone' that isn't necessary, especially with Elijah doing some work in that
space right now.

[1] https://github.com/git-for-windows/git/issues/3498 [2]
https://lore.kernel.org/git/pull.1043.git.1632160658.gitgitgadget@gmail.com

Thanks, -Stolee

Derrick Stolee (3):
  sparse-checkout: fix segfault on malformed patterns
  sparse-checkout: fix OOM error with mixed patterns
  sparse-checkout: refuse to add to bad patterns

 builtin/sparse-checkout.c          |  5 ++++-
 dir.c                              |  5 +----
 t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 6 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1069
-- 
gitgitgadget
