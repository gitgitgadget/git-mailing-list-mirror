From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 3/4] notes: add notes.merge option to select default strategy
Date: Tue, 11 Aug 2015 13:57:20 -0700
Message-ID: <1439326641-9447-4-git-send-email-jacob.e.keller@intel.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 22:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGcC-0003uD-U0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbbHKU5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:57:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:9837 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbbHKU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:57:31 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 11 Aug 2015 13:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,655,1432623600"; 
   d="scan'208";a="782214969"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2015 13:57:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275727>

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-notes about "notes.merge" to select a general strategy for all
notes merges. This enables a user to always get expected merge strategy
such as "cat_sort_uniq" without having to pass the "-s" option manually.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt            |  7 ++++++
 Documentation/git-notes.txt         | 14 +++++++++++-
 builtin/notes.c                     | 44 +++++++++++++++++++++++--------------
 notes-merge.h                       | 16 ++++++++------
 t/t3309-notes-merge-auto-resolve.sh | 29 ++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 24 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b3df1b16491c..488c2e8eec1b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1905,6 +1905,13 @@ mergetool.writeToTemp::
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
index 674682b34b83..9c4f8536182f 100644
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
+	This option overrides the "notes.merge" configuration setting.
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
@@ -247,6 +248,9 @@ When done, the user can either finalize the merge with
 'git notes merge --commit', or abort the merge with
 'git notes merge --abort'.
 
+Users may select an automated merge strategy from among the following using
+either -s/--strategy option or configuring notes.merge accordingly:
+
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
 
@@ -310,6 +314,14 @@ core.notesRef::
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
index 63f95fc55439..3c705f5e26ff 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -737,6 +737,24 @@ static int merge_commit(struct notes_merge_options *o)
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
+	else
+		return -1;
+
+	return 0;
+}
+
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
@@ -745,7 +763,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	struct notes_merge_options o;
 	int do_merge = 0, do_commit = 0, do_abort = 0;
 	int verbosity = 0, result;
-	const char *strategy = NULL;
+	const char *strategy = NULL, *configured_strategy = NULL;
 	struct option options[] = {
 		OPT_GROUP(N_("General options")),
 		OPT__VERBOSITY(&verbosity),
@@ -795,21 +813,15 @@ static int merge(int argc, const char **argv, const char *prefix)
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
+	git_config_get_string_const("notes.merge", &configured_strategy);
+
+	if (configured_strategy &&
+	    parse_notes_strategy(configured_strategy, &o.strategy))
+		die("Unknown notes merge strategy: %s", configured_strategy);
+
+	if (strategy && parse_notes_strategy(strategy, &o.strategy)) {
+		error("Unknown -s/--strategy: %s", strategy);
+		usage_with_options(git_notes_merge_usage, options);
 	}
 
 	t = init_notes_check("merge");
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
-- 
2.5.0.482.gfcd5645
