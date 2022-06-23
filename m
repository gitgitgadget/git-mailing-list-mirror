Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E2CCA47C
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiFWLmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiFWLlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFB4BFF9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so2308494pjz.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN8OhcDXR6q1XLN9NsKGEVVgFuPfGxmyPxmclVfqsys=;
        b=c0QqmbsF41t42P/3bMcaj91xYiEurqrV9lV7Rt3QDOgr3Q+WXhUpRmZMxR+2yw4CY3
         FX0pKHwUJhJo++eMT/O+5iA6XVJTz6VDhG2+GXOkCSwbBcuXmd6avgGKSoTrVzpDtxYr
         AEA0naVsU8e3ggGr0Jc5p5REsZ24JVj7+Jk8sdLCkdYzFoH4rsP2P+grv21AHxYVLtzz
         XZN4ObtW8gn2fzeTyR5NdpZdsTLNeggy7P9KtsQHhTJFijoc/F9ptYoPEC+kMWEQYxjf
         KBJEz+jz6u+GozLQjCMdjKo/5z2pfawvh9g3UgmSI6meImpPNZHonl2Cfe6NX9sgp58B
         vChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN8OhcDXR6q1XLN9NsKGEVVgFuPfGxmyPxmclVfqsys=;
        b=JWX8DCTsByNXeCWSSsVwgz+jXHn9MlsoMPdytOk3/5V/KzdPUE+Zc2B4gEVQ2C+Y1y
         kf5uC5mcdcVSDuYxv1RU8AV9adSeTuaqzGIc4ie7IaYqWZtcbjrG4vgmwRLttKvKaNDM
         NXNSZ9jP9X4eQ6JDEPwO4U8tGT7+Ror41OifDyuYP6XOLisokyqt46dm+VehLW1lTBpW
         HOtKmc4eyvX1EmcczJkiNS/iXIDHK16iB8v4v5ao/TdgMqwPdu8sA7Zw8sFOjojCUGAs
         HQwXy4G7sHabbMi/ohR65C45spO887aXbUu8T0vCDeeEWs2tWEHUzKForURugr0CCn9n
         aaQQ==
X-Gm-Message-State: AJIora/CZXAz+c2s+UbdwrL015q3TmsaFaiRGL7l1cCY7dZBzx5Q9RpK
        RlTqA+pV3vZlrG3ywEeA21cq9xag2eesiGBr
X-Google-Smtp-Source: AGRyM1vtixqp8xHcoS52+HGbehvi9EhyStOiqqZhFMRYgqy5SvWM2rO40+9LIkCB/FkOCU1+gmqIHw==
X-Received: by 2002:a17:90b:3907:b0:1ec:9225:6a81 with SMTP id ob7-20020a17090b390700b001ec92256a81mr3645111pjb.0.1655984511321;
        Thu, 23 Jun 2022 04:41:51 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:51 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 4/7] mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
Date:   Thu, 23 Jun 2022 19:41:17 +0800
Message-Id: <20220623114120.12768-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> file which is not on-disk but exists in
index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
out with "bad source".

Change the checking logic, so that such <source>
file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 21 +++++++++++++++++++--
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7f8d658028..d1b3229be6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -186,11 +186,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
-			/* only error if existence is expected. */
-			if (modes[i] != SPARSE) {
+			int pos;
+			const struct cache_entry *ce;
+
+			pos = cache_name_pos(src, length);
+			if (pos < 0) {
+				/* only error if existence is expected. */
+				if (modes[i] != SPARSE)
+					bad = _("bad source");
+				goto act_on_entry;
+			}
+
+			ce = active_cache[pos];
+			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
 				goto act_on_entry;
 			}
+
+			if (!ignore_sparse)
+				string_list_append(&only_match_skip_worktree, src);
+			else
+				modes[i] = SPARSE;
+			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
 		    (dst[length] == 0 || dst[length] == '/')) {
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 023e657c9e..1510b5ed6a 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -241,7 +241,7 @@ test_expect_failure 'can move out-of-cone directory with --sparse' '
 	test_path_is_file sub/folder1/file1
 '
 
-test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+test_expect_success 'refuse to move out-of-cone file without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -252,7 +252,7 @@ test_expect_failure 'refuse to move out-of-cone file without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone file with --sparse' '
+test_expect_success 'can move out-of-cone file with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-- 
2.35.1

