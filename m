Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9341F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbdARXGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:06:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:32786 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdARXG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:29 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,250,1477983600"; 
   d="scan'208";a="54909588"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 0/5] extend git-describe pattern matching
Date:   Wed, 18 Jan 2017 15:06:03 -0800
Message-Id: <20170118230608.28030-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.488.g1cece4bcb7a5
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

- v3
* fix broken test (sorry for the thrash!)

- v4
* update documentation and commit messages at Junio's suggestion
* add completion

After even more thought, I do not like the way that git-log works with
--exclude, and do not believe it gives enough extra expressive power to
bother with the complexity. The current implementation of --match and
--exclude is relatively easy to explain and makes some sense. Since we
did not have a historical reasoning in the same way that git-log does, I
do not think using something like an exclude_list or similar is worth
the added complexity.

-- interdiff since v3 --
diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index 21a43b78924a..8755f3af7bcd 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -93,7 +93,9 @@ OPTIONS
 	the "refs/tags/" prefix. This can be used to narrow the tag space and
 	find only tags matching some meaningful criteria. If given multiple
 	times, a list of patterns will be accumulated and tags matching any
-	of the patterns will be excluded. Use `--no-exclude` to clear and
+	of the patterns will be excluded. When combined with --match a tag will
+	be considered when it matches at least one --match pattern and does not
+	match any of the --exclude patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
 --always::
diff --git c/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
index 301b4a8d55e6..da83f280ed88 100644
--- c/Documentation/git-name-rev.txt
+++ w/Documentation/git-name-rev.txt
@@ -33,9 +33,11 @@ OPTIONS
 --exclude=<pattern>::
 	Do not use any ref whose name matches a given shell pattern. The
 	pattern can be one of branch name, tag name or fully qualified ref
-	name. If given multiple times, exclude refs that match any of the given
-	shell patterns. Use `--no-exclude` to clear the list of exclude
-	patterns.
+	name. If given multiple times, a ref will be excluded when it matches
+	any of the given patterns. When used together with --refs, a ref will
+	be used as a match only when it matches at least one --ref pattern and
+	does not match any --exclude patterns. Use `--no-exclude` to clear the
+	list of exclude patterns.
 
 --all::
 	List all commits reachable from all refs
diff --git c/Documentation/technical/api-parse-options.txt w/Documentation/technical/api-parse-options.txt
index 6914f54f5f44..36768b479e16 100644
--- c/Documentation/technical/api-parse-options.txt
+++ w/Documentation/technical/api-parse-options.txt
@@ -168,10 +168,10 @@ There are some macros to easily define options:
 	Introduce an option with string argument.
 	The string argument is put into `str_var`.
 
-`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
+`OPT_STRING_LIST(short, long, &struct string_list, arg_str, description)`::
 	Introduce an option with string argument.
-	The string argument is stored as an element in `&list` which must be a
-	struct string_list. Reset the list using `--no-option`.
+	The string argument is stored as an element in `string_list`.
+	Use of `--no-option` will clear the list of preceding values.
 
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
diff --git c/builtin/name-rev.c w/builtin/name-rev.c
index da4a0d7c0fdf..ea8ef48102f8 100644
--- c/builtin/name-rev.c
+++ w/builtin/name-rev.c
@@ -166,10 +166,11 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 
 		/* See if any of the patterns match. */
 		for_each_string_list_item(item, &data->ref_filters) {
-			/*
-			 * We want to check every pattern even if we already
-			 * found a match, just in case one of the later
-			 * patterns could abbreviate the output.
+			/* Check every pattern even after we found a match so
+			 * that we can determine when we should abbreviate the
+			 * output. We will abbreviate the output when any of
+			 * the patterns match a subpath, even if one of the
+			 * patterns matches fully.
 			 */
 			switch (subpath_matches(path, item->string)) {
 			case -1: /* did not match */
diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 6721ff80fb13..835d7fcfd4f2 100644
--- c/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -1198,6 +1198,7 @@ _git_describe ()
 		__gitcomp "
 			--all --tags --contains --abbrev= --candidates=
 			--exact-match --debug --long --match --always
+			--exclude
 			"
 		return
 	esac

Jacob Keller (5):
  doc: add documentation for OPT_STRING_LIST
  name-rev: extend --refs to accept multiple patterns
  name-rev: add support to exclude refs by pattern match
  describe: teach --match to accept multiple patterns
  describe: teach describe negative pattern matches

 Documentation/git-describe.txt                | 15 +++++++-
 Documentation/git-name-rev.txt                | 13 ++++++-
 Documentation/technical/api-parse-options.txt |  5 +++
 builtin/describe.c                            | 51 +++++++++++++++++++++----
 builtin/name-rev.c                            | 54 +++++++++++++++++++++------
 contrib/completion/git-completion.bash        |  1 +
 t/t6007-rev-list-cherry-pick-file.sh          | 38 +++++++++++++++++++
 t/t6120-describe.sh                           | 27 ++++++++++++++
 8 files changed, 183 insertions(+), 21 deletions(-)

-- 
2.11.0.488.g1cece4bcb7a5

