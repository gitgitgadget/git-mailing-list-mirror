Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4B81F859
	for <e@80x24.org>; Mon, 22 Aug 2016 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756952AbcHVXnx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 19:43:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:38849 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756831AbcHVXnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 19:43:49 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP; 22 Aug 2016 16:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,562,1464678000"; 
   d="scan'208";a="706789"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2016 16:43:45 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v10 6/9] allow do_submodule_path to work even if submodule isn't checked out
Date:   Mon, 22 Aug 2016 16:43:41 -0700
Message-Id: <20160822234344.22797-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160822234344.22797-1-jacob.e.keller@intel.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
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

If we can't find this, just leave it alone and let the caller of
do_submodule_path handle a missing directory normally.

It might be worth adding a die() call here, but that seems a bit
overkill.

Because this change fixes add_submodule_odb to work even if the
submodule is not checked out, update the wording of the submodule log
diff format to correctly display that the submodule is "not initialized"
instead of "not checked out"

Add tests to ensure this change works as expected.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 path.c                                    |  11 +++
 submodule.c                               |   2 +-
 t/t4059-diff-submodule-not-initialized.sh | 127 ++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh

diff --git a/path.c b/path.c
index fe3c4d96c6d8..07dd0f62eb82 100644
--- a/path.c
+++ b/path.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "dir.h"
 #include "worktree.h"
+#include "submodule-config.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -474,6 +475,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	const char *git_dir;
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
+	const struct submodule *sub;
 
 	strbuf_addstr(buf, path);
 	strbuf_complete(buf, '/');
@@ -484,6 +486,15 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
+	if (!is_git_directory(buf->buf)) {
+		sub = submodule_from_path(null_sha1, path);
+		if (sub) {
+			strbuf_reset(buf);
+			strbuf_git_path(buf, "%s/%s", "modules",
+					sub->name);
+		}
+	}
+
 	strbuf_addch(buf, '/');
 	strbuf_addbuf(&git_submodule_dir, buf);
 
diff --git a/submodule.c b/submodule.c
index 1b5cdfb7e784..e1a51b7506ff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
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
index 000000000000..c8775854d3c2
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
+	commit_file sm1 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule directory removed' '
+	rm -rf sm1 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
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

