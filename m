Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1664B216A4
	for <e@80x24.org>; Wed, 18 Jan 2017 23:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdARXH2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:07:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:21511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdARXGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:31 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,250,1477983600"; 
   d="scan'208";a="54909591"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 2/5] name-rev: extend --refs to accept multiple patterns
Date:   Wed, 18 Jan 2017 15:06:05 -0800
Message-Id: <20170118230608.28030-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.488.g1cece4bcb7a5
In-Reply-To: <20170118230608.28030-1-jacob.e.keller@intel.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git name-rev to take multiple --refs stored as a string list of
patterns. The list of patterns will be matched inclusively, and each ref
only needs to match one pattern to be included. A ref will only be
excluded if it does not match any of the given patterns. Additionally,
if any of the patterns would allow abbreviation, then we will abbreviate
the ref, even if another pattern is more strict and would not have
allowed abbreviation on its own.

Add tests and documentation for this change. The tests expected output
is dynamically generated, but this is in order to avoid hard-coding
a commit object id in the test results (as the expected output is to
simply leave the commit object unnamed).

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-name-rev.txt       |  4 +++-
 builtin/name-rev.c                   | 42 +++++++++++++++++++++++++-----------
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 13 deletions(-)

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
index cd89d48b65e8..85897ea1f714 100644
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
@@ -150,16 +150,34 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
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
+			/* Check every pattern even after we found a match so
+			 * that we can determine when we should abbreviate the
+			 * output. We will abbreviate the output when any of
+			 * the patterns match a subpath, even if one of the
+			 * patterns matches fully.
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
@@ -306,11 +324,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
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
index 1408b608eb03..d9827a6389a3 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -99,6 +99,32 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 	test_cmp actual.named expect
 '
 
+test_expect_success 'name-rev multiple --refs combine inclusive' '
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
+	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
+		<actual >actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+<tags/F
+EOF
+
+test_expect_success 'name-rev --refs excludes non-matched patterns' '
+	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
+	git name-rev --stdin --name-only --refs="*tags/F" \
+		<actual >actual.named &&
+	test_cmp actual.named expect
+'
+
+test_expect_success 'name-rev --no-refs clears the refs list' '
+	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
+	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
+		<expect >actual &&
+	test_cmp actual expect
+'
+
 cat >expect <<EOF
 +tags/F
 =tags/D
-- 
2.11.0.488.g1cece4bcb7a5

