From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 14:12:20 -0400
Message-ID: <1438107144-24293-3-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9N2-0004nU-GW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbG1SMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:12:47 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33193 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbG1SMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:45 -0400
Received: by qged69 with SMTP id d69so79974220qge.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dijaG/h5TPbq2ogfB8e1G+gKlydqoViRXZAk+qrnVJY=;
        b=JH83h9rlvHsBX8/deXEBnc5SaVn/tTY8ltt5xEUenXqvhR+9bgMlDBQB6atQSlF+rT
         B3FiR3snCmzcDV6RByTF2Ldgk7qMeKK6XMU/vfz/mP2XDj6L6ByqvEYh63I1NcsX1/KW
         uOjKaZWzo+D1ihyASC8f6nQj8XeyRWES6ovEjZUo5dcH6k+zUJC6V22pgst7UpANUCMa
         fUNygYy2zoey04NEU/L8xPgDuSYs7iffn7rHLiT29McsYrEksTTZUU4xltTbmEiVD6N9
         OmCvB4OOBX5c9F/XImWHHmodkzD8jXg10iNBJrYuTpyhEr2sA83PYly4ZiE6dA8I0Hbl
         rbzA==
X-Gm-Message-State: ALoCoQkQYyefvzGksMmHkv9UP/YBYwTDSZXFRaGQpTxGX/PLytX8rHVJeElGVktpbSFj4vk4h4o9
X-Received: by 10.140.102.84 with SMTP id v78mr5367405qge.81.1438107164730;
        Tue, 28 Jul 2015 11:12:44 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274806>

All-caps files like NOTES_MERGE_REF are pseudorefs, and thus are
per-worktree.  We don't want multiple notes merges happening at once
(in different worktrees), so we want to make these refs true refs.

So, we lowercase NOTES_MERGE_REF and friends.  That way, backends
that distinguish between pseudorefs and real refs can correctly
handle notes merges.

This will also enable us to prevent pseudorefs from being updated by
the ref update machinery e.g. git update-ref.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-notes.txt           | 12 ++---
 builtin/notes.c                       | 38 ++++++++--------
 notes-merge.c                         | 10 ++--
 notes-merge.h                         |  8 ++--
 t/t3310-notes-merge-manual-resolve.sh | 86 +++++++++++++++++------------------
 t/t3311-notes-merge-fanout.sh         |  6 +--
 6 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 851518d..82fa3fd 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -103,7 +103,7 @@ merge::
 If conflicts arise and a strategy for automatically resolving
 conflicting notes (see the -s/--strategy option) is not given,
 the "manual" resolver is used. This resolver checks out the
-conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
+conflicting notes in a special worktree (`.git/notes_merge_worktree`),
 and instructs the user to manually resolve the conflicts there.
 When done, the user can either finalize the merge with
 'git notes merge --commit', or abort the merge with
@@ -189,11 +189,11 @@ OPTIONS
 --commit::
 	Finalize an in-progress 'git notes merge'. Use this option
 	when you have resolved the conflicts that 'git notes merge'
-	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
+	stored in .git/notes_merge_worktree. This amends the partial
 	merge commit created by 'git notes merge' (stored in
-	.git/NOTES_MERGE_PARTIAL) by adding the notes in
-	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
-	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
+	.git/notes_merge_partial) by adding the notes in
+	.git/notes_merge_worktree. The notes ref stored in the
+	.git/notes_merge_ref symref is updated to the resulting commit.
 
 --abort::
 	Abort/reset a in-progress 'git notes merge', i.e. a notes merge
@@ -241,7 +241,7 @@ NOTES MERGE STRATEGIES
 
 The default notes merge strategy is "manual", which checks out
 conflicting notes in a special work tree for resolving notes conflicts
