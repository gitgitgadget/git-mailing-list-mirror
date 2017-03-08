Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17F0202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdCHPoL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:44:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:59976 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdCHPoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:44:06 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1cux920occ-009SxC; Wed, 08
 Mar 2017 16:43:58 +0100
Date:   Wed, 8 Mar 2017 16:43:40 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to die
 on error
In-Reply-To: <cover.1488987786.git.johannes.schindelin@gmx.de>
Message-ID: <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:giCElnFRVZKGPUodTTUlFkqNTLlAdMX7Xg7Ll6fqNZik7+guBAn
 OH8tmAEuN2efw8jUmTsln1eriur6XxQ7Q1H9sIEwMqTUAdV8eEGorVosVXesW9alZ8tuyID
 DzsFJBdqUwU6Cbfbhr3ps52pKxLAqabsS5ZaXL4PjPV27qAZezW3RLxSgaWzzMGMqml3ii8
 Yn4p0j3bpdJ5YcGR2rBJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LLjcthZPGC8=:hhm/HN0sHI2Yf9Acw6jGLY
 6/X6K1YxQYSiG+raqNv7X2uvx4zGaXflx2m+Lw5/rYhzprrEdF3J69827Gzv2eLg6w7Hc17pQ
 RxAPN0ZooTRzXddKjE1ppnk88Eib19Z+Sre9uYwrTkljaN/0+unogD3jUdx32sPKTOgRdozt+
 86uABva+oh2l6LOxHqjjevUuoR2OQ7/MvfMva94u+G7Wm68b+iREExsV2dxYH73h9+StGxW2B
 jmy9JGDydpAeL8w41QOODnZdByjEOsWbWNMdOI9gKTUcDrU+cTAR5J+T4Et/9bTx28ujESx4g
 uIrHyqc5svSg6KZ2hGTxnXQHHWDJi50rHITeWrfHIJetRsHz6TdnGRNoL8JYWwxmWCXabyUJR
 TeRb4beLB6ShLoGXAqWrdBbUnBKBvUBFq8+pkPqkUrQ/NQfx9RQEaJgdaZskl/ersjlU4ATz4
 lKJZWgB7dK69+3TsUbz8JzTJMTm1QTSi9L45QmgdzA5PrUxsp1/pCmIqQnyvC6AgG6E6gj/36
 DG/Y6af9BO8uIblbL+ucXjRLmA3TK4kOnDnw2y9kra4suf70skCcQnicPdFd+p3PaVsqHxgeQ
 F3vpFQOzQJ8Kt73YTd9OrGhM8mKBmhjoyZE2UdWQXW5HfzuhKu2g5kjjB5NnL/aZx1jiIUmIh
 hx6OBUOWL1dAPenUGhsOPjxsli8yIbhx9pdKCud+pUcH3GCnEFIzfLCeiYV46gnm5JeRgQCVt
 xD5CnpxEINm17hiGbpt8ExoSvCj54+MLZ8hF+7gqLZDygublgnIjrk1kjI7ETrSjGYnhMratt
 8X/d2zH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4ac9006f832 (real_path: have callers use real_pathdup and
strbuf_realpath, 2016-12-12), we changed the xstrdup(real_path())
pattern to use real_pathdup() directly.

The only problem with this change is that real_path() calls
strbuf_realpath() with die_on_error = 1 while real_pathdup() calls it
with die_on_error = 0. Meaning that in cases where real_path() causes
Git to die() with an error message, real_pathdup() is silent and returns
NULL instead.

The callers, however, are ill-prepared for that change, as they expect
the return value to be non-NULL.

This patch fixes that by extending real_pathdup()'s signature to accept
the die_on_error flag and simply pass it through to strbuf_realpath(),
and then adjust all callers after a careful audit whether they would
handle NULLs well.

Note: this fix not only prevents NULL pointer accesses, but it also
reintroduces the error messages that were lost with the change to
real_pathdup().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 abspath.c            |  4 ++--
 builtin/init-db.c    |  6 +++---
 cache.h              |  2 +-
 dir.c                |  4 ++--
 environment.c        |  2 +-
 setup.c              |  4 ++--
 submodule.c          | 10 +++++-----
 t/t1501-work-tree.sh |  2 +-
 worktree.c           |  2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/abspath.c b/abspath.c
index 2f0c26e0e2c..b02e068aa34 100644
--- a/abspath.c
+++ b/abspath.c
@@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
-char *real_pathdup(const char *path)
+char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
 	char *retval = NULL;
 
