Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D5820C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbdLGA7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:59:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:54924 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdLGA7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:59:35 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2017 16:59:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,370,1508828400"; 
   d="scan'208";a="10239758"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.177.172])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2017 16:59:35 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] diff: fix --relative without arguments
Date:   Wed,  6 Dec 2017 16:59:29 -0800
Message-Id: <20171207005929.24109-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.15.1.477.g3ed0a2a61da8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Recently, commit f7923a5ece00 ("diff: use skip_to_optional_val()",
2017-12-04) changed how we parsed some diff options, preferring
skip_to_optional_val instead of a more complex skip_prefix() setup.

Unfortunately, this breaks --relative, because of the semantics of
skip_to_optional_val. If no optional_val is given, then the function
puts the empty string "" into the arg. Unfortunately, relative passes in
options->prefix as the location for the optional argument, and expects
this value to remain unchanged if no optional value was given.

This results in breaking --relative when no arguments are provided. This
cascades into many failures of code flow that rely on this.

Partially revert the commit, and restore --relative option parsing to
the previous working code.

Since no tests exist for --relative without options, add a new test
which will help ensure no future regressions.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Actually perform the revert of --relative handling.

 diff.c                   | 6 +++++-
 t/t4045-diff-relative.sh | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b62e4b61b564..1919afb4f104 100644
--- a/diff.c
+++ b/diff.c
@@ -4581,8 +4581,12 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.rename_empty = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
 		options->flags.rename_empty = 0;
-	else if (skip_to_optional_val(arg, "--relative", &options->prefix))
+	else if (!strcmp(arg, "--relative"))
 		options->flags.relative_name = 1;
+	else if (skip_prefix(arg, "--relative=", &arg)) {
+		options->flags.relative_name = 1;
+		options->prefix = arg;
+	}
 
 	/* xdiff options */
 	else if (!strcmp(arg, "--minimal"))
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f5034d31..41e4f59b2ffb 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -70,4 +70,9 @@ for type in diff numstat stat raw; do
 	check_$type dir/file2 --relative=sub
 done
 
+cd subdir
+for type in diff numstat stat raw; do
+	check_$type file2 --relative
+done
+
 test_done
-- 
2.15.1.477.g3ed0a2a61da8

