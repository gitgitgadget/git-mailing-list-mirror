Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D593520A28
	for <e@80x24.org>; Wed, 20 Sep 2017 01:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbdITBKy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 21:10:54 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:36804
        "EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750733AbdITBKx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 21:10:53 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id uTWqdLwfzkEGpuTWudbPol; Tue, 19 Sep 2017 18:10:22 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH v2] describe: teach --match to handle branches and remotes
Date:   Wed, 20 Sep 2017 04:10:10 +0300
Message-Id: <20170920011010.10399-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-reply-to: <20170920010719.GA12408@jessie.local>
X-CMAE-Envelope: MS4wfLjrGk2VUTVIpjuXsNy1PqtV6TKmnFIjWiwdsUyS/vay52TBQtJmt3WyuUXuseLIPvkT/l0Lf5vFHf9QZqphE83UTSOJufZPAf9Rb7rs49Mk3J3lCjMN
 a7zgRAtvPGN3ok46FxVjdjplj8U/2R5AHghq/zcdyFP24K6h8vA6W8gQ1w6MKyBGKITOGbrN4gDQb1p7uTkBgIulSDDc0xJ8Ik/sxqVet2D7Ly92RueC+SQL
 cya7bsaYYVTwGPmFWBDgLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git describe` uses `--match`, it matches only tags, basically
ignoring the `--all` argument even when it is specified.

Fix it by also matching branch name and $remote_name/$remote_branch_name,
for remote-tracking references, with the specified patterns. Update
documentation accordingly and add tests.

Signed-off-by: Max Kirillov <max@max630.net>
---
Changed to use skip_prefix(). Calculate path_to_match only once.

Add case of discarding unknown type with exclude
 Documentation/git-describe.txt | 24 ++++++++++++++----------
 builtin/describe.c             | 29 +++++++++++++++++------------
 t/t6120-describe.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 26f19d3b07..c924c945ba 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -87,19 +87,23 @@ OPTIONS
 
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository. If given multiple times, a
-	list of patterns will be accumulated, and tags matching any of the
-	patterns will be considered. Use `--no-match` to clear and reset the
-	list of patterns.
+	excluding the "refs/tags/" prefix. If used with `--all`, it also
+	considers local branches and remote-tracking references matching the
+	pattern, excluding respectively "refs/heads/" and "refs/remotes/"
+	prefix; references of other types are never considered. If given
+	multiple times, a list of patterns will be accumulated, and tags
+	matching any of the patterns will be considered.  Use `--no-match` to
+	clear and reset the list of patterns.
 
 --exclude <pattern>::
 	Do not consider tags matching the given `glob(7)` pattern, excluding
-	the "refs/tags/" prefix. This can be used to narrow the tag space and
-	find only tags matching some meaningful criteria. If given multiple
-	times, a list of patterns will be accumulated and tags matching any
-	of the patterns will be excluded. When combined with --match a tag will
-	be considered when it matches at least one --match pattern and does not
+	the "refs/tags/" prefix. If used with `--all`, it also does not consider
+	local branches and remote-tracking references matching the pattern,
+	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
+	references of other types are never considered. If given multiple times,
+	a list of patterns will be accumulated and tags matching any of the
+	patterns will be excluded. When combined with --match a tag will be
+	considered when it matches at least one --match pattern and does not
 	match any of the --exclude patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 42afa1e244..f15b6e531d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -129,13 +129,24 @@ static void add_to_known_names(const char *path,
 
 static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
-	int is_tag = starts_with(path, "refs/tags/");
+	int is_tag = 0;
 	struct object_id peeled;
 	int is_annotated, prio;
-
-	/* Reject anything outside refs/tags/ unless --all */
-	if (!all && !is_tag)
+	const char *path_to_match = NULL;
+
+	if (skip_prefix(path, "refs/tags/", &path_to_match)) {
+		is_tag = 1;
+	} else if (all) {
+		if ((exclude_patterns.nr || patterns.nr) &&
+		    !skip_prefix(path, "refs/heads/", &path_to_match) &&
+		    !skip_prefix(path, "refs/remotes/", &path_to_match)) {
+			/* Only accept reference of known type if there are match/exclude patterns */
+			return 0;
+		}
+	} else {
+		/* Reject anything outside refs/tags/ unless --all */
 		return 0;
+	}
 
 	/*
 	 * If we're given exclude patterns, first exclude any tag which match
@@ -144,11 +155,8 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	if (exclude_patterns.nr) {
 		struct string_list_item *item;
 
-		if (!is_tag)
-			return 0;
-
 		for_each_string_list_item(item, &exclude_patterns) {
-			if (!wildmatch(item->string, path + 10, 0))
+			if (!wildmatch(item->string, path_to_match, 0))
 				return 0;
 		}
 	}
@@ -161,11 +169,8 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 		int found = 0;
 		struct string_list_item *item;
 
-		if (!is_tag)
-			return 0;
-
 		for_each_string_list_item(item, &patterns) {
-			if (!wildmatch(item->string, path + 10, 0)) {
+			if (!wildmatch(item->string, path_to_match, 0)) {
 				found = 1;
 				break;
 			}
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 25110ea55d..0a8f754100 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -190,6 +190,33 @@ check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="te
 
 check_describe "test1-lightweight-*" --long --tags --match="test3-*" --match="test1-*" HEAD
 
+test_expect_success 'set-up branches' '
+	git branch branch_A A &&
+	git branch branch_C c &&
+	git update-ref refs/remotes/origin/remote_branch_A "A^{commit}" &&
+	git update-ref refs/remotes/origin/remote_branch_C "c^{commit}" &&
+	git update-ref refs/original/original_branch_A test-annotated~2
+'
+
+check_describe "heads/branch_A*" --all --match="branch_*" --exclude="branch_C" HEAD
+
+check_describe "remotes/origin/remote_branch_A*" --all --match="origin/remote_branch_*" --exclude="origin/remote_branch_C" HEAD
+
+check_describe "original/original_branch_A*" --all test-annotated~1
+
+test_expect_success '--match does not work for other types' '
+	test_must_fail git describe --all --match="*original_branch_*" test-annotated~1
+'
+
+test_expect_success '--exclude does not work for other types' '
+	R=$(git describe --all --exclude="any_pattern_even_not_matching" test-annotated~1) &&
+	case "$R" in
+	*original_branch_A*) echo "fail: Found unknown reference $R with --exclude"
+		false;;
+	*) echo ok: Found some known type;;
+	esac
+'
+
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
-- 
2.11.0.1122.gc3fec58.dirty