-(`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
+(`.git/notes_merge_worktree`), and instructs the user to resolve the
 conflicts in that work tree.
 When done, the user can either finalize the merge with
 'git notes merge --commit', or abort the merge with
diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..e0b8a02 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -670,14 +670,14 @@ static int merge_abort(struct notes_merge_options *o)
 	int ret = 0;
 
 	/*
-	 * Remove .git/NOTES_MERGE_PARTIAL and .git/NOTES_MERGE_REF, and call
-	 * notes_merge_abort() to remove .git/NOTES_MERGE_WORKTREE.
+	 * Remove .git/notes_merge_partial and .git/notes_merge_ref, and call
+	 * notes_merge_abort() to remove .git/notes_merge_worktree.
 	 */
 
-	if (delete_ref("NOTES_MERGE_PARTIAL", NULL, 0))
-		ret += error("Failed to delete ref NOTES_MERGE_PARTIAL");
-	if (delete_ref("NOTES_MERGE_REF", NULL, REF_NODEREF))
-		ret += error("Failed to delete ref NOTES_MERGE_REF");
+	if (delete_ref("notes_merge_partial", NULL, 0))
+		ret += error("Failed to delete ref notes_merge_partial");
+	if (delete_ref("notes_merge_ref", NULL, REF_NODEREF))
+		ret += error("Failed to delete ref notes_merge_ref");
 	if (notes_merge_abort(o))
 		ret += error("Failed to remove 'git notes merge' worktree");
 	return ret;
@@ -694,16 +694,16 @@ static int merge_commit(struct notes_merge_options *o)
 	int ret;
 
 	/*
-	 * Read partial merge result from .git/NOTES_MERGE_PARTIAL,
-	 * and target notes ref from .git/NOTES_MERGE_REF.
+	 * Read partial merge result from .git/notes_merge_partial,
+	 * and target notes ref from .git/notes_merge_ref.
 	 */
 
-	if (get_sha1("NOTES_MERGE_PARTIAL", sha1))
-		die("Failed to read ref NOTES_MERGE_PARTIAL");
+	if (get_sha1("notes_merge_partial", sha1))
+		die("Failed to read ref notes_merge_partial");
 	else if (!(partial = lookup_commit_reference(sha1)))
-		die("Could not find commit from NOTES_MERGE_PARTIAL.");
+		die("Could not find commit from notes_merge_partial.");
 	else if (parse_commit(partial))
-		die("Could not parse commit from NOTES_MERGE_PARTIAL.");
+		die("Could not parse commit from notes_merge_partial.");
 
 	if (partial->parents)
 		hashcpy(parent_sha1, partial->parents->item->object.sha1);
@@ -711,12 +711,12 @@ static int merge_commit(struct notes_merge_options *o)
 		hashclr(parent_sha1);
 
 	t = xcalloc(1, sizeof(struct notes_tree));
-	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	init_notes(t, "notes_merge_partial", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
+		resolve_refdup("notes_merge_ref", 0, sha1, NULL);
 	if (!o->local_ref)
-		die("Failed to resolve NOTES_MERGE_REF");
+		die("Failed to resolve notes_merge_ref");
 
 	if (notes_merge_commit(o, t, partial, sha1))
 		die("Failed to finalize notes merge");
@@ -825,11 +825,11 @@ static int merge(int argc, const char **argv, const char *prefix)
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
-		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
+		/* Update .git/notes_merge_partial with partial merge result */
+		update_ref(msg.buf, "notes_merge_partial", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
-		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
+		/* Store ref-to-be-updated into .git/notes_merge_ref */
+		if (create_symref("notes_merge_ref", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
 			    default_notes_ref());
 		printf("Automatic notes merge failed. Fix conflicts in %s and "
diff --git a/notes-merge.c b/notes-merge.c
index 0b2b82c..58a8637 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -274,10 +274,10 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 				    "'git notes merge --commit' or 'git notes "
 				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
-				    "notes merge.", git_path("NOTES_MERGE_*"));
+				    "notes merge.", git_path("notes_merge_*"));
 			else
 				die("You have not concluded your notes merge "
-				    "(%s exists).", git_path("NOTES_MERGE_*"));
+				    "(%s exists).", git_path("notes_merge_*"));
 		}
 
 		if (safe_create_leading_directories_const(git_path(
@@ -663,7 +663,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		       unsigned char *result_sha1)
 {
 	/*
-	 * Iterate through files in .git/NOTES_MERGE_WORKTREE and add all
+	 * Iterate through files in .git/notes_merge_workree and add all
 	 * found notes to 'partial_tree'. Write the updated notes tree to
 	 * the DB, and commit the resulting tree object while reusing the
 	 * commit message and parents from 'partial_commit'.
@@ -734,8 +734,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 int notes_merge_abort(struct notes_merge_options *o)
 {
 	/*
-	 * Remove all files within .git/NOTES_MERGE_WORKTREE. We do not remove
-	 * the .git/NOTES_MERGE_WORKTREE directory itself, since it might be
+	 * Remove all files within .git/notes_merge_workree. We do not remove
+	 * the .git/notes_merge_workree directory itself, since it might be
 	 * the current working directory of the user.
 	 */
 	struct strbuf buf = STRBUF_INIT;
diff --git a/notes-merge.h b/notes-merge.h
index 1d01f6a..18705d6 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -1,7 +1,7 @@
 #ifndef NOTES_MERGE_H
 #define NOTES_MERGE_H
 
-#define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
+#define NOTES_MERGE_WORKTREE "notes_merge_worktree"
 
 enum notes_merge_verbosity {
 	NOTES_MERGE_VERBOSITY_DEFAULT = 2,
@@ -46,7 +46,7 @@ void init_notes_merge_options(struct notes_merge_options *o);
  *    are stored in 'local_tree', and the SHA1 or the resulting commit
  *    (to be amended when the conflicts have been resolved) is written into
  *    'result_sha1'. The unmerged entries are written into the
- *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
+ *    .git/notes_merge_worktree directory with conflict markers.
  *    -1 is returned.
  *
  * Both o->local_ref and o->remote_ref must be given (non-NULL), but either ref
@@ -65,7 +65,7 @@ int notes_merge(struct notes_merge_options *o,
  * the given 'partial_commit', the partial result commit created by a previous
  * call to notes_merge().
  *
- * This function will add the (now resolved) notes in .git/NOTES_MERGE_WORKTREE
+ * This function will add the (now resolved) notes in .git/notes_merge_worktree
  * to 'partial_tree', and create a final notes merge commit, the SHA1 of which
  * will be stored in 'result_sha1'.
  */
@@ -77,7 +77,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 /*
  * Abort conflict resolution from an earlier notes_merge()
  *
- * Removes the notes merge worktree in .git/NOTES_MERGE_WORKTREE.
+ * Removes the notes merge worktree in .git/notes_merge_worktree.
  */
 int notes_merge_abort(struct notes_merge_options *o);
 
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 195bb97..dc9ecd5 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -178,12 +178,12 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	grep -q "\\.git/notes_merge_worktree" output &&
 	# Inspect merge conflicts
-	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	ls .git/notes_merge_worktree >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
 	( for f in $(cat expect_conflicts); do
-		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		test_cmp "expect_conflict_$f" ".git/notes_merge_worktree/$f" ||
 		exit 1
 	done ) &&
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
@@ -222,10 +222,10 @@ test_expect_success 'change notes in z' '
 '
 
 test_expect_success 'cannot do merge w/conflicts when previous merge is unfinished' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test -d .git/notes_merge_worktree &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should indicate what is wrong
-	grep -q "\\.git/NOTES_MERGE_\\* exists" output
+	grep -q "\\.git/notes_merge_\\* exists" output
 '
 
 # Setup non-conflicting merge between x and new notes ref w
@@ -282,7 +282,7 @@ w notes on 1st commit
 EOF
 
 test_expect_success 'can do merge without conflicts even if previous merge is unfinished (x => w)' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test -d .git/notes_merge_worktree &&
 	git notes merge x &&
 	verify_notes w &&
 	# Verify that other notes refs has not changed (x and y)
@@ -316,15 +316,15 @@ EOF
 
 test_expect_success 'finalize conflicting merge (z => m)' '
 	# Resolve conflicts and finalize merge
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha1 <<EOF &&
 y and z notes on 1st commit
 EOF
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha4 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha4 <<EOF &&
 y and z notes on 4th commit
 EOF
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	# No .git/notes_merge_* files left
+	test_might_fail ls .git/notes_merge_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
@@ -369,12 +369,12 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	grep -q "\\.git/notes_merge_worktree" output &&
 	# Inspect merge conflicts
-	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	ls .git/notes_merge_worktree >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
 	( for f in $(cat expect_conflicts); do
-		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		test_cmp "expect_conflict_$f" ".git/notes_merge_worktree/$f" ||
 		exit 1
 	done ) &&
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
@@ -385,8 +385,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	# No .git/notes_merge_* files left
+	test_might_fail ls .git/notes_merge_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == y)
 	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
@@ -403,12 +403,12 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	grep -q "\\.git/notes_merge_worktree" output &&
 	# Inspect merge conflicts
-	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	ls .git/notes_merge_worktree >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
 	( for f in $(cat expect_conflicts); do
-		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		test_cmp "expect_conflict_$f" ".git/notes_merge_worktree/$f" ||
 		exit 1
 	done ) &&
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
@@ -441,19 +441,19 @@ EOF
 
 test_expect_success 'add + remove notes in finalized merge (z => m)' '
 	# Resolve one conflict
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha1 <<EOF &&
 y and z notes on 1st commit
 EOF
 	# Remove another conflict
-	rm .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	rm .git/notes_merge_worktree/$commit_sha4 &&
 	# Remove a D/F conflict
-	rm .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
+	rm .git/notes_merge_worktree/$commit_sha3 &&
 	# Add a new note
-	echo "new note on 5th commit" > .git/NOTES_MERGE_WORKTREE/$commit_sha5 &&
+	echo "new note on 5th commit" > .git/notes_merge_worktree/$commit_sha5 &&
 	# Finalize merge
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	# No .git/notes_merge_* files left
+	test_might_fail ls .git/notes_merge_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
@@ -484,12 +484,12 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git update-ref refs/notes/m refs/notes/y &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	grep -q "\\.git/notes_merge_worktree" output &&
 	# Inspect merge conflicts
-	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	ls .git/notes_merge_worktree >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
 	( for f in $(cat expect_conflicts); do
-		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		test_cmp "expect_conflict_$f" ".git/notes_merge_worktree/$f" ||
 		exit 1
 	done ) &&
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
@@ -507,31 +507,31 @@ test_expect_success 'reset notes ref m to somewhere else (w)' '
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
 '
 
-test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
+test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != notes_merge_partial^1)' '
 	# Resolve conflicts
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha1 <<EOF &&
 y and z notes on 1st commit
 EOF
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha4 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha4 <<EOF &&
 y and z notes on 4th commit
 EOF
 	# Fail to finalize merge
 	test_must_fail git notes merge --commit >output 2>&1 &&
-	# .git/NOTES_MERGE_* must remain
-	test -f .git/NOTES_MERGE_PARTIAL &&
-	test -f .git/NOTES_MERGE_REF &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	# .git/notes_merge_* must remain
+	git rev-parse --verify notes_merge_partial &&
+	git rev-parse --verify notes_merge_ref &&
+	test -f .git/notes_merge_worktree/$commit_sha1 &&
+	test -f .git/notes_merge_worktree/$commit_sha2 &&
+	test -f .git/notes_merge_worktree/$commit_sha3 &&
+	test -f .git/notes_merge_worktree/$commit_sha4 &&
 	# Refs are unchanged
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
-	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
-	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
+	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse notes_merge_partial^1)" &&
+	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse notes_merge_partial^1)" &&
 	# Mention refs/notes/m, and its current and expected value in output
 	grep -q "refs/notes/m" output &&
 	grep -q "$(git rev-parse refs/notes/m)" output &&
-	grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	grep -q "$(git rev-parse notes_merge_partial^1)" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -541,8 +541,8 @@ EOF
 
 test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	# No .git/notes_merge_* files left
+	test_might_fail ls .git/notes_merge_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == w)
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
@@ -563,7 +563,7 @@ test_expect_success 'switch cwd before committing notes merge' '
 	git notes --ref=other add -m bar HEAD &&
 	test_must_fail git notes merge refs/notes/other &&
 	(
-		cd .git/NOTES_MERGE_WORKTREE &&
+		cd .git/notes_merge_worktree &&
 		echo "foo" > $(git rev-parse HEAD) &&
 		echo "bar" >> $(git rev-parse HEAD) &&
 		git notes merge --commit
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 93516ef..eeaea62 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -387,10 +387,10 @@ other notes for commit4
 EOF
 
 test_expect_success 'verify conflict entries (with no fanout)' '
-	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	ls .git/notes_merge_worktree >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
 	( for f in $(cat expect_conflicts); do
-		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		test_cmp "expect_conflict_$f" ".git/notes_merge_worktree/$f" ||
 		exit 1
 	done ) &&
 	# Verify that current notes tree (pre-merge) has not changed (m == w)
@@ -417,7 +417,7 @@ other notes for commit1
 EOF
 
 test_expect_success 'resolve and finalize merge (z => w)' '
-	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha3 <<EOF &&
+	cat >.git/notes_merge_worktree/$commit_sha3 <<EOF &&
 other notes for commit3
 
 appended notes for commit3
-- 
2.0.4.315.gad8727a-twtrsrc
