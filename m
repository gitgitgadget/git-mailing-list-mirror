Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE7C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiF3SAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiF3SA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F529813
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so28428523wra.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/nK1LftP3Hz3QLm6IbWbEgWJPBrdRMDVaaiM0ohZNU=;
        b=jktpSm8DiBZKEa7wkePyDWkk40QtUF3Ej6FnMu5evyaVYVqVE8DOmmCBN12nurjaph
         EzTxV0UfBsMfWTHFr+J7sCdt0mV4KLde75znbi1QFC1RKSl6+BRxwWAl3Pdh8xGH0acH
         ZBHZ3EysVjAM0drcqqA60dmhqgrO4/CuHomkpXVahh3PUwr6m996UH+SucIhAKRYTLTf
         hjzSa6SMrpPw5XJYhMob2xXQhk+49QxENIjOp1o+KaWt36GOMTZP5Iz5Y8Kds/6J9fbd
         8zjsGRsQup1eVRRVfmHb0ZLQSRx9YDIyJ5xsDVJvOHI4ErTExz+6oXLUTxOc+hf6a3lm
         KeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/nK1LftP3Hz3QLm6IbWbEgWJPBrdRMDVaaiM0ohZNU=;
        b=MsEttQvsuzJKYFCAgEk2qOWpTBN4BouwpVJp1fRiSdxf+NhUSW095G3G3nPXvMOqKB
         jIbR3JJ9A3k/IA8TT4X+xbY1AB3ORClL0bUhvdB/ZZdlK9l8n7y41hD8yN+qZRYD6tWI
         VT0no1Xq5U2yiLXov7IsrhECLNvA/bg7q9CzT2fbBWsBhoZZZFgCs8Idk0rV73uvTch8
         BO6WU0dYCHDnlNoC6OYps1il71T7U7Uk58w7J6OBaQWc8PZyB6DY3kV9UdUr9S1DKAg0
         Ah46hMO8Wen286djHcbhMlndn3WSrEEcpY5+/nlP8umBeeBX9KCeqSW3QO3bYN3V2+d9
         /Bqw==
X-Gm-Message-State: AJIora/APgYPsdd7AsXeLH71XlXrfp0hkXjqLBlw4N9e8eWlvm0ysbWd
        QOsEldsW6ZgM+JpI67ub2cU0RWI9Htn/IA==
X-Google-Smtp-Source: AGRyM1vwGDyN/oqXhLw7pOnv2mJvC+PHaQDlMtjHrusPXsN62bq2cLbEW12HuBWYzG4YiZdyv2LrrQ==
X-Received: by 2002:adf:f6d0:0:b0:21b:c3f8:6230 with SMTP id y16-20020adff6d0000000b0021bc3f86230mr10015324wrp.116.1656612024608;
        Thu, 30 Jun 2022 11:00:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/11] built-ins: fix common memory leaks
Date:   Thu, 30 Jun 2022 20:00:10 +0200
Message-Id: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of trivial leak-fixes which allows us to mark a
significant number of new tests as entirely passing under
SANITIZE=leak.

Now that 2da81d1efb0 (Merge branch 'ab/plug-leak-in-revisions',
2022-06-07) has landed we're going to have more & more cases where
fixing just one leak will allow us to mark N tests as passing in their
entirety. This is the first stepping stone on the way to that end.

Ævar Arnfjörð Bjarmason (11):
  check-ref-format: fix trivial memory leak
  clone: fix memory leak in copy_ref() call
  submodule.c: free() memory from xgetcwd()
  revert: free "struct replay_opts" members
  cat-file: fix a memory leak in --batch-command mode
  merge-file: refactor for subsequent memory leak fix
  merge-file: fix memory leaks on error path
  checkout: add a missing clear_unpack_trees_porcelain()
  gc: fix a memory leak
  cat-file: fix a common "struct object_context" memory leak
  pull: fix a "struct oid_array" memory leak

 builtin/cat-file.c                   | 33 +++++++++++++++++++---------
 builtin/check-ref-format.c           | 11 +++++++---
 builtin/checkout.c                   |  1 +
 builtin/clone.c                      |  1 +
 builtin/gc.c                         |  8 ++++++-
 builtin/merge-file.c                 | 32 +++++++++++++++------------
 builtin/pull.c                       | 16 +++++++++-----
 builtin/revert.c                     |  3 +++
 submodule.c                          |  3 ++-
 t/t0028-working-tree-encoding.sh     |  1 +
 t/t1051-large-conversion.sh          |  2 ++
 t/t1402-check-ref-format.sh          |  1 +
 t/t3304-notes-mixed.sh               |  1 +
 t/t4044-diff-index-unique-abbrev.sh  |  2 ++
 t/t4140-apply-ita.sh                 |  1 +
 t/t5314-pack-cycle-detection.sh      |  4 ++--
 t/t5524-pull-msg.sh                  |  1 +
 t/t6403-merge-file.sh                |  2 ++
 t/t6417-merge-ours-theirs.sh         |  1 +
 t/t6422-merge-rename-corner-cases.sh |  1 +
 t/t8007-cat-file-textconv.sh         |  2 ++
 t/t8010-cat-file-filters.sh          |  2 ++
 t/t9101-git-svn-props.sh             |  1 -
 t/t9104-git-svn-follow-parent.sh     |  1 -
 t/t9132-git-svn-broken-symlink.sh    |  1 -
 t/t9301-fast-import-notes.sh         |  1 +
 26 files changed, 93 insertions(+), 40 deletions(-)

-- 
2.37.0.874.g7d3439f13c4

