Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0AC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiF3SAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiF3SAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003122AC79
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso59325wmq.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhsCgrBaEAT4H1YdmzM9UxknebkvnB/cgI0gXCpajJs=;
        b=V/bs+huWkZ0E3ri/fpHU2MMYU+I7+tKGTmwIgJqv4Pe2IEHntqToxwBgREvfprpa4O
         f74tBwjoNqf7fNerFGxfRR4HbSAra4yU2Ms9uGXldTGVsfuzSBIx+P/Q/UxcAnlquXlY
         Fq9JwnzoYcomXQe3ayAVeSid7664Fp0bOPcw6tTrciYo4UIez+Y4qz168lPEb5CT6QW7
         5u8oUa5vRLTgc64hlDZVPQM0uW6KqRMQzj3dKHNA7E3c/6aeh1tTHnk4XY2guUwSu1He
         ZjJ5oeci91CebLTGjT5/LACvwjjpRCjN6TcabydOPVcO+u4nBOPIfR7qOi2QeZesUuXy
         VN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhsCgrBaEAT4H1YdmzM9UxknebkvnB/cgI0gXCpajJs=;
        b=Z3mokk9q4OpfLWpEEeskLImhLH/zV6QlgDPVAmEJcBGKmHteonbV2IXwsDEkj9lAT/
         Zw0w7zMZ4A9ofNORvsdgjz6v/0GWj6OYvuC3EpjXfF0Lz+Xg//mUWsX3vCVciflRXDej
         PTHyCBxmyNr8wfyezW+mjhwPXhUixU4Gd55SGdGVeolBJlK82w8SenEfQzmBFBxgDlvt
         bQAB2nWIK4EhGbqymQ38mP0oUC79kvYWuarcF2ypNFhy01kC6eHDg/5zDXouwdnG7g+Z
         iQdUNpOewzrVm1UafBqks0MtM9hY3AnIIHGzal6p3m1GPuBgUmFpSYm5Yr04S3ndEBfW
         qHXg==
X-Gm-Message-State: AJIora9Hxdl2keGOYMBy/iHB3bP/xgmjALXNErdDch0kkq58KrzzAEgy
        SfGcLeG42j4L9L/fb09YC5xQRksX0tX7tw==
X-Google-Smtp-Source: AGRyM1u7Fp8qbv9DF4cVbHu2m09M7WFdduxWMFjBZeFwwXYzeCXvDLygjnGQffBhluV8YmeS6L4CCQ==
X-Received: by 2002:a05:600c:3494:b0:3a0:37f0:86ad with SMTP id a20-20020a05600c349400b003a037f086admr11565514wmq.65.1656612034981;
        Thu, 30 Jun 2022 11:00:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/11] pull: fix a "struct oid_array" memory leak
Date:   Thu, 30 Jun 2022 20:00:21 +0200
Message-Id: <patch-11.11-022399ad652-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 44c175c7a46 (pull: error on no merge
candidates, 2015-06-18). As a result we can mark several tests as
passing with SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

Removing the "int ret = 0" assignment added here in a6d7eb2c7a6 (pull:
optionally rebase submodules (remote submodule changes only),
2017-06-23) is not a logic error, it could always have been left
uninitialized (as "int ret"), now that we'll use the "ret" from the
upper scope we can drop the assignment in the "opt_rebase" branch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pull.c               | 16 ++++++++++------
 t/t5524-pull-msg.sh          |  1 +
 t/t6417-merge-ours-theirs.sh |  1 +
 t/t9101-git-svn-props.sh     |  1 -
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 01155ba67b2..403a24d7ca6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -990,6 +990,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	int rebase_unspecified = 0;
 	int can_ff;
 	int divergent;
+	int ret;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1100,7 +1101,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (is_null_oid(&orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
-		return pull_into_void(merge_heads.oid, &curr_head);
+		ret = pull_into_void(merge_heads.oid, &curr_head);
+		goto cleanup;
 	}
 	if (merge_heads.nr > 1) {
 		if (opt_rebase)
@@ -1125,8 +1127,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	}
 
 	if (opt_rebase) {
-		int ret = 0;
-
 		struct object_id newbase;
 		struct object_id upstream;
 		get_rebase_newbase_and_upstream(&newbase, &upstream, &curr_head,
@@ -1149,12 +1149,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
 			ret = rebase_submodules();
 
-		return ret;
+		goto cleanup;
 	} else {
-		int ret = run_merge();
+		ret = run_merge();
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
 			ret = update_submodules();
-		return ret;
+		goto cleanup;
 	}
+
+cleanup:
+	oid_array_clear(&merge_heads);
+	return ret;
 }
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index b2be3605f5a..56716e29ddf 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -2,6 +2,7 @@
 
 test_description='git pull message generation'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dollar='$Dollar'
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 62d1406119e..482b73a998f 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -4,6 +4,7 @@ test_description='Merge-recursive ours and theirs variants'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index d043e80fc34..52046e60d51 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn property tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 mkdir import
-- 
2.37.0.874.g7d3439f13c4

