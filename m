Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0675CC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356011AbiALSH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiALSHx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:07:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C45C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d19so5840284wrb.0
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fGKJW+c77AHI8/Yl4BF5u/5w7gZ8Y9O6+B1UIPTgJek=;
        b=TTFZexJlZ4ZztUkL9vHYrXZ7DeLSYxoV5nJyzVA2ps7GZ/AjpbbNHxZ2blVbemfd5B
         GdszypHxHyvOzbs0CnJPrggCAPS3A/IXuXDzmTfEyMMehuvL3UGj1JEKTJjWyA/xamaD
         oAc3jtb7jNyN9TK8gQymcB+zgXk7pmOf4d2iA+Fmc354STfhYeWflFrgBPktKUnMs73I
         uEbGgXeq6+Xs1RZXGTlV0jrj4GgSQjmBECG+iYW+kkGHGHCiMsY+sypHmeAPZxcxgM6E
         O+ywmHGUUlnpOV/6cSBC+fBp/xqrC8P/CIgsK+0ljG+gGkdw9M0TqlOnAgjLxn6Kq6ct
         Drhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fGKJW+c77AHI8/Yl4BF5u/5w7gZ8Y9O6+B1UIPTgJek=;
        b=3axfnExeTlQGPLXPVPlKLH3pLawj3XKnPPYHuh8OpqDTZ03R1FcMyOs1vpCBcbKIP8
         1CjL8DDVQP5v1xZLhfguS/qb1GRqh1HbRIG4GuE/md/vLn0MTix6H6Mt9D7MudaY0jmr
         jFJ6JmB3K5lSI/XunnuhKu6J66+nFusUbAXVskNbWsJFVW2pfeGbZGLbvcmD61GyOWx9
         +CuXteDjTz1tdh52epCsYmBnUQxbLTWoyzhdlocxN3IIltCi5Pt5V+UBL7wqrMdEKyyu
         tjsKJYEg5KF5spLFuu9Ai3Hp6viRlyryWBcjhP+YK6BLo2EDqFRDJyMNPSagmqvu8ihu
         IQlg==
X-Gm-Message-State: AOAM531npy1WagysB7UpkPhPK+qDnrNDfOuId6ygueKrpatBig82aSns
        XckDwFJT2RGdq/uimkVp+BHgEGm8bMw=
X-Google-Smtp-Source: ABdhPJy7MBfBhpm/oVMFdCwzfIHP/1dFGjpzuz+SY0QY+GZuD0SQlB1E1a8AMiLWKLKL38TAO+lzIw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr800501wru.69.1642010871364;
        Wed, 12 Jan 2022 10:07:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm485590wmq.20.2022.01.12.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:07:49 -0800 (PST)
Message-Id: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:41 +0000
Subject: [PATCH 0/7] reftable: avoid reading and writing empty keys
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this series makes sure that the object record does not have to consider
empty keys (and therefore, a NULL memcpy destination)

while we're at it add some more tests, and fix a naming mistake.

Han-Wen Nienhuys (7):
  Documentation: object_id_len goes up to 31
  reftable: reject 0 object_id_len
  reftable: add a test that verifies that writing empty keys fails
  reftable: avoid writing empty keys at the block layer
  reftable: ensure that obj_id_len is >= 2 on writing
  reftable: add test for length of disambiguating prefix
  reftable: rename writer_stats to reftable_writer_stats

 Documentation/technical/reftable.txt |   2 +-
 reftable/block.c                     |  27 ++++---
 reftable/block_test.c                |   5 ++
 reftable/reader.c                    |   5 ++
 reftable/readwrite_test.c            | 103 ++++++++++++++++++++++++++-
 reftable/reftable-writer.h           |   2 +-
 reftable/writer.c                    |   9 +--
 7 files changed, 135 insertions(+), 18 deletions(-)


base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1185%2Fhanwen%2Fobj-id-len-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1185/hanwen/obj-id-len-v1
Pull-Request: https://github.com/git/git/pull/1185
-- 
gitgitgadget
