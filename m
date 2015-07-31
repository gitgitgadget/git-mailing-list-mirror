From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 2/2] notes: add notes.merge option to select default strategy
Date: Fri, 31 Jul 2015 16:12:21 -0700
Message-ID: <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:12:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJTn-0003yc-MU
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbbGaXMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:12:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:46299 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbbGaXMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:12:33 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP; 31 Jul 2015 16:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,587,1432623600"; 
   d="scan'208";a="617069088"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2015 16:12:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275093>

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-notes about a new configuration option "notes.merge" for
selecting the default notes merge strategy. Document the option in
config.txt and git-notes.txt

Add tests for the configuration option. Ensure that command line
--strategy option overrides the configured value. Ensure that -s can't
be passed with --commit or --abort. Ensure that --abort and --commit
can't be used together.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Johan Herland <johan@herland.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt              |  7 +++++
 Documentation/git-notes.txt           | 30 ++++++++++++-------
 builtin/notes.c                       | 55 +++++++++++++++++++++++++----------
 notes-merge.h                         | 16 +++++-----
 t/t3309-notes-merge-auto-resolve.sh   | 29 ++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++++
 6 files changed, 115 insertions(+), 34 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3c1e4df09beb..85c15126e4ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1937,6 +1937,13 @@ mergetool.writeToTemp::
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
+notes.merge::
+	Which merge strategy to choose by default when resolving notes
+	conflicts. Must be one of `manual`, `ours`, `theirs`, `union`,
+	or `cat_sort_uniq`. Defaults to `manual`. See "NOTES MERGE
+	STRATEGIES" section of linkgit:git-notes[1] for more information
+	on each strategy.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 674682b34b83..d8944f5aec60 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -101,13 +101,13 @@ merge::
 	any) into the current notes ref (called "local").
 +
 If conflicts arise and a strategy for automatically resolving
-conflicting notes (see the -s/--strategy option) is not given,
-the "manual" resolver is used. This resolver checks out the
-conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
-and instructs the user to manually resolve the conflicts there.
-When done, the user can either finalize the merge with
-'git notes merge --commit', or abort the merge with
-'git notes merge --abort'.
+conflicting notes (see the -s/--strategy option or notes.merge
+config option) is not given, the "manual" resolver is used.
+This resolver checks out the conflicting notes in a special
+worktree (`.git/NOTES_MERGE_WORKTREE`), and instructs the user
+to manually resolve the conflicts there. When done, the user
+can either finalize the merge with 'git notes merge --commit',
+or abort the merge with 'git notes merge --abort'.
 
 remove::
 	Remove the notes for given objects (defaults to HEAD). When
@@ -181,10 +181,10 @@ OPTIONS
 -s <strategy>::
 --strategy=<strategy>::
 	When merging notes, resolve notes conflicts using the given
-	strategy. The following strategies are recognized: "manual"
-	(default), "ours", "theirs", "union" and "cat_sort_uniq".
-	See the "NOTES MERGE STRATEGIES" section below for more
-	information on each notes merge strategy.
+	strategy. Overrides "notes.merge". The following strategies are
+	recognized: `manual`, `ours`, `theirs`, `union` and
+	`cat_sort_uniq`. See the `NOTES MERGE STRATEGIES` section below
+	for more information on each notes merge strategy.
 
 --commit::
 	Finalize an in-progress 'git notes merge'. Use this option
@@ -310,6 +310,14 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
 
+notes.merge::
+	Which merge strategy to choose by default when resolving notes
+	conflicts. Must be one of `manual`, `ours`, `theirs`, `union`,
+	or `cat_sort_uniq`. Defaults to `manual`. See "NOTES MERGE
+	STRATEGIES" section above for more information on each strategy.
++
+This setting can be overridden by passing the `--strategy` option.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index 88fdafb32bc0..728980bc79bf 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -93,6 +93,8 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	"\nWrite/edit the notes for the following object:\n";
 
+static enum notes_merge_strategy merge_strategy;
+
 struct note_data {
 	int given;
 	int use_editor;
@@ -741,6 +743,25 @@ static int merge_commit(struct notes_merge_options *o)
 	return ret;
 }
 
