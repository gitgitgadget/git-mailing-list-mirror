Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DE920259
	for <e@80x24.org>; Wed,  7 Dec 2016 02:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbcLGCeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 21:34:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:30614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbcLGCeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 21:34:20 -0500
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP; 06 Dec 2016 18:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,310,1477983600"; 
   d="scan'208";a="37746635"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2016 18:33:05 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 2/2] describe: add support for multiple match patterns
Date:   Tue,  6 Dec 2016 18:32:59 -0800
Message-Id: <20161207023259.29355-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161207023259.29355-1-jacob.e.keller@intel.com>
References: <20161207023259.29355-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Convert "--match" into a string list that accumulates patterns. If any
patterns are given, then include all tags that match at least one
pattern. This allows the user to construct multiple small patterns and
compose them. If desired, a future patch could expand functionality by
adding a new option to determine the style of combining multiple
patterns.

The primary use of this feature can be seen when trying to find which
release tag a given commit made it into. Suppose that you version all
your official releases such as "v1.2", "v1.3", "v1.4", "v2.1" and so on.
Now, you also have other tags which represent -rc releases and other
such tags. If you want to find the first major release that contains
a given commit you might try

git describe --contains --match="v?.?" <commit>

This will work as long as you have only single digits. But if you start
adding multiple digits, the pattern becomes not enough to match all the
tags you wanted while excluding the ones you didn't.

By implementing multiple --match invocations, this can be avoided by
simply passing multiple match patterns to the command:

git describe --contains --match="v[0-9].[0-9]" --match="v[0-9].[0-9][0-9]" ...

The end result is the ability to easily search tag space for which
tag included a given commit, without including -rc and other tags which
aren't interesting to you.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-describe.txt |  6 +++++-
 builtin/describe.c             | 31 ++++++++++++++++++++++++-------
 t/t6120-describe.sh            | 19 +++++++++++++++++++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e4ac448ff565..c85f2811ce28 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -83,7 +83,11 @@ OPTIONS
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
 	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository.
+	leaking private tags from the repository, or to shrink the scope of
+	searched tags to avoid -rc tags or similar. If given multiple a list
+	of patterns will be accumulated, and tags matching any of the patterns
+	will be considered. Use `--no-match` to clear and reset the list of
+	patterns.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
diff --git a/builtin/describe.c b/builtin/describe.c
index 01490a157efc..e3ceab65e273 100644
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
 
@@ -129,9 +129,25 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
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
+			if (!wildmatch(item->string, path + 10, 0, NULL)) {
+				break;
+			}
+
+			/* If we get here, no pattern matched. */
+			return 0;
+		}
+	}
 
 	/* Is it annotated? */
 	if (!peel_ref(path, peeled.hash)) {
@@ -404,7 +420,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
-		OPT_STRING(0, "match",       &pattern, N_("pattern"),
+		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
 			   N_("only consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
@@ -430,6 +446,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("--long is incompatible with --abbrev=0"));
 
 	if (contains) {
+		struct string_list_item *item;
 		struct argv_array args;
 
 		argv_array_init(&args);
@@ -440,8 +457,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
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
2.11.0.rc2.152.g4d04e67

