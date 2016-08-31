Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B78D1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 23:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761117AbcHaXcN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 19:32:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:26661 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760925AbcHaXcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 19:32:12 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP; 31 Aug 2016 16:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,264,1470726000"; 
   d="scan'208";a="3559536"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2016 16:27:29 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v12 0/8] submodule inline diff format
Date:   Wed, 31 Aug 2016 16:27:17 -0700
Message-Id: <20160831232725.28205-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc2.311.g2bd286e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Hopefully the final revision here. I've squashed in the memory leak fix
suggested by Stefan, and the suggested changes from Junio, including his
re-worded commit messages.

interdiff between v11 and v12
diff --git c/path.c w/path.c
index 3dbc4478a4aa..ba60c9849ef7 100644
--- c/path.c
+++ w/path.c
@@ -467,7 +467,7 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	return pathname->buf;
 }
 
-/* Returns 0 on success, non-zero on failure. */
+/* Returns 0 on success, negative on failure. */
 #define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
 static int do_submodule_path(struct strbuf *buf, const char *path,
 			     const char *fmt, va_list args)
@@ -523,8 +523,10 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	va_start(args, fmt);
 	err = do_submodule_path(&buf, path, fmt, args);
 	va_end(args);
-	if (err)
+	if (err) {
+		strbuf_release(&buf);
 		return NULL;
+	}
 	return strbuf_detach(&buf, NULL);
 }
 
-------->8

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
 path.c                                             |  39 +-
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
 20 files changed, 1666 insertions(+), 164 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh
 create mode 100755 t/t4060-diff-submodule-option-diff-format.sh

-- 
2.10.0.rc2.311.g2bd286e

