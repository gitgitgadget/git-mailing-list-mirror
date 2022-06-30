Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EEAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiF3Ciq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiF3Cig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A78DF35
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jh14so15794012plb.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/JzyUB+8soeR+ytNEPgHPwCWP61ls7r/6McNW4S+iI=;
        b=Wv4hFRM20I6X7fwiStMUEkXO3tgo5bsWK8yxkLDp7MHm0AaD6162eXXFF8T4SC/fv5
         ZmIkLci0HdBpayg1fM9gj8wjHstV9JVf0Bp6Efre3qtoJOIAY/vl281Y/SyG/Q+e8C2n
         BUcdVsTMiJWaV0JWFiqMcQYCeczNBI59X1Rzwrb6Wz56D+YTgbgcY0wE+F+N5NqjpmJy
         pyotxtV51bURRBUtP2btmnpfem591xVnFqHZITJBkGluA7JOzth1IPesqEIiXmfDa9XD
         oCG2hjoUWjp+bEQxnObBThiIVD0qLm5SsYUtF5MYlrslu6+9QkhjXtoijZhNAr4rhopU
         4S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/JzyUB+8soeR+ytNEPgHPwCWP61ls7r/6McNW4S+iI=;
        b=K1L7qVK9dmquxc/Qcht232cBdkcersrmMfEZouSyb7PRX0TE80786c/tknFsdfh7tD
         CquroX20dP3z3MIxz51KY5f5eONMeDVYDzttAiUW8CFYTIS1RbTru1Co9Oa+oh96dQQN
         XZ6U7BK5xAXfA/u34DhGAEHc7USfAGE6hbR92vaNAkVEKBEZ5crjb713MEOccDs9rjUr
         p6LevHkjOnknzFTazzlg1p4T9tk3Ncg2fojfaLjTibHhRQBWqcQ4A3SWM4mJD2zDerQD
         HSMct3Vv8TnxziyQTsKGnURXHjQeJ2fcAC2bOvbp4yuqPnhN5bfeXsyIru3SGY3x9Ddn
         p+0A==
X-Gm-Message-State: AJIora9MbQ+gXu7lIzYAhsuvWhtc0Ye6VRmv2T3Gd6nCcIac0n5lsbYN
        eJoKPZpaaTNfeSCbIRRaJDX8SK/s5mU=
X-Google-Smtp-Source: AGRyM1vVL/khFV640/vwy9aVZPL59Qvqduj7ktmXHcvKUOM3PhKAda6jGNitIUeUt1DMRzEmJUjJOw==
X-Received: by 2002:a17:90a:5309:b0:1ec:82a1:3b86 with SMTP id x9-20020a17090a530900b001ec82a13b86mr7242196pjh.54.1656556689252;
        Wed, 29 Jun 2022 19:38:09 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:38:08 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 8/8] mv: add check_dir_in_index() and solve general dir check issue
Date:   Thu, 30 Jun 2022 10:37:37 +0800
Message-Id: <20220630023737.473690-9-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> directory which is not on-disk due
to its existence outside of sparse-checkout cone, "giv mv" command
errors out with "bad source".

Add a helper check_dir_in_index() function to see if a directory
name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
such directories.

Change the checking logic, so that such <source> directory makes
"giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                             | 50 +++++++++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 t/t7002-mv-sparse-checkout.sh            |  4 +-
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b805a0d0f6..2a38e2af46 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -25,6 +25,7 @@ enum update_mode {
 	WORKING_DIRECTORY = (1 << 1),
 	INDEX = (1 << 2),
 	SPARSE = (1 << 3),
+	SKIP_WORKTREE_DIR = (1 << 4),
 };
 
 #define DUP_BASENAME 1
@@ -123,6 +124,36 @@ static int index_range_of_same_dir(const char *src, int length,
 	return last - first;
 }
 
+/*
+ * Check if an out-of-cone directory should be in the index. Imagine this case
+ * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
+ * and thus the directory is sparsified.
+ *
+ * Return 0 if such directory exist (i.e. with any of its contained files not
+ * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
+ * Return 1 otherwise.
+ */
+static int check_dir_in_index(const char *name)
+{
+	const char *with_slash = add_slash(name);
+	int length = strlen(with_slash);
+
+	int pos = cache_name_pos(with_slash, length);
+	const struct cache_entry *ce;
+
+	if (pos < 0) {
+		pos = -pos - 1;
+		if (pos >= the_index.cache_nr)
+			return 1;
+		ce = active_cache[pos];
+		if (strncmp(with_slash, ce->name, length))
+			return 1;
+		if (ce_skip_worktree(ce))
+			return 0;
+	}
+	return 1;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
@@ -184,7 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length;
 		const char *bad = NULL;
 		int skip_sparse = 0;
 
@@ -198,12 +229,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 			pos = cache_name_pos(src, length);
 			if (pos < 0) {
+				const char *src_w_slash = add_slash(src);
+				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
+				    !check_dir_in_index(src)) {
+					modes[i] |= SKIP_WORKTREE_DIR;
+					goto dir_check;
+				}
 				/* only error if existence is expected. */
 				if (!(modes[i] & SPARSE))
 					bad = _("bad source");
 				goto act_on_entry;
 			}
-
 			ce = active_cache[pos];
 			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
@@ -230,12 +266,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			bad = _("can not move directory into itself");
 			goto act_on_entry;
 		}
-		if ((src_is_dir = S_ISDIR(st.st_mode))
+		if (S_ISDIR(st.st_mode)
 		    && lstat(dst, &st) == 0) {
 			bad = _("cannot move directory over file");
 			goto act_on_entry;
 		}
-		if (src_is_dir) {
+
+dir_check:
+		if (S_ISDIR(st.st_mode)) {
 			int j, dst_len, n;
 			int first = cache_name_pos(src, length), last;
 
@@ -369,7 +407,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (!(mode & (INDEX | SPARSE)) &&
+		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
@@ -384,7 +422,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							      1);
 		}
 
-		if (mode & (WORKING_DIRECTORY))
+		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
 			continue;
 
 		pos = cache_name_pos(src, strlen(src));
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 5eef799e25..763c6cc684 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1828,7 +1828,7 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
 	test_cmp full-checkout-err sparse-index-err
 '
 
-test_expect_failure 'mv directory from out-of-cone to in-cone' '
+test_expect_success 'mv directory from out-of-cone to in-cone' '
 	init_repos &&
 
 	# <source> as a sparse directory (or SKIP_WORKTREE_DIR without enabling
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 6d2fb4f8d2..71fe29690f 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -219,7 +219,7 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
+test_expect_success 'refuse to move out-of-cone directory without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -230,7 +230,7 @@ test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone directory with --sparse' '
+test_expect_success 'can move out-of-cone directory with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-- 
2.35.1

