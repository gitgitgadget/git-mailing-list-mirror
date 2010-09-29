From: Johan Herland <johan@herland.net>
Subject: [PATCH 10/18] git notes merge: Handle real,
 non-conflicting notes merges
Date: Wed, 29 Sep 2010 02:23:23 +0200
Message-ID: <1285719811-10871-11-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kSj-0000uw-1n
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab0I2AXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:23:53 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab0I2AXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:52 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003ZUFRMTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:46 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DCE2D1EEF869_CA28712B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 8B83C1EEF860_CA28712F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:45 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157502>

This continuation of the 'git notes merge' implementation teaches notes-merge
to properly do real merges between notes trees: Two diffs are performed, one
from $base to $remote, and another from $base to $local. The paths in each
diff are normalized to SHA1 object names. The two diffs are then consolidated
into a single list of change pairs to be evaluated. Each change pair consist
of:

  - The annotated object's SHA1
  - The $base SHA1 (i.e. the common ancestor notes for this object)
  - The $local SHA1 (i.e. the current notes for this object)
  - The $remote SHA1 (i.e. the to-be-merged notes for this object)

>From the pair ($base -> $local, $base -> $remote), we can determine the merge
result using regular 3-way rules. If conflicts are encountered in this
process, we fail loudly and exit (conflict handling to be added in a future
patch), If we can complete the merge without conflicts, the resulting
notes tree is committed, and the current notes ref updated.

The patch includes added testcases verifying that we can successfully do real
conflict-less merges.

This patch has been improved by the following contributions:
- Jonathan Nieder: Future-proof by always checking add_note() return value
- Stephen Boyd: Use test_commit

Cc: Jonathan Nieder <jrnieder@gmail.com>
Cc: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c        |   15 ++-
 notes-merge.c          |  325 +++++++++++++++++++++++++++++++++++++++++++++++-
 notes-merge.h          |   15 ++-
 t/t3308-notes-merge.sh |  188 ++++++++++++++++++++++++++++
 4 files changed, 532 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 717548d..82d2ffe 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -765,6 +765,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
 	unsigned char result_sha1[20];
+	struct notes_tree *t;
 	struct notes_merge_options o;
 	int verbosity = 0, result;
 	struct option options[] = {
@@ -787,19 +788,23 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
-	result = notes_merge(&o, result_sha1);
+	t = init_notes_check("merge");
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
 		    remote_ref.buf, default_notes_ref());
-	if (result == 0) { /* Merge resulted (trivially) in result_sha1 */
+	o.commit_msg = msg.buf + 7; // skip "notes: " prefix
+
+	result = notes_merge(&o, t, result_sha1);
+
+	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
 		/* Update default notes ref with new commit */
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, DIE_ON_ERR);
-	} else {
+	else
 		/* TODO: */
-		die("'git notes merge' cannot yet handle non-trivial merges!");
-	}
+		die("'git notes merge' cannot yet handle conflicts!");
 
+	free_notes(t);
 	strbuf_release(&remote_ref);
 	strbuf_release(&msg);
 	return 0;
diff --git a/notes-merge.c b/notes-merge.c
index 9a4dc6d..f625ebd 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,8 +1,14 @@
 #include "cache.h"
 #include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "notes.h"
 #include "notes-merge.h"
 
