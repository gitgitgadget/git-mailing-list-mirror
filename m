Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2AD1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758785AbcHYXil (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:38:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:42011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758738AbcHYXig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:38:36 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062159"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:45 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 0/8] submodule inline diff format
Date:   Thu, 25 Aug 2016 16:32:35 -0700
Message-Id: <20160825233243.30700-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Modify the changes to do_submodule_path so that we properly call
gitmodules_config() before the lookup of submodule_from_path. This may
need to be modified so that we only call it the first time as I'm not
sure what sort of performance hit we'll see. Note that we only need this
call if we no longer have the checkout so it may not be so bad.

Also make the function propagate an error code up to the callers so that
they don't try to use an invalid path. This is better than die()'ing
because a failure can occur if the submodule configuration can't be
found for some reason (such as committing the submodule but not the
.gitmodules file which we previously did in the test).

interdiff between v10 and v11:
diff --git w/cache.h c/cache.h
index 70428e92d7ed..4f6693afa387 100644
--- w/cache.h
+++ c/cache.h
@@ -819,8 +819,8 @@ extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-extern void strbuf_git_path_submodule(struct strbuf *sb, const char *path,
-				      const char *fmt, ...)
+extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
diff --git w/path.c c/path.c
index 07dd0f62eb82..e9369f75319d 100644
--- w/path.c
+++ c/path.c
@@ -469,13 +469,16 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	return pathname->buf;
 }
 
-static void do_submodule_path(struct strbuf *buf, const char *path,
-			      const char *fmt, va_list args)
+/* Returns 0 on success, non-zero on failure. */
+#define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
+static int do_submodule_path(struct strbuf *buf, const char *path,
+			     const char *fmt, va_list args)
 {
 	const char *git_dir;
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
 	const struct submodule *sub;
+	int err = 0;
 
 	strbuf_addstr(buf, path);
 	strbuf_complete(buf, '/');
@@ -487,12 +490,14 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
+		gitmodules_config();
 		sub = submodule_from_path(null_sha1, path);
-		if (sub) {
-			strbuf_reset(buf);
-			strbuf_git_path(buf, "%s/%s", "modules",
-					sub->name);
+		if (!sub) {
+			err = SUBMODULE_PATH_ERR_NOT_CONFIGURED;
+			goto cleanup;
 		}
+		strbuf_reset(buf);
+		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
 	}
 
 	strbuf_addch(buf, '/');
@@ -505,27 +510,36 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 
 	strbuf_cleanup_path(buf);
 
+cleanup:
 	strbuf_release(&git_submodule_dir);
 	strbuf_release(&git_submodule_common_dir);
+
+	return err;
 }
 
 char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 {
+	int err;
 	va_list args;
 	struct strbuf buf = STRBUF_INIT;
 	va_start(args, fmt);
-	do_submodule_path(&buf, path, fmt, args);
+	err = do_submodule_path(&buf, path, fmt, args);
 	va_end(args);
+	if (err)
+		return NULL;
 	return strbuf_detach(&buf, NULL);
 }
 
-void strbuf_git_path_submodule(struct strbuf *buf, const char *path,
-			       const char *fmt, ...)
+int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
+			      const char *fmt, ...)
 {
+	int err;
 	va_list args;
 	va_start(args, fmt);
-	do_submodule_path(buf, path, fmt, args);
+	err = do_submodule_path(buf, path, fmt, args);
 	va_end(args);
+
+	return err;
 }
 
 static void do_git_common_path(struct strbuf *buf,
diff --git w/refs/files-backend.c c/refs/files-backend.c
index 12290d249643..1f34b444af8d 100644
--- w/refs/files-backend.c
+++ c/refs/files-backend.c
@@ -1225,13 +1225,19 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	struct strbuf refname;
 	struct strbuf path = STRBUF_INIT;
 	size_t path_baselen;
+	int err = 0;
 
 	if (*refs->name)
-		strbuf_git_path_submodule(&path, refs->name, "%s", dirname);
+		err = strbuf_git_path_submodule(&path, refs->name, "%s", dirname);
 	else
 		strbuf_git_path(&path, "%s", dirname);
 	path_baselen = path.len;
 
+	if (err) {
+		strbuf_release(&path);
+		return;
+	}
+
 	d = opendir(path.buf);
 	if (!d) {
 		strbuf_release(&path);
diff --git w/submodule.c c/submodule.c
index 405fa9e4eb32..5a62aa296098 100644
--- w/submodule.c
+++ c/submodule.c
@@ -127,7 +127,9 @@ static int add_submodule_odb(const char *path)
 	int ret = 0;
 	size_t alloc;
 
-	strbuf_git_path_submodule(&objects_directory, path, "objects/");
+	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
+	if (ret)
+		goto done;
 	if (!is_directory(objects_directory.buf)) {
 		ret = -1;
 		goto done;
diff --git w/t/t4059-diff-submodule-not-initialized.sh c/t/t4059-diff-submodule-not-initialized.sh
index c8775854d3c2..bd6927578423 100755
--- w/t/t4059-diff-submodule-not-initialized.sh
+++ c/t/t4059-diff-submodule-not-initialized.sh
@@ -50,8 +50,8 @@ test_expect_success 'setup - submodules' '
 
 test_expect_success 'setup - git submodule add' '
 	git submodule add ./sm2 sm1 &&
-	commit_file sm1 &&
-	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	commit_file sm1 .gitmodules &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD -- sm1 >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 0000000...$smhead1 (new submodule)
 	EOF
@@ -60,7 +60,7 @@ test_expect_success 'setup - git submodule add' '
 
 test_expect_success 'submodule directory removed' '
 	rm -rf sm1 &&
-	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD -- sm1 >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 0000000...$smhead1 (new submodule)
 	EOF

--------->8

Jacob Keller (7):
  cache: add empty_tree_oid object and helper function
  graph: add support for --line-prefix on all graph-aware output
  diff: prepare for additional submodule formats
  allow do_submodule_path to work even if submodule isn't checked out
  submodule: convert show_submodule_summary to use struct object_id *
  submodule: refactor show_submodule_summary with helper function
  diff: teach diff to display submodule difference with an inline diff

Junio C Hamano (1):
  diff.c: remove output_prefix_length field

 Documentation/diff-config.txt                      |   9 +-
 Documentation/diff-options.txt                     |  20 +-
 builtin/rev-list.c                                 |  70 +-
 cache.h                                            |  29 +-
 diff.c                                             |  64 +-
 diff.h                                             |  11 +-
 graph.c                                            | 100 ++-
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 path.c                                             |  37 +-
 refs/files-backend.c                               |   8 +-
 sha1_file.c                                        |   6 +
 submodule.c                                        | 190 +++++-
 submodule.h                                        |   8 +-
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 +
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4059-diff-submodule-not-initialized.sh          | 127 ++++
 t/t4060-diff-submodule-option-diff-format.sh       | 749 +++++++++++++++++++++
 t/t4202-log.sh                                     | 323 +++++++++
 20 files changed, 1664 insertions(+), 164 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh
 create mode 100755 t/t4060-diff-submodule-option-diff-format.sh

-- 
2.10.0.rc0.259.g83512d9

