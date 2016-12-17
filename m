Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC30F1FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbcLQAyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:54:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:21446 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934201AbcLQAyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:54:45 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP; 16 Dec 2016 16:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,360,1477983600"; 
   d="scan'208";a="1100258506"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2016 16:54:43 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Norbert Kiesel <nkiesel@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] diff: prefer indent heuristic over compaction heuristic
Date:   Fri, 16 Dec 2016 16:54:42 -0800
Message-Id: <20161217005442.5866-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The current configuration code for enabling experimental heuristics
prefers the last-set heuristic in the configuration. However, it is not
necessarily easy to see what order the configuration will be read. This
means that it is possible for a user to have accidentally enabled both
heuristics, and end up only enabling the older compaction heuristic.

Modify the code so that we do not clear the other heuristic when we set
each heuristic enabled. Then, during diff_setup() when we check the
configuration, we will first check the newer indent heuristic. This
ensures that we only enable the newer heuristic if both have been
enabled.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 diff.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index ec8728362dae..48a5b2797e3d 100644
--- a/diff.c
+++ b/diff.c
@@ -223,16 +223,10 @@ void init_diff_ui_defaults(void)
 
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.indentheuristic")) {
+	if (!strcmp(var, "diff.indentheuristic"))
 		diff_indent_heuristic = git_config_bool(var, value);
-		if (diff_indent_heuristic)
-			diff_compaction_heuristic = 0;
-	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
+	if (!strcmp(var, "diff.compactionheuristic"))
 		diff_compaction_heuristic = git_config_bool(var, value);
-		if (diff_compaction_heuristic)
-			diff_indent_heuristic = 0;
-	}
 	return 0;
 }
 
-- 
2.11.0.rc2.152.g4d04e67

