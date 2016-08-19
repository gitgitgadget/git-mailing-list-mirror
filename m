Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC762018E
	for <e@80x24.org>; Fri, 19 Aug 2016 02:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755127AbcHSCEE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:04:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:55924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754258AbcHSAyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:17 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP; 18 Aug 2016 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,542,1464678000"; 
   d="scan'208";a="867906875"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2016 17:00:40 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if path is not checked out
Date:   Thu, 18 Aug 2016 17:00:27 -0700
Message-Id: <20160819000031.24854-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160819000031.24854-1-jacob.e.keller@intel.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Currently, do_submodule_path will first try to locate the git directory
using read_gitfile on <path to submodule>/.git. If this fails, it goes
ahead and assumes the path is actually the git directory. This is good
as it allows submodules which aren't stored in the superproject's .git
directory to function correctly. However, in some cases the submodule is
no longer locally checked out, but still has object data stored in the
parent project's .git/modules/<path to submodule>.

To make this work, add code to check if we found a valid git directory.
If we haven't, then try the standard location of module data instead.
This has the advantage of allowing callers of do_submodule_path
(add_submodule_odb) to correctly function even if the submodule isn't
currently checked out, but was previously initialized.

Update the wording of the submodule log diff format to correctly
display that the submodule is "not initialized" instead of "not checked
out"

Add tests to ensure that even once we remove the submodule directory, it
works by checking in the .git directory.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 path.c                                    |   5 ++
 submodule.c                               |   2 +-
 t/t4059-diff-submodule-not-initialized.sh | 105 ++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh

diff --git a/path.c b/path.c
index 17551c483476..0cb30123e988 100644
--- a/path.c
+++ b/path.c
@@ -482,6 +482,11 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
+	if (!is_git_directory(buf->buf)) {
+		strbuf_reset(buf);
+		strbuf_git_path(buf, "%s/%s", "modules", path);
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
index 000000000000..cc787454033a
--- /dev/null
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -0,0 +1,105 @@
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
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+# Tested non-UTF-8 encoding
+test_encoding="ISO8859-1"
+
+# String "added" in German (translated with Google Translate), encoded in UTF-8,
+# used in sample commit log messages in add_file() function below.
+added=$(printf "hinzugef\303\274gt")
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
+commit_file () {
+	test_tick &&
+	git commit "$@" -m "Commit $*" >/dev/null
+}
+
+test_create_repo sm1 &&
+test_create_repo sm2 &&
+add_file sm1 foo >/dev/null &&
+add_file sm2 foo1 foo2 >/dev/null &&
+smhead1=$(cd sm2; git rev-parse --short --verify HEAD) &&
+cd sm1
+
+test_expect_success 'setup - submodule directory' '
+	git submodule add ../sm2 sm2 &&
+	commit_file sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule directory removed' '
+	rm -rf sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'setup - submodule multiple commits' '
+	git submodule update --checkout sm2 &&
+	smhead2=$(add_file sm2 foo3 foo4) &&
+	commit_file sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule removed multiple commits' '
+	rm -rf sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+cd ..
+
+test_expect_success 'submodule not initialized in new clone' '
+	git clone sm1 sm3 &&
+	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1...$smhead2 (not initialized)
+	EOF
+	test_cmp expected actual
+
+'
+
+test_done
-- 
2.10.0.rc0.217.g609f9e8.dirty

