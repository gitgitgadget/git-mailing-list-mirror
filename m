Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CECC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiF3SAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiF3SAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A72A717
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so28428523wra.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8+WUp+iXKHBR2PdSBe8FTzBTza1e7kWfoCBBPI9EXM=;
        b=A7+vRDBK0CC6wyOBnr/gYYHaQNjOalrTjzPN1CAMCstH/lEwrvpYiyiyEjM/1+ezg/
         nO6lFIOlUISJ6iZ/ZMuVeKcBoIsGgN3tf/qKKdPkOef9/5HWPOP4eFO2Rk28z4FNhJdo
         3/GBK1JU4Y+EwSN3Dtprt6URFPu73cpahiEZjfNMH9Ck3oW5x8v2dspyAV+G1PO03kxy
         roeXBDkqTSHni2iIWYXoSflo4ca6MUexNBGoo3kNPjTcFhCr85I+YZr9+7LZkXo3bxnQ
         yGJHJuNEmlWIyn9M9nW//t6LvF3TNIVcHfaXvJVzGQyioDHzWEi3pYVp5/Oy3LU4Dg4/
         S10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8+WUp+iXKHBR2PdSBe8FTzBTza1e7kWfoCBBPI9EXM=;
        b=VrMsKZt6lF3m9h8cCpM/Y4kJqfVD6gGmWOOgPBbmQlb2WovO2pBDP0+9fz+DwGk9cU
         LQICIHs1ellptr3buZUaBB4AOc745fdCMPpU7nPRbzp7W9TILH0U7f2EJFKGe4ZEOMip
         8/ARtHYnIG8FvMlR+O6pluTAIZA6Z9HVDypD4MbdMubfEvrOfu4TR9Yof9rQaNc1dnoI
         +YNub2at9oKLkel03J9AGd78t9JzKvX5BA1xf3DYnaIWAn4xpt9QKKPK5lP4FpwbtfPP
         HlUIqG8biPadLfoCKBSHbCYAxhbS0cTNAQIQRSAoO72ylIuv/nqjZ6xYW1AGeSON5Nhj
         zpNg==
X-Gm-Message-State: AJIora8FjkvD7N2wInI7tn4fqnGrYe/j9/+FeOAhZhF36G0nAECYr7h6
        5sW5XMhet9BqKekSiPgvviowhff32KtqQA==
X-Google-Smtp-Source: AGRyM1vJti81AN1IM9ziHbje+kvtCvuXiQrpnKwU3IzNi0WqtaDRgqEwRlAHzNcQuTz4eFYaoph1qw==
X-Received: by 2002:a5d:59a8:0:b0:21d:1bdd:44b9 with SMTP id p8-20020a5d59a8000000b0021d1bdd44b9mr10154464wrr.7.1656612031242;
        Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/11] merge-file: fix memory leaks on error path
Date:   Thu, 30 Jun 2022 20:00:17 +0200
Message-Id: <patch-07.11-8803a0df799-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "merge-file", we need to loop over the "mmfs"
array and free() what we've got so far when we error out. As a result
we can mark a test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-file.c  | 10 ++++++----
 t/t6403-merge-file.sh |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 793817f3cb9..c923bbf2abb 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -87,7 +87,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 		free(fname);
 		if (ret)
-			return ret;
+			goto cleanup;
+
 	}
 
 	xmp.ancestor = names[1];
@@ -95,9 +96,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	xmp.file2 = names[2];
 	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
 
-	for (i = 0; i < 3; i++)
-		free(mmfs[i].ptr);
-
 	if (ret >= 0) {
 		const char *filename = argv[0];
 		char *fpath = prefix_filename(prefix, argv[0]);
@@ -118,5 +116,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (ret > 127)
 		ret = 127;
 
+cleanup:
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
 	return ret;
 }
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 2f421d967ab..1a7082323dd 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='RCS merge replacement: merge-file'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.37.0.874.g7d3439f13c4

