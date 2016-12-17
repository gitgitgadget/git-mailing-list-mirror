Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910A71FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758597AbcLQBYo (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:24:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:43564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758337AbcLQBYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:24:37 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,360,1477983600"; 
   d="scan'208";a="1082903360"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2016 17:24:34 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 5/5] describe: teach describe negative pattern matches
Date:   Fri, 16 Dec 2016 17:24:31 -0800
Message-Id: <20161217012431.29548-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161217012431.29548-1-jacob.e.keller@intel.com>
References: <20161217012431.29548-1-jacob.e.keller@intel.com>
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
 2 files changed, 29 insertions(+)

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
-- 
2.11.0.rc2.152.g4d04e67

