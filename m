Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7146920960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdDMRMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:12:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:10607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbdDMRM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:12:29 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP; 13 Apr 2017 10:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,195,1488873600"; 
   d="scan'208";a="77006548"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.158])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2017 10:12:26 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
Date:   Thu, 13 Apr 2017 10:12:24 -0700
Message-Id: <20170413171224.3537-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.776.gded3dc243c29.dirty
In-Reply-To: <20170413171224.3537-1-jacob.e.keller@intel.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Don't assume that the current working directory is the root of the
repository. Correctly generate the path for the recursing child
processes by building it from the work_tree() root instead. Otherwise if
we run ls-files using --git-dir or --work-tree it will not work
correctly as it attempts to change directory into a potentially invalid
location. Best case, it doesn't exist and we produce an error. Worst
case we cd into the wrong location and unknown behavior occurs.

Add a new test which highlights this possibility.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I'm not sure that I'm convinced by this method of solving the problem as
I suspect it has some corner cases (what about when run inside a
subdirectory? It seems to work for me but I'm not sure...) Additionally,
it felt weird that there's no helper function for creating a toplevel
relative path.

 builtin/ls-files.c                     |  5 ++++-
 t/t3007-ls-files-recurse-submodules.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e9b3546ca053..a6c70dbe9ec8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -203,6 +203,7 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	char *dir;
 
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
@@ -221,8 +222,10 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_pushv(&cp.args, submodule_options.argv);
 
 	cp.git_cmd = 1;
-	cp.dir = ce->name;
+	dir = mkpathdup("%s/%s", get_git_work_tree(), ce->name);
+	cp.dir = dir;
 	status = run_command(&cp);
+	free(dir);
 	if (status)
 		exit(status);
 }
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index c8030dd3299a..ebb956fd16cc 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -82,6 +82,17 @@ test_expect_success 'ls-files recurses more than 1 level' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files works with GIT_DIR' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	c
+	subsub/d
+	EOF
+
+	git --git-dir=submodule/.git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--recurse-submodules and pathspecs setup' '
 	echo e >submodule/subsub/e.txt &&
 	git -C submodule/subsub add e.txt &&
-- 
2.12.2.776.gded3dc243c29.dirty

