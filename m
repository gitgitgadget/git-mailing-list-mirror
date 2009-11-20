From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv8 08/10] fast-import: Proper notes tree manipulation using
 the notes API
Date: Fri, 20 Nov 2009 02:39:12 +0100
Message-ID: <1258681154-2167-9-git-send-email-johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIU4-0004ED-FX
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbZKTBjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757436AbZKTBjq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:39:46 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58324 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757420AbZKTBjn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:39:43 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00MOBWMDSE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:49 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00D7NWLXUY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:49 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1258681154-2167-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133290>

This patch teaches 'git fast-import' to use the notes API to organize
the manipulation of note objects through a fast-import stream.
Note objects are added both to the notes tree and the "regular" tree
through the 'N' command, and when we're about to store the "regular" tree
object for the current commit, we walk through the notes tree to adjust all
the note object locations in the stored tree.

Unloading of a fast-import branch also unloads the corresponding notes
tree (if any), and the notes tree is (re)loaded when needed.

Signed-off-by: Johan Herland <johan@herland.net>
---

This patch is substantially different from the previous iteration.
Unloading (and reloading) the notes tree along with its corresponding
branch was relatively straightforward to fix, but avoiding the
destroying and re-adding of all the notes in every commit was much
harder. After 3-4 attempts at a simpler (but fundamentally broken)
approach, I finally landed on this. I'm not satisfied with the amount
of code introduced by this patch, and would be happy if someone found
a better/shorter/more elegant way to solve this problem.


...Johan


 fast-import.c          |  297 +++++++++++++++++++++++++++++++++++++++++++++++-
 t/t9300-fast-import.sh |  156 +++++++++++++++++++++++--
 2 files changed, 435 insertions(+), 18 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index dd3c99d..be3cbf9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -156,6 +156,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "notes.h"

 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -246,6 +247,7 @@ struct branch
 	struct tree_entry branch_tree;
 	uintmax_t last_commit;
 	unsigned active : 1;
+	unsigned has_notes : 1;
 	unsigned pack_id : PACK_ID_BITS;
 	unsigned char sha1[20];
 };
@@ -277,6 +279,33 @@ struct recent_command
 	char *buf;
 };

+struct notes_tree_list
+{
+	struct notes_tree tree;
+	struct notes_tree_list *next;
+};
+
+struct tree_entry_replace
+{
+	struct tree_entry_replace *next;
+	char *old_path;
+	char *new_path;
+};
+
+struct reconcile_notes_tree_helper_data
+{
+	struct tree_entry *root;
+	struct tree_entry_replace **replace_list;
+};
+
+struct reconcile_note_and_tree_entry_data
+{
+	const unsigned char *object_sha1;
+	const unsigned char *note_sha1;
+	const char *note_tree_path;
+	struct tree_entry_replace **replace_list;
+};
+
 /* Configured limits on output */
 static unsigned long max_depth = 10;
 static off_t max_packsize = (1LL << 32) - 1;
@@ -341,6 +370,9 @@ static struct branch *active_branches;
 static struct tag *first_tag;
 static struct tag *last_tag;

+/* Notes data */
+static struct notes_tree_list *notes_trees;
+
 /* Input stream parsing */
 static whenspec_type whenspec = WHENSPEC_RAW;
 static struct strbuf command_buf = STRBUF_INIT;
@@ -694,6 +726,7 @@ static struct branch *new_branch(const char *name)
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
 	b->active = 0;
+	b->has_notes = 0;
 	b->pack_id = MAX_PACK_ID;
 	branch_table[hc] = b;
 	branch_count++;
@@ -1816,6 +1849,221 @@ static void parse_new_blob(void)
 	store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark);
 }

