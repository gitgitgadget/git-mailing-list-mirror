From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 15/23] git notes merge: Manual conflict resolution, part 1/2
Date: Mon, 25 Oct 2010 02:08:45 +0200
Message-ID: <1287965333-5099-16-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdl-0000ju-Sf
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab0JYAJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59910 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab0JYAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:26 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0051AKFKGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:20 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id AE576179913F_CC4CAB0B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:20 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 75F871796C46_CC4CAB0F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:19 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:15 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159907>

Conflicts (that are to be resolved manually) are written into a special-
purpose working tree, located at .git/NOTES_MERGE_WORKTREE. Within this
directory, conflicting notes entries are stored (with conflict markers
produced by ll_merge()) using the SHA1 of the annotated object. The
.git/NOTES_MERGE_WORKTREE directory will only contain the _conflicting_
note entries. The non-conflicting note entries (aka. the partial merge
result) are stored in 'local_tree', and the SHA1 of the resulting commit
is written to 'result_sha1'. The return value from notes_merge() is -1.

The user is told to edit the files within the .git/NOTES_MERGE_WORKTREE
directory in order to resolve the conflicts.

The patch also contains documentation and testcases for the correct setup
of .git/NOTES_MERGE_WORKTREE.

The next part will recombine the partial notes merge result with the
resolved conflicts in .git/NOTES_MERGE_WORKTREE to produce the complete
merge result.

This patch has been improved by the following contributions:
- Jonathan Nieder: Use trace_printf(...) instead of OUTPUT(o, 5, ...)

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt           |   10 +-
 builtin/notes.c                       |    8 +-
 notes-merge.c                         |  166 ++++++++++++++++++-
 notes-merge.h                         |   11 +-
 t/t3310-notes-merge-manual-resolve.sh |  292 +++++++++++++++++++++++++++++++++
 5 files changed, 474 insertions(+), 13 deletions(-)
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 07a5042..f003b7c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -92,7 +92,9 @@ merge::
 +
 If conflicts arise and a strategy for automatically resolving
 conflicting notes (see the -s/--strategy option) is not given,
-the merge fails (TODO).
+the "manual" resolver is used. This resolver checks out the
+conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
+and instructs the user to manually resolve the conflicts there.
 
 remove::
 	Remove the notes for a given object (defaults to HEAD).
@@ -191,8 +193,10 @@ object, in which case the history of the notes can be read with
 NOTES MERGE STRATEGIES
 ----------------------
 
