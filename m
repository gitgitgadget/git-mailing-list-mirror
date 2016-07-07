Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9612070D
	for <e@80x24.org>; Thu,  7 Jul 2016 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbcGGTqC (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 15:46:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:31275 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGGTqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 15:46:00 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jul 2016 15:46:00 EDT
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 84AB98458C;
	Thu,  7 Jul 2016 15:26:46 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com
Subject: [PATCH] Add very verbose porcelain output to status
Date:	Thu,  7 Jul 2016 15:26:28 -0400
Message-Id: <1467919588-11930-1-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tools interacting with Git repositories may need to know the complete
state of the working directory. For efficiency, it would be good to have
a single command to obtain this information.

We already have a `--porcelain` mode intended for tools' consumption,
and it only makes sense to enhance this mode to offer more information.

Just like we do elsewhere in Git's source code, we now interpret
multiple `--verbose` flags accumulatively, and show substantially more
information in porcelain mode at verbosity level 2.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt |  83 ++++++
 builtin/commit.c             |  15 +
 t/t7064-wtstatus-vvp.sh      | 150 ++++++++++
 wt-status.c                  | 676 ++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h                  |  10 +
 5 files changed, 932 insertions(+), 2 deletions(-)
 create mode 100755 t/t7064-wtstatus-vvp.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e1e8f57..f88316a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -49,6 +49,9 @@ OPTIONS
 	twice, then also show the changes in the working tree that
 	have not yet been staged (i.e., like the output of `git diff`).
 
+	When given twice with `--porcelain`, additional output is enabled.
+	See the section entitled "Very Verbose Porcelain Format" for details.
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
@@ -207,6 +210,86 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Very Verbose Porcelain Format
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When --verbose is given twice along with --porcelain, additional output
+is provided.
+
+If --branch is given, the first line shows a summary of the current
+operation in progress.  This line begins with "### state: ", the name
+of the operation in progress, and then operation-specific information.
+Fields are separated by a single space.
+
+    Operation   Fields                     Explanation
+    ------------------------------------------------------------------
+    clean
+    ------------------------------------------------------------------
+    merge       <nr>                       Number unmerged
+    ------------------------------------------------------------------
+    am          [E]                        Present if the current patch
+                                           is empty
+    ------------------------------------------------------------------
+    rebase      <nr>                       Number unmerged
+                [S]                        Present if split commit in
+                                           progress during rebase
+                [E]                        Present if editing a commit
+                                           during rebase
+                [I(<done>/<total>)]        Present if in an interactive
+                                           rebase. Step counts are given.
+                [<current>:<onto>]         Rebase branches
+    ------------------------------------------------------------------
+    cherrypick  <sha>
+                <nr>                       Number unmerged
+    ------------------------------------------------------------------
+    revert      <sha>
+                <nr>                       Number unmerged
+    ------------------------------------------------------------------
+    bisect      [<branch>]
+    ------------------------------------------------------------------
+
+If --branch is given, the second line shows branch tracking information.
+This line begins with "### track: ".  Fields are separated by a single
+space, unless otherwise indicated.
+
+    Field                    Meaning
+    --------------------------------------------------------
+    <sha> | "(initial)"      Current commit
+    <branch> | "(detached)"  Current branch
+    ":"<upstream>            Upstream branch, if set
+    "+"<ahead>               Ahead count, if upstream present
+    "-"<behind>              Behind count, if upstream present
+    --------------------------------------------------------
+
+A series of lines are then displayed for the tracked entries.
+Lines have one of the following formats:
+
+    XYS mH mI mW shaH shaI PATH
+    XYS mH mI mW shaH shaI score OLD_PATH\tPATH
+    XYS m1 m2 m3 mW sha1 sha2 sha3 PATH
+
+* X and Y were described in the short format section.
+* S is a one character summary of the submodule status with values '0'..'7'
+  representing the sum of: 4 when submodule has a new commit, 2 when the
+  submodule is modified, and 1 when the submodule contains untracked changes.
+  The value is ' ' if the entry is not a submodule.
+* mH, mI, and mW are the 6 digit octal modes for the head, index, and worktree
+  versions of the entry.
+* m1, m2, and m3 are the modes for the stage 1, 2, and 3 versions of the entry
+  when in an unmerged state.
+* shaH and shaI are the 40 character hashes for the head and index version.
+* sha1, sha2, and sha3 are the hashes for the stage 1, 2, and 3 versions of
+  the entry when in an unmerged state.
+* score is the rename percentage score.
+* PATH is the current path.
+* OLD_PATH is the source path for a staged rename.
+
+A series of lines are then displayed for untracked and ignored entries.
+
+    XXX PATH
+
+* XXX is "???" for untracked entries and "!!!" for ignored entries.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 3f18942..b856108 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -500,6 +500,8 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->fp = fp;
 	s->nowarn = nowarn;
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	if (!s->is_initial)
+		hashcpy(s->sha_commit, sha1);
 
 	wt_status_collect(s);
 
@@ -1380,7 +1382,20 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	fd = hold_locked_index(&index_lock, 0);
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	if (!s.is_initial)
+		hashcpy(s.sha_commit, sha1);
+
 	s.ignore_submodule_arg = ignore_submodule_arg;
+	if (verbose > 1 && status_format == STATUS_FORMAT_PORCELAIN) {
+		/* Capture extra data for very verbose porcelain output. */
+		s.verbose = verbose;
+
+		/* Force safe_crlf off to prevent normal LF/CRLF warning
+		 * message from being printed on stderr for each new file.
+		 */
+		safe_crlf = SAFE_CRLF_FALSE;
+	}
+
 	wt_status_collect(&s);
 
 	if (0 <= fd)
diff --git a/t/t7064-wtstatus-vvp.sh b/t/t7064-wtstatus-vvp.sh
new file mode 100755
index 0000000..87e5b4e
--- /dev/null
+++ b/t/t7064-wtstatus-vvp.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description='git status --porcelain --verbose --verbose
+
+This test exercises very verbose output for git status.'
+
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git config --local core.autocrlf false &&
+	echo x >file_x &&
+	echo y >file_y &&
+	echo z >file_z &&
+	mkdir dir1 &&
+	echo a >dir1/file_a &&
+	echo b >dir1/file_b
+'
+
+
+##################################################################
+## Confirm VVP output prior to initial commit.
+##################################################################
+
+test_expect_success pre_initial_commit_0 '
+	cat >expected <<EOF &&
+### state: clean
+### track: (initial) master
+??? actual
+??? dir1/
+??? expected
+??? file_x
+??? file_y
+??? file_z
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=normal >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success pre_initial_commit_1 '
+	git add file_x file_y file_z dir1 &&
+	cat >expected <<EOF &&
+### state: clean
+### track: (initial) master
+A   000000 100644 100644 0000000000000000000000000000000000000000 78981922613b2afb6025042ff6bd878ac1994e85 dir1/file_a
+A   000000 100644 100644 0000000000000000000000000000000000000000 61780798228d17af2d34fce4cfbdf35556832472 dir1/file_b
+A   000000 100644 100644 0000000000000000000000000000000000000000 587be6b4c3f93f93c489c0111bba5596147a26cb file_x
+A   000000 100644 100644 0000000000000000000000000000000000000000 975fbec8256d3e8a3797e7a3611380f27c49f4ac file_y
+A   000000 100644 100644 0000000000000000000000000000000000000000 b68025345d5301abad4d9ec9166f455243a0d746 file_z
+??? actual
+??? expected
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Create first commit. Confirm commit sha in new track header.
+## Then make some changes on top of it.
+##################################################################
+
+test_expect_success initial_commit_0 '
+	git commit -m initial &&
+	H0=`git rev-parse HEAD` &&
+	cat >expected <<EOF &&
+### state: clean
+### track: $H0 master
+??? actual
+??? expected
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_1 '
+	echo x >>file_x &&
+	rm file_z &&
+	H0=`git rev-parse HEAD` &&
+	cat >expected <<EOF &&
+### state: clean
+### track: $H0 master
+ M  100644 100644 100644 587be6b4c3f93f93c489c0111bba5596147a26cb 587be6b4c3f93f93c489c0111bba5596147a26cb file_x
+ D  100644 100644 000000 b68025345d5301abad4d9ec9166f455243a0d746 b68025345d5301abad4d9ec9166f455243a0d746 file_z
+??? actual
+??? expected
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_2 '
+	git add file_x &&
+	git rm file_z &&
+	H0=`git rev-parse HEAD` &&
+	cat >expected <<EOF &&
+### state: clean
+### track: $H0 master
+M   100644 100644 100644 587be6b4c3f93f93c489c0111bba5596147a26cb 560e017033beac775889ae5ff81a070fe16c6e8e file_x
+D   100644 000000 000000 b68025345d5301abad4d9ec9166f455243a0d746 0000000000000000000000000000000000000000 file_z
+??? actual
+??? expected
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_3 '
+	git mv file_y renamed_y &&
+	H0=`git rev-parse HEAD` &&
+	printf "### state: clean\n" >expected &&
+	printf "### track: $H0 master\n" >>expected &&
+	printf "M   100644 100644 100644 587be6b4c3f93f93c489c0111bba5596147a26cb 560e017033beac775889ae5ff81a070fe16c6e8e file_x\n" >>expected &&
+	printf "D   100644 000000 000000 b68025345d5301abad4d9ec9166f455243a0d746 0000000000000000000000000000000000000000 file_z\n" >>expected &&
+	printf "R   100644 100644 100644 975fbec8256d3e8a3797e7a3611380f27c49f4ac 975fbec8256d3e8a3797e7a3611380f27c49f4ac 100 file_y\trenamed_y\n" >>expected &&
+	printf "??? actual\n" >>expected &&
+	printf "??? expected\n" >>expected &&
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Create second commit.
+##################################################################
+
+test_expect_success second_commit_0 '
+	git commit -m second &&
+	H1=`git rev-parse HEAD` &&
+	cat >expected <<EOF &&
+### state: clean
+### track: $H1 master
+??? actual
+??? expected
+EOF
+	git status --porcelain --branch --verbose --verbose --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## The end.
+##################################################################
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 4ce4e35..d870e08 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -406,6 +406,89 @@ static void wt_status_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
+
+/* Copy info for both sides of a head-vs-index change
+ * into the very verbose porcelain data.
+ */
+static void vvp_updated_entry(
+	struct wt_status_change_data *d,
+	struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		d->vvp.mode_index = p->two->mode;
+		hashcpy(d->vvp.sha1_index, p->two->sha1);
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->vvp.mode_head = p->one->mode;
+		hashcpy(d->vvp.sha1_head, p->one->sha1);
+		break;
+
+	case DIFF_STATUS_RENAMED:
+		d->vvp.rename_score = p->score * 100 / MAX_SCORE;
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_TYPE_CHANGED:
+	case DIFF_STATUS_UNMERGED:
+		d->vvp.mode_head = p->one->mode;
+		d->vvp.mode_index = p->two->mode;
+		hashcpy(d->vvp.sha1_head, p->one->sha1);
+		hashcpy(d->vvp.sha1_index, p->two->sha1);
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		/* This should never happen. */
+		break;
+	}
+}
+
+/* Copy info for both sides of an index-vs-worktree change
+ * into the very verbose porcelain data.
+ */
+static void vvp_changed_entry(
+	struct wt_status_change_data *d,
+	const struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		d->vvp.mode_worktree = p->two->mode;
+		/* don't bother with worktree sha, since it is almost always zero. */
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->vvp.mode_index = p->one->mode;
+		hashcpy(d->vvp.sha1_index, p->one->sha1);
+		break;
+
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_RENAMED:
+	case DIFF_STATUS_TYPE_CHANGED:
+		d->vvp.mode_index = p->one->mode;
+		d->vvp.mode_worktree = p->two->mode;
+		hashcpy(d->vvp.sha1_index, p->one->sha1);
+		/* don't bother with worktree sha, since it is almost always zero. */
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		/* This should never happen. */
+		break;
+
+	case DIFF_STATUS_UNMERGED:
+		/* This should never happen. */
+		break;
+	}
+}
+
+static void vvp_added_initial_entry(
+	struct wt_status_change_data *d,
+	const struct cache_entry *ce)
+{
+	d->vvp.mode_index = ce->ce_mode;
+	hashcpy(d->vvp.sha1_index, ce->sha1);
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -433,6 +516,9 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		d->dirty_submodule = p->two->dirty_submodule;
 		if (S_ISGITLINK(p->two->mode))
 			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
+
+		if (s->verbose > 1)
+			vvp_changed_entry(d, p);
 	}
 }
 
