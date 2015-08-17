From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 5/6] notes: add notes.mergeStrategy option to select default strategy
Date: Mon, 17 Aug 2015 14:33:33 -0700
Message-ID: <1439847214-2980-6-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2W-0003aM-4j
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbHQVdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:12036 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbbHQVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:38 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910992"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276097>

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-notes about "notes.mergeStrategy" to select a general strategy
for all notes merges. This enables a user to always get expected merge
strategy such as "cat_sort_uniq" without having to pass the "-s" option
manually.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt            |  6 ++++++
 Documentation/git-notes.txt         | 14 ++++++++++++-
 builtin/notes.c                     | 19 ++++++++++++++++--
 t/t3309-notes-merge-auto-resolve.sh | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index de67ad1fdedf..2ff3ed64a4d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1919,6 +1919,12 @@ mergetool.writeToTemp::
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
+notes.mergeStrategy::
+	Which merge strategy to choose by default when resolving notes
+	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
+	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
+	section of linkgit:git-notes[1] for more information on each strategy.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 00c84be33ca9..71453d4a700f 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -101,7 +101,7 @@ merge::
 	any) into the current notes ref (called "local").
 +
 If conflicts arise and a strategy for automatically resolving
-conflicting notes (see the -s/--strategy option) is not given,
+conflicting notes (see the "NOTES MERGE STRATEGIES" section) is not given,
 the "manual" resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
@@ -183,6 +183,7 @@ OPTIONS
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
 	(default), "ours", "theirs", "union" and "cat_sort_uniq".
+	This option overrides the "notes.mergeStrategy" configuration setting.
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
@@ -247,6 +248,9 @@ When done, the user can either finalize the merge with
 'git notes merge --commit', or abort the merge with
 'git notes merge --abort'.
 
+Users may select an automated merge strategy from among the following using
+either -s/--strategy option or configuring notes.mergeStrategy accordingly:
+
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
 
@@ -310,6 +314,14 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
 
+notes.mergeStrategy::
+	Which merge strategy to choose by default when resolving notes
+	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
+	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
+	section above for more information on each strategy.
++
+This setting can be overridden by passing the `--strategy` option.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index 0e7aba98f4d7..91f7a6547b0f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -738,6 +738,19 @@ static int merge_commit(struct notes_merge_options *o)
 	return ret;
 }
 
+static int git_config_get_notes_strategy(const char *key,
+					 enum notes_merge_strategy *strategy)
+{
+	const char *value;
+
+	if (git_config_get_string_const(key, &value))
+		return 1;
+	if (parse_notes_merge_strategy(value, strategy))
+		git_die_config(key, "unknown notes merge strategy %s", value);
+
+	return 0;
+}
+
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
@@ -796,15 +809,17 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
+	t = init_notes_check("merge");
+
 	if (strategy) {
 		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
 			error("Unknown -s/--strategy: %s", strategy);
 			usage_with_options(git_notes_merge_usage, options);
 		}
+	} else {
+		git_config_get_notes_strategy("notes.mergeStrategy", &o.strategy);
 	}
 
-	t = init_notes_check("merge");
-
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
 		    remote_ref.buf, default_notes_ref());
 	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 461fd84755d7..1cd047f8d75f 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -298,6 +298,13 @@ test_expect_success 'merge z into y with invalid strategy => Fail/No changes' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with invalid configuration option => Fail/No changes' '
+	git config core.notesRef refs/notes/y &&
+	test_must_fail git -c notes.mergeStrategy="foo" notes merge z &&
+	# Verify no changes (y)
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_ours
 68b8630d25516028bed862719855b3d6768d7833 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -365,6 +372,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ours" configuration option => Non-conflicting 3-way merge' '
+	git -c notes.mergeStrategy="ours" notes merge z &&
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
@@ -432,6 +450,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "theirs" strategy overriding configuration option "ours" => Non-conflicting 3-way merge' '
+	git -c notes.mergeStrategy="ours" notes merge --strategy=theirs z &&
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
@@ -644,4 +673,15 @@ test_expect_success 'merge y into z with "cat_sort_uniq" strategy => Non-conflic
 	verify_notes z cat_sort_uniq
 '
 
+test_expect_success 'reset to pre-merge state (z)' '
+	git update-ref refs/notes/z refs/notes/z^1 &&
+	# Verify pre-merge state
+	verify_notes z z
+'
+
+test_expect_success 'merge y into z with "cat_sort_uniq" strategy configuration option => Non-conflicting 3-way merge' '
+	git -c notes.mergeStrategy="cat_sort_uniq" notes merge y &&
+	verify_notes z cat_sort_uniq
+'
+
 test_done
-- 
2.5.0.280.g4aaba03
