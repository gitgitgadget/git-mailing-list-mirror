Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6294D2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 23:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755665AbcHSXfh (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 19:35:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:6539 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754491AbcHSXff (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 19:35:35 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2016 16:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,547,1464678000"; 
   d="scan'208";a="1044481258"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2016 16:34:37 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v9 4/8] diff: prepare for additional submodule formats
Date:   Fri, 19 Aug 2016 16:34:28 -0700
Message-Id: <20160819233432.15188-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160819233432.15188-1-jacob.e.keller@intel.com>
References: <20160819233432.15188-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

A future patch will add a new format for displaying the difference of
a submodule. Make it easier by changing how we store the current
selected format. Replace the DIFF_OPT flag with an enumeration, as each
format will be mutually exclusive.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 diff.c | 12 ++++++------
 diff.h |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index e57cf39ad109..d6b321da3d1d 100644
--- a/diff.c
+++ b/diff.c
@@ -132,9 +132,9 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 static int parse_submodule_params(struct diff_options *options, const char *value)
 {
 	if (!strcmp(value, "log"))
-		DIFF_OPT_SET(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_LOG;
 	else if (!strcmp(value, "short"))
-		DIFF_OPT_CLR(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_SHORT;
 	else
 		return -1;
 	return 0;
@@ -2300,9 +2300,9 @@ static void builtin_diff(const char *name_a,
 	struct strbuf header = STRBUF_INIT;
 	const char *line_prefix = diff_line_prefix(o);
 
-	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
-			(!one->mode || S_ISGITLINK(one->mode)) &&
-			(!two->mode || S_ISGITLINK(two->mode))) {
+	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
+	    (!one->mode || S_ISGITLINK(one->mode)) &&
+	    (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one->path ? one->path : two->path,
@@ -3916,7 +3916,7 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
-		DIFF_OPT_SET(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_LOG;
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
diff --git a/diff.h b/diff.h
index 1f57aad25c71..43b353aea091 100644
--- a/diff.h
+++ b/diff.h
@@ -83,7 +83,6 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
-#define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
@@ -110,6 +109,11 @@ enum diff_words_type {
 	DIFF_WORDS_COLOR
 };
 
+enum diff_submodule_format {
+	DIFF_SUBMODULE_SHORT = 0,
+	DIFF_SUBMODULE_LOG
+};
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -157,6 +161,7 @@ struct diff_options {
 	int stat_count;
 	const char *word_regex;
 	enum diff_words_type word_diff;
+	enum diff_submodule_format submodule_format;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
-- 
2.10.0.rc0.259.g83512d9

