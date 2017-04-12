Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD9E20970
	for <e@80x24.org>; Wed, 12 Apr 2017 00:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdDLAjR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 20:39:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:14850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbdDLAjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 20:39:15 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP; 11 Apr 2017 17:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,187,1488873600"; 
   d="scan'208";a="1134215529"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.158])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2017 17:39:14 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] ls-files: properly prepare submodule environment
Date:   Tue, 11 Apr 2017 17:39:11 -0700
Message-Id: <20170412003911.1142-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.776.gded3dc243c29.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Since commit e77aa336f116 ("ls-files: optionally recurse into
submodules", 2016-10-07) ls-files has known how to recurse into
submodules when displaying files.

Unfortunately this code does not work as expected. Initially, it
produced results indicating that a --super-prefix can't be used from
a subdirectory:

  fatal: can't use --super-prefix from a subdirectory

After commit b58a68c1c187 ("setup: allow for prefix to be passed to git
commands", 2017-03-17) this behavior changed and resulted in repeated
calls of ls-files with an expanding super-prefix.

This recursive expanding super-prefix appears to be the result of
ls-files acting on the super-project instead of on the submodule files.

We can fix this by properly preparing the submodule environment when
setting up the submodule process. This ensures that the command we
execute properly reads the directory and ensures that we correctly
operate in the submodule instead of repeating oureslves on the
super-project contents forever.

While we're here lets also add some tests to ensure that ls-files works
with recurse-submodules to catch these issues in the future.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I found this fix on accident after looking at git-grep code and
comparing how ls-files instantiated the submodule. Can someone who knows
more about submodules explain the reasoning better for this fix?
Essentially we "recurse" into the submodule folder, but still operate as
if we're at the root of the project but with a new prefix. So then we
keep recursing into the submodule forever.

I also added some tests here, and I *definitely* think this should be a
maintenance backport into any place which supports ls-files
--recurse-submodules, since as far as I can tell it is otherwise
useless.

There were no tests for it, so I added some based on git-grep tests. I
did not try them against the broken setups, because of the endless
recursion.

 builtin/ls-files.c                     |   4 +
 t/t3080-ls-files-recurse-submodules.sh | 162 +++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100755 t/t3080-ls-files-recurse-submodules.sh

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db551..e9b3546ca053 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "pathspec.h"
 #include "run-command.h"
+#include "submodule.h"
 
 static int abbrev;
 static int show_deleted;
@@ -203,6 +204,9 @@ static void show_gitlink(const struct cache_entry *ce)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
 
+	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
+
 	if (prefix_len)
 		argv_array_pushf(&cp.env_array, "%s=%s",
 				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
diff --git a/t/t3080-ls-files-recurse-submodules.sh b/t/t3080-ls-files-recurse-submodules.sh
new file mode 100755
index 000000000000..6788a8f09635
--- /dev/null
+++ b/t/t3080-ls-files-recurse-submodules.sh
@@ -0,0 +1,162 @@
+#!/bin/sh
+
+test_description='Test ls-files recurse-submodules feature
+
+This test verifies the recurse-submodules feature correctly lists files across
+submodules.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup directory structure and submodule' '
+	echo "foobar" >a &&
+	mkdir b &&
+	echo "bar" >b/b &&
+	git add a b &&
+	git commit -m "add a and b" &&
+	git init submodule &&
+	echo "foobar" >submodule/a &&
+	git -C submodule add a &&
+	git -C submodule commit -m "add a" &&
+	git submodule add ./submodule &&
+	git commit -m "added submodule"
+'
+
+test_expect_success 'ls-files correctly lists files in a submodule' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/a
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files and basic pathspecs' '
+	cat >expect <<-\EOF &&
+	submodule/a
+	EOF
+
+	git ls-files --recurse-submodules -- submodule >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files and nested submodules' '
+	git init submodule/sub &&
+	echo "foobar" >submodule/sub/a &&
+	git -C submodule/sub add a &&
+	git -C submodule/sub commit -m "add a" &&
+	git -C submodule submodule add ./sub &&
+	git -C submodule add sub &&
+	git -C submodule commit -m "added sub" &&
+	git add submodule &&
+	git commit -m "updated submodule" &&
+
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/.gitmodules
+	submodule/a
+	submodule/sub/a
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files using relative path' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file2 &&
+	git -C parent add src/file2 &&
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add files and submodule" &&
+
+	# From top works
+	cat >expect <<-\EOF &&
+	.gitmodules
+	file
+	src/file2
+	sub/file
+	EOF
+	git -C parent ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top
+	cat >expect <<-\EOF &&
+	../.gitmodules
+	../file
+	file2
+	../sub/file
+	EOF
+	git -C parent/src ls-files --recurse-submodules .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule
+	cat >expect <<-\EOF &&
+	../sub/file
+	EOF
+	git -C parent/src ls-files --recurse-submodules ../sub >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files from a subdir' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file &&
+	git -C parent add src/file &&
+	git -C parent submodule add ../sub src/sub &&
+	git -C parent submodule add ../sub sub &&
+	git -C parent commit -m "add files and submodules" &&
+
+	# Verify grep from root works
+	cat >expect <<-\EOF &&
+	.gitmodules
+	src/file
+	src/sub/file
+	sub/file
+	EOF
+	git -C parent ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	# Verify grep from a subdir works
+	cat >expect <<-\EOF &&
+	file
+	sub/file
+	EOF
+	git -C parent/src ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_incompatible_with_recurse_submodules ()
+{
+	test_expect_success "--recurse-submodules and $1 are incompatible" "
+		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
+		test_i18ngrep -- '--recurse-submodules unsupported mode' actual
+	"
+}
+
+test_incompatible_with_recurse_submodules --deleted
+test_incompatible_with_recurse_submodules --others
+test_incompatible_with_recurse_submodules --unmerged
+test_incompatible_with_recurse_submodules --killed
+test_incompatible_with_recurse_submodules --modified
+
+test_done
-- 
2.12.2.776.gded3dc243c29.dirty

