Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8CB620C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 23:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdARXG5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:06:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:21511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbdARXGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:32 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,250,1477983600"; 
   d="scan'208";a="54909594"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 4/5] describe: teach --match to accept multiple patterns
Date:   Wed, 18 Jan 2017 15:06:07 -0800
Message-Id: <20170118230608.28030-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.488.g1cece4bcb7a5
In-Reply-To: <20170118230608.28030-1-jacob.e.keller@intel.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach `--match` to be accepted multiple times, accumulating a list of
patterns to match into a string list. Each pattern is inclusive, such
that a tag need only match one of the provided patterns to be
considered for matching.

This extension is useful as it enables more flexibility in what tags
match, and may avoid the need to run the describe command multiple
times to get the same result.

Add tests and update the documentation for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-describe.txt |  5 ++++-
 builtin/describe.c             | 30 +++++++++++++++++++++++-------
 t/t6120-describe.sh            | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e4ac448ff565..7ad41e2f6ade 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -83,7 +83,10 @@ OPTIONS
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
 	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository.
+	leaking private tags from the repository. If given multiple times, a
+	list of patterns will be accumulated, and tags matching any of the
+	patterns will be considered. Use `--no-match` to clear and reset the
+	list of patterns.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
diff --git a/builtin/describe.c b/builtin/describe.c
index 01490a157efc..5cc9e9abe798 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -28,7 +28,7 @@ static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hashmap names;
 static int have_util;
-static const char *pattern;
+static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *dirty;
 
@@ -129,9 +129,24 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	if (!all && !is_tag)
 		return 0;
 
-	/* Accept only tags that match the pattern, if given */
-	if (pattern && (!is_tag || wildmatch(pattern, path + 10, 0, NULL)))
-		return 0;
+	/*
+	 * If we're given patterns, accept only tags which match at least one
+	 * pattern.
+	 */
+	if (patterns.nr) {
+		struct string_list_item *item;
+
+		if (!is_tag)
+			return 0;
+
+		for_each_string_list_item(item, &patterns) {
+			if (!wildmatch(item->string, path + 10, 0, NULL))
+				break;
+
+			/* If we get here, no pattern matched. */
+			return 0;
+		}
+	}
 
 	/* Is it annotated? */
 	if (!peel_ref(path, peeled.hash)) {
@@ -404,7 +419,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
-		OPT_STRING(0, "match",       &pattern, N_("pattern"),
+		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
 			   N_("only consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
@@ -430,6 +445,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("--long is incompatible with --abbrev=0"));
 
 	if (contains) {
+		struct string_list_item *item;
 		struct argv_array args;
 
 		argv_array_init(&args);
@@ -440,8 +456,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			argv_array_push(&args, "--always");
 		if (!all) {
 			argv_array_push(&args, "--tags");
-			if (pattern)
-				argv_array_pushf(&args, "--refs=refs/tags/%s", pattern);
+			for_each_string_list_item(item, &patterns)
+				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
 		}
 		if (argc)
 			argv_array_pushv(&args, argv);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 85f269411cb3..9e5db9b87a1f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -182,6 +182,10 @@ check_describe "test2-lightweight-*" --tags --match="test2-*"
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
 
+check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
+
+check_describe "test2-lightweight-*" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
+
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
@@ -206,4 +210,19 @@ test_expect_success 'describe --contains with the exact tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains and --match' '
+	echo "A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	test_must_fail git describe --contains --match="B" $tagged_commit &&
+	git describe --contains --match="B" --match="A" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe --contains and --no-match' '
+	echo "A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git describe --contains --match="B" --no-match $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.488.g1cece4bcb7a5

