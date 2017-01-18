Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BA320756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbdARAIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:08:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:59468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbdARAEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:04:22 -0500
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP; 17 Jan 2017 16:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,247,1477983600"; 
   d="scan'208";a="55122129"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2017 16:03:56 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 0/5] extend git-describe pattern matching
Date:   Tue, 17 Jan 2017 16:03:40 -0800
Message-Id: <20170118000345.31196-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git describe and git name-rev the ability to match multiple
patterns inclusively. Additionally, teach these commands to also accept
negative patterns to exclude any refs which match.

The pattern lists for positive and negative patterns are inclusive. This
means that for the positive patterns, a reference will be considered as
long as it matches at least one of the match patterns. It need not match
all given patterns. Additionally for negative patterns, we will not
consider any ref which matches any negative pattern, even if it matches
one of the positive patterns.

Together this allows the ability to express far more sets of tags than a
single match pattern alone. It does not provide quite the same depth as
would teaching full regexp but it is simpler and easy enough to
understand.

- v2
* use --exclude instead of --discard
* use modern style in tests

I chose *not* to implement the suggestion of ordered values for exclude
and match, since this is not how the current implementation of
git-describe worked, and it didn't really make sense to me what was
being requested. I looked at the interface for git-log, and it appears
that the command accepts multiple invocations of --branches, --remotes,
and similar. I do not believe these need to be identical interfaces. I
welcome feedback on this decision, but I am not convinced yet that the
ordered arguments are worth the trouble.

diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index a89bbde207b2..21a43b78924a 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -88,12 +88,12 @@ OPTIONS
	patterns will be considered. Use `--no-match` to clear and reset the
	list of patterns.
 
---discard <pattern>::
+--exclude <pattern>::
	Do not consider tags matching the given `glob(7)` pattern, excluding
	the "refs/tags/" prefix. This can be used to narrow the tag space and
	find only tags matching some meaningful criteria. If given multiple
	times, a list of patterns will be accumulated and tags matching any
-	of the patterns will be discarded. Use `--no-discard` to clear and
+	of the patterns will be excluded. Use `--no-exclude` to clear and
	reset the list of patterns.
 
 --always::
diff --git c/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
index 9b46e5ea9aae..301b4a8d55e6 100644
--- c/Documentation/git-name-rev.txt
+++ w/Documentation/git-name-rev.txt
@@ -30,11 +30,11 @@ OPTIONS
	given multiple times, use refs whose names match any of the given shell
	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
---discard=<pattern>::
+--exclude=<pattern>::
	Do not use any ref whose name matches a given shell pattern. The
	pattern can be one of branch name, tag name or fully qualified ref
-	name. If given multiple times, discard refs that match any of the given
-	shell patterns. Use `--no-discards` to clear the list of discard
+	name. If given multiple times, exclude refs that match any of the given
+	shell patterns. Use `--no-exclude` to clear the list of exclude
	patterns.
 
 --all::
diff --git c/Documentation/technical/api-parse-options.txt w/Documentation/technical/api-parse-options.txt
index 15e876e4c804..6914f54f5f44 100644
--- c/Documentation/technical/api-parse-options.txt
+++ w/Documentation/technical/api-parse-options.txt
@@ -169,9 +169,9 @@ There are some macros to easily define options:
	The string argument is put into `str_var`.
 
 `OPT_STRING_LIST(short, long, &list, arg_str, description)`::
-	Introduce an option with a string argument. Repeated invocations
-	accumulate into a list of strings. Reset and clear the list with
-	`--no-option`.
+	Introduce an option with string argument.
+	The string argument is stored as an element in `&list` which must be a
+	struct string_list. Reset the list using `--no-option`.
 
 `OPT_INTEGER(short, long, &int_var, description)`::
	Introduce an option with integer argument.
diff --git c/builtin/describe.c w/builtin/describe.c
index c09288ee6321..6769446e1f57 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -29,7 +29,7 @@ static int max_candidates = 10;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
-static struct string_list discard_patterns = STRING_LIST_INIT_NODUP;
+static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *dirty;
 
@@ -131,16 +131,16 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
		return 0;
 
	/*
-	 * If we're given discard patterns, first discard any tag which match
-	 * any of the discard pattern.
+	 * If we're given exclude patterns, first exclude any tag which match
+	 * any of the exclude pattern.
	 */
