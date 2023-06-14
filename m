Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB3EB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjFNQcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFNQcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:32:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45041FDC
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:32:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce829aca1bso989693276.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686760335; x=1689352335;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/aDdcKrNWbYzXut+nO2js9/T6HIl5759yflJeMc4HY=;
        b=f6VXfl7V49pi7szBNwhj8erceEcqzuK2alG17V0BfcCadGwZYiprUroGd6R7sSvRH8
         3gvWFIsIk+vBTi0Ed25z80eSPmXdxUPLRXAi+DyKCm8X7C9cKP6Hgg4tRCoM67Lqbe74
         LahemSQYmWF6xmE/LDWJORSXsd4U0jTI/+4dKEL0/mX2C6xv6Z3DdVKBuWl+ZOLehAV1
         wop0MM+Sj5pum3dFfUr3PTZR+3MXS5WMqnCn4Z+njqmN2PxPuo/WvceKdCLCq70MJvxI
         LOT/5yCJWrD7FrtdCEEtnahtNJzoHINJt8a7eA8ZyRVCDD4mYbLMeYQ4CykH0iBHYTI/
         viRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686760335; x=1689352335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/aDdcKrNWbYzXut+nO2js9/T6HIl5759yflJeMc4HY=;
        b=Ms1VdDCRHPcUoSZS7y6DO0KKBpS4s3HgjXZhhdpSACb8+TRCkJsjguOF+Kks+zfEaw
         WchxYBkSWq0iGBlSfspXAa4Ymfglv8JLRufXdnzXiy2YJwxFzMFnyK5GYWLUlV5ryv7Q
         UUKjuarA2QwUQGB4MazeetPDJJzZ1x2dII6GviFpe8vpeEnWPTP3dj9tvGLg305D5YZM
         Dyfmm6RJJlHgIL7TDx9Wp7xY6pEvBcEFzEOXXqUz89Ccro3X0CVPboTnCGdLvrFz2xEP
         Ba2D7JHH4CSoHQtEGDlcvmVaeOSTHWQJMkCfDJJjoZBp8sFC1LUEE+jOKeoe47/p/UyT
         sH8g==
X-Gm-Message-State: AC+VfDxuEZLBd1YPM2GtxmfduRvhRryPN0Cslnz2O+fznbuxVHBc//Sv
        tIyltLj4uA446ZBKCkqkOb6wPvni7fVsdhV6Ndr0XUWCsILtEplqs0wnifE759Z9tz1VXdDiwnD
        v8PkzzjQwKv3hM2ph91FhQrQkScQ8C7T0LsUnMqyyb3i3oSuyZtkUrtQSfCm2K58=
X-Google-Smtp-Source: ACHHUZ5NtGgGWbgU6W+QR/9JjaihhAECDLIg7OKLSf1W1PncL7inK4PWuuv3UQ2PxtIO5aVCQGqIh/AvY7L8MA==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:d1e8:6e0c:96d0:4f23])
 (user=sokcevic job=sendgmr) by 2002:a25:20a:0:b0:bc6:3354:e65e with SMTP id
 10-20020a25020a000000b00bc63354e65emr385174ybc.7.1686760335079; Wed, 14 Jun
 2023 09:32:15 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:31:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614163127.3182986-2-sokcevic@google.com>
Subject: [PATCH v3] diff-lib: honor override_submodule_config flag bit
From:   Josip Sokcevic <sokcevic@google.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `diff.ignoreSubmodules = all` is set and submodule commits are
manually staged (e.g. via `git-update-index`), `git-commit` should
record the commit  with updated submodules.

`index_differs_from` is called from `prepare_to_commit` with flags set to
`override_submodule_config = 1`. `index_differs_from` then merges the
default diff flags and passed flags.

When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
both `override_submodule_config` and `ignore_submodules` set to 1. This
results in `git-commit` ignoring staged commits.

This patch restores original `flags.ignore_submodule` if
`flags.override_submodule_config` is set.

Signed-off-by: Josip Sokcevic <sokcevic@google.com>
---
 diff-lib.c                  |  9 ++++++++-
 t/t7406-submodule-update.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 60e979dc1b..1918517ebd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -669,8 +669,15 @@ int index_differs_from(struct repository *r,
 	setup_revisions(0, NULL, &rev, &opt);
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.exit_with_status = 1;
-	if (flags)
+	if (flags) {
 		diff_flags_or(&rev.diffopt.flags, flags);
+		/*
+		 * Now that flags are merged, honor override_submodule_config
+		 * and ignore_submodules from passed flags.
+		 */
+		if (flags->override_submodule_config)
+			rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;
+	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	has_changes = rev.diffopt.flags.has_changes;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f3..3c85ac2fbf 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,27 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+add_submodule_commit_and_validate () {
+	HASH=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000,$HASH,sub &&
+	git commit -m "create submodule" &&
+	echo "160000 commit $HASH	sub" > expect &&
+	git ls-tree HEAD -- sub >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'commit with staged submodule change' '
+	add_submodule_commit_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
+	test_config diff.ignoreSubmodules dirty &&
+	add_submodule_commit_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
+	test_config diff.ignoreSubmodules all &&
+	add_submodule_commit_and_validate
+'
+
 test_done
-- 
2.41.0.162.gfafddb0af9-goog

