Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C75B1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758120AbcHYXff (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:35:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:23240 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757271AbcHYXfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:35:17 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062168"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:46 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 5/8] allow do_submodule_path to work even if submodule isn't checked out
Date:   Thu, 25 Aug 2016 16:32:40 -0700
Message-Id: <20160825233243.30700-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Currently, do_submodule_path will attempt locating the .git directory by
using read_gitfile on <path>/.git. If this fails it just assumes the
<path>/.git is actually a git directory.

This is good because it allows for handling submodules which were cloned
in a regular manner first before being added to the parent project.

Unfortunately this fails if the <path> is not actually checked out any
longer, such as by removing the directory.

Fix this by checking if the directory we found is actually a gitdir. In
the case it is not, attempt to lookup the submodule configuration and
find the name of where it is stored in the .git/modules/ folder of the
parent project.

If we can't locate the submodule configuration this might occur because
for example a submodule gitlink was added but the corresponding
.gitmodules file was not properly updated. A die() here would not be
pleasant to the users of submodule diff formats, so instead, modify
do_submodule_path to return an error code. For git_pathdup_submodule,
just return NULL when we fail to find a path. For strbuf_git_path_submodule
propagate the error code to the caller.

Modify the callers of these functions to check the error code and fail
properly. This ensures we don't attempt to use a bad path that doesn't
match the corresponding submodule.

Because this change fixes add_submodule_odb to work even if the
submodule is not checked out, update the wording of the submodule log
diff format to correctly display that the submodule is "not initialized"
instead of "not checked out"

Add tests to ensure this change works as expected.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 cache.h                                   |   4 +-
 path.c                                    |  37 +++++++--
 refs/files-backend.c                      |   8 +-
 submodule.c                               |   6 +-
 t/t4059-diff-submodule-not-initialized.sh | 127 ++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 11 deletions(-)
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh

diff --git a/cache.h b/cache.h
index 70428e92d7ed..4f6693afa387 100644
--- a/cache.h
+++ b/cache.h
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
diff --git a/path.c b/path.c
index fe3c4d96c6d8..e9369f75319d 100644
--- a/path.c
+++ b/path.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "dir.h"
 #include "worktree.h"
+#include "submodule-config.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -468,12 +469,16 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
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
+	const struct submodule *sub;
+	int err = 0;
 
 	strbuf_addstr(buf, path);
 	strbuf_complete(buf, '/');
@@ -484,6 +489,17 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
+	if (!is_git_directory(buf->buf)) {
+		gitmodules_config();
+		sub = submodule_from_path(null_sha1, path);
+		if (!sub) {
+			err = SUBMODULE_PATH_ERR_NOT_CONFIGURED;
+			goto cleanup;
+		}
+		strbuf_reset(buf);
+		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
+	}
+
 	strbuf_addch(buf, '/');
 	strbuf_addbuf(&git_submodule_dir, buf);
 
@@ -494,27 +510,36 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 12290d249643..1f34b444af8d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
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
diff --git a/submodule.c b/submodule.c
index 1b5cdfb7e784..6096cf428be7 100644
--- a/submodule.c
+++ b/submodule.c
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
@@ -348,7 +350,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	if (is_null_sha1(two))
 		message = "(submodule deleted)";
 	else if (add_submodule_odb(path))
-		message = "(not checked out)";
+		message = "(not initialized)";
 	else if (is_null_sha1(one))
 		message = "(new submodule)";
 	else if (!(left = lookup_commit_reference(one)) ||
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
new file mode 100755
index 000000000000..cd70fd5192ea
--- /dev/null
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Jacob Keller, based on t4041 by Jens Lehmann
+#
+
+test_description='Test for submodule diff on non-checked out submodule
+
+This test tries to verify that add_submodule_odb works when the submodule was
+initialized previously but the checkout has since been removed.
+'
+
+. ./test-lib.sh
+
+# Tested non-UTF-8 encoding
+test_encoding="ISO8859-1"
+
+# String "added" in German (translated with Google Translate), encoded in UTF-8,
+# used in sample commit log messages in add_file() function below.
+added=$(printf "hinzugef\303\274gt")
+
+add_file () {
+	(
+		cd "$1" &&
+		shift &&
+		for name
+		do
+			echo "$name" >"$name" &&
+			git add "$name" &&
+			test_tick &&
+			# "git commit -m" would break MinGW, as Windows refuse to pass
+			# $test_encoding encoded parameter to git.
+			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
+			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+		done >/dev/null &&
+		git rev-parse --short --verify HEAD
+	)
+}
+
+commit_file () {
+	test_tick &&
+	git commit "$@" -m "Commit $*" >/dev/null
+}
+
+test_expect_success 'setup - submodules' '
+	test_create_repo sm2 &&
+	add_file . foo &&
+	add_file sm2 foo1 foo2 &&
+	smhead1=$(git -C sm2 rev-parse --short --verify HEAD)
+'
+
+test_expect_success 'setup - git submodule add' '
+	git submodule add ./sm2 sm1 &&
+	commit_file sm1 .gitmodules &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD -- sm1 >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule directory removed' '
+	rm -rf sm1 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD -- sm1 >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'setup - submodule multiple commits' '
+	git submodule update --checkout sm1 &&
+	smhead2=$(add_file sm1 foo3 foo4) &&
+	commit_file sm1 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule removed multiple commits' '
+	rm -rf sm1 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule not initialized in new clone' '
+	git clone . sm3 &&
+	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $smhead1...$smhead2 (not initialized)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'setup submodule moved' '
+	git submodule update --checkout sm1 &&
+	git mv sm1 sm4 &&
+	commit_file sm4 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm4 0000000...$smhead2 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule moved then removed' '
+	smhead3=$(add_file sm4 foo6 foo7) &&
+	commit_file sm4 &&
+	rm -rf sm4 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm4 $smhead2..$smhead3:
+	  > Add foo7 ($added foo7)
+	  > Add foo6 ($added foo6)
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.10.0.rc0.259.g83512d9

