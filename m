Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF8820960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbdDMRMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:12:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:10607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbdDMRM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:12:28 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP; 13 Apr 2017 10:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,195,1488873600"; 
   d="scan'208";a="77006547"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.158])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2017 10:12:26 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/2] ls-files: fix recurse-submodules with nested submodules
Date:   Thu, 13 Apr 2017 10:12:23 -0700
Message-Id: <20170413171224.3537-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.776.gded3dc243c29.dirty
In-Reply-To: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Since commit e77aa336f116 ("ls-files: optionally recurse into
submodules", 2016-10-07) ls-files has known how to recurse into
submodules when displaying files.

Unfortunately this fails for certain cases, including when nesting more
than one submodule, called from within a submodule that itself has
submodules, or when the GIT_DIR environemnt variable is set.

Prior to commit b58a68c1c187 ("setup: allow for prefix to be passed to
git commands", 2017-03-17) this resulted in an error indicating that
--prefix and --super-prefix were incompatible.

After this commit, instead, the process loops forever with a GIT_DIR set
to the parent and continuously reads the parent submodule files and
recursing forever.

Fix this by preparing the environment properly for submodules when
setting up the child process. This is similar to how other commands such
as grep behave.

This was not caught by the original tests because the scenario is
avoided if the submodules are created separately and not stored as the
standard method of putting the submodule git directory under
.git/modules/<name>. We can update the test to show the failure by the
addition of "git submodule absorbgitdirs" to the test case. However,
note that this new test would run forever without the necessary fix in
this patch.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I updated and reworded the description so that the problem would be more
obvious. It doesn't occur always, but only when run nested with properly
absorbed gitdirs for the submodules. This explains the reason why the
test case had not caught the issue before.

 builtin/ls-files.c                     | 4 ++++
 t/t3007-ls-files-recurse-submodules.sh | 1 +
 2 files changed, 5 insertions(+)

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
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index 4cf6ccf5a8ea..c8030dd3299a 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -77,6 +77,7 @@ test_expect_success 'ls-files recurses more than 1 level' '
 	git -C submodule/subsub commit -m "add d" &&
 	git -C submodule submodule add ./subsub &&
 	git -C submodule commit -m "added subsub" &&
+	git submodule absorbgitdirs &&
 	git ls-files --recurse-submodules >actual &&
 	test_cmp expect actual
 '
-- 
2.12.2.776.gded3dc243c29.dirty

