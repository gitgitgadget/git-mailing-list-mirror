From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 5/8] notes: implement parse_combine_rewrite_fn using parse_notes_merge_strategy
Date: Mon, 17 Aug 2015 01:46:28 -0700
Message-ID: <1439801191-3026-6-git-send-email-jacob.e.keller@intel.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 10:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRG4g-0002kE-CB
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbbHQIrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 04:47:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:40512 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbbHQIrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 04:47:17 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 17 Aug 2015 01:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,693,1432623600"; 
   d="scan'208";a="770177871"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2015 01:47:15 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276036>

From: Jacob Keller <jacob.keller@gmail.com>

Teach the rewrite combine notes to use the same names as git-notes
merge. This will support all current names plus a few new synonyms.

Update documentation to point to NOTES MERGE STRATEGIES to explain the
various rewrite options available.

Implementing rewrite functionality completely in terms of merging is
left as an exercise for a future contributor.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt    |  8 ++++---
 Documentation/git-notes.txt | 18 ++++++++++-----
 notes-utils.c               | 26 +++++++++++++--------
 t/t3301-notes.sh            | 55 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index de67ad1fdedf..4daa804b1eab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1946,9 +1946,11 @@ notes.rewrite.<command>::
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
 	"notes.rewrite.<command>" option), determines what to do if
-	the target commit already has a note.  Must be one of
-	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
-	Defaults to `concatenate`.
+	the target commit already has a note.  With the exception of `manual`,
+	any automatic merge strategy may be chosen.  Beware that in the
+	re-write context the typical notion of `ours` and `theirs` is reversed.
+	See the "NOTES MERGE STRATEGIES" section above for information on each
+	of the available strategies.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 5028e9355de5..678dadfdf3c3 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -336,9 +336,11 @@ environment variable.
 
 notes.rewriteMode::
 	When copying notes during a rewrite, what to do if the target
-	commit already has a note.  Must be one of `overwrite`,
-	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
-	`concatenate`.
+	commit already has a note.  With the exception of `manual`, any
+	automatic merge strategy may be chosen.  Beware that in the re-write
+	context the typical notion of `ours` and `theirs` is reversed .  See
+	the "NOTES MERGE STRATEGIES" section above for information on each of
+	the available strategies.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
@@ -374,9 +376,13 @@ does not match any refs is silently ignored.
 
 'GIT_NOTES_REWRITE_MODE'::
 	When copying notes during a rewrite, what to do if the target
-	commit already has a note.
-	Must be one of `overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
-	This overrides the `core.rewriteMode` setting.
+	commit already has a note.  With the exception of `manual`, any
+	automatic merge strategy may be chosen.  Beware that in the re-write
+	context the typical notion of `ours` and `theirs` is reversed .  See
+	the "NOTES MERGE STRATEGIES" section above for information on each of
+	the available strategies.
++
+Overrides the notes.rewriteMode configuration option.
 
 'GIT_NOTES_REWRITE_REF'::
 	When rewriting commits, which notes to copy from the original
diff --git a/notes-utils.c b/notes-utils.c
index 656b0ea152e2..8d4cc8909bcf 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -80,16 +80,24 @@ int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s)
 
 static combine_notes_fn parse_combine_notes_fn(const char *v)
 {
-	if (!strcasecmp(v, "overwrite"))
-		return combine_notes_overwrite;
-	else if (!strcasecmp(v, "ignore"))
-		return combine_notes_ignore;
-	else if (!strcasecmp(v, "concatenate"))
-		return combine_notes_concatenate;
-	else if (!strcasecmp(v, "cat_sort_uniq"))
-		return combine_notes_cat_sort_uniq;
-	else
+	enum notes_merge_strategy s;
+
+	if (parse_notes_merge_strategy(v, &s))
 		return NULL;
+
+	switch (s) {
+	case NOTES_MERGE_RESOLVE_OURS:
+		return combine_notes_ignore;
+	case NOTES_MERGE_RESOLVE_THEIRS:
+		return combine_notes_overwrite;
+	case NOTES_MERGE_RESOLVE_UNION:
+		return combine_notes_concatenate;
+	case NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ:
+		return combine_notes_cat_sort_uniq;
+	case NOTES_MERGE_RESOLVE_MANUAL:
+	default:
+		return NULL;
+	}
 }
 
 static int notes_rewrite_config(const char *k, const char *v, void *cb)
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 8cffd35fb03d..eb1b5824a422 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -997,6 +997,26 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git notes copy --for-rewrite (theirs)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}a fresh note
+	EOF
+	git notes add -f -m"a fresh note" HEAD^ &&
+	test_config notes.rewriteMode theirs &&
+	test_config notes.rewriteRef "refs/notes/*" &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git notes copy --for-rewrite (ignore)' '
 	test_config notes.rewriteMode ignore &&
 	test_config notes.rewriteRef "refs/notes/*" &&
@@ -1006,6 +1026,15 @@ test_expect_success 'git notes copy --for-rewrite (ignore)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git notes copy --for-rewrite (ours)' '
+	test_config notes.rewriteMode ours &&
+	test_config notes.rewriteRef "refs/notes/*" &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git notes copy --for-rewrite (append)' '
 	cat >expect <<-EOF &&
 		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
@@ -1028,6 +1057,30 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git notes copy --for-rewrite (union append)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}a fresh note
+		${indent}
+		${indent}another fresh note
+		${indent}
+		${indent}yet again a fresh note
+	EOF
+	git notes add -f -m"yet again a fresh note" HEAD^ &&
+	test_config notes.rewriteMode union &&
+	test_config notes.rewriteRef "refs/notes/*" &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 	cat >expect <<-EOF &&
 		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
@@ -1041,6 +1094,8 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 		${indent}
 		${indent}another fresh note
 		${indent}
+		${indent}yet again a fresh note
+		${indent}
 		${indent}append 1
 		${indent}
 		${indent}append 2
-- 
2.5.0.280.g4aaba03
