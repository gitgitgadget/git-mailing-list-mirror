From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 16/23] git notes merge: Manual conflict resolution, part 2/2
Date: Mon, 25 Oct 2010 02:08:46 +0200
Message-ID: <1287965333-5099-17-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdr-0000ju-7S
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab0JYAKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 20:10:00 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab0JYAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:28 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0051HKFLGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:21 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9F5471798FEC_CC4CAB1B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:21 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 56757179627C_CC4CAB1F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:20 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:16 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159916>

When the notes merge conflicts in .git/NOTES_MERGE_WORKTREE have been
resolved, we need to record a new notes commit on the appropriate notes
ref with the resolved notes.

This patch implements 'git notes merge --commit' which the user should
run after resolving conflicts in the notes merge worktree. This command
finalizes the notes merge by recombining the partial notes tree from
part 1 with the now-resolved conflicts in the notes merge worktree in a
merge commit, and updating the appropriate ref to this merge commit.

In order to correctly finalize the merge, we need to keep track of thre=
e
things:

- The partial merge result from part 1, containing the auto-merged note=
s.
  This is now stored into a ref called .git/NOTES_MERGE_PARTIAL.
- The unmerged notes. These are already stored in
  .git/NOTES_MERGE_WORKTREE, thanks to part 1.
- The notes ref to be updated by the finalized merge result. This is no=
w
  stored in a symref called .git/NOTES_MERGE_REF.

In addition to "git notes merge --commit", which uses the above details
to create the finalized notes merge commit, this patch also implements
"git notes merge --reset", which aborts the ongoing notes merge by simp=
ly
removing the files/directory described above.

=46TR, "git notes merge --commit" reuses "git notes merge --reset" to r=
emove
the information described above (.git/NOTES_MERGE_*) after the notes me=
rge
have been successfully finalized.

The patch also contains documentation and testcases for the two new opt=
ions.

This patch has been improved by the following contributions:
- =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: Fix nonsense sentence in --co=
mmit description
- Sverre Rabbelier: Rename --reset to --abort

Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Thanks-to: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt           |   22 ++++
 builtin/notes.c                       |  106 +++++++++++++++++++-
 notes-merge.c                         |   71 +++++++++++++-
 notes-merge.h                         |   23 +++++
 t/t3310-notes-merge-manual-resolve.sh |  176 +++++++++++++++++++++++++=