+static struct notes_tree *notes_tree_create(const char *branch_name)
+{
+	struct notes_tree_list *ret = (struct notes_tree_list *)
+		xcalloc(sizeof(struct notes_tree_list), 1);
+	init_notes(&ret->tree, branch_name, combine_notes_overwrite,
+		NOTES_INIT_EMPTY);
+	ret->next = notes_trees;
+	notes_trees = ret;
+	return &ret->tree;
+}
+
+static struct notes_tree *notes_tree_get(struct branch *b)
+{
+	struct notes_tree_list *cur = notes_trees;
+	while (cur && strcmp(cur->tree.ref, b->name))
+		cur = cur->next;
+	return cur ? &cur->tree : NULL;
+}
+
+static void add_to_replace_list(
+		struct tree_entry_replace **replace_list,
+		const char *old_path, const char *new_path)
+{
+	struct tree_entry_replace *r = (struct tree_entry_replace *)
+		xmalloc(sizeof(struct tree_entry_replace));
+	r->next = (*replace_list)->next;
+	r->old_path = xstrdup(old_path);
+	r->new_path = xstrdup(new_path);
+	(*replace_list)->next = r;
+	*replace_list = r;
+}
+
+static void process_replace_list(struct tree_entry_replace *r,
+		struct tree_entry *root)
+{
+	struct tree_entry_replace *tmp;
+	struct tree_entry e;
+	while (r) {
+		if (r->old_path && r->new_path) {
+			/* rename old_path to new_path */
+			memset(&e, 0, sizeof(e));
+			tree_content_remove(root, r->old_path, &e);
+			if (!e.versions[1].mode)
+				die("Path %s not in branch", r->old_path);
+			tree_content_set(root, r->new_path, e.versions[1].sha1,
+					 e.versions[1].mode, e.tree);
+		}
+		tmp = r;
+		r = r->next;
+		free(tmp);
+	}
+}
+
+/*
+ * Find tree entries below given root that "match" the given SHA1 sum, and
+ * invoke the given callback for each matching entry.
+ */
+static int do_for_each_tree_entry_matching_sha1(
+		struct tree_entry *root,
+		const char *hex_sha1,
+		unsigned int match_len,
+		char *path,
+		unsigned int path_len,
+		int cb_fn(struct tree_entry *e, const char *path,
+			  unsigned int path_len, void *cb_data),
+		void *cb_data)
+{
+	struct tree_content *t = root->tree;
+	struct tree_entry *e;
+	unsigned int i;
+	int result;
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (match_len + e->name->str_len > 40 ||
+		    memcmp(hex_sha1 + match_len, e->name->str_dat,
+			e->name->str_len))
+			continue;
+
+		/* partial or full match = append to path */
+		if (path_len)
+			path[path_len++] = '/';
+		memcpy(path + path_len, e->name->str_dat,
+			e->name->str_len);
+		path_len += e->name->str_len;
+		assert(path_len < 80);
+		match_len += e->name->str_len;
+		assert(match_len <= 40);
+
+		if (match_len == 40) {
+			/* full match */
+			assert(path_len < 80);
+			path[path_len] = '\0';
+			if ((result = cb_fn(e, path, path_len, cb_data)))
+				return result;
+		}
+		else {
+			/* partial match */
+			assert(match_len < 40);
+			if (S_ISDIR(e->versions[1].mode)) {
+				if (!e->tree)
+					load_tree(e);
+				result = do_for_each_tree_entry_matching_sha1(
+					e, hex_sha1, match_len, path, path_len,
+					cb_fn, cb_data);
+				if (result)
+					return result;
+			}
+		}
+
+		path_len -= e->name->str_len;
+		if (path_len)
+			path_len--;
+		match_len -= e->name->str_len;
+	}
+	return 0;
+}
+
+static int for_each_tree_entry_matching_sha1(
+		struct tree_entry *root,
+		const unsigned char *sha1,
+		int cb_fn(struct tree_entry *e, const char *path,
+			  unsigned int path_len, void *cb_data),
+		void *cb_data)
+{
+	char hex_sha1[40], path[80];
+	memcpy(hex_sha1, sha1_to_hex(sha1), 40);
+	return do_for_each_tree_entry_matching_sha1(root, hex_sha1, 0, path, 0,
+					       cb_fn, cb_data);
+}
+
+static int reconcile_note_and_tree_entry(struct tree_entry *e,
+		const char *path, unsigned int path_len, void *cb_data)
+{
+	struct reconcile_note_and_tree_entry_data *d =
+		(struct reconcile_note_and_tree_entry_data *) cb_data;
+	int same_path = !strcmp(path, d->note_tree_path);
+	int same_sha1 = !hashcmp(e->versions[1].sha1, d->note_sha1);
+	if (same_sha1 && !same_path)
+		add_to_replace_list(d->replace_list, path, d->note_tree_path);
+	/* TODO: handle the other combinations of same_path and same_sha1 */
+	return 0;
+}
+
+static int reconcile_notes_tree_helper(
+		const unsigned char *object_sha1,
+		const unsigned char *note_sha1,
+		const char *note_tree_path,
+		void *cb_data)
+{
+	/*
+	 * Coordinate reconciliation by traversing the tree and invoking the
+	 * reconcile_note_and_tree_entry() helper for each tree_entry whose
+	 * path matches the object_sha1 of the current note.
+	 */
+	struct reconcile_notes_tree_helper_data *d =
+		(struct reconcile_notes_tree_helper_data *) cb_data;
+	struct reconcile_note_and_tree_entry_data r =
+		{ object_sha1, note_sha1, note_tree_path, d->replace_list };
+	return for_each_tree_entry_matching_sha1(d->root, object_sha1,
+		reconcile_note_and_tree_entry, &r);
+}
+
+static void do_notes_tree_load(struct tree_entry *root,
+		const char *sha1_prefix, unsigned int sha1_prefix_len,
+		struct notes_tree *notes)
+{
+	struct tree_content *t = root->tree;
+	unsigned int i;
+	char hex_sha1[40];
+
+	if (sha1_prefix_len)
+		memcpy(hex_sha1, sha1_prefix, sha1_prefix_len);
+	for (i = 0; i < t->entry_count; i++) {
+		unsigned char sha1[20];
+		struct tree_entry *e = t->entries[i];
+		if (e->name->str_len + sha1_prefix_len > 40)
+			continue;
+		memcpy(hex_sha1 + sha1_prefix_len, e->name->str_dat,
+			e->name->str_len);
+		if (sha1_prefix_len + e->name->str_len == 40 &&
+		    !get_sha1_hex(hex_sha1, sha1))
+			add_note(notes, sha1, e->versions[1].sha1, NULL);
+		if (sha1_prefix_len + e->name->str_len >= 40 ||
+		    !S_ISDIR(e->versions[1].mode))
+			continue;
+		if (!e->tree)
+			load_tree(e);
+		do_notes_tree_load(e, hex_sha1,
+			sha1_prefix_len + e->name->str_len, notes);
+	}
+}
+
+static void notes_tree_load(struct notes_tree *notes, struct tree_entry *root)
+{
+	do_notes_tree_load(root, NULL, 0, notes);
+}
+
+static void notes_tree_unload(const char *branch_name)
+{
+	struct notes_tree_list *cur = notes_trees, *prev = NULL;
+	while (cur && strcmp(cur->tree.ref, branch_name)) {
+		prev = cur;
+		cur = cur->next;
+	}
+	if (!cur)
+		return;
+	if (prev)
+		prev->next = cur->next;
+	else
+		notes_trees = cur->next;
+	free_notes(&cur->tree);
+	free(cur);
+}
+
 static void unload_one_branch(void)
 {
 	while (cur_active_branches
@@ -1844,6 +2092,8 @@ static void unload_one_branch(void)
 			release_tree_content_recursive(e->branch_tree.tree);
 			e->branch_tree.tree = NULL;
 		}
+		if (e->has_notes)
+			notes_tree_unload(e->name);
 		cur_active_branches--;
 	}
 }
