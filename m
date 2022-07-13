Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BCC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiGMNKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiGMNKn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18059E35
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so15444892wra.5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hrS53QNCCMaJZ5AJtcawz6MjnEE6LW9/fBG34HK0LE=;
        b=OVk4mqIPUoVuVSI4D695pylnZPpdc/X2R4vRT6MJSayZSy+x/8GFY3LZV5fxAUwOwq
         iMBRFXnSUXOtsHVCO/Sjo9yaOCWxlk33smiWH6+FOMRFrnJjiRfwFUoE01aJsdA+Xfmh
         OmPjlQ91jNON882j9efb+XBziofp+Ueq1vMkpEVI1QXWl1g3HyGMhcZsiA2UPesKV4RN
         J8AT/wk+2f/F/Nr5roUZVu7mgOrRnqbWEK8hCYW9JqGvwn8yW9m7wbKruTwSqlytFrk+
         R0a612NWlQRiexJqiGU/JsF0ZW0SrXqBDidq3sovXKeOWAoMb5rSYKzG2DsdApkaUj2a
         VMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hrS53QNCCMaJZ5AJtcawz6MjnEE6LW9/fBG34HK0LE=;
        b=pnlSN6m9IsIXHPEnhhQvei6TjjSJ38Zx8zKUpS0MooqsAdy5AbB1nnoOtwXKe2Gr6M
         MhjFdBJr04UJ/zdn7iozn130IGwkj4HyW1IMS1zJZ7KDRpbiW22tTCQv3HdLcRYpzTjA
         v8S0a7KLgBS39ODn9X406EIvsjrPGt1ir3TdwckRrzGn1TV6MmxVRksdQwIjvLUuFLMY
         S7cj4rpq6PY0SjAskBTXgvoYczSm03MMaTFR3z6iN1TsdCOksm6imWvehXfyGC/m/enE
         OQ9QGswm30F9MI8S/01uq+zrP8ck10rAJDF4b3Vo8Ne9ENr2DRfZ0SrEsfOTZK0m1EsH
         gaYA==
X-Gm-Message-State: AJIora8u5OjSqav1K54NCvsIXJ8kdTK+A0Dl2VMahIb0+4ZPXKnZd1dY
        GxBDz+odmGst+DWXQKvsctlgtbvvXYanuw==
X-Google-Smtp-Source: AGRyM1vXz2ikpqnmAnPljSJjMbpwBwhDRU4z7gWieAmEpFiKJwSWEOgh7OosrUOO1rHH8UNrx1CkoA==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr3277656wrv.413.1657717840260;
        Wed, 13 Jul 2022 06:10:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] revisions API: fix more memory leaks
Date:   Wed, 13 Jul 2022 15:10:29 +0200
Message-Id: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series fixes a couple of mistakes in 1-2/6 that snuck in in
the revisions_release() series, those compliment the already queued
jk/diff-files-cleanup-fix.

The rest of this fixes a few tricky remaining memory leaks, allowing
us to mark the tests seen in the diffstat as passing with
SANITIZE=leak.

The "git show" leak in 4/6 in particular showed up in a lot of places
in our test suite, so fixing it really helps us to accelerate towards
marking more entire tests as leak-free.

Passing CI for this series can be found at:
https://github.com/avar/git/tree/avar/follow-up-release-revisions-fixes

Ævar Arnfjörð Bjarmason (6):
  bisect.c: add missing "goto" for release_revisions()
  test-fast-rebase helper: use release_revisions() (again)
  log: make the intent of cmd_show()'s "rev.pending" juggling clearer
  log: fix common "rev.pending" memory leak in "git show"
  bisect.c: partially fix bisect_rev_setup() memory leak
  revisions API: don't leak memory on argv elements that need free()-ing

 bisect.c                                      | 28 +++++++++++--------
 builtin/log.c                                 | 22 ++++++++-------
 builtin/submodule--helper.c                   |  5 +++-
 remote.c                                      |  5 +++-
 revision.c                                    |  2 ++
 revision.h                                    |  3 +-
 t/helper/test-fast-rebase.c                   |  2 --
 t/t0203-gettext-setlocale-sanity.sh           |  1 +
 t/t1020-subdirectory.sh                       |  1 +
 t/t2020-checkout-detach.sh                    |  1 +
 t/t3307-notes-man.sh                          |  1 +
 t/t3920-crlf-messages.sh                      |  2 ++
 t/t4069-remerge-diff.sh                       |  1 +
 t/t7007-show.sh                               |  1 +
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  1 +
 t/t9122-git-svn-author.sh                     |  1 -
 t/t9162-git-svn-dcommit-interactive.sh        |  1 -
 17 files changed, 50 insertions(+), 28 deletions(-)

-- 
2.37.0.932.g7b7031e73bc

