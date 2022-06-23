Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F21C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiFWLmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFWLl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881094BFE9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k127so13650945pfd.10
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGJonfRz8QCsdAKY1pQeQi7v/qw/myKwiE3nlvGM1Fc=;
        b=IIg5w2eodYyOuRm/WTuJuxj3cFD8TzETXuTBrli/CEn9x73wa1QorHX7rwZsMDoe6/
         dP+FPN8OuCWhdhsqEnT1YnAAmjONbJnKnfPp5ydwPRRH9OMoue73HPs0zsL9glIzjRn2
         OgHiUcJw9sxKxVi3bnPiFF6oktSFWgbxhL+oaTJtDuRGShXWC4dUYROT3IkmN7JgkuU3
         E25MJQuUGq4m8thuAU7AB6a2c3AjVFeJrQ2Q7zCV/oPEzWJa6CUpXe9xSpIMGo1GjPL2
         +Yq/rWZ4CvOphoS6zpJY3boPDtJUQ5PGpdNH2F8LVOxZPIkHqVpDlrKu3judw40pbQh3
         8DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGJonfRz8QCsdAKY1pQeQi7v/qw/myKwiE3nlvGM1Fc=;
        b=ylpi+oBuT7gpOvyTaAS7+k7emvfestrwF3recE0lkGCyePBOy7c/CNcp66Dpdiq6Q0
         /kJv/GfjJsyhNnwpVeB9fsQkD+9t8MEnbiiBpLjlpswCwlSfSax3BWcPphF/ugrL0dZf
         GQCyLH40ZiHvEuzzxfvfauxt/m7b6V4uqO7DQnC8zwODXkW/w7+L39pO+V1rz3H0nct5
         zdDLI7bs5rrz+2h5mNLI/lSfHj6o3GfE2wPihrTuqFmpxSus7RGf0YUe+KTw/0xzKxhc
         MB9RKPeCT8Me8D8xgZkKsWlAhew9A4MJ0ZnPv59dg/IwSKxTq/aUBoYBWjMOUKSTXEFz
         TN/g==
X-Gm-Message-State: AJIora+XoJkf9bYSgi/baowjkq5ASobXMxYpg0uxSjchIrp4u77aGOAt
        yUxwvSRb1g1iTFk+DPI7gpA=
X-Google-Smtp-Source: AGRyM1vpV/y7G501j/nJ6zdY5F29MU23wUIhTtZRRp4SHX+O7mYctx/kcRFEff3xtV7jRXaHkGXtfg==
X-Received: by 2002:a63:7a57:0:b0:40c:e242:e947 with SMTP id j23-20020a637a57000000b0040ce242e947mr7281052pgn.511.1655984516992;
        Thu, 23 Jun 2022 04:41:56 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:56 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 7/7] mv: add check_dir_in_index() and solve general dir check issue
Date:   Thu, 23 Jun 2022 19:41:20 +0800
Message-Id: <20220623114120.12768-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
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
 builtin/mv.c                  | 50 ++++++++++++++++++++++++++++++-----
 t/t7002-mv-sparse-checkout.sh |  4 +--
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aa29da4337..b5d0d8ef4f 100644
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

