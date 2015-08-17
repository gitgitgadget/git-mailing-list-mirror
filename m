From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 4/8] notes: allow use of the "rewrite" terminology for merge strategies
Date: Mon, 17 Aug 2015 01:46:27 -0700
Message-ID: <1439801191-3026-5-git-send-email-jacob.e.keller@intel.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 10:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRG4p-0002pW-QK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 10:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbbHQIrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 04:47:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:64623 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbbHQIrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 04:47:17 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 17 Aug 2015 01:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,693,1432623600"; 
   d="scan'208";a="770177870"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2015 01:47:15 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276039>

From: Jacob Keller <jacob.keller@gmail.com>

notes-merge.c already re-uses the same functions for the automatic merge
strategies used by the rewrite functionality. Teach the -s/--strategy
option how to interpret the equivalent rewrite terminology for
consistency.

Add tests for the new synonyms.

Teaching rewrite how to understand merge terminology is left for a
following patch.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-notes.txt         |  6 +++++
 notes-utils.c                       |  6 +++++
 t/t3309-notes-merge-auto-resolve.sh | 45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 00c84be33ca9..5028e9355de5 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -250,13 +250,19 @@ When done, the user can either finalize the merge with
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
 
+"ignore" is an alternative spelling for "ours".
+
 "theirs" automatically resolves notes conflicts in favor of the remote
 version (i.e. the given notes ref being merged into the current notes
 ref).
 
+"overwrite" is an alternative spelling for "theirs".
+
 "union" automatically resolves notes conflicts by concatenating the
 local and remote versions.
 
+"concatenate" is an alternative spelling for "union".
+
 "cat_sort_uniq" is similar to "union", but in addition to concatenating
 the local and remote versions, this strategy also sorts the resulting
 lines, and removes duplicate lines from the result. This is equivalent
diff --git a/notes-utils.c b/notes-utils.c
index 299e34bccc58..656b0ea152e2 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -60,10 +60,16 @@ int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s)
 		*s = NOTES_MERGE_RESOLVE_MANUAL;
 	else if (!strcmp(v, "ours"))
 		*s = NOTES_MERGE_RESOLVE_OURS;
+	else if (!strcmp(v, "ignore"))
+		*s = NOTES_MERGE_RESOLVE_OURS;
 	else if (!strcmp(v, "theirs"))
 		*s = NOTES_MERGE_RESOLVE_THEIRS;
+	else if (!strcmp(v, "overwrite"))
+		*s = NOTES_MERGE_RESOLVE_THEIRS;
 	else if (!strcmp(v, "union"))
 		*s = NOTES_MERGE_RESOLVE_UNION;
+	else if (!strcmp(v, "concatenate"))
+		*s = NOTES_MERGE_RESOLVE_UNION;
 	else if (!strcmp(v, "cat_sort_uniq"))
 		*s = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
 	else
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 461fd84755d7..909900672446 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -365,6 +365,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ignore" strategy => Non-conflicting 3-way merge' '
+	git notes merge --strategy=ignore z &&
+	verify_notes y ours
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_theirs
 9b4b2c61f0615412da3c10f98ff85b57c04ec765 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -432,6 +443,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "overwrite" strategy => Non-conflicting 3-way merge' '
+	git notes merge --strategy=overwrite z &&
+	verify_notes y theirs
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union
 7c4e546efd0fe939f876beb262ece02797880b54 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -505,6 +527,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "concatenate" strategy => Non-conflicting 3-way merge' '
+	git notes merge --strategy=concatenate z &&
+	verify_notes y union
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union2
 d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -579,6 +612,18 @@ test_expect_success 'reset to pre-merge state (z)' '
 	verify_notes z z
 '
 
+test_expect_success 'merge y into z with "concatenate" strategy => Non-conflicting 3-way merge' '
+	git config core.notesRef refs/notes/z &&
+	git notes merge --strategy=concatenate y &&
+	verify_notes z union2
+'
+
+test_expect_success 'reset to pre-merge state (z)' '
+	git update-ref refs/notes/z refs/notes/z^1 &&
+	# Verify pre-merge state
+	verify_notes z z
+'
+
 cat <<EOF | sort >expect_notes_cat_sort_uniq
 6be90240b5f54594203e25d9f2f64b7567175aee $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-- 
2.5.0.280.g4aaba03