-The default notes merge strategy is "manual", which is not yet
-implemented (TODO).
+The default notes merge strategy is "manual", which checks out
+conflicting notes in a special work tree for resolving notes conflicts
+(`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
+conflicts in that work tree.
 
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
diff --git a/builtin/notes.c b/builtin/notes.c
index a249f19..7a2a288 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -820,14 +820,14 @@ static int merge(int argc, const char **argv, const char *prefix)
 		/* Update default notes ref with new commit */
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, DIE_ON_ERR);
-	else
-		/* TODO: */
-		die("'git notes merge' cannot yet handle conflicts!");
+	else /* Merge has unresolved conflicts */
+		printf("Automatic notes merge failed. Fix conflicts in %s.\n",
+		       git_path(NOTES_MERGE_WORKTREE));
 
 	free_notes(t);
 	strbuf_release(&remote_ref);
 	strbuf_release(&msg);
-	return 0;
+	return result < 0; /* return non-zero on conflicts */
 }
 
 static int remove_cmd(int argc, const char **argv, const char *prefix)
diff --git a/notes-merge.c b/notes-merge.c
index f2fa12d..5734d0b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -3,6 +3,9 @@
 #include "refs.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "xdiff-interface.h"
+#include "ll-merge.h"
+#include "dir.h"
 #include "notes.h"
 #include "notes-merge.h"
 
@@ -263,16 +266,169 @@ static void diff_tree_local(struct notes_merge_options *o,
 	diff_tree_release_paths(&opt);
 }
 
+static void check_notes_merge_worktree(struct notes_merge_options *o)
+{
+	if (!o->has_worktree) {
+		/*
+		 * Must establish NOTES_MERGE_WORKTREE.
+		 * Abort if NOTES_MERGE_WORKTREE already exists
+		 */
+		if (file_exists(git_path(NOTES_MERGE_WORKTREE))) {
+			if (advice_resolve_conflict)
+				die("You have not concluded your previous "
+				    "notes merge (%s exists).\nPlease, use "
+				    "'git notes merge --commit' or 'git notes "
+				    "merge --reset' to commit/abort the "
+				    "previous merge before you start a new "
+				    "notes merge.", git_path("NOTES_MERGE_*"));
+			else
+				die("You have not concluded your notes merge "
+				    "(%s exists).", git_path("NOTES_MERGE_*"));
+		}
+
+		if (safe_create_leading_directories(git_path(
+				NOTES_MERGE_WORKTREE "/.test")))
+			die_errno("unable to create directory %s",
+				  git_path(NOTES_MERGE_WORKTREE));
+		o->has_worktree = 1;
+	} else if (!file_exists(git_path(NOTES_MERGE_WORKTREE)))
+		/* NOTES_MERGE_WORKTREE should already be established */
+		die("missing '%s'. This should not happen",
+		    git_path(NOTES_MERGE_WORKTREE));
+}
+
+static void write_buf_to_worktree(const unsigned char *obj,
+				  const char *buf, unsigned long size)
+{
+	int fd;
+	char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	if (safe_create_leading_directories(path))
+		die_errno("unable to create directory for '%s'", path);
+	if (file_exists(path))
+		die("found existing file at '%s'", path);
+
+	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("failed to open '%s'", path);
+
+	while (size > 0) {
+		long ret = write_in_full(fd, buf, size);
+		if (ret < 0) {
+			/* Ignore epipe */
+			if (errno == EPIPE)
+				break;
+			die_errno("notes-merge");
+		} else if (!ret) {
+			die("notes-merge: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+
+	close(fd);
+}
+
+static void write_note_to_worktree(const unsigned char *obj,
+				   const unsigned char *note)
+{
+	enum object_type type;
+	unsigned long size;
+	void *buf = read_sha1_file(note, &type, &size);
+
+	if (!buf)
+		die("cannot read note %s for object %s",
+		    sha1_to_hex(note), sha1_to_hex(obj));
+	if (type != OBJ_BLOB)
+		die("blob expected in note %s for object %s",
+		    sha1_to_hex(note), sha1_to_hex(obj));
+	write_buf_to_worktree(obj, buf, size);
+	free(buf);
+}
+
+static int ll_merge_in_worktree(struct notes_merge_options *o,
+				struct notes_merge_pair *p)
+{
+	mmbuffer_t result_buf;
+	mmfile_t base, local, remote;
+	int status;
+
+	read_mmblob(&base, p->base);
+	read_mmblob(&local, p->local);
+	read_mmblob(&remote, p->remote);
+
+	status = ll_merge(&result_buf, sha1_to_hex(p->obj), &base, NULL,
+			  &local, o->local_ref, &remote, o->remote_ref, 0);
+
+	free(base.ptr);
+	free(local.ptr);
+	free(remote.ptr);
+
+	if ((status < 0) || !result_buf.ptr)
+		die("Failed to execute internal merge");
+
+	write_buf_to_worktree(p->obj, result_buf.ptr, result_buf.size);
+	free(result_buf.ptr);
+
+	return status;
+}
+
+static int merge_one_change_manual(struct notes_merge_options *o,
+				   struct notes_merge_pair *p,
+				   struct notes_tree *t)
+{
+	const char *lref = o->local_ref ? o->local_ref : "local version";
+	const char *rref = o->remote_ref ? o->remote_ref : "remote version";
+
+	trace_printf("\t\t\tmerge_one_change_manual(obj = %.7s, base = %.7s, "
+	       "local = %.7s, remote = %.7s)\n",
+	       sha1_to_hex(p->obj), sha1_to_hex(p->base),
+	       sha1_to_hex(p->local), sha1_to_hex(p->remote));
+
+	OUTPUT(o, 2, "Auto-merging notes for %s", sha1_to_hex(p->obj));
+	check_notes_merge_worktree(o);
+	if (is_null_sha1(p->local)) {
+		/* D/F conflict, checkout p->remote */
+		assert(!is_null_sha1(p->remote));
+		OUTPUT(o, 1, "CONFLICT (delete/modify): Notes for object %s "
+		       "deleted in %s and modified in %s. Version from %s "
+		       "left in tree.", sha1_to_hex(p->obj), lref, rref, rref);
+		write_note_to_worktree(p->obj, p->remote);
+	} else if (is_null_sha1(p->remote)) {
+		/* D/F conflict, checkout p->local */
+		assert(!is_null_sha1(p->local));
+		OUTPUT(o, 1, "CONFLICT (delete/modify): Notes for object %s "
+		       "deleted in %s and modified in %s. Version from %s "
+		       "left in tree.", sha1_to_hex(p->obj), rref, lref, lref);
+		write_note_to_worktree(p->obj, p->local);
+	} else {
+		/* "regular" conflict, checkout result of ll_merge() */
+		const char *reason = "content";
+		if (is_null_sha1(p->base))
+			reason = "add/add";
+		assert(!is_null_sha1(p->local));
+		assert(!is_null_sha1(p->remote));
+		OUTPUT(o, 1, "CONFLICT (%s): Merge conflict in notes for "
+		       "object %s", reason, sha1_to_hex(p->obj));
+		ll_merge_in_worktree(o, p);
+	}
+
+	trace_printf("\t\t\tremoving from partial merge result\n");
+	remove_note(t, p->obj);
+
+	return 1;
+}
+
 static int merge_one_change(struct notes_merge_options *o,
 			    struct notes_merge_pair *p, struct notes_tree *t)
 {
 	/*
-	 * Return 0 if change was resolved (and added to notes_tree),
-	 * 1 if conflict
+	 * Return 0 if change is successfully resolved (stored in notes_tree).
+	 * Return 1 is change results in a conflict (NOT stored in notes_tree,
+	 * but instead written to NOTES_MERGE_WORKTREE with conflict markers).
 	 */
 	switch (o->strategy) {
 	case NOTES_MERGE_RESOLVE_MANUAL:
-		return 1;
+		return merge_one_change_manual(o, p, t);
 	case NOTES_MERGE_RESOLVE_OURS:
 		OUTPUT(o, 2, "Using local notes for %s", sha1_to_hex(p->obj));
 		/* nothing to do */
@@ -478,8 +634,8 @@ int notes_merge(struct notes_merge_options *o,
 	result = merge_from_diffs(o, base_tree_sha1, local->tree->object.sha1,
 				  remote->tree->object.sha1, local_tree);
 
-	if (result > 0) { /* successful non-trivial merge */
-		/* Commit result */
+	if (result != 0) { /* non-trivial merge (with or without conflicts) */
+		/* Commit (partial) result */
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
diff --git a/notes-merge.h b/notes-merge.h
index ed356ae..55ef3d9 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -1,6 +1,8 @@
 #ifndef NOTES_MERGE_H
 #define NOTES_MERGE_H
 
+#define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
+
 enum notes_merge_verbosity {
 	NOTES_MERGE_VERBOSITY_DEFAULT = 2,
 	NOTES_MERGE_VERBOSITY_MAX = 5
@@ -17,6 +19,7 @@ struct notes_merge_options {
 		NOTES_MERGE_RESOLVE_THEIRS,
 		NOTES_MERGE_RESOLVE_UNION
 	} strategy;
+	unsigned has_worktree:1;
 };
 
 void init_notes_merge_options(struct notes_merge_options *o);
@@ -51,7 +54,13 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
  * 2. The merge successfully completes, producing a merge commit. local_tree
  *    contains the updated notes tree, the SHA1 of the resulting commit is
  *    written into 'result_sha1', and 1 is returned.
- * 3. The merge fails. result_sha1 is set to null_sha1, and -1 is returned.
+ * 3. The merge results in conflicts. This is similar to #2 in that the
+ *    partial merge result (i.e. merge result minus the unmerged entries)
+ *    are stored in 'local_tree', and the SHA1 or the resulting commit
+ *    (to be amended when the conflicts have been resolved) is written into
+ *    'result_sha1'. The unmerged entries are written into the
+ *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
+ *    -1 is returned.
  *
  * Both o->local_ref and o->remote_ref must be given (non-NULL), but either ref
  * (although not both) may refer to a non-existing notes ref, in which case
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
new file mode 100755
index 0000000..eadb6b7
--- /dev/null
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -0,0 +1,292 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johan Herland
+#
+
+test_description='Test notes merging with manual conflict resolution'
+
+. ./test-lib.sh
+
+# Set up a notes merge scenario with different kinds of conflicts
+test_expect_success 'setup commits' '
+	test_commit 1st &&
+	test_commit 2nd &&
+	test_commit 3rd &&
+	test_commit 4th &&
+	test_commit 5th
+'
+
+commit_sha1=$(git rev-parse 1st^{commit})
+commit_sha2=$(git rev-parse 2nd^{commit})
+commit_sha3=$(git rev-parse 3rd^{commit})
+commit_sha4=$(git rev-parse 4th^{commit})
+commit_sha5=$(git rev-parse 5th^{commit})
+
+verify_notes () {
+	notes_ref="$1"
+	git -c core.notesRef="refs/notes/$notes_ref" notes |
+		sort >"output_notes_$notes_ref" &&
+	test_cmp "expect_notes_$notes_ref" "output_notes_$notes_ref" &&
+	git -c core.notesRef="refs/notes/$notes_ref" log --format="%H %s%n%N" \
+		>"output_log_$notes_ref" &&
+	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
+}
+
+cat <<EOF | sort >expect_notes_x
+6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
+e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
+ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+x notes on 4th commit
+
+$commit_sha3 3rd
+x notes on 3rd commit
+
+$commit_sha2 2nd
+x notes on 2nd commit
+
+$commit_sha1 1st
+
+EOF
+
+test_expect_success 'setup merge base (x)' '
+	git config core.notesRef refs/notes/x &&
+	git notes add -m "x notes on 2nd commit" 2nd &&
+	git notes add -m "x notes on 3rd commit" 3rd &&
+	git notes add -m "x notes on 4th commit" 4th &&
+	verify_notes x
+'
+
+cat <<EOF | sort >expect_notes_y
+e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
+b0a6021ec006d07e80e9b20ec9b444cbd9d560d3 $commit_sha1
+EOF
+
+cat >expect_log_y <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+y notes on 4th commit
+
+$commit_sha3 3rd
+y notes on 3rd commit
+
+$commit_sha2 2nd
+
+$commit_sha1 1st
+y notes on 1st commit
+
+EOF
+
+test_expect_success 'setup local branch (y)' '
+	git update-ref refs/notes/y refs/notes/x &&
+	git config core.notesRef refs/notes/y &&
+	git notes add -f -m "y notes on 1st commit" 1st &&
+	git notes remove 2nd &&
+	git notes add -f -m "y notes on 3rd commit" 3rd &&
+	git notes add -f -m "y notes on 4th commit" 4th &&
+	verify_notes y
+'
+
+cat <<EOF | sort >expect_notes_z
+cff59c793c20bb49a4e01bc06fb06bad642e0d54 $commit_sha4
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+0a81da8956346e19bcb27a906f04af327e03e31b $commit_sha1
+EOF
+
+cat >expect_log_z <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+z notes on 4th commit
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+z notes on 1st commit
+
+EOF
+
+test_expect_success 'setup remote branch (z)' '
+	git update-ref refs/notes/z refs/notes/x &&
+	git config core.notesRef refs/notes/z &&
+	git notes add -f -m "z notes on 1st commit" 1st &&
+	git notes add -f -m "z notes on 2nd commit" 2nd &&
+	git notes remove 3rd &&
+	git notes add -f -m "z notes on 4th commit" 4th &&
+	verify_notes z
+'
+
+# At this point, before merging z into y, we have the following status:
+#
+# commit | base/x  | local/y | remote/z | diff from x to y/z
+# -------|---------|---------|----------|---------------------------
+# 1st    | [none]  | b0a6021 | 0a81da8  | added     / added (diff)
+# 2nd    | ceefa67 | [none]  | 283b482  | removed   / changed
+# 3rd    | e5388c1 | 5772f42 | [none]   | changed   / removed
+# 4th    | 6e8e3fe | e2bfd06 | cff59c7  | changed   / changed (diff)
+# 5th    | [none]  | [none]  | [none]   | [none]
+
+cat <<EOF | sort >expect_conflicts
+$commit_sha1
+$commit_sha2
+$commit_sha3
+$commit_sha4
+EOF
+
+cat >expect_conflict_$commit_sha1 <<EOF
+<<<<<<< refs/notes/m
+y notes on 1st commit
+=======
+z notes on 1st commit
+>>>>>>> refs/notes/z
+EOF
+
+cat >expect_conflict_$commit_sha2 <<EOF
+z notes on 2nd commit
+EOF
+
+cat >expect_conflict_$commit_sha3 <<EOF
+y notes on 3rd commit
+EOF
+
+cat >expect_conflict_$commit_sha4 <<EOF
+<<<<<<< refs/notes/m
+y notes on 4th commit
+=======
+z notes on 4th commit
+>>>>>>> refs/notes/z
+EOF
+
+cp expect_notes_y expect_notes_m
+cp expect_log_y expect_log_m
+
+git rev-parse refs/notes/y > pre_merge_y
+
+test_expect_success 'merge z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
+	git update-ref refs/notes/m refs/notes/y &&
+	git config core.notesRef refs/notes/m &&
+	test_must_fail git notes merge z >output &&
+	# Output should point to where to resolve conflicts
+	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	# Inspect merge conflicts
+	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	test_cmp expect_conflicts output_conflicts &&
+	( for f in $(cat expect_conflicts); do
+		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		exit 1
+	done ) &&
+	# Verify that current notes tree (pre-merge) has not changed (m == y)
+	verify_notes y &&
+	verify_notes m &&
+	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+'
+
+cat <<EOF | sort >expect_notes_z
+00494adecf2d9635a02fa431308d67993f853968 $commit_sha4
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+0a81da8956346e19bcb27a906f04af327e03e31b $commit_sha1
+EOF
+
+cat >expect_log_z <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+z notes on 4th commit
+
+More z notes on 4th commit
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+z notes on 1st commit
+
+EOF
+
+test_expect_success 'change notes in z' '
+	git notes --ref z append -m "More z notes on 4th commit" 4th &&
+	verify_notes z
+'
+
+test_expect_success 'cannot do merge w/conflicts when previous merge is unfinished' '
+	test -d .git/NOTES_MERGE_WORKTREE &&
+	test_must_fail git notes merge z >output 2>&1 &&
+	# Output should indicate what is wrong
+	grep -q "\\.git/NOTES_MERGE_\\* exists" output
+'
+
+# Setup non-conflicting merge between x and new notes ref w
+
+cat <<EOF | sort >expect_notes_w
+ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
+f75d1df88cbfe4258d49852f26cfc83f2ad4494b $commit_sha1
+EOF
+
+cat >expect_log_w <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+x notes on 2nd commit
+
+$commit_sha1 1st
+w notes on 1st commit
+
+EOF
+
+test_expect_success 'setup unrelated notes ref (w)' '
+	git config core.notesRef refs/notes/w &&
+	git notes add -m "w notes on 1st commit" 1st &&
+	git notes add -m "x notes on 2nd commit" 2nd &&
+	verify_notes w
+'
+
+cat <<EOF | sort >expect_notes_w
+6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
+e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
+ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
+f75d1df88cbfe4258d49852f26cfc83f2ad4494b $commit_sha1
+EOF
+
+cat >expect_log_w <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+x notes on 4th commit
+
+$commit_sha3 3rd
+x notes on 3rd commit
+
+$commit_sha2 2nd
+x notes on 2nd commit
+
+$commit_sha1 1st
+w notes on 1st commit
+
+EOF
+
+test_expect_success 'can do merge without conflicts even if previous merge is unfinished (x => w)' '
+	test -d .git/NOTES_MERGE_WORKTREE &&
+	git notes merge x &&
+	verify_notes w &&
+	# Verify that other notes refs has not changed (x and y)
+	verify_notes x &&
+	verify_notes y
+'
+
+test_done
-- 
1.7.3.98.g5ad7d9
