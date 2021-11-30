Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AADC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbhK3Vlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbhK3Vlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D7C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p18so18655651wmq.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbITkZ4vmTfzm0R2pCpqhKRnAComYIB2UINvvbPkm4w=;
        b=Hj7ApwOnL0zwWmQrDpeRzYEHvSsy3XbuDOJxZmyoGqcjGVetfqu8YgMHp6bPyuVlGh
         l3fNx6N47SE9GcOLahxRQvqFCPoBq2eqJ+ruchFFhIvDLj0p+Vf8niaYD7a9iE0VDOLw
         XEg3Fl1Fpd9R5Rgm7GLTCg/aIqr1motqtmgERi5E27QALhrA7tKz85srjWBjrrXOPXwL
         MzS2+xsK5u9kafZUwiCMJo+3rlvx0kll3ovqrgNFArC86eCgYvBphySe6c7jxn4X8qB5
         VhI2oeoj8O0D4LpzAGqc4Kist/HNq4+uXMPHV8o5Hgc2R5poF5IUA2Kj2l8pmexn6iT3
         5c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbITkZ4vmTfzm0R2pCpqhKRnAComYIB2UINvvbPkm4w=;
        b=6HhyVdicKzZak66Ayd5GMafvRsOeF/UV/9FpslbGEVoitHVSusOugxeT+WEVZ5SP9c
         Y7i2V5hzYA8Tz9RilGqd6A/YJnt9Xa0momzhERUk+7ujyjr5Bz4oi7OVmWojVUfBdUN5
         7EEGqLaevHnVtUUNiBBxpjSAYE/E5PbAXt3fz+7zbXBz7howgRtH+bRroP1o1LRrEBda
         6RXjvoHcA9yFgeShnagDwGYZGSRyxHgpZpaT7h2NRbxUEUEnbOtCUBINbRqqjR57eJl1
         /qewFqF+qGP3toKS8CHIW16Qx4Bkx92w3eipMOIx1Sv4135TxxGHI9j58crv+QZz9ott
         sxag==
X-Gm-Message-State: AOAM532O10DWxtlGFkyKEghTS6u+kEekmgk24yDkCf/bu+Lm1dDKs+LD
        0jVPFRopw4kS817PwXObawdN/IyREOU=
X-Google-Smtp-Source: ABdhPJyeA4+XJM+WW1is3nqjkdTd43zegZMB75RxWjmgVbr54wk7nMjq8lb9FJu2oS+ihT7cwxHxug==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr1537453wmi.171.1638308297740;
        Tue, 30 Nov 2021 13:38:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/12] reflog + gc: refactor, progress output, reftable-readyness
Date:   Tue, 30 Nov 2021 22:38:02 +0100
Message-Id: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up topic I had for my "errno" refs API changes that
just landed[1]. I initially thought I'd split this into multiple
submissions, but I think it's probably better to consider it in
unison.

Comments on individual patches below:

1. https://lore.kernel.org/git/cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (12):
  reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
  reflog expire: narrow scope of "cb" in cmd_reflog_expire()
  reflog: change one->many worktree->refnames to use a string_list
  reflog expire: don't do negative comparison on enum values
  reflog expire: refactor & use "tip_commit" only for UE_NORMAL
  reflog expire: don't use lookup_commit_reference_gently()
  reflog: reduce scope of "struct rev_info"
  refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN

This is all refactorings to make the reflog-related code smaller,
easier to read, using string-list instead of a custom home-grown flex
array API etc, and to make it clear what variables and data is used
where. This really helps for subsequent steps.

  reflog + refs-backend: move "verbose" out of the backend

As noted in
https://lore.kernel.org/git/211123.864k83w3y4.gmgdl@evledraar.gmail.com/
this makes the "verbose" API independent, so the reftable backend
we'll have soon won't need to do anything special to support it.

It used to conflict with Han-Wen's topic, but in his v2 he picked
another approach.

  reflog expire: add progress output on --stale-fix
  gc + reflog: emit progress output from "reflog expire --all"
  gc + reflog: don't stall before initial "git gc" progress output

These are all progress additions to "reflog expire" including fixing
the long-standing oddity that on large repos "git gc"'s progress seems
to simply hang before reaching "Enumerating objects".

As noted in 12/12 this is partly a bit of a hack, but I've got other
in-flight progress.c API changes that'll eventually lead to supporting
"nested" progress bars, which this code will be one of the first
consumers of.

 Documentation/git-reflog.txt |   8 ++
 builtin/gc.c                 |   4 +-
 builtin/reflog.c             | 260 ++++++++++++++++++++++-------------
 refs.h                       |   3 +-
 refs/files-backend.c         |  44 +++---
 5 files changed, 194 insertions(+), 125 deletions(-)

-- 
2.34.1.877.g7d5b0a3b8a6

