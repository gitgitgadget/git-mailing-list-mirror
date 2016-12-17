Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D751F1FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758442AbcLQBYi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:24:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:5683 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757869AbcLQBYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:24:35 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,360,1477983600"; 
   d="scan'208";a="1082903357"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 2/5] name-rev: extend --refs to accept multiple patterns
Date:   Fri, 16 Dec 2016 17:24:28 -0800
Message-Id: <20161217012431.29548-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161217012431.29548-1-jacob.e.keller@intel.com>
References: <20161217012431.29548-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git name-rev to take a string list of patterns from --refs instead
of only a single pattern. The list of patterns will be matched
inclusively, such that a ref only needs to match one pattern to be
included. If a ref will only be excluded if it does not match any of the
patterns.

Add tests and documentation for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-name-rev.txt       |  4 +++-
 builtin/name-rev.c                   | 41 +++++++++++++++++++++++++-----------
 t/t6007-rev-list-cherry-pick-file.sh | 30 ++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ca28fb8e2a07..7433627db12d 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -26,7 +26,9 @@ OPTIONS
 
 --refs=<pattern>::
 	Only use refs whose names match a given shell pattern.  The pattern
-	can be one of branch name, tag name or fully qualified ref name.
+	can be one of branch name, tag name or fully qualified ref name. If
+	given multiple times, use refs whose names match any of the given shell
+	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
 --all::
 	List all commits reachable from all refs
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cd89d48b65e8..000a2a700ed3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -108,7 +108,7 @@ static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
 struct name_ref_data {
 	int tags_only;
 	int name_only;
-	const char *ref_filter;
+	struct string_list ref_filters;
 };
 
 static struct tip_table {
@@ -150,16 +150,33 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
 
-	if (data->ref_filter) {
-		switch (subpath_matches(path, data->ref_filter)) {
-		case -1: /* did not match */
-			return 0;
-		case 0:  /* matched fully */
-			break;
-		default: /* matched subpath */
-			can_abbreviate_output = 1;
-			break;
+	if (data->ref_filters.nr) {
+		struct string_list_item *item;
+		int matched = 0;
+
+		/* See if any of the patterns match. */
+		for_each_string_list_item(item, &data->ref_filters) {
+			/*
+			 * We want to check every pattern even if we already
+			 * found a match, just in case one of the later
+			 * patterns could abbreviate the output.
+			 */
+			switch (subpath_matches(path, item->string)) {
+			case -1: /* did not match */
+				break;
+			case 0: /* matched fully */
+				matched = 1;
+				break;
+			default: /* matched subpath */
+				matched = 1;
+				can_abbreviate_output = 1;
+				break;
+			}
 		}
+
+		/* If none of the patterns matched, stop now */
+		if (!matched)
+			return 0;
 	}
 
 	add_to_tip_table(oid->hash, path, can_abbreviate_output);
@@ -306,11 +323,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
-	struct name_ref_data data = { 0, 0, NULL };
+	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
-		OPT_STRING(0, "refs", &data.ref_filter, N_("pattern"),
+		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
 				   N_("only use refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 1408b608eb03..d072ec43b016 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -99,6 +99,36 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 	test_cmp actual.named expect
 '
 
+test_expect_success 'name-rev multiple --refs combine inclusive' '
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+<tags/F
+$(git rev-list --left-right --right-only --cherry-pick F...E -- bar)
+EOF
+
+test_expect_success 'name-rev --refs excludes non-matched patterns' '
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/F" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+$(git rev-list --left-right --cherry-pick F...E -- bar)
+EOF
+
+test_expect_success 'name-rev --no-refs clears the refs list' '
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
 cat >expect <<EOF
 +tags/F
 =tags/D
-- 
2.11.0.rc2.152.g4d04e67

