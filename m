Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02F11FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758132AbcLQBYg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:24:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:16030 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757457AbcLQBYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:24:35 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,360,1477983600"; 
   d="scan'208";a="1082903354"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 0/5] extend describe and name-rev pattern matching
Date:   Fri, 16 Dec 2016 17:24:26 -0800
Message-Id: <20161217012431.29548-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This series adds support for extending describe and name-rev pattern
matching to allow (a) taking multiple patterns and (b) negative patterns
which discard instead of keep. These changes increase the flexibility of
the describe mechanism so that searching for specific tag formats can be
done more easily.

Changes since v1
* add new patches for negative pattern matching
* tweak the documentation slightly

-- interdiff since v1 --
diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index c85f2811ce28..a89bbde207b2 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -83,11 +83,18 @@ OPTIONS
 --match <pattern>::
	Only consider tags matching the given `glob(7)` pattern,
	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository, or to shrink the scope of
-	searched tags to avoid -rc tags or similar. If given multiple a list
-	of patterns will be accumulated, and tags matching any of the patterns
-	will be considered. Use `--no-match` to clear and reset the list of
-	patterns.
+	leaking private tags from the repository. If given multiple times, a
+	list of patterns will be accumulated, and tags matching any of the
+	patterns will be considered. Use `--no-match` to clear and reset the
+	list of patterns.
+
+--discard <pattern>::
+	Do not consider tags matching the given `glob(7)` pattern, excluding
+	the "refs/tags/" prefix. This can be used to narrow the tag space and
+	find only tags matching some meaningful criteria. If given multiple
+	times, a list of patterns will be accumulated and tags matching any
+	of the patterns will be discarded. Use `--no-discard` to clear and
+	reset the list of patterns.
 
 --always::
	Show uniquely abbreviated commit object as fallback.
diff --git c/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
index 7433627db12d..9b46e5ea9aae 100644
--- c/Documentation/git-name-rev.txt
+++ w/Documentation/git-name-rev.txt
@@ -30,6 +30,13 @@ OPTIONS
	given multiple times, use refs whose names match any of the given shell
	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
+--discard=<pattern>::
+	Do not use any ref whose name matches a given shell pattern. The
+	pattern can be one of branch name, tag name or fully qualified ref
+	name. If given multiple times, discard refs that match any of the given
+	shell patterns. Use `--no-discards` to clear the list of discard
+	patterns.
+
 --all::
	List all commits reachable from all refs
 
diff --git c/builtin/describe.c w/builtin/describe.c
index e3ceab65e273..c09288ee6321 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -29,6 +29,7 @@ static int max_candidates = 10;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
+static struct string_list discard_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *dirty;
 
@@ -130,6 +131,22 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
		return 0;
 
	/*
+	 * If we're given discard patterns, first discard any tag which match
+	 * any of the discard pattern.
+	 */
+	if (discard_patterns.nr) {
+		struct string_list_item *item;
+
+		if (!is_tag)
+			return 0;
+
+		for_each_string_list_item(item, &discard_patterns) {
+			if (!wildmatch(item->string, path + 10, 0, NULL))
+				return 0;
+		}
+	}
+
+	/*
	 * If we're given patterns, accept only tags which match at least one
	 * pattern.
	 */
@@ -140,9 +157,8 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
			return 0;
 
		for_each_string_list_item(item, &patterns) {
-			if (!wildmatch(item->string, path + 10, 0, NULL)) {
+			if (!wildmatch(item->string, path + 10, 0, NULL))
				break;
-			}
 
			/* If we get here, no pattern matched. */
			return 0;
@@ -422,6 +438,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
			    N_("consider <n> most recent tags (default: 10)")),
		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
			   N_("only consider tags matching <pattern>")),
+		OPT_STRING_LIST(0, "discard", &discard_patterns, N_("pattern"),
+			   N_("do not consider tags matching <pattern>")),
		OPT_BOOL(0, "always",        &always,
			N_("show abbreviated commit object as fallback")),
		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
@@ -459,6 +477,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
			argv_array_push(&args, "--tags");
			for_each_string_list_item(item, &patterns)
				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
+			for_each_string_list_item(item, &discard_patterns)
+				argv_array_pushf(&args, "--discard=refs/tags/%s", item->string);
		}
		if (argc)
			argv_array_pushv(&args, argv);
diff --git c/builtin/name-rev.c w/builtin/name-rev.c
index 000a2a700ed3..86479c17a7c9 100644
--- c/builtin/name-rev.c
+++ w/builtin/name-rev.c
@@ -109,6 +109,7 @@ struct name_ref_data {
	int tags_only;
	int name_only;
	struct string_list ref_filters;
+	struct string_list discard_filters;
 };
 
 static struct tip_table {
@@ -150,6 +151,15 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
	if (data->tags_only && !starts_with(path, "refs/tags/"))
		return 0;
 
+	if (data->discard_filters.nr) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, &data->discard_filters) {
+			if (subpath_matches(path, item->string) >= 0)
+				return 0;
+		}
+	}
+
	if (data->ref_filters.nr) {
		struct string_list_item *item;
		int matched = 0;
@@ -323,12 +333,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
	struct object_array revs = OBJECT_ARRAY_INIT;
	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
-	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP };
+	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
	struct option opts[] = {
		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
				   N_("only use refs matching <pattern>")),
+		OPT_STRING_LIST(0, "discard", &data.discard_filters, N_("pattern"),
+				   N_("ignore refs matching <pattern>")),
		OPT_GROUP(""),
		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
diff --git c/t/t6007-rev-list-cherry-pick-file.sh w/t/t6007-rev-list-cherry-pick-file.sh
index d072ec43b016..8a4c35f6ffee 100755
--- c/t/t6007-rev-list-cherry-pick-file.sh
+++ w/t/t6007-rev-list-cherry-pick-file.sh
@@ -118,6 +118,13 @@ test_expect_success 'name-rev --refs excludes non-matched patterns' '
	test_cmp actual.named expect
 '
 
+test_expect_success 'name-rev --discard excludes matched patterns' '
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" --discard="*E" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
 cat >expect <<EOF
 $(git rev-list --left-right --cherry-pick F...E -- bar)
 EOF
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index 9e5db9b87a1f..4e4a9f2e5305 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -218,6 +218,14 @@ test_expect_success 'describe --contains and --match' '
	test_cmp expect actual
 '
 
+test_expect_success 'describe --discard' '
+	echo "c~1" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	test_must_fail git describe --contains --match="B" $tagged_commit &&
+	git describe --contains --match="?" --discard="A" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'describe --contains and --no-match' '
	echo "A^0" >expect &&
	tagged_commit=$(git rev-parse "refs/tags/A^0") &&

Jacob Keller (5):
  doc: add documentation for OPT_STRING_LIST
  name-rev: extend --refs to accept multiple patterns
  name-rev: add support to discard refs by pattern match
  describe: teach --match to accept multiple patterns
  describe: teach describe negative pattern matches

 Documentation/git-describe.txt                | 13 ++++++-
 Documentation/git-name-rev.txt                | 11 +++++-
 Documentation/technical/api-parse-options.txt |  5 +++
 builtin/describe.c                            | 51 ++++++++++++++++++++++----
 builtin/name-rev.c                            | 53 +++++++++++++++++++++------
 t/t6007-rev-list-cherry-pick-file.sh          | 30 +++++++++++++++
 t/t6120-describe.sh                           | 19 ++++++++++
 7 files changed, 161 insertions(+), 21 deletions(-)

-- 
2.11.0.rc2.152.g4d04e67

