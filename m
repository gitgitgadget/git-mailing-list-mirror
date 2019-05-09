Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7B51F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEIV1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:27:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726704AbfEIV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:27:34 -0400
Received: (qmail 10020 invoked by uid 109); 9 May 2019 21:27:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:27:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6419 invoked by uid 111); 9 May 2019 21:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:28:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:27:31 -0400
Date:   Thu, 9 May 2019 17:27:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/14] submodule: drop unused prefix parameter from some
 functions
Message-ID: <20190509212731.GB15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We stopped using the "prefix" parameter of
relocate_single_git_dir_into_superproject() and its callers in
202275b96b (submodule.c: get_super_prefix_or_empty, 2017-03-14), where
we switched to using the environment global directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rm.c                |  6 +++---
 builtin/submodule--helper.c |  3 +--
 submodule.c                 | 10 ++++------
 submodule.h                 |  3 +--
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 90cbe896c9..be8edc6d1e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -61,7 +61,7 @@ static void print_error_files(struct string_list *files_list,
 	}
 }
 
-static void submodules_absorb_gitdir_if_needed(const char *prefix)
+static void submodules_absorb_gitdir_if_needed(void)
 {
 	int i;
 	for (i = 0; i < list.nr; i++) {
@@ -83,7 +83,7 @@ static void submodules_absorb_gitdir_if_needed(const char *prefix)
 			continue;
 
 		if (!submodule_uses_gitfile(name))
-			absorb_git_dir_into_superproject(prefix, name,
+			absorb_git_dir_into_superproject(name,
 				ABSORB_GITDIR_RECURSE_SUBMODULES);
 	}
 }
@@ -313,7 +313,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!index_only)
-		submodules_absorb_gitdir_if_needed(prefix);
+		submodules_absorb_gitdir_if_needed();
 
 	/*
 	 * If not forced, the file, the index and the HEAD (if exists)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8c72ea864c..7262f1a000 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2107,8 +2107,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	for (i = 0; i < list.nr; i++)
-		absorb_git_dir_into_superproject(prefix,
-				list.entries[i]->name, flags);
+		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 
 	return 0;
 }
diff --git a/submodule.c b/submodule.c
index 2cfaba0599..0f199c5137 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1910,7 +1910,7 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old_head) {
 			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject("", path,
+				absorb_git_dir_into_superproject(path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
 			char *gitdir = xstrfmt("%s/modules/%s",
@@ -1997,8 +1997,7 @@ int submodule_move_head(const char *path,
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
  */
-static void relocate_single_git_dir_into_superproject(const char *prefix,
-						      const char *path)
+static void relocate_single_git_dir_into_superproject(const char *path)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	const char *new_git_dir;
@@ -2040,8 +2039,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void absorb_git_dir_into_superproject(const char *prefix,
-				      const char *path,
+void absorb_git_dir_into_superproject(const char *path,
 				      unsigned flags)
 {
 	int err_code;
@@ -2082,7 +2080,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
-			relocate_single_git_dir_into_superproject(prefix, path);
+			relocate_single_git_dir_into_superproject(path);
 
 		free(real_sub_git_dir);
 		free(real_common_git_dir);
diff --git a/submodule.h b/submodule.h
index 9e18e9b807..8072e6d6dd 100644
--- a/submodule.h
+++ b/submodule.h
@@ -141,8 +141,7 @@ void submodule_unset_core_worktree(const struct submodule *sub);
 void prepare_submodule_repo_env(struct argv_array *out);
 
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
-void absorb_git_dir_into_superproject(const char *prefix,
-				      const char *path,
+void absorb_git_dir_into_superproject(const char *path,
 				      unsigned flags);
 
 /*
-- 
2.21.0.1382.g4c6032d436