-	if (discard_patterns.nr) {
+	if (exclude_patterns.nr) {
		struct string_list_item *item;
 
		if (!is_tag)
			return 0;
 
-		for_each_string_list_item(item, &discard_patterns) {
+		for_each_string_list_item(item, &exclude_patterns) {
			if (!wildmatch(item->string, path + 10, 0, NULL))
				return 0;
		}
@@ -438,7 +438,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
			    N_("consider <n> most recent tags (default: 10)")),
		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
			   N_("only consider tags matching <pattern>")),
-		OPT_STRING_LIST(0, "discard", &discard_patterns, N_("pattern"),
+		OPT_STRING_LIST(0, "exclude", &exclude_patterns, N_("pattern"),
			   N_("do not consider tags matching <pattern>")),
		OPT_BOOL(0, "always",        &always,
			N_("show abbreviated commit object as fallback")),
@@ -477,8 +477,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
			argv_array_push(&args, "--tags");
			for_each_string_list_item(item, &patterns)
				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
-			for_each_string_list_item(item, &discard_patterns)
-				argv_array_pushf(&args, "--discard=refs/tags/%s", item->string);
+			for_each_string_list_item(item, &exclude_patterns)
+				argv_array_pushf(&args, "--exclude=refs/tags/%s", item->string);
		}
		if (argc)
			argv_array_pushv(&args, argv);
diff --git c/builtin/name-rev.c w/builtin/name-rev.c
index 86479c17a7c9..da4a0d7c0fdf 100644
--- c/builtin/name-rev.c
+++ w/builtin/name-rev.c
@@ -109,7 +109,7 @@ struct name_ref_data {
	int tags_only;
	int name_only;
	struct string_list ref_filters;
-	struct string_list discard_filters;
+	struct string_list exclude_filters;
 };
 
 static struct tip_table {
@@ -151,10 +151,10 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
	if (data->tags_only && !starts_with(path, "refs/tags/"))
		return 0;
 
-	if (data->discard_filters.nr) {
+	if (data->exclude_filters.nr) {
		struct string_list_item *item;
 
-		for_each_string_list_item(item, &data->discard_filters) {
+		for_each_string_list_item(item, &data->exclude_filters) {
			if (subpath_matches(path, item->string) >= 0)
				return 0;
		}
@@ -339,7 +339,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
				   N_("only use refs matching <pattern>")),
-		OPT_STRING_LIST(0, "discard", &data.discard_filters, N_("pattern"),
+		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
				   N_("ignore refs matching <pattern>")),
		OPT_GROUP(""),
		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
diff --git c/t/t6007-rev-list-cherry-pick-file.sh w/t/t6007-rev-list-cherry-pick-file.sh
index 8a4c35f6ffee..83838d0da208 100755
--- c/t/t6007-rev-list-cherry-pick-file.sh
+++ w/t/t6007-rev-list-cherry-pick-file.sh
@@ -100,42 +100,43 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 '
 
 test_expect_success 'name-rev multiple --refs combine inclusive' '
-	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
-		< actual > actual.named &&
+		<actual >actual.named &&
	test_cmp actual.named expect
 '
 
 cat >expect <<EOF
 <tags/F
-$(git rev-list --left-right --right-only --cherry-pick F...E -- bar)
 EOF
 
 test_expect_success 'name-rev --refs excludes non-matched patterns' '
-	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
	git name-rev --stdin --name-only --refs="*tags/F" \
-		< actual > actual.named &&
-	test_cmp actual.named expect
-'
-
-test_expect_success 'name-rev --discard excludes matched patterns' '
-	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" --discard="*E" \
-		< actual > actual.named &&
+		<actual >actual.named &&
	test_cmp actual.named expect
 '
 
 cat >expect <<EOF
-$(git rev-list --left-right --cherry-pick F...E -- bar)
+<tags/F
 EOF
 
-test_expect_success 'name-rev --no-refs clears the refs list' '
-	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
-		< actual > actual.named &&
+test_expect_success 'name-rev --exclude excludes matched patterns' '
+	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
+		<actual >actual.named &&
	test_cmp actual.named expect
 '
 
+test_expect_success 'name-rev --no-refs clears the refs list' '
+	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
+	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
+		<actual >actual &&
+	test_cmp actual expect
+'
+
 cat >expect <<EOF
 +tags/F
 =tags/D
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index 4e4a9f2e5305..167491fd5b0d 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -218,11 +218,11 @@ test_expect_success 'describe --contains and --match' '
	test_cmp expect actual
 '
 
-test_expect_success 'describe --discard' '
+test_expect_success 'describe --exclude' '
	echo "c~1" >expect &&
	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
	test_must_fail git describe --contains --match="B" $tagged_commit &&
-	git describe --contains --match="?" --discard="A" $tagged_commit >actual &&
+	git describe --contains --match="?" --exclude="A" $tagged_commit >actual &&
	test_cmp expect actual
 '
 

Jacob Keller (5):
  doc: add documentation for OPT_STRING_LIST
  name-rev: extend --refs to accept multiple patterns
  name-rev: add support to exclude refs by pattern match
  describe: teach --match to accept multiple patterns
  describe: teach describe negative pattern matches

 Documentation/git-describe.txt                | 13 ++++++-
 Documentation/git-name-rev.txt                | 11 +++++-
 Documentation/technical/api-parse-options.txt |  5 +++
 builtin/describe.c                            | 51 ++++++++++++++++++++++----
 builtin/name-rev.c                            | 53 +++++++++++++++++++++------
 t/t6007-rev-list-cherry-pick-file.sh          | 38 +++++++++++++++++++
 t/t6120-describe.sh                           | 27 ++++++++++++++
 7 files changed, 177 insertions(+), 21 deletions(-)

-- 
2.11.0.403.g196674b8396b