+static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *strategy)
+{
+	if (!strcmp(arg, "manual"))
+		*strategy = NOTES_MERGE_RESOLVE_MANUAL;
+	else if (!strcmp(arg, "ours"))
+		*strategy = NOTES_MERGE_RESOLVE_OURS;
+	else if (!strcmp(arg, "theirs"))
+		*strategy = NOTES_MERGE_RESOLVE_THEIRS;
+	else if (!strcmp(arg, "union"))
+		*strategy = NOTES_MERGE_RESOLVE_UNION;
+	else if (!strcmp(arg, "cat_sort_uniq"))
+		*strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
+	else {
+		return 1;
+	}
+
+	return 0;
+}
+
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
@@ -799,23 +820,13 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
-	if (strategy) {
-		if (!strcmp(strategy, "manual"))
-			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
-		else if (!strcmp(strategy, "ours"))
-			o.strategy = NOTES_MERGE_RESOLVE_OURS;
-		else if (!strcmp(strategy, "theirs"))
-			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
-		else if (!strcmp(strategy, "union"))
-			o.strategy = NOTES_MERGE_RESOLVE_UNION;
-		else if (!strcmp(strategy, "cat_sort_uniq"))
-			o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
-		else {
-			error("Unknown -s/--strategy: %s", strategy);
-			usage_with_options(git_notes_merge_usage, options);
-		}
+	if (strategy && parse_notes_strategy(strategy, &merge_strategy)) {
+		error("Unknown -s/--strategy: %s", strategy);
+		usage_with_options(git_notes_merge_usage, options);
 	}
 
+	o.strategy = merge_strategy;
+
 	t = init_notes_check("merge", NOTES_INIT_WRITABLE);
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
@@ -950,6 +961,18 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int git_notes_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "notes.merge")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (parse_notes_strategy(value, &merge_strategy))
+			return error("Unknown notes merge strategy: %s", value);
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	int result;
@@ -960,7 +983,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_notes_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
diff --git a/notes-merge.h b/notes-merge.h
index 1d01f6aacf54..bda8c0c8d348 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -8,18 +8,20 @@ enum notes_merge_verbosity {
 	NOTES_MERGE_VERBOSITY_MAX = 5
 };
 
+enum notes_merge_strategy {
+	NOTES_MERGE_RESOLVE_MANUAL = 0,
+	NOTES_MERGE_RESOLVE_OURS,
+	NOTES_MERGE_RESOLVE_THEIRS,
+	NOTES_MERGE_RESOLVE_UNION,
+	NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
+};
+
 struct notes_merge_options {
 	const char *local_ref;
 	const char *remote_ref;
 	struct strbuf commit_msg;
 	int verbosity;
-	enum {
-		NOTES_MERGE_RESOLVE_MANUAL = 0,
-		NOTES_MERGE_RESOLVE_OURS,
-		NOTES_MERGE_RESOLVE_THEIRS,
-		NOTES_MERGE_RESOLVE_UNION,
-		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
-	} strategy;
+	enum notes_merge_strategy strategy;
 	unsigned has_worktree:1;
 };
 
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 461fd84755d7..a773b01b73db 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -298,6 +298,13 @@ test_expect_success 'merge z into y with invalid strategy => Fail/No changes' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with invalid configuration option => Fail/No changes' '
+	git config core.notesRef refs/notes/y &&
+	test_must_fail git -c notes.merge="foo" notes merge z &&
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
+	git -c notes.merge="ours" notes merge z &&
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
+	git -c notes.merge="ours" notes merge --strategy=theirs z &&
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
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 195bb97f859d..d5572121da69 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -314,6 +314,18 @@ y and z notes on 1st commit
 
 EOF
 
+test_expect_success 'do not allow mixing --commit and --abort' '
+	test_must_fail git notes merge --commit --abort
+'
+
+test_expect_success 'do not allow mixing --commit and --strategy' '
+	test_must_fail git notes merge --commit --strategy theirs
+'
+
+test_expect_success 'do not allow mixing --abort and --strategy' '
+	test_must_fail git notes merge --abort --strategy theirs
+'
+
 test_expect_success 'finalize conflicting merge (z => m)' '
 	# Resolve conflicts and finalize merge
 	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
-- 
2.5.0.482.gfcd5645
