Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13AC2092F
	for <e@80x24.org>; Thu, 12 Jan 2017 00:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762351AbdALAR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 19:17:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:59579 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753158AbdALAR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 19:17:27 -0500
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jan 2017 16:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,347,1477983600"; 
   d="scan'208";a="51987756"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2017 16:17:24 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 3/5] name-rev: add support to discard refs by pattern match
Date:   Wed, 11 Jan 2017 16:17:19 -0800
Message-Id: <20170112001721.2534-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
In-Reply-To: <20170112001721.2534-1-jacob.e.keller@intel.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Extend name-rev further to support matching refs by adding `--discard`
patterns. These patterns will limit the scope of refs by discarding any
ref that matches at least one discard pattern. Checking the discard refs
shall happen first, before checking the include --refs patterns. This
will allow more flexibility to matching certain kinds of references.

Add tests and update Documentation for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-name-rev.txt       |  7 +++++++
 builtin/name-rev.c                   | 14 +++++++++++++-
 t/t6007-rev-list-cherry-pick-file.sh |  7 +++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 7433627db12d..9b46e5ea9aae 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
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
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 000a2a700ed3..86479c17a7c9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
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
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index d072ec43b016..8a4c35f6ffee 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
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
-- 
2.11.0.403.g196674b8396b

