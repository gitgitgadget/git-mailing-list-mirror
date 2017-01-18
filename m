Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AF620756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbdARAEq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:04:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:59468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbdARAEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:04:25 -0500
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP; 17 Jan 2017 16:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,247,1477983600"; 
   d="scan'208";a="55122138"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2017 16:03:56 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 5/5] describe: teach describe negative pattern matches
Date:   Tue, 17 Jan 2017 16:03:45 -0800
Message-Id: <20170118000345.31196-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
In-Reply-To: <20170118000345.31196-1-jacob.e.keller@intel.com>
References: <20170118000345.31196-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-describe the `--exclude` option which will allow specifying
a glob pattern of tags to ignore. This can be combined with the
`--match` patterns to enable more flexibility in determining which tags
to consider.

For example, suppose you wish to find the first official release tag
that contains a certain commit. If we assume that official release tags
are of the form "v*" and pre-release candidates include "*rc*" in their
name, we can now find the first tag that introduces commit abcdef via:

  git describe --contains --match="v*" --exclude="*rc*"

Add documentation and tests for this change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-describe.txt |  8 ++++++++
 builtin/describe.c             | 21 +++++++++++++++++++++
 t/t6120-describe.sh            |  8 ++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7ad41e2f6ade..21a43b78924a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -88,6 +88,14 @@ OPTIONS
 	patterns will be considered. Use `--no-match` to clear and reset the
 	list of patterns.
 
+--exclude <pattern>::
+	Do not consider tags matching the given `glob(7)` pattern, excluding
+	the "refs/tags/" prefix. This can be used to narrow the tag space and
+	find only tags matching some meaningful criteria. If given multiple
+	times, a list of patterns will be accumulated and tags matching any
+	of the patterns will be excluded. Use `--no-exclude` to clear and
+	reset the list of patterns.
+
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 5cc9e9abe798..6769446e1f57 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -29,6 +29,7 @@ static int max_candidates = 10;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
+static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *dirty;
 
@@ -130,6 +131,22 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 		return 0;
 
 	/*
+	 * If we're given exclude patterns, first exclude any tag which match
+	 * any of the exclude pattern.
+	 */
+	if (exclude_patterns.nr) {
+		struct string_list_item *item;
+
+		if (!is_tag)
+			return 0;
+
+		for_each_string_list_item(item, &exclude_patterns) {
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
+		OPT_STRING_LIST(0, "exclude", &exclude_patterns, N_("pattern"),
+			   N_("do not consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
@@ -458,6 +477,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			argv_array_push(&args, "--tags");
 			for_each_string_list_item(item, &patterns)
 				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
+			for_each_string_list_item(item, &exclude_patterns)
+				argv_array_pushf(&args, "--exclude=refs/tags/%s", item->string);
 		}
 		if (argc)
 			argv_array_pushv(&args, argv);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9e5db9b87a1f..167491fd5b0d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -218,6 +218,14 @@ test_expect_success 'describe --contains and --match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --exclude' '
+	echo "c~1" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	test_must_fail git describe --contains --match="B" $tagged_commit &&
+	git describe --contains --match="?" --exclude="A" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'describe --contains and --no-match' '
 	echo "A^0" >expect &&
 	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
-- 
2.11.0.403.g196674b8396b

