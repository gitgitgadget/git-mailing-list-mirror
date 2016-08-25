Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CB41F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758168AbcHYXg5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:36:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:61121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757271AbcHYXgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:36:55 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062169"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:47 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 6/8] submodule: convert show_submodule_summary to use struct object_id *
Date:   Thu, 25 Aug 2016 16:32:41 -0700
Message-Id: <20160825233243.30700-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Since we're going to be changing this function in a future patch, lets
go ahead and convert this to use object_id now.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 diff.c      |  2 +-
 submodule.c | 16 ++++++++--------
 submodule.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index d6b321da3d1d..16253b191f53 100644
--- a/diff.c
+++ b/diff.c
@@ -2307,7 +2307,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one->path ? one->path : two->path,
 				line_prefix,
-				one->oid.hash, two->oid.hash,
+				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
diff --git a/submodule.c b/submodule.c
index 6096cf428be7..7cb236b0a108 100644
--- a/submodule.c
+++ b/submodule.c
@@ -337,7 +337,7 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
 {
@@ -347,14 +347,14 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
 
-	if (is_null_sha1(two))
+	if (is_null_oid(two))
 		message = "(submodule deleted)";
 	else if (add_submodule_odb(path))
 		message = "(not initialized)";
-	else if (is_null_sha1(one))
+	else if (is_null_oid(one))
 		message = "(new submodule)";
-	else if (!(left = lookup_commit_reference(one)) ||
-		 !(right = lookup_commit_reference(two)))
+	else if (!(left = lookup_commit_reference(one->hash)) ||
+		 !(right = lookup_commit_reference(two->hash)))
 		message = "(commits not present)";
 	else if (prepare_submodule_summary(&rev, path, left, right,
 					   &fast_forward, &fast_backward))
@@ -367,16 +367,16 @@ void show_submodule_summary(FILE *f, const char *path,
 		fprintf(f, "%sSubmodule %s contains modified content\n",
 			line_prefix, path);
 
-	if (!hashcmp(one, two)) {
+	if (!oidcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
 	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
-			find_unique_abbrev(one, DEFAULT_ABBREV));
+			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
-	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s", find_unique_abbrev(two->hash, DEFAULT_ABBREV));
 	if (message)
 		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
diff --git a/submodule.h b/submodule.h
index 2af939099819..d83df57e24ff 100644
--- a/submodule.h
+++ b/submodule.h
@@ -43,7 +43,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
-- 
2.10.0.rc0.259.g83512d9

