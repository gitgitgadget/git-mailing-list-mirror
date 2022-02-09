Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115DC433FE
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiBIL6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiBIL5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D1E00F7CC
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 02:59:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i14so3280173wrc.10
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OaVgRIh/dQaaTvCrGu1NlXNAFtGF3wz6lmrjTspresQ=;
        b=qHbj6sVo1XQ6VAil1H8PJU598HgSrkbPKUpfIkLdupYAe0xW8h5xIIYsVUx+7i2wCT
         YsqOx90rO0Rs5DtLDgVdsnwMwPSPqgZ0yurPCKdGK3I/+/iE6qxtE/QeoFUgRyCgyotY
         BJeYkdzJwTa568Fc1uPwbP/mWUFtfX9bitLA87qQtpwZAoq4VzLimaPiT3SVEHajmMFP
         ZLO2iesouctOMq8X3UO7d13lppM/22SmjSyIfVkbVsNhzkejfiDh0eqmF4KVW19pOgGS
         HXw8VqIRz0ScoxhxJNO57tFVnHNtcSUQ3grlmVxB7bMa5BwnjRtIkX2guF5QGDxzUrvZ
         +8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OaVgRIh/dQaaTvCrGu1NlXNAFtGF3wz6lmrjTspresQ=;
        b=X5BBap624DUg7b29jFC8NmIfQRVQ49gRGJiSKm/buew5ffMXbAMMrpTDBpd6xv0SoS
         ddJf3SxeG3ozYKo997d4JFHeXNW+0PwVOIwCb4Jv0sT6/o2euz36nm05npeJFFBZy7oC
         yrYHfPbYYGvTVb81PQ2RzZzq7CjC6ckBNXgM/xn2bpkzNxFvneD2/elVF7uGxwFs2FqE
         bslG/gmq1LBTn9gHmMSlZaKFh0giu2ebFmcEp9qb70UzLF3YOJ6yL8LiG9E6CD6jGtTG
         3pI1B0rfsLPp1tRApiNnH8QthFDGz0d2/NJGKdn4YQcGcER0+d4LP6TET556J4NjpYTX
         JMxg==
X-Gm-Message-State: AOAM5316O8PhIpcdkns6KTIZRAmWky/4Fkfa/J5eTtdTVXLTifrJJlBj
        Tl5qoaAm9KSj6AXYauQwUlNvPqy1mpI=
X-Google-Smtp-Source: ABdhPJxvESw4lUAHHJ4ofkaZfkaxfTsblR1INZI2mlm8VcCHrReXxE94yQyTcfsIaqEERdqCIrSqKA==
X-Received: by 2002:a5d:6084:: with SMTP id w4mr1604663wrt.667.1644404356948;
        Wed, 09 Feb 2022 02:59:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20sm4783323wmq.22.2022.02.09.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:59:16 -0800 (PST)
Message-Id: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 10:59:12 +0000
Subject: [PATCH 0/3] xdiff: handle allocation failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other users of xdiff such as libgit2 need to be able to handle allocation
failures. This series fixes the few cases where we are not doing this
already.

Edward's patch[1] reminded me that I had these waiting to be submitted.

[1] https://lore.kernel.org/git/20220209013354.GB7@abe733c6e288/

Phillip Wood (3):
  xdiff: handle allocation failure in patience diff
  xdiff: refactor a function
  xdiff: handle allocation failure when merging

 xdiff/xmerge.c    | 44 ++++++++++++++++++++++++--------------------
 xdiff/xpatience.c | 17 ++++++++++++-----
 2 files changed, 36 insertions(+), 25 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1140%2Fphillipwood%2Fwip%2Fxdiff-handle-allocation-failures-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1140/phillipwood/wip/xdiff-handle-allocation-failures-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1140
-- 
gitgitgadget