-	if (strbuf_realpath(&realpath, path, 0))
+	if (strbuf_realpath(&realpath, path, die_on_error))
 		retval = strbuf_detach(&realpath, NULL);
 
 	strbuf_release(&realpath);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 1d4d6a00789..8a6acb0ec69 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -338,7 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
-	char *original_git_dir = real_pathdup(git_dir);
+	char *original_git_dir = real_pathdup(git_dir, 1);
 
 	if (real_git_dir) {
 		struct stat st;
@@ -489,7 +489,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = real_pathdup(real_git_dir);
+		real_git_dir = real_pathdup(real_git_dir, 1);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -560,7 +560,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		const char *git_dir_parent = strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg = real_pathdup(rel);
+			git_work_tree_cfg = real_pathdup(rel, 1);
 			free(rel);
 		}
 		if (!git_work_tree_cfg)
diff --git a/cache.h b/cache.h
index 80b6372cf76..ae0b4fc70b5 100644
--- a/cache.h
+++ b/cache.h
@@ -1153,7 +1153,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
-char *real_pathdup(const char *path);
+char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
diff --git a/dir.c b/dir.c
index 4541f9e1460..aeeb5ce1049 100644
--- a/dir.c
+++ b/dir.c
@@ -2730,8 +2730,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = real_pathdup(git_dir_);
-	char *work_tree = real_pathdup(work_tree_);
+	char *git_dir = real_pathdup(git_dir_, 1);
+	char *work_tree = real_pathdup(work_tree_, 1);
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
diff --git a/environment.c b/environment.c
index c07fb17fb70..42dc3106d2f 100644
--- a/environment.c
+++ b/environment.c
@@ -259,7 +259,7 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = real_pathdup(new_work_tree);
+	work_tree = real_pathdup(new_work_tree, 1);
 }
 
 const char *get_git_work_tree(void)
diff --git a/setup.c b/setup.c
index 967f289f1ef..6b48cb91ff2 100644
--- a/setup.c
+++ b/setup.c
@@ -698,7 +698,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir);
+			gitdir = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
@@ -806,7 +806,7 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 		/* Keep entry but do not canonicalize it */
 		return 1;
 	} else {
-		char *real_path = real_pathdup(ceil);
+		char *real_path = real_pathdup(ceil, 0);
 		if (!real_path) {
 			return 0;
 		}
diff --git a/submodule.c b/submodule.c
index 3b98766a6bc..0a2831d846d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1403,7 +1403,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		/* If it is an actual gitfile, it doesn't need migration. */
 		return;
 
-	real_old_git_dir = real_pathdup(old_git_dir);
+	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
 	sub = submodule_from_path(null_sha1, path);
 	if (!sub)
@@ -1412,7 +1412,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	new_git_dir = git_path("modules/%s", sub->name);
 	if (safe_create_leading_directories_const(new_git_dir) < 0)
 		die(_("could not create directory '%s'"), new_git_dir);
-	real_new_git_dir = real_pathdup(new_git_dir);
+	real_new_git_dir = real_pathdup(new_git_dir, 1);
 
 	if (!prefix)
 		prefix = get_super_prefix();
@@ -1472,14 +1472,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		new_git_dir = git_path("modules/%s", sub->name);
 		if (safe_create_leading_directories_const(new_git_dir) < 0)
 			die(_("could not create directory '%s'"), new_git_dir);
-		real_new_git_dir = real_pathdup(new_git_dir);
+		real_new_git_dir = real_pathdup(new_git_dir, 1);
 		connect_work_tree_and_git_dir(path, real_new_git_dir);
 
 		free(real_new_git_dir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
-		char *real_sub_git_dir = real_pathdup(sub_git_dir);
-		char *real_common_git_dir = real_pathdup(get_git_common_dir());
+		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
+		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
 			relocate_single_git_dir_into_superproject(prefix, path);
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 046d9b7909f..b06210ec5e8 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -423,7 +423,7 @@ test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
 	)
 '
 
-test_expect_failure 'error out gracefully on invalid $GIT_WORK_TREE' '
+test_expect_success 'error out gracefully on invalid $GIT_WORK_TREE' '
 	(
 		GIT_WORK_TREE=/.invalid/work/tree &&
 		export GIT_WORK_TREE &&
diff --git a/worktree.c b/worktree.c
index d633761575b..0486e31ad4a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -255,7 +255,7 @@ struct worktree *find_worktree(struct worktree **list,
 		return wt;
 
 	arg = prefix_filename(prefix, strlen(prefix), arg);
-	path = real_pathdup(arg);
+	path = real_pathdup(arg, 1);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
-- 
2.12.0.windows.1.7.g94dafc3b124
