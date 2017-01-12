Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124DC20798
	for <e@80x24.org>; Thu, 12 Jan 2017 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbdALARa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 19:17:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:54929 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762338AbdALAR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 19:17:28 -0500
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jan 2017 16:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,347,1477983600"; 
   d="scan'208";a="51987759"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2017 16:17:25 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 5/5] describe: teach describe negative pattern matches
Date:   Wed, 11 Jan 2017 16:17:21 -0800
Message-Id: <20170112001721.2534-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
In-Reply-To: <20170112001721.2534-1-jacob.e.keller@intel.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-describe the `--discard` option which will allow specifying
a glob pattern of tags to ignore. This can be combined with the
`--match` patterns to enable more flexibility in determining which tags
to consider.

For example, suppose you wish to find the first official release tag
that contains a certain commit. If we assume that official release tags
are of the form "v*" and pre-release candidates include "*rc*" in their
name, we can now find the first tag that introduces commit abcdef via:

  git describe --contains --match="v*" --discard="*rc*"

Add documentation and tests for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-describe.txt |  8 ++++++++
 builtin/describe.c             | 21 +++++++++++++++++++++
 t/t6120-describe.sh            |  8 ++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7ad41e2f6ade..a89bbde207b2 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -88,6 +88,14 @@ OPTIONS
 	patterns will be considered. Use `--no-match` to clear and reset the
 	list of patterns.
 
+--discard <pattern>::
+	Do not consider tags matching the given `glob(7)` pattern, excluding
+	the "refs/tags/" prefix. This can be used to narrow the tag space and
+	find only tags matching some meaningful criteria. If given multiple
+	times, a list of patterns will be accumulated and tags matching any
+	of the patterns will be discarded. Use `--no-discard` to clear and
+	reset the list of patterns.
+
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 5cc9e9abe798..c09288ee6321 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
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
@@ -421,6 +438,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
 			   N_("only consider tags matching <pattern>")),
+		OPT_STRING_LIST(0, "discard", &discard_patterns, N_("pattern"),
+			   N_("do not consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
@@ -458,6 +477,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			argv_array_push(&args, "--tags");
 			for_each_string_list_item(item, &patterns)
 				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
+			for_each_string_list_item(item, &discard_patterns)
+				argv_array_pushf(&args, "--discard=refs/tags/%s", item->string);
 		}
 		if (argc)
 			argv_array_pushv(&args, argv);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9e5db9b87a1f..4e4a9f2e5305 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
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
-- 
2.11.0.403.g196674b8396b