+struct notes_merge_pair {
+	unsigned char obj[20], base[20], local[20], remote[20];
+};
+
 void init_notes_merge_options(struct notes_merge_options *o)
 {
 	memset(o, 0, sizeof(struct notes_merge_options));
@@ -17,6 +23,305 @@ static int show(struct notes_merge_options *o, int v)
 #define OUTPUT(o, v, ...) \
 	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (0)
 
+static int path_to_sha1(const char *path, unsigned char *sha1)
+{
+	char hex_sha1[40];
+	int i = 0;
+	while (*path && i < 40) {
+		if (*path != '/')
+			hex_sha1[i++] = *path;
+		path++;
+	}
+	if (*path || i != 40)
+		return -1;
+	return get_sha1_hex(hex_sha1, sha1);
+}
+
+static int verify_notes_filepair(struct diff_filepair *p, unsigned char *sha1)
+{
+	switch (p->status) {
+	case DIFF_STATUS_MODIFIED:
+		assert(p->one->mode == p->two->mode);
+		assert(!is_null_sha1(p->one->sha1));
+		assert(!is_null_sha1(p->two->sha1));
+		break;
+	case DIFF_STATUS_ADDED:
+		assert(is_null_sha1(p->one->sha1));
+		break;
+	case DIFF_STATUS_DELETED:
+		assert(is_null_sha1(p->two->sha1));
+		break;
+	default:
+		return -1;
+	}
+	assert(!strcmp(p->one->path, p->two->path));
+	return path_to_sha1(p->one->path, sha1);
+}
+
+static struct notes_merge_pair *find_notes_merge_pair_pos(
+		struct notes_merge_pair *list, int len, unsigned char *obj,
+		int insert_new, int *occupied)
+{
+	/*
+	 * Both diff_tree_remote() and diff_tree_local() tend to process
+	 * merge_pairs in ascending order. Therefore, cache last returned
+	 * index, and search sequentially from there until the appropriate
+	 * position is found.
+	 *
+	 * Since inserts only happen from diff_tree_remote() (which mainly
+	 * _appends_), we don't care that inserting into the middle of the
+	 * list is expensive (using memmove()).
+	 */
+	static int last_index = 0;
+	int i = last_index < len ? last_index : len - 1;
+	int prev_cmp = 0, cmp = -1;
+	while (i >= 0 && i < len) {
+		cmp = hashcmp(obj, list[i].obj);
+		if (!cmp) /* obj belongs @ i */
+			break;
+		else if (cmp < 0 && prev_cmp <= 0) /* obj belongs < i */
+			i--;
+		else if (cmp < 0) /* obj belongs between i-1 and i */
+			break;
+		else if (cmp > 0 && prev_cmp >= 0) /* obj belongs > i */
+			i++;
+		else /* if (cmp > 0) */ { /* obj belongs between i and i+1 */
+			i++;
+			break;
+		}
+		prev_cmp = cmp;
+	}
+	if (i < 0)
+		i = 0;
+	/* obj belongs at, or immediately preceding, index i (0 <= i <= len) */
+
+	if (!cmp)
+		*occupied = 1;
+	else {
+		*occupied = 0;
+		if (insert_new && i < len) {
+			memmove(list + i + 1, list + i,
+				(len - i) * sizeof(struct notes_merge_pair));
+			memset(list + i, 0, sizeof(struct notes_merge_pair));
+		}
+	}
+	last_index = i;
+	return list + i;
+}
+
+static unsigned char uninitialized[20] =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff" \
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff";
+
+static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
+						 const unsigned char *base,
+						 const unsigned char *remote,
+						 int *num_changes)
+{
+	struct diff_options opt;
+	struct notes_merge_pair *changes;
+	int i, len = 0;
+
+	OUTPUT(o, 5, "\tdiff_tree_remote(base = %.7s, remote = %.7s)",
+	       sha1_to_hex(base), sha1_to_hex(remote));
+
+	diff_setup(&opt);
+	DIFF_OPT_SET(&opt, RECURSIVE);
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	if (diff_setup_done(&opt) < 0)
+		die("diff_setup_done failed");
+	diff_tree_sha1(base, remote, "", &opt);
+	diffcore_std(&opt);
+
+	changes = xcalloc(diff_queued_diff.nr, sizeof(struct notes_merge_pair));
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct notes_merge_pair *mp;
+		int occupied;
+		unsigned char obj[20];
+
+		if (verify_notes_filepair(p, obj)) {
+			OUTPUT(o, 5, "\t\tCannot merge entry '%s' (%c): "
+			       "%.7s -> %.7s. Skipping!", p->one->path,
+			       p->status, sha1_to_hex(p->one->sha1),
+			       sha1_to_hex(p->two->sha1));
+			continue;
+		}
+		mp = find_notes_merge_pair_pos(changes, len, obj, 1, &occupied);
+		if (occupied) {
+			/* We've found an addition/deletion pair */
+			assert(!hashcmp(mp->obj, obj));
+			if (is_null_sha1(p->one->sha1)) { /* addition */
+				assert(is_null_sha1(mp->remote));
+				hashcpy(mp->remote, p->two->sha1);
+			} else if (is_null_sha1(p->two->sha1)) { /* deletion */
+				assert(is_null_sha1(mp->base));
+				hashcpy(mp->base, p->one->sha1);
+			} else
+				assert(!"Invalid existing change recorded");
+		} else {
+			hashcpy(mp->obj, obj);
+			hashcpy(mp->base, p->one->sha1);
+			hashcpy(mp->local, uninitialized);
+			hashcpy(mp->remote, p->two->sha1);
+			len++;
+		}
+		OUTPUT(o, 5, "\t\tRecorded remote change for %s: %.7s -> %.7s",
+		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),
+		       sha1_to_hex(mp->remote));
+	}
+	diff_flush(&opt);
+	diff_tree_release_paths(&opt);
+
+	*num_changes = len;
+	return changes;
+}
+
+static void diff_tree_local(struct notes_merge_options *o,
+			    struct notes_merge_pair *changes, int len,
+			    const unsigned char *base,
+			    const unsigned char *local)
+{
+	struct diff_options opt;
+	int i;
+
+	OUTPUT(o, 5, "\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)",
+	       len, sha1_to_hex(base), sha1_to_hex(local));
+
+	diff_setup(&opt);
+	DIFF_OPT_SET(&opt, RECURSIVE);
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	if (diff_setup_done(&opt) < 0)
+		die("diff_setup_done failed");
+	diff_tree_sha1(base, local, "", &opt);
+	diffcore_std(&opt);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct notes_merge_pair *mp;
+		int match;
+		unsigned char obj[20];
+
+		if (verify_notes_filepair(p, obj)) {
+			OUTPUT(o, 5, "\t\tCannot merge entry '%s' (%c): "
+			       "%.7s -> %.7s. Skipping!", p->one->path,
+			       p->status, sha1_to_hex(p->one->sha1),
+			       sha1_to_hex(p->two->sha1));
+			continue;
+		}
+		mp = find_notes_merge_pair_pos(changes, len, obj, 0, &match);
+		if (!match) {
+			OUTPUT(o, 5, "\t\tIgnoring local-only change for %s: "
+			       "%.7s -> %.7s", sha1_to_hex(obj),
+			       sha1_to_hex(p->one->sha1),
+			       sha1_to_hex(p->two->sha1));
+			continue;
+		}
+
+		assert(!hashcmp(mp->obj, obj));
+		if (is_null_sha1(p->two->sha1)) { /* deletion */
+			/*
+			 * Either this is a true deletion (1), or it is part
+			 * of an A/D pair (2), or D/A pair (3):
+			 *
+			 * (1) mp->local is uninitialized; set it to null_sha1
+			 * (2) mp->local is not uninitialized; don't touch it
+			 * (3) mp->local is uninitialized; set it to null_sha1
+			 *     (will be overwritten by following addition)
+			 */
+			if (!hashcmp(mp->local, uninitialized))
+				hashclr(mp->local);
+		} else if (is_null_sha1(p->one->sha1)) { /* addition */
+			/*
+			 * Either this is a true addition (1), or it is part
+			 * of an A/D pair (2), or D/A pair (3):
+			 *
+			 * (1) mp->local is uninitialized; set to p->two->sha1
+			 * (2) mp->local is uninitialized; set to p->two->sha1
+			 * (3) mp->local is null_sha1;     set to p->two->sha1
+			 */
+			assert(is_null_sha1(mp->local) ||
+			       !hashcmp(mp->local, uninitialized));
+			hashcpy(mp->local, p->two->sha1);
+		} else { /* modification */
+			/*
+			 * This is a true modification. p->one->sha1 shall
+			 * match mp->base, and mp->local shall be uninitialized.
+			 * Set mp->local to p->two->sha1.
+			 */
+			assert(!hashcmp(p->one->sha1, mp->base));
+			assert(!hashcmp(mp->local, uninitialized));
+			hashcpy(mp->local, p->two->sha1);
+		}
+		OUTPUT(o, 5, "\t\tRecorded local change for %s: %.7s -> %.7s",
+		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),
+		       sha1_to_hex(mp->local));
+	}
+	diff_flush(&opt);
+	diff_tree_release_paths(&opt);
+}
+
+static int merge_changes(struct notes_merge_options *o,
+			 struct notes_merge_pair *changes, int *num_changes,
+			 struct notes_tree *t)
+{
+	int i, conflicts = 0;
+
+	OUTPUT(o, 5, "\tmerge_changes(num_changes = %i)", *num_changes);
+	for (i = 0; i < *num_changes; i++) {
+		struct notes_merge_pair *p = changes + i;
+		OUTPUT(o, 5, "\t\t%.7s: %.7s -> %.7s/%.7s",
+		       sha1_to_hex(p->obj), sha1_to_hex(p->base),
+		       sha1_to_hex(p->local), sha1_to_hex(p->remote));
+
+		if (!hashcmp(p->base, p->remote)) {
+			/* no remote change; nothing to do */
+			OUTPUT(o, 5, "\t\t\tskipping (no remote change)");
+		} else if (!hashcmp(p->local, p->remote)) {
+			/* same change in local and remote; nothing to do */
+			OUTPUT(o, 5, "\t\t\tskipping (local == remote)");
+		} else if (!hashcmp(p->local, uninitialized) ||
+			   !hashcmp(p->local, p->base)) {
+			/* no local change; adopt remote change */
+			OUTPUT(o, 5, "\t\t\tno local change, adopting remote");
+			if (add_note(t, p->obj, p->remote,
+				     combine_notes_overwrite))
+				die("confused: combine_notes_overwrite failed");
+		} else {
+			/* need file-level merge between local and remote */
+			OUTPUT(o, 5, "\t\t\tneed content-level merge");
+			conflicts += 1; /* TODO */
+		}
+	}
+
+	return conflicts;
+}
+
+static int merge_from_diffs(struct notes_merge_options *o,
+			    const unsigned char *base,
+			    const unsigned char *local,
+			    const unsigned char *remote, struct notes_tree *t)
+{
+	struct notes_merge_pair *changes;
+	int num_changes, conflicts;
+
+	OUTPUT(o, 5, "\tmerge_from_diffs(base = %.7s, local = %.7s, "
+	       "remote = %.7s)", sha1_to_hex(base), sha1_to_hex(local),
+	       sha1_to_hex(remote));
+
+	changes = diff_tree_remote(o, base, remote, &num_changes);
+	diff_tree_local(o, changes, num_changes, base, local);
+
+	conflicts = merge_changes(o, changes, &num_changes, t);
+	free(changes);
+
+	OUTPUT(o, 4, "Merge result: %i unmerged notes and a %s notes tree",
+	       conflicts, t->dirty ? "dirty" : "clean");
+
+	return conflicts ? -1 : 1;
+}
+
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 			 const char *msg, unsigned char *result_sha1)
 {
@@ -44,14 +349,16 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 }
 
 int notes_merge(struct notes_merge_options *o,
+		struct notes_tree *local_tree,
 		unsigned char *result_sha1)
 {
 	unsigned char local_sha1[20], remote_sha1[20];
 	struct commit *local, *remote;
 	struct commit_list *bases = NULL;
-	const unsigned char *base_sha1;
+	const unsigned char *base_sha1, *base_tree_sha1;
 	int result = 0;
 
+	assert(!strcmp(o->local_ref, local_tree->ref));
 	hashclr(result_sha1);
 
 	OUTPUT(o, 5, "notes_merge(o->local_ref = %s, o->remote_ref = %s)",
@@ -90,14 +397,17 @@ int notes_merge(struct notes_merge_options *o,
 	bases = get_merge_bases(local, remote, 1);
 	if (!bases) {
 		base_sha1 = null_sha1;
+		base_tree_sha1 = (unsigned char *)EMPTY_TREE_SHA1_BIN;
 		OUTPUT(o, 4, "No merge base found; doing history-less merge");
 	} else if (!bases->next) {
 		base_sha1 = bases->item->object.sha1;
+		base_tree_sha1 = bases->item->tree->object.sha1;
 		OUTPUT(o, 4, "One merge base found (%.7s)",
 		       sha1_to_hex(base_sha1));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
 		base_sha1 = bases->item->object.sha1;
+		base_tree_sha1 = bases->item->tree->object.sha1;
 		OUTPUT(o, 3, "Multiple merge bases found. Using the first "
 		       "(%.7s)", sha1_to_hex(base_sha1));
 	}
@@ -119,8 +429,17 @@ int notes_merge(struct notes_merge_options *o,
 		goto found_result;
 	}
 
-	/* TODO: */
-	result = error("notes_merge() cannot yet handle real merges.");
+	result = merge_from_diffs(o, base_tree_sha1, local->tree->object.sha1,
+				  remote->tree->object.sha1, local_tree);
+
+	if (result > 0) { /* successful non-trivial merge */
+		/* Commit result */
+		struct commit_list *parents = NULL;
+		commit_list_insert(remote, &parents); /* LIFO order */
+		commit_list_insert(local, &parents);
+		create_notes_commit(local_tree, parents, o->commit_msg,
+				    result_sha1);
+	}
 
 found_result:
 	free_commit_list(bases);
diff --git a/notes-merge.h b/notes-merge.h
index b570123..e42ce4b 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -4,6 +4,7 @@
 struct notes_merge_options {
 	const char *local_ref;
 	const char *remote_ref;
+	const char *commit_msg;
 	int verbosity;
 };
 
@@ -26,19 +27,27 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 /*
  * Merge notes from o->remote_ref into o->local_ref
  *
+ * The given notes_tree 'local_tree' must be the notes_tree referenced by the
+ * o->local_ref. This is the notes_tree in which the object-level merge is
+ * performed.
+ *
  * The commits given by the two refs are merged, producing one of the following
  * outcomes:
  *
  * 1. The merge trivially results in an existing commit (e.g. fast-forward or
- *    already-up-to-date). The SHA1 of the result is written into 'result_sha1'
- *    and 0 is returned.
- * 2. The merge fails. result_sha1 is set to null_sha1, and non-zero returned.
+ *    already-up-to-date). 'local_tree' is untouched, the SHA1 of the result
+ *    is written into 'result_sha1' and 0 is returned.
+ * 2. The merge successfully completes, producing a merge commit. local_tree
+ *    contains the updated notes tree, the SHA1 of the resulting commit is
+ *    written into 'result_sha1', and 1 is returned.
+ * 3. The merge fails. result_sha1 is set to null_sha1, and -1 is returned.
  *
  * Either ref (but not both) may not exist in which case the missing ref is
  * interpreted as an empty notes tree, and the merge trivially results in
  * what the other ref points to.
  */
 int notes_merge(struct notes_merge_options *o,
+		struct notes_tree *local_tree,
 		unsigned char *result_sha1);
 
 #endif
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 0342e37..b211e82 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -136,4 +136,192 @@ test_expect_success 'merge changed (y) into original (x) => Fast-forward' '
 	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
 '
 
+test_expect_success 'merge empty notes ref (z => y)' '
+	# Prepare empty (but valid) notes ref (z)
+	git config core.notesRef refs/notes/z &&
+	git notes add -m "foo" &&
+	git notes remove &&
+	git notes >output_notes_z &&
+	test_cmp /dev/null output_notes_z &&
+	# Do the merge (z => y)
+	git config core.notesRef refs/notes/y &&
+	git notes merge z &&
+	verify_notes y &&
+	# y should no longer point to the same notes commit as x
+	test "$(git rev-parse refs/notes/x)" != "$(git rev-parse refs/notes/y)"
+'
+
+cat <<EOF | sort >expect_notes_y
+0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
+dec2502dac3ea161543f71930044deff93fa945c $commit_sha4
+4069cdb399fd45463ec6eef8e051a16a03592d91 $commit_sha3
+d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
+43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+EOF
+
+cat >expect_log_y <<EOF
+$commit_sha5 5th
+Notes on 5th commit
+
+$commit_sha4 4th
+New notes on 4th commit
+
+$commit_sha3 3rd
+Notes on 3rd commit
+
+More notes on 3rd commit
+
+$commit_sha2 2nd
+New notes on 2nd commit
+
+$commit_sha1 1st
+Notes on 1st commit
+
+More notes on 1st commit
+
+EOF
+
+test_expect_success 'change notes on other notes ref (y)' '
+	# Append to 1st commit notes
+	git notes append -m "More notes on 1st commit" 1st &&
+	# Add new notes to 2nd commit
+	git notes add -m "New notes on 2nd commit" 2nd &&
+	verify_notes y
+'
+
+cat <<EOF | sort >expect_notes_x
+0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
+1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
+daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 5th
+Notes on 5th commit
+
+$commit_sha4 4th
+New notes on 4th commit
+
+More notes on 4th commit
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+
+$commit_sha1 1st
+Notes on 1st commit
+
+EOF
+
+test_expect_success 'change notes on notes ref (x)' '
+	git config core.notesRef refs/notes/x &&
+	git notes remove 3rd &&
+	git notes append -m "More notes on 4th commit" 4th &&
+	verify_notes x
+'
+
+cat <<EOF | sort >expect_notes_x
+0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
+1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
+d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
+43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 5th
+Notes on 5th commit
+
+$commit_sha4 4th
+New notes on 4th commit
+
+More notes on 4th commit
+
+$commit_sha3 3rd
+
+$commit_sha2 2nd
+New notes on 2nd commit
+
+$commit_sha1 1st
+Notes on 1st commit
+
+More notes on 1st commit
+
+EOF
+
+test_expect_success 'merge y into x => Non-conflicting 3-way merge' '
+	git notes merge y &&
+	verify_notes x &&
+	verify_notes y
+'
+
+cat <<EOF | sort >expect_notes_w
+05a4927951bcef347f51486575b878b2b60137f2 $commit_sha3
+d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
+EOF
+
+cat >expect_log_w <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+
+$commit_sha3 3rd
+New notes on 3rd commit
+
+$commit_sha2 2nd
+New notes on 2nd commit
+
+$commit_sha1 1st
+
+EOF
+
+test_expect_success 'create notes on new, separate notes ref (w)' '
+	git config core.notesRef refs/notes/w &&
+	# Add same note as refs/notes/y on 2nd commit
+	git notes add -m "New notes on 2nd commit" 2nd &&
+	# Add new note on 3rd commit (non-conflicting)
+	git notes add -m "New notes on 3rd commit" 3rd &&
+	# Verify state of notes on new, separate notes ref (w)
+	verify_notes w
+'
+
+cat <<EOF | sort >expect_notes_x
+0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
+1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
+05a4927951bcef347f51486575b878b2b60137f2 $commit_sha3
+d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
+43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 5th
+Notes on 5th commit
+
+$commit_sha4 4th
+New notes on 4th commit
+
+More notes on 4th commit
+
+$commit_sha3 3rd
+New notes on 3rd commit
+
+$commit_sha2 2nd
+New notes on 2nd commit
+
+$commit_sha1 1st
+Notes on 1st commit
+
+More notes on 1st commit
+
+EOF
+
+test_expect_success 'merge w into x => Non-conflicting history-less merge' '
+	git config core.notesRef refs/notes/x &&
+	git notes merge w &&
+	# Verify new state of notes on other notes ref (x)
+	verify_notes x &&
+	# Also verify that nothing changed on other notes refs (y and w)
+	verify_notes y &&
+	verify_notes w
+'
+
 test_done
-- 
1.7.3.98.g5ad7d9
