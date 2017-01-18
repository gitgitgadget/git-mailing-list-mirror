Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E4B1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdARXHW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:07:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:32786 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdARXGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:32 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,250,1477983600"; 
   d="scan'208";a="54909593"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 3/5] name-rev: add support to exclude refs by pattern match
Date:   Wed, 18 Jan 2017 15:06:06 -0800
Message-Id: <20170118230608.28030-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.488.g1cece4bcb7a5
In-Reply-To: <20170118230608.28030-1-jacob.e.keller@intel.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Extend git-name-rev to support excluding refs which match shell patterns
using --exclude. These patterns can be used to limit the scope of refs
by excluding any ref that matches one of the --exclude patterns. A ref
will only be used for naming when it matches at least one --ref pattern
but does not match any of the --exclude patterns. Thus, --exlude
patterns are given precedence over --ref patterns.

For example, suppose you wish to name a series of commits based on an
official release tag of the form "v*" but excluding any pre-release tags
which match "*rc*". You can use the following to do so:

  git name-rev --refs="v*" --exclude="*rc*" --all

Add tests and update Documentation for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-name-rev.txt       |  9 +++++++++
 builtin/name-rev.c                   | 14 +++++++++++++-
 t/t6007-rev-list-cherry-pick-file.sh | 12 ++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 7433627db12d..da83f280ed88 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -30,6 +30,15 @@ OPTIONS
 	given multiple times, use refs whose names match any of the given shell
 	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
+--exclude=<pattern>::
+	Do not use any ref whose name matches a given shell pattern. The
+	pattern can be one of branch name, tag name or fully qualified ref
+	name. If given multiple times, a ref will be excluded when it matches
+	any of the given patterns. When used together with --refs, a ref will
+	be used as a match only when it matches at least one --ref pattern and
+	does not match any --exclude patterns. Use `--no-exclude` to clear the
+	list of exclude patterns.
+
 --all::
 	List all commits reachable from all refs
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 85897ea1f714..ea8ef48102f8 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -109,6 +109,7 @@ struct name_ref_data {
 	int tags_only;
 	int name_only;
 	struct string_list ref_filters;
+	struct string_list exclude_filters;
 };
 
 static struct tip_table {
@@ -150,6 +151,15 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
 
+	if (data->exclude_filters.nr) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, &data->exclude_filters) {
+			if (subpath_matches(path, item->string) >= 0)
+				return 0;
+		}
+	}
+
 	if (data->ref_filters.nr) {
 		struct string_list_item *item;
 		int matched = 0;
@@ -324,12 +334,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
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
+		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
+				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index d9827a6389a3..29597451967d 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -118,6 +118,18 @@ test_expect_success 'name-rev --refs excludes non-matched patterns' '
 	test_cmp actual.named expect
 '
 
+cat >expect <<EOF
+<tags/F
+EOF
+
+test_expect_success 'name-rev --exclude excludes matched patterns' '
+	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
+	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
+		<actual >actual.named &&
+	test_cmp actual.named expect
+'
+
 test_expect_success 'name-rev --no-refs clears the refs list' '
 	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
 	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
-- 
2.11.0.488.g1cece4bcb7a5