@@ -2010,7 +2260,7 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }

-static void note_change_n(struct branch *b)
+static void note_change_n(struct branch *b, struct notes_tree *notes)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
@@ -2080,8 +2330,16 @@ static void note_change_n(struct branch *b)
 			    typename(type), command_buf.buf);
 	}

+	assert(notes);
+	add_note(notes, commit_sha1, sha1, NULL);
+
+	/*
+	 * Also add a corresponding entry to the branch_tree. This entry is
+	 * a placeholder for the final note entry in the tree, and will be
+	 * renamed into the correct location before committing the tree.
+	 */
 	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
-		S_IFREG | 0644, NULL);
+			 S_IFREG | 0644, NULL);
 }

 static void file_change_deleteall(struct branch *b)
@@ -2213,6 +2471,7 @@ static void parse_new_commit(void)
 	char *committer = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
+	struct notes_tree *notes = NULL;

 	/* Obtain the branch name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2243,6 +2502,10 @@ static void parse_new_commit(void)
 		load_branch(b);
 	}

+	/* retrieve notes tree */
+	if (b->has_notes)
+		notes = notes_tree_get(b);
+
 	/* file_change* */
 	while (command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
@@ -2253,10 +2516,22 @@ static void parse_new_commit(void)
 			file_change_cr(b, 1);
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
-		else if (!prefixcmp(command_buf.buf, "N "))
-			note_change_n(b);
-		else if (!strcmp("deleteall", command_buf.buf))
+		else if (!prefixcmp(command_buf.buf, "N ")) {
+			if (!notes) {
+				notes = notes_tree_create(b->name);
+				notes_tree_load(notes, &b->branch_tree);
+				b->has_notes = 1;
+			}
+			note_change_n(b, notes);
+		}
+		else if (!strcmp("deleteall", command_buf.buf)) {
+			if (notes) {
+				notes_tree_unload(b->name);
+				b->has_notes = 0;
+				notes = NULL;
+			}
 			file_change_deleteall(b);
+		}
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2265,6 +2540,18 @@ static void parse_new_commit(void)
 			break;
 	}

