Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEAC433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhKUAuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKUAuH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30878C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n29so25265812wra.11
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ny5Jpiyum7hw5GBwwYA5/OlRCX5EyEBJtz9iVEkNML8=;
        b=ABWAorhhf7oWOUHkxgKb2s9ES+N8GCBYlYZ54XI/+1p/mQ2j0Qv4AjBoIiLFLPiDJr
         84d/63xVhBJgLZOe4H8mZtk6qDpojv+iYBg9BbEIulUIlKvI/ysieCw/k8K1EuZocGM9
         HSf2Pgz/zpcOihsvwTDnd+bKpMnzfLwyo1LyDjJge/RDBmRigAY2NRGnw9Hv1QnD+/ne
         ih9LHV27YUFhs7AD3f8sL+okoy1n7OrWGlHatWBNbgJXE4LsCsPWnGaqVpkhcyyyPMP1
         XEn9D+XEjXAMurdXl3Wd/HssRn0Y4sZScgM8o6aq32tRcbB57fAuMo/vl9oO26NWKnvL
         S/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ny5Jpiyum7hw5GBwwYA5/OlRCX5EyEBJtz9iVEkNML8=;
        b=hHbVi75eKW8Fp8Cs9nnGxemmuy1Zu9gYOPZ7tiq9Ty/i58REDCxmANnRCWrJx6IJNw
         le0HfqPDo0l9pTOEbDZr1woZWaE+BTP5KUNIzvU4JwBPMQQJyNoSHUEiHkzmCW9RYvqk
         eesTj7mocJ9rZZZggPXQTMXrFehzRBxvoJcrygG8wnedon+OzT4lyFyEfF0CZ+PrD/0j
         tPWKXkU1h+8MhjD8v769KtCn6t1s8u256h+oOe71CyPWsapaod3+mUO9aRMKtbaV6MvH
         bb52FfeVZEINn/X0uygyBOaiG/THvD3ty2Xx9W7/e/Hxk9k8y8h3SHl/3y7ShCw6CjTE
         W5Yw==
X-Gm-Message-State: AOAM531sd3TxWHdH0sNl+CBa54k/8496kuDAkeR7vRwZlxhuAVzUWSgE
        0Q/DH7XJxnwpOFHT2ygY6E8cWf4iiu8=
X-Google-Smtp-Source: ABdhPJz9P9dUWNHdixdulNp25E5UVYozTMmF9yze+1Gin020L5w6OJviEnCO6cjR8pQnjiJWBFl3mQ==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr23418841wrc.130.1637455621503;
        Sat, 20 Nov 2021 16:47:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm16057505wmh.13.2021.11.20.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:01 -0800 (PST)
Message-Id: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:52 +0000
Subject: [PATCH 0/8] Avoid removing the current working directory, even if it becomes empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally, if folks run git commands such as checkout or rebase from a
subdirectory, that git command could remove their current working directory
and result in subsequent git and non-git commands either getting confused or
printing messages that confuse the user (e.g. "fatal: Unable to read current
working directory: No such file or directory"). We already refuse to remove
directories that have untracked files within them[1], preferring to show an
error; with this series, we tweak that rule a bit to also refuse to remove
the current working directory even if it has no untracked files within it.

Peff endorsed the idea behind this series at [2] and even pointed out a
corner case that he suggested (and I agree) would probably be more
problematic to attempt to address than to leave be.

This series has a minor textual conflict with so/stash-staged (in next),
because both series add a new parameter to the do_push_stash() function. The
correct resolution is simple -- just to take both new parameters. However,
let me know if you'd rather I rebased onto so/stash-staged.

(Sorry for the delay; I know I promised this months ago in response to [3],
but it was blocked by some preliminary series and then by my absence during
a migration at $DAYJOB).

[1] well, with a few exceptions; see
https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[3]
https://lore.kernel.org/git/c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com/

Elijah Newren (8):
  t2501: add various tests for removing the current working directory
  repository, setup: introduce the_cwd
  unpack-trees: refuse to remove the current working directory
  unpack-trees: add special cwd handling
  symlinks: do not include current working directory in dir removal
  clean: do not attempt to remove current working directory
  stash: do not attempt to remove current working directory
  dir: avoid removing the current working directory

 builtin/clean.c      |  29 +++--
 builtin/stash.c      |  13 ++-
 dir.c                |  11 +-
 repository.c         |   1 +
 repository.h         |   1 +
 setup.c              |   2 +
 symlinks.c           |  12 +-
 t/t2501-cwd-empty.sh | 255 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c       |  28 ++++-
 unpack-trees.h       |   1 +
 10 files changed, 329 insertions(+), 24 deletions(-)
 create mode 100755 t/t2501-cwd-empty.sh


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v1
Pull-Request: https://github.com/git/git/pull/1140
-- 
gitgitgadget