@@ -486,6 +572,9 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			d->stagemask = unmerged_mask(p->two->path);
 			break;
 		}
+
+		if (s->verbose > 1)
+			vvp_updated_entry(d, p);
 	}
 }
 
@@ -565,8 +654,12 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
 		}
-		else
+		else {
 			d->index_status = DIFF_STATUS_ADDED;
+
+			if (s->verbose > 1)
+				vvp_added_initial_entry(d, ce);
+		}
 	}
 }
 
@@ -1751,5 +1844,584 @@ void wt_porcelain_print(struct wt_status *s)
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
-	wt_shortstatus_print(s);
+
+	if (s->verbose > 1)
+		wt_porcelain_very_verbose_print(s);
+	else
+		wt_shortstatus_print(s);
+}
+
+/*****************************************************************
+ * Very Verbose Porcelain Output Routines.
+ *****************************************************************/
+
+static int wt_vvp_count_unmerged(struct wt_status *s)
+{
+	int sum = 0;
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = s->change.items[i].util;
+		if (d->stagemask)
+			sum++;
+	}
+	return sum;
+}
+
+static int wt_vvp_count_rebase_todolist(
+	const char *path)
+{
+	int count = 0;
+
+	if (file_exists(git_path("%s", path))) {
+		struct string_list list = STRING_LIST_INIT_DUP;
+		read_rebase_todolist(path, &list);
+		count = list.nr;
+		string_list_clear(&list, 0);
+	}
+
+	return count;
+}
+
+/* Print very verbose porcelain output for state data.
+ * This is a one-line summary of any current operation in progress.
+ * The code here tests the various state variables in the
+ * same order as wt_status_print_state() to minimize discrepancies.
+ *
+ *
+ *    "### state: merge <nr_unmerged><eol>"
+ *
+ *         <nr_unmerged> ::= integer number of unmerged files.
+ *
+ *
+ *    "### state: am[ <is_empty>]<eol>"
+ *
+ *            <is_empty> ::= "E" if the current patch is empty.
+ *
+ *
+ *    "### state: rebase <nr_unmerged>[ <S>][ <E>][ <I>][ <branches>]<eol>"
+ *
+ *         <nr_unmerged> ::= integer number of unmerged files.
+ *
+ *                   <S> ::= "S" if a split in progress.
+ *                   <E> ::= "E" if edit is in progress.
+ *                   <I> ::= "I(<steps_done>/<steps_total>)" if interactive.
+ *
+ *            <branches> ::= "<current>:<onto>"
+ *             <current> ::= The current branch name.
+ *                <onto> ::= the onto branch name.
+ *
+ *
+ *    "### state: cherrypick <sha1> <nr_unmerged><eol>"
+ *
+ *                <sha1> ::= 40 character SHA1 of the commit.
+ *         <nr_unmerged> ::= integer number of unmerged files.
+ *
+ *
+ *    "### state: revert <sha1> <nr_unmerged><eol>"
+ *
+ *                <sha1> ::= 40 character SHA1 of the commit.
+ *         <nr_unmerged> ::= integer number of unmerged files.
+ *
+ *
+ *    "### state: bisect[ <branch>]<eol>"
+ *
+ *              <branch> ::= the branch name, when defined.
+ *
+ *
+ *    "### state: clean<eol>"
+ *
+ *
+ * In all variations, the end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ */
+static void wt_vvp_print_state(
+	struct wt_status *s,
+	struct wt_status_state *state)
+{
+	struct stat st;
+
+	fprintf(s->fp, "### state:");
+
+	if (state->merge_in_progress) {
+		fprintf(s->fp, " merge %d", wt_vvp_count_unmerged(s));
+	} else if (state->am_in_progress) {
+		fprintf(s->fp, " am");
+		if (state->am_empty_patch)
+			fprintf(s->fp, " E");
+	} else if (state->rebase_in_progress || state->rebase_interactive_in_progress) {
+		int count = wt_vvp_count_unmerged(s);
+		int split = split_commit_in_progress(s);
+		int edit = (!(count || split || state->rebase_in_progress ||
+					  !stat(git_path_merge_msg(), &st)));
+		fprintf(s->fp, " rebase");
+		fprintf(s->fp, " %d", count);
+		if (split)
+			fprintf(s->fp, " S");
+		if (edit)
+			fprintf(s->fp, " E");
+		if (state->rebase_interactive_in_progress) {
+			int nr_done = wt_vvp_count_rebase_todolist("rebase-merge/done");
+			int nr_todo = wt_vvp_count_rebase_todolist("rebase-merge/git-rebase-todo");
+			fprintf(s->fp, " I(%d/%d)", nr_done, nr_done + nr_todo);
+		}
+		if (state->branch) {
+			fprintf(s->fp, " %s:%s", state->branch, state->onto);
+		}
+	} else if (state->cherry_pick_in_progress) {
+		fprintf(s->fp, " cherrypick %s %d",
+				find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV),
+				wt_vvp_count_unmerged(s));
+	} else if (state->revert_in_progress) {
+		fprintf(s->fp, " revert %s %d",
+				find_unique_abbrev(state->revert_head_sha1, DEFAULT_ABBREV),
+				wt_vvp_count_unmerged(s));
+	} else if (state->bisect_in_progress) {
+		fprintf(s->fp, " bisect");
+		if (state->branch) {
+			fprintf(s->fp, " %s", state->branch);
+		}
+	} else {
+		fprintf(s->fp, " clean");
+	}
+	fprintf(s->fp, "%c", (s->null_termination ? '\0' : '\n'));
+}
+
+/* Print branch tracking information for very verbose porcelain output.
+ * This is a one-line summary of the branch and tracking information.
+ * The code here is modeled on wt_shortstatus_print_tracking().
+ *
+ *    "### track: <commit>[ <head>[:<upstream>[ +<ahead> -<behind>]]<eol>"
+ *
+ *              <commit> ::= <sha1>
+ *                           40 character SHA1 of the current commit.
+ *              <commit> ::= "(initial)" literal to indicate initialized
+ *                           repo with no commits.
+ *
+ *                <head> ::= <branch_name> the current branch name.
+ *                <head> ::= "(detached)" literal when detached head.
+ *
+ *            <upstream> ::= the upstream branch name, when set.
+ *
+ *               <ahead> ::= integer ahead value, when upstream set
+ *                           and commit is present.
+ *
+ *              <behind> ::= integer behind value, when upstream set
+ *                           and commit is present.
+ *
+ *
+ * The end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ */
+static void wt_vvp_print_state_and_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *base;
+	const char *branch_name;
+	struct wt_status_state state;
+	int ab_info, nr_ahead, nr_behind;
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state,
+						s->branch && !strcmp(s->branch, "HEAD"));
+	wt_vvp_print_state(s, &state);
+
+	fprintf(s->fp, "### track:");
+	fprintf(s->fp, " %s",
+			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha_commit)));
+
+	if (s->branch) {
+		if (!strcmp(s->branch, "HEAD")) {
+			fprintf(s->fp, " %s", "(detached)");
+			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
+				branch_name = state.onto;
+			} else if (state.detached_from) {
+				branch_name = state.detached_from;
+			} else {
+				branch_name = "";
+			}
+		} else {
+			branch_name = NULL;
+			skip_prefix(s->branch, "refs/heads/", &branch_name);
+			fprintf(s->fp, " %s", branch_name);
+		}
+
+		/* Lookup stats on the upstream tracking branch, if set. */
+		branch = branch_get(branch_name);
+		base = NULL;
+		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		if (base) {
+			base = shorten_unambiguous_ref(base, 0);
+			fprintf(s->fp, ":%s", base);
+			free((char *)base);
+
+			if (ab_info)
+				fprintf(s->fp, " +%d -%d", nr_ahead, nr_behind);
+		}
+	}
+
+	fprintf(s->fp, "%c", (s->null_termination ? '\0' : '\n'));
+
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+}
+
+/* Convert various submodule status values into a
+ * single bitmask integer key and return character
+ * '0' through '7'.
+ *
+ * We do this instead of trying to find a meaningful
+ * mnemonic for each combination; this also avoids
+ * confusion redefining values used by the X and Y bits.
+ *
+ *     0 => when the submodule is clean.
+ *     1 => when submodule contains untracked changes.
+ *     2 => when submodule is modified.
+ *     4 => when submodule has new commit.
+ *
+ * We return ' ' if the entry is not a submodule.
+ *
+ */
+static char wt_vvp_summary_submodule_state(
+	struct wt_status_change_data *d)
+{
+	if (S_ISGITLINK(d->vvp.mode_head) ||
+		S_ISGITLINK(d->vvp.mode_index) ||
+		S_ISGITLINK(d->vvp.mode_worktree)) {
+		int summary = 0;
+
+		if (d->new_submodule_commits)
+			summary |= 0x4;
+		if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+			summary |= 0x2;
+		if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+			summary |= 0x1;
+
+		return '0' + summary;
+	}
+
+	return ' ';
+}
+
+/* Various fix-up steps before we start printing an item.
+ */
+static void wt_vvp_fix_up_status(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+
+	if (!d->index_status) {
+		if (d->worktree_status == DIFF_STATUS_MODIFIED ||
+			d->worktree_status == DIFF_STATUS_DELETED) {
+			/* X=' ' Y=[MD]
+			 * The item did not change in head-vs-index scan so the head
+			 * column was never set. (The index column was set during the
+			 * index-vs-worktree scan.)
+			 * Force set the head column to make the output complete.
+			 */
+			d->vvp.mode_head = d->vvp.mode_index;
+			hashcpy(d->vvp.sha1_head, d->vvp.sha1_index);
+		}
+	}
+
+	if (!d->worktree_status) {
+		if (d->index_status == DIFF_STATUS_MODIFIED ||
+			d->index_status == DIFF_STATUS_ADDED ||
+			d->index_status == DIFF_STATUS_RENAMED ||
+			d->index_status == DIFF_STATUS_COPIED) {
+			/* X=[MARC] Y=' '
+			 * The item did not changed in the index-vs-worktree scan so
+			 * the worktree column was never set.
+			 * Force set the worktree mode to make the output complete.
+			 */
+			d->vvp.mode_worktree = d->vvp.mode_index;
+		}
+	}
+}
+
+/* Print very verbose porcelain info for normal tracked entries.
+ * Like wt_shortstatus_print().
+ *
+ * Detail lines for normal tracked entries (that are NOT in a
+ * merge conflict) have the following format:
+ *
+ *    "<keys> <mh> <mi> <mw> <sha_h> <sha_i> [<score> <path_1><tab>]<path_2><eol>"
+ *
+ *                <keys> ::= <X><Y><S>
+ *
+ *                   <X> ::= 1 character [ MADRC] See the "X" column in the short format.
+ *                   <Y> ::= 1 character [ MD]    See the "Y" column in the short format.
+ *                   <S> ::= 1 digit integer submodule status or space.
+ *
+ *                  <mh> ::= 6 character octal integer git "mode" for version of entry in head.
+ *                           For example, 100644 for regular files.
+ *                  <mi> ::= 6 character octal integer for mode in index.
+ *                  <mw> ::= 6 character octal integer for mode in worktree.
+ *
+ *               <sha_h> ::= 40 character SHA1 of the content in the head.
+ *               <sha_i> ::= 40 character SHA1 of the staged content.
+ *
+ *               <score> ::= Rename percentage score.  This is an integer
+ *                           value between 0 and 100.  It is only present
+ *                           when a rename is staged (when <X> == 'R').
+ *              <path_1> ::= Pathname of the file in the head, quoted if necessary.
+ *                           Only present if a rename is staged.
+ *
+ *                 <tab> ::= literal tab (0x09) byte pathname delimiter.
+ *                           Only present if a rename is staged.
+ *
+ *              <path_2> ::= Pathname of the current file, quoted if necessary.
+ *
+ *
+ * The end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ *
+ * Unlike shortstatus, we DO NOT swap the head and index pathnames
+ * based upon the -z flag.
+ *
+ */
+static void wt_vvp_print_status(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	char keys[4];
+
+	wt_vvp_fix_up_status(it, s);
+
+	keys[0] = d->index_status ? d->index_status : ' ';
+	keys[1] = d->worktree_status ? d->worktree_status : ' ';
+	keys[2] = wt_vvp_summary_submodule_state(d);
+	keys[3] = 0;
+
+	fprintf(s->fp, "%s %06o %06o %06o %s %s",
+			keys,
+			d->vvp.mode_head,
+			d->vvp.mode_index,
+			d->vvp.mode_worktree,
+			sha1_to_hex(d->vvp.sha1_head),
+			sha1_to_hex(d->vvp.sha1_index));
+
+	if (d->head_path) {
+		struct strbuf buf_1 = STRBUF_INIT;
+		struct strbuf buf_2 = STRBUF_INIT;
+		const char *path_1 = quote_path(d->head_path, s->prefix, &buf_1);
+		const char *path_2 = quote_path(it->string, s->prefix, &buf_2);
+
+		fprintf(s->fp, " %d %s%c%s",
+				d->vvp.rename_score,
+				path_1,
+				'\t',
+				path_2);
+
+		strbuf_release(&buf_1);
+		strbuf_release(&buf_2);
+
+	} else {
+		struct strbuf buf = STRBUF_INIT;
+		const char *path = quote_path(it->string, s->prefix, &buf);
+		fprintf(s->fp, " %s", path);
+		strbuf_release(&buf);
+	}
+
+	fprintf(s->fp, "%c", (s->null_termination ? '\0' : '\n'));
+}
+
+/* Print very verbose porcelain status info for unmerged entries.
+ * Like wt_shortstatus_unmerged().
+ *
+ * Detail lines for unmerged entries have the following format:
+ *
+ *    "<keys> <m1> <m2> <m3> <mw> <sha1> <sha2> <sha3> <path><eol>
+ *
+ *                <keys> ::= <X><Y><S>
+ *
+ *                   <X> ::= [ADU] See the "X" column in the short format.
+ *                   <Y> ::= [ADU] See the "Y" column in the short format.
+ *                   <S> ::= 1 digit integer submodule status or space.
+ *
+ *                  <m1> ::= 6 character octal integer for stage 1 git "mode".
+ *                           For example, 100644 for regular files.
+ *                  <m2> ::= 6 character octal integer for stage 2 mode.
+ *                  <m3> ::= 6 character octal integer for stage 3 mode.
+ *                  <mw> ::= 6 character octal integer worktree mode.
+ *
+ *                <sha1> ::= 40 character SHA1 of the stage 1 content.
+ *                <sha2> ::= 40 character SHA1 of the stage 2 content.
+ *                <sha3> ::= 40 character SHA1 of the stage 3 content.
+ *
+ *                <path> ::= Pathname of the current file, quoted if necessary.
+ *
+ *
+ * The end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ *
+ * Only one pathname is printed, regardless of renames.
+ * This is consistent with the short format.
+ *
+ */
+static void wt_vvp_print_unmerged(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct {
+		int mode;
+		unsigned char sha1[20];
+	} stages[3];
+	struct strbuf buf = STRBUF_INIT;
+	struct wt_status_change_data *d = it->util;
+	const struct cache_entry *ce;
+	const char *path = quote_path(it->string, s->prefix, &buf);
+	const char *how = "??";
+	int pos, stage;
+	char sub = wt_vvp_summary_submodule_state(d);
+
+	switch (d->stagemask) {
+	case 1: how = "DD"; break; /* both deleted */
+	case 2: how = "AU"; break; /* added by us */
+	case 3: how = "UD"; break; /* deleted by them */
+	case 4: how = "UA"; break; /* added by them */
+	case 5: how = "DU"; break; /* deleted by us */
+	case 6: how = "AA"; break; /* both added */
+	case 7: how = "UU"; break; /* both modified */
+	}
+
+	/* Lookup {mode,sha} for stages[123] */
+	memset(stages, 0, sizeof(stages));
+	pos = cache_name_pos(it->string, strlen(it->string));
+	assert(pos < 0);
+	pos = -pos-1;
+	while (pos < active_nr) {
+		ce = active_cache[pos++];
+		stage = ce_stage(ce);
+		if (strcmp(ce->name, it->string) || !stage)
+			break;
+		stages[stage - 1].mode = ce->ce_mode;
+		hashcpy(stages[stage - 1].sha1, ce->sha1);
+	}
+
+	/* Disregard the vvp values for head and index from the diffs because
+	 * they are redundant with the stage data.
+	 */
+	fprintf(s->fp, "%s%c %06o %06o %06o %06o %s %s %s %s%c",
+			how, sub,
+			stages[0].mode, stages[1].mode, stages[2].mode, d->vvp.mode_worktree,
+			sha1_to_hex(stages[0].sha1),
+			sha1_to_hex(stages[1].sha1),
+			sha1_to_hex(stages[2].sha1),
+			path,
+			(s->null_termination ? '\0' : '\n'));
+
+	strbuf_release(&buf);
+}
+
+/* Print very verbose porcelain status info for "other"
+ * entries (such as untracked and ignored).
+ * Like wt_shortstatus_other().
+ *
+ * Detail lines for untracked and ignored entries have
+ * the following format:
+ *
+ *    "<XXX> <path><eol>"
+ *
+ *                 <XXX> ::= 3 character version of "XY" short format
+ *                           (for column alignment with other row types).
+ *
+ *                <path> ::= Pathname of the entry, quoted if necessary.
+ *
+ *
+ * The end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ */
+static void wt_vvp_print_other(
+	struct string_list_item *it,
+	struct wt_status *s,
+	const char *sign)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *path = quote_path(it->string, s->prefix, &buf);
+
+	fprintf(s->fp, "%s %s%c",
+			sign,
+			path,
+			(s->null_termination ? '\0' : '\n'));
+
+	strbuf_release(&buf);
+}
+
+/* Print very verbose porcelain status.
+ *
+ * If "-b", the output will start with 2 fixed header lines containing
+ * the overall state and tracking information.
+ *
+ * Output is then followed by a series of detail lines for
+ * tracked items (either normal changes or unmerged conflicts).
+ *
+ * Output is then followed by detail lines for any untracked
+ * items.  This depends upon the '-u' option.
+ *
+ * Output is then followed by detail lines for any ignored
+ * items.  This depends upon the '--ignored' option.
+ *
+ * Line format information is given with the individual
+ * sections.
+ *
+ *
+ * [<state>
+ *  <track>]
+ * [<tracked_items>]*
+ * [<untracked_items>]*
+ * [<ignored_items>]*
+ *
+ */
+void wt_porcelain_very_verbose_print(struct wt_status *s)
+{
+	int i;
+
+	if (s->show_branch)
+		wt_vvp_print_state_and_tracking(s);
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s->change.items[i]);
+		d = it->util;
+
+		if (d->stagemask)
+			wt_vvp_print_unmerged(it, s);
+		else
+			wt_vvp_print_status(it, s);
+	}
+
+	for (i = 0; i < s->untracked.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->untracked.items[i]);
+		wt_vvp_print_other(it, s, "???");
+	}
+
+	for (i = 0; i < s->ignored.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->ignored.items[i]);
+		wt_vvp_print_other(it, s, "!!!");
+	}
 }
diff --git a/wt-status.h b/wt-status.h
index 2ca93f6..c78bac2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -39,6 +39,14 @@ struct wt_status_change_data {
 	int index_status;
 	int stagemask;
 	char *head_path;
+
+	struct
+	{
+		int rename_score;
+		int mode_head, mode_index, mode_worktree;
+		unsigned char sha1_head[20], sha1_index[20];
+	} vvp;
+
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
 };
@@ -65,6 +73,7 @@ struct wt_status {
 	int null_termination;
 	int show_branch;
 	int hints;
+	unsigned char sha_commit[GIT_SHA1_RAWSZ]; /* Commit SHA (when not Initial) */
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
@@ -109,6 +118,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
+void wt_porcelain_very_verbose_print(struct wt_status *s);
 
 __attribute__((format (printf, 3, 4)))
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
-- 
2.8.0.rc4.17.gac42084.dirty

