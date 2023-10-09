Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46236E95A9C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379061AbjJIXfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379038AbjJIXfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 19:35:16 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6A9D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 16:35:13 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S4Fkg60Bnz9snY;
        Tue, 10 Oct 2023 01:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1696894507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezzO0xe3JSClqveT5b0ioxz8R3VpCy3UM8ZEnoWM1Fc=;
        b=wE/6Tx+ggwPI8W8XrsWc4/6s/M1jjIdLYSuBRq3ZirKrwpnyj9PEGAHeRnBu7fGgr0VKpC
        CD7WIipJuYs7kD0TZf/pJPBKAf8jx+0NER04SKVKElNPk+BqSyxaada+PVlCY0lAFxnVIJ
        GnXehDrg2mNB86gGaeuMvYYKXXjtAC9T0tzDZU03RBUvf2Bfz/sxdcYT1VM6yAXMtxOz21
        ZnFZI881Smwk174tUc/jFD9jopLiqScnwOZghgk7/0jUSnM9a+iRAaDbqA8CLJj7kugexr
        K4JlQHWC6B0cy4TmEqo2MrUJUZULF/Fn1cH1oWyb8NGxmvrGbgkNk0VvZ13pvQ==
From:   Hugo Sales <hugo@hsal.es>
To:     git@vger.kernel.org
Cc:     Hugo Sales <hugo@hsal.es>
Subject: [PATCH 1/3] mv: Add -p option to create parent directories
Date:   Tue, 10 Oct 2023 00:34:56 +0100
Message-ID: <20231009233458.1371351-2-hugo@hsal.es>
In-Reply-To: <20231009233458.1371351-1-hugo@hsal.es>
References: <20231009233458.1371351-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S4Fkg60Bnz9snY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by "mkdir -p", this patch allows specifying a "-p" or
"--parents" flag which will create all non-existent directories in the
destination path before renaming the file.

This allows the user to not have to run two commands to move files to a
new directory.

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 builtin/mv.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index c596515ad0..5d64d86179 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -168,7 +168,7 @@ static int empty_dir_has_sparse_contents(const char *name)
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
+	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0, create_parents = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -176,6 +176,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
+		OPT_BOOL('p', "parents", &create_parents, N_("create missing parent directories")),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
@@ -220,8 +221,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
 		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
-	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
+	else if (create_parents ||
+		 (!lstat(dest_path[0], &st) && S_ISDIR(st.st_mode))) {
 		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
 	} else {
 		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
@@ -381,7 +382,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			bad = _("multiple sources for the same target");
 			goto act_on_entry;
 		}
-		if (is_dir_sep(dst[strlen(dst) - 1])) {
+
+		if (!create_parents && is_dir_sep(dst[strlen(dst) - 1])) {
 			bad = _("destination directory does not exist");
 			goto act_on_entry;
 		}
@@ -459,11 +461,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (show_only)
 			continue;
 		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
-		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
-		    rename(src, dst) < 0) {
-			if (ignore_errors)
-				continue;
-			die_errno(_("renaming '%s' failed"), src);
+		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
+			if (create_parents && safe_create_leading_directories_const(dst) < 0) {
+				if (ignore_errors)
+					continue;
+				die_errno(_("creating parent directories for '%s' failed"), dst);
+			}
+
+			if (rename(src, dst) < 0) {
+				if (ignore_errors)
+					continue;
+				die_errno(_("renaming '%s' failed"), src);
+			}
 		}
 		if (submodule_gitfile[i]) {
 			if (!update_path_in_gitmodules(src, dst))
-- 
2.42.0