++++++++
 5 files changed, 394 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f003b7c..a822551 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 'git notes' edit [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
+'git notes' merge --commit [-v | -q]
+'git notes' merge --abort [-v | -q]
 'git notes' remove [<object>]
 'git notes' prune [-n | -v]
=20
@@ -95,6 +97,9 @@ conflicting notes (see the -s/--strategy option) is n=
ot given,
 the "manual" resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
+When done, the user can either finalize the merge with
+'git notes merge --commit', or abort the merge with
+'git notes merge --abort'.
=20
 remove::
 	Remove the notes for a given object (defaults to HEAD).
@@ -154,6 +159,20 @@ OPTIONS
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
=20
+--commit::
+	Finalize an in-progress 'git notes merge'. Use this option
+	when you have resolved the conflicts that 'git notes merge'
+	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
+	merge commit created by 'git notes merge' (stored in
+	.git/NOTES_MERGE_PARTIAL) by adding the notes in
+	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
+	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
+
+--abort::
+	Abort/reset a in-progress 'git notes merge', i.e. a notes merge
+	with conflicts. This simply removes all files related to the
+	notes merge.
+
 -q::
 --quiet::
 	When merging notes, operate quietly.
@@ -197,6 +216,9 @@ The default notes merge strategy is "manual", which=
 checks out
 conflicting notes in a special work tree for resolving notes conflicts
 (`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
 conflicts in that work tree.
+When done, the user can either finalize the merge with
+'git notes merge --commit', or abort the merge with
+'git notes merge --abort'.
=20
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
diff --git a/builtin/notes.c b/builtin/notes.c
index 7a2a288..db60ead 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -27,6 +27,8 @@ static const char * const git_notes_usage[] =3D {
 	"git notes [--ref <notes_ref>] edit [<object>]",
 	"git notes [--ref <notes_ref>] show [<object>]",
 	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <note=
s_ref>",
+	"git notes merge --commit [-v | -q]",
+	"git notes merge --abort [-v | -q]",
 	"git notes [--ref <notes_ref>] remove [<object>]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	NULL
@@ -65,6 +67,8 @@ static const char * const git_notes_show_usage[] =3D =
{
=20
 static const char * const git_notes_merge_usage[] =3D {
 	"git notes merge [<options>] <notes_ref>",
+	"git notes merge --commit [<options>]",
+	"git notes merge --abort [<options>]",
 	NULL
 };
=20
@@ -761,33 +765,119 @@ static int show(int argc, const char **argv, con=
st char *prefix)
 	return retval;
 }
=20
+static int merge_abort(struct notes_merge_options *o)
+{
+	int ret =3D 0;
+
+	/*
+	 * Remove .git/NOTES_MERGE_PARTIAL and .git/NOTES_MERGE_REF, and call
+	 * notes_merge_abort() to remove .git/NOTES_MERGE_WORKTREE.
+	 */
+
+	if (delete_ref("NOTES_MERGE_PARTIAL", NULL, 0))
+		ret +=3D error("Failed to delete ref NOTES_MERGE_PARTIAL");
+	if (delete_ref("NOTES_MERGE_REF", NULL, REF_NODEREF))
+		ret +=3D error("Failed to delete ref NOTES_MERGE_REF");
+	if (notes_merge_abort(o))
+		ret +=3D error("Failed to remove 'git notes merge' worktree");
+	return ret;
+}
+
+static int merge_commit(struct notes_merge_options *o)
+{
+	struct strbuf msg =3D STRBUF_INIT;
+	unsigned char sha1[20];
+	struct notes_tree *t;
+	struct commit *partial;
+	struct pretty_print_context pretty_ctx;
+
+	/*
+	 * Read partial merge result from .git/NOTES_MERGE_PARTIAL,
+	 * and target notes ref from .git/NOTES_MERGE_REF.
+	 */
+
+	if (get_sha1("NOTES_MERGE_PARTIAL", sha1))
+		die("Failed to read ref NOTES_MERGE_PARTIAL");
+	else if (!(partial =3D lookup_commit_reference(sha1)))
+		die("Could not find commit from NOTES_MERGE_PARTIAL.");
+	else if (parse_commit(partial))
+		die("Could not parse commit from NOTES_MERGE_PARTIAL.");
+
+	t =3D xcalloc(1, sizeof(struct notes_tree));
+	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+
+	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, 0);
+	if (!o->local_ref)
+		die("Failed to resolve NOTES_MERGE_REF");
+
+	if (notes_merge_commit(o, t, partial, sha1))
+		die("Failed to finalize notes merge");
+
+	/* Reuse existing commit message in reflog message */
+	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
+	format_commit_message(partial, "%s", &msg, &pretty_ctx);
+	strbuf_trim(&msg);
+	strbuf_insert(&msg, 0, "notes: ", 7);
+	update_ref(msg.buf, o->local_ref, sha1, NULL, 0, DIE_ON_ERR);
+
+	free_notes(t);
+	strbuf_release(&msg);
+	return merge_abort(o);
+}
+
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref =3D STRBUF_INIT, msg =3D STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
+	int do_merge =3D 0, do_commit =3D 0, do_abort =3D 0;
 	int verbosity =3D 0, result;
 	const char *strategy =3D NULL;
 	struct option options[] =3D {
+		OPT_GROUP("General options"),
 		OPT__VERBOSITY(&verbosity),
+		OPT_GROUP("Merge options"),
 		OPT_STRING('s', "strategy", &strategy, "strategy",
 			   "resolve notes conflicts using the given "
 			   "strategy (manual/ours/theirs/union)"),
+		OPT_GROUP("Committing unmerged notes"),
+		{ OPTION_BOOLEAN, 0, "commit", &do_commit, NULL,
+			"finalize notes merge by committing unmerged notes",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+		OPT_GROUP("Aborting notes merge resolution"),
+		{ OPTION_BOOLEAN, 0, "abort", &do_abort, NULL,
+			"abort notes merge",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_END()
 	};
=20
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_notes_merge_usage, 0);
=20
-	if (argc !=3D 1) {
+	if (strategy || do_commit + do_abort =3D=3D 0)
+		do_merge =3D 1;
+	if (do_merge + do_commit + do_abort !=3D 1) {
+		error("cannot mix --commit, --abort or -s/--strategy");
+		usage_with_options(git_notes_merge_usage, options);
+	}
+
+	if (do_merge && argc !=3D 1) {
 		error("Must specify a notes ref to merge");
 		usage_with_options(git_notes_merge_usage, options);
+	} else if (!do_merge && argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_merge_usage, options);
 	}
=20
 	init_notes_merge_options(&o);
 	o.verbosity =3D verbosity + NOTES_MERGE_VERBOSITY_DEFAULT;
=20
+	if (do_abort)
+		return merge_abort(&o);
+	if (do_commit)
+		return merge_commit(&o);
+
 	o.local_ref =3D default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
 	expand_notes_ref(&remote_ref);
@@ -820,9 +910,19 @@ static int merge(int argc, const char **argv, cons=
t char *prefix)
 		/* Update default notes ref with new commit */
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, DIE_ON_ERR);
-	else /* Merge has unresolved conflicts */
-		printf("Automatic notes merge failed. Fix conflicts in %s.\n",
+	else { /* Merge has unresolved conflicts */
+		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
+		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
+			   0, DIE_ON_ERR);
+		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
+		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
+			die("Failed to store link to current notes ref (%s)",
+			    default_notes_ref());
+		printf("Automatic notes merge failed. Fix conflicts in %s and "
+		       "commit the result with 'git notes merge --commit', or "
+		       "abort the merge with 'git notes merge --abort'.\n",
 		       git_path(NOTES_MERGE_WORKTREE));
+	}
=20
 	free_notes(t);
 	strbuf_release(&remote_ref);
diff --git a/notes-merge.c b/notes-merge.c
index 5734d0b..b44273c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -278,7 +278,7 @@ static void check_notes_merge_worktree(struct notes=
_merge_options *o)
 				die("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
 				    "'git notes merge --commit' or 'git notes "
-				    "merge --reset' to commit/abort the "
+				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
 				    "notes merge.", git_path("NOTES_MERGE_*"));
 			else
@@ -649,3 +649,72 @@ found_result:
 	       result, sha1_to_hex(result_sha1));
 	return result;
 }
+
+int notes_merge_commit(struct notes_merge_options *o,
+		       struct notes_tree *partial_tree,
+		       struct commit *partial_commit,
+		       unsigned char *result_sha1)
+{
+	/*
+	 * Iterate through files in .git/NOTES_MERGE_WORKTREE and add all
+	 * found notes to 'partial_tree'. Write the updates notes tree to
+	 * the DB, and commit the resulting tree object while reusing the
+	 * commit message and parents from 'partial_commit'.
+	 * Finally store the new commit object SHA1 into 'result_sha1'.
+	 */
+	struct dir_struct dir;
+	const char *path =3D git_path(NOTES_MERGE_WORKTREE "/");
+	int path_len =3D strlen(path), i;
+	const char *msg =3D strstr(partial_commit->buffer, "\n\n");
+
+	OUTPUT(o, 3, "Committing notes in notes merge worktree at %.*s",
+	       path_len - 1, path);
+
+	if (!msg || msg[2] =3D=3D '\0')
+		die("partial notes commit has empty message");
+	msg +=3D 2;
+
+	memset(&dir, 0, sizeof(dir));
+	read_directory(&dir, path, path_len, NULL);
+	for (i =3D 0; i < dir.nr; i++) {
+		struct dir_entry *ent =3D dir.entries[i];
+		struct stat st;
+		const char *relpath =3D ent->name + path_len;
+		unsigned char obj_sha1[20], blob_sha1[20];
+
+		if (ent->len - path_len !=3D 40 || get_sha1_hex(relpath, obj_sha1)) =
{
+			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s'", ent->name);
+			continue;
+		}
+
+		/* write file as blob, and add to partial_tree */
+		if (stat(ent->name, &st))
+			die_errno("Failed to stat '%s'", ent->name);
+		if (index_path(blob_sha1, ent->name, &st, 1))
+			die("Failed to write blob object from '%s'", ent->name);
+		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
+			die("Failed to add resolved note '%s' to notes tree",
+			    ent->name);
+		OUTPUT(o, 4, "Added resolved note for object %s: %s",
+		       sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
+	}
+
+	create_notes_commit(partial_tree, partial_commit->parents, msg,
+			    result_sha1);
+	OUTPUT(o, 4, "Finalized notes merge commit: %s",
+	       sha1_to_hex(result_sha1));
+	return 0;
+}
+
+int notes_merge_abort(struct notes_merge_options *o)
+{
+	/* Remove .git/NOTES_MERGE_WORKTREE directory and all files within */
+	struct strbuf buf =3D STRBUF_INIT;
+	int ret;
+
+	strbuf_addstr(&buf, git_path(NOTES_MERGE_WORKTREE));
+	OUTPUT(o, 3, "Removing notes merge worktree at %s", buf.buf);
+	ret =3D remove_dir_recursively(&buf, 0);
+	strbuf_release(&buf);
+	return ret;
+}
diff --git a/notes-merge.h b/notes-merge.h
index 55ef3d9..aa75693 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -71,4 +71,27 @@ int notes_merge(struct notes_merge_options *o,
 		struct notes_tree *local_tree,
 		unsigned char *result_sha1);
=20
+/*
+ * Finalize conflict resolution from an earlier notes_merge()
+ *
+ * The given notes tree 'partial_tree' must be the notes_tree correspo=
nding to
+ * the given 'partial_commit', the partial result commit created by a =
previous
+ * call to notes_merge().
+ *
+ * This function will add the (now resolved) notes in .git/NOTES_MERGE=
_WORKTREE
+ * to 'partial_tree', and create a final notes merge commit, the SHA1 =
of which
+ * will be stored in 'result_sha1'.
+ */
+int notes_merge_commit(struct notes_merge_options *o,
+		       struct notes_tree *partial_tree,
+		       struct commit *partial_commit,
+		       unsigned char *result_sha1);
+
+/*
+ * Abort conflict resolution from an earlier notes_merge()
+ *
+ * Removes the notes merge worktree in .git/NOTES_MERGE_WORKTREE.
+ */
+int notes_merge_abort(struct notes_merge_options *o);
+
 #endif
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merg=
e-manual-resolve.sh
index eadb6b7..0ec315a 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -171,6 +171,7 @@ cp expect_notes_y expect_notes_m
 cp expect_log_y expect_log_m
=20
 git rev-parse refs/notes/y > pre_merge_y
+git rev-parse refs/notes/z > pre_merge_z
=20
 test_expect_success 'merge z into m (=3D=3D y) with default ("manual")=
 resolver =3D> Conflicting 3-way merge' '
 	git update-ref refs/notes/m refs/notes/y &&
@@ -289,4 +290,179 @@ test_expect_success 'can do merge without conflic=
ts even if previous merge is un
 	verify_notes y
 '
=20
+cat <<EOF | sort >expect_notes_m
+021faa20e931fb48986ffc6282b4bb05553ac946 $commit_sha4
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+0a59e787e6d688aa6309e56e8c1b89431a0fc1c1 $commit_sha1
+EOF
+
+cat >expect_log_m <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+y and z notes on 4th commit
+
+$commit_sha3 3rd
+y notes on 3rd commit
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+y and z notes on 1st commit
+
+EOF
+
+test_expect_success 'finalize conflicting merge (z =3D> m)' '
+	# Resolve conflicts and finalize merge
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+y and z notes on 1st commit
+EOF
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha4 <<EOF &&
+y and z notes on 4th commit
+EOF
+	git notes merge --commit &&
+	# No .git/NOTES_MERGE_* files left
+	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_cmp /dev/null output &&
+	# Merge commit has pre-merge y and pre-merge z as parents
+	test "$(git rev-parse refs/notes/m^1)" =3D "$(cat pre_merge_y)" &&
+	test "$(git rev-parse refs/notes/m^2)" =3D "$(cat pre_merge_z)" &&
+	# Merge commit mentions the notes refs merged
+	git log -1 --format=3D%B refs/notes/m > merge_commit_msg &&
+	grep -q refs/notes/m merge_commit_msg &&
+	grep -q refs/notes/z merge_commit_msg &&
+	# Verify contents of merge result
+	verify_notes m &&
+	# Verify that other notes refs has not changed (w, x, y and z)
+	verify_notes w &&
+	verify_notes x &&
+	verify_notes y &&
+	verify_notes z
+'
+
+cat >expect_conflict_$commit_sha4 <<EOF
+<<<<<<< refs/notes/m
+y notes on 4th commit
+=3D=3D=3D=3D=3D=3D=3D
+z notes on 4th commit
+
+More z notes on 4th commit
+>>>>>>> refs/notes/z
+EOF
+
+cp expect_notes_y expect_notes_m
+cp expect_log_y expect_log_m
+
+git rev-parse refs/notes/y > pre_merge_y
+git rev-parse refs/notes/z > pre_merge_z
+
+test_expect_success 'redo merge of z into m (=3D=3D y) with default ("=
manual") resolver =3D> Conflicting 3-way merge' '
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
+	# Verify that current notes tree (pre-merge) has not changed (m =3D=3D=
 y)
+	verify_notes y &&
+	verify_notes m &&
+	test "$(git rev-parse refs/notes/m)" =3D "$(cat pre_merge_y)"
+'
+
+test_expect_success 'abort notes merge' '
+	git notes merge --abort &&
+	# No .git/NOTES_MERGE_* files left
+	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_cmp /dev/null output &&
+	# m has not moved (still =3D=3D y)
+	test "$(git rev-parse refs/notes/m)" =3D "$(cat pre_merge_y)"
+	# Verify that other notes refs has not changed (w, x, y and z)
+	verify_notes w &&
+	verify_notes x &&
+	verify_notes y &&
+	verify_notes z
+'
+
+git rev-parse refs/notes/y > pre_merge_y
+git rev-parse refs/notes/z > pre_merge_z
+
+test_expect_success 'redo merge of z into m (=3D=3D y) with default ("=
manual") resolver =3D> Conflicting 3-way merge' '
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
+	# Verify that current notes tree (pre-merge) has not changed (m =3D=3D=
 y)
+	verify_notes y &&
+	verify_notes m &&
+	test "$(git rev-parse refs/notes/m)" =3D "$(cat pre_merge_y)"
+'
+
+cat <<EOF | sort >expect_notes_m
+304dfb4325cf243025b9957486eb605a9b51c199 $commit_sha5
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+0a59e787e6d688aa6309e56e8c1b89431a0fc1c1 $commit_sha1
+EOF
+
+cat >expect_log_m <<EOF
+$commit_sha5 5th
+new note on 5th commit
+
+$commit_sha4 4th
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+y and z notes on 1st commit
+
+EOF
+
+test_expect_success 'add + remove notes in finalized merge (z =3D> m)'=
 '
+	# Resolve one conflict
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+y and z notes on 1st commit
+EOF
+	# Remove another conflict
+	rm .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	# Remove a D/F conflict
+	rm .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
+	# Add a new note
+	echo "new note on 5th commit" > .git/NOTES_MERGE_WORKTREE/$commit_sha=
5 &&
+	# Finalize merge
+	git notes merge --commit &&
+	# No .git/NOTES_MERGE_* files left
+	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_cmp /dev/null output &&
+	# Merge commit has pre-merge y and pre-merge z as parents
+	test "$(git rev-parse refs/notes/m^1)" =3D "$(cat pre_merge_y)" &&
+	test "$(git rev-parse refs/notes/m^2)" =3D "$(cat pre_merge_z)" &&
+	# Merge commit mentions the notes refs merged
+	git log -1 --format=3D%B refs/notes/m > merge_commit_msg &&
+	grep -q refs/notes/m merge_commit_msg &&
+	grep -q refs/notes/z merge_commit_msg &&
+	# Verify contents of merge result
+	verify_notes m &&
+	# Verify that other notes refs has not changed (w, x, y and z)
+	verify_notes w &&
+	verify_notes x &&
+	verify_notes y &&
+	verify_notes z
+'
+
 test_done
--=20
1.7.3.98.g5ad7d9