+	if (notes) {
+		/* reconcile diffs between b->branch_tree and the notes tree */
+		struct reconcile_notes_tree_helper_data d;
+		struct tree_entry_replace *replace_list =
+			xcalloc(1, sizeof(struct tree_entry_replace));
+		struct tree_entry_replace *anchor = replace_list;
+		d.root = &b->branch_tree;
+		d.replace_list = &replace_list;
+		for_each_note(notes, reconcile_notes_tree_helper, &d);
+		process_replace_list(anchor, &b->branch_tree);
+	}
+
 	/* build the tree and the commit */
 	store_tree(&b->branch_tree);
 	hashcpy(b->branch_tree.versions[0].sha1,
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b49815d..bf8c509 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1092,9 +1092,12 @@ test_expect_success 'P: fail on blob mark in gitlink' '
 ### series Q (notes)
 ###

-note1_data="Note for the first commit"
-note2_data="Note for the second commit"
-note3_data="Note for the third commit"
+note1_data="The first note for the first commit"
+note2_data="The first note for the second commit"
+note3_data="The first note for the third commit"
+note1b_data="The second note for the first commit"
+note1c_data="The third note for the first commit"
+note2b_data="The second note for the second commit"

 test_tick
 cat >input <<INPUT_END
@@ -1169,7 +1172,45 @@ data <<EOF
 $note3_data
 EOF

+commit refs/notes/foobar
+mark :10
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes (:10)
+COMMIT
+
+N inline :3
+data <<EOF
+$note1b_data
+EOF
+
+commit refs/notes/foobar2
+mark :11
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes (:11)
+COMMIT
+
+N inline :3
+data <<EOF
+$note1c_data
+EOF
+
+commit refs/notes/foobar
+mark :12
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes (:12)
+COMMIT
+
+deleteall
+N inline :5
+data <<EOF
+$note2b_data
+EOF
+
 INPUT_END
+
 test_expect_success \
 	'Q: commit notes' \
 	'git fast-import <input &&
@@ -1224,8 +1265,8 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 notes (:9)
 EOF
 test_expect_success \
-	'Q: verify notes commit' \
-	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
+	'Q: verify first notes commit' \
+	'git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
 	test_cmp expect actual'

 cat >expect.unsorted <<EOF
@@ -1235,23 +1276,112 @@ cat >expect.unsorted <<EOF
 EOF
 cat expect.unsorted | sort >expect
 test_expect_success \
-	'Q: verify notes tree' \
-	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	'Q: verify first notes tree' \
+	'git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	 test_cmp expect actual'

 echo "$note1_data" >expect
 test_expect_success \
-	'Q: verify note for first commit' \
-	'git cat-file blob refs/notes/foobar:$commit1 >actual && test_cmp expect actual'
+	'Q: verify first note for first commit' \
+	'git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual'

 echo "$note2_data" >expect
 test_expect_success \
-	'Q: verify note for second commit' \
-	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
+	'Q: verify first note for second commit' \
+	'git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual'
+
+echo "$note3_data" >expect
+test_expect_success \
+	'Q: verify first note for third commit' \
+	'git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual'
+
+cat >expect <<EOF
+parent `git rev-parse --verify refs/notes/foobar~2`
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+notes (:10)
+EOF
+test_expect_success \
+	'Q: verify second notes commit' \
+	'git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect.unsorted <<EOF
+100644 blob $commit1
+100644 blob $commit2
+100644 blob $commit3
+EOF
+cat expect.unsorted | sort >expect
+test_expect_success \
+	'Q: verify second notes tree' \
+	'git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	 test_cmp expect actual'
+
+echo "$note1b_data" >expect
+test_expect_success \
+	'Q: verify second note for first commit' \
+	'git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual'
+
+echo "$note2_data" >expect
+test_expect_success \
+	'Q: verify first note for second commit' \
+	'git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual'

 echo "$note3_data" >expect
 test_expect_success \
-	'Q: verify note for third commit' \
-	'git cat-file blob refs/notes/foobar:$commit3 >actual && test_cmp expect actual'
+	'Q: verify first note for third commit' \
+	'git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual'
+
+cat >expect <<EOF
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+notes (:11)
+EOF
+test_expect_success \
+	'Q: verify third notes commit' \
+	'git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect.unsorted <<EOF
+100644 blob $commit1
+EOF
+cat expect.unsorted | sort >expect
+test_expect_success \
+	'Q: verify third notes tree' \
+	'git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	 test_cmp expect actual'
+
+echo "$note1c_data" >expect
+test_expect_success \
+	'Q: verify third note for first commit' \
+	'git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual'
+
+cat >expect <<EOF
+parent `git rev-parse --verify refs/notes/foobar^`
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+notes (:12)
+EOF
+test_expect_success \
+	'Q: verify fourth notes commit' \
+	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect.unsorted <<EOF
+100644 blob $commit2
+EOF
+cat expect.unsorted | sort >expect
+test_expect_success \
+	'Q: verify fourth notes tree' \
+	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	 test_cmp expect actual'
+
+echo "$note2b_data" >expect
+test_expect_success \
+	'Q: verify second note for second commit' \
+	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'

 test_done
--
1.6.4.304.g1365c.dirty
