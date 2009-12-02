From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 01/11] fast-import: Proper notes tree manipulation
Date: Wed, 02 Dec 2009 03:09:33 +0100
Message-ID: <1259719783-4674-2-git-send-email-johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFefc-0005XN-O0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbZLBCKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbZLBCKF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:10:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44143 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754459AbZLBCKD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:10:03 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000GVJ60XEG10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:09 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:09 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1259719783-4674-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134284>

This patch teaches 'git fast-import' to automatically organize note objects
in a fast-import stream into an appropriate fanout structure. The notes API
in notes.h is NOT used to accomplish this, because trying to keep the
fast-import and notes data structures in sync would yield a significantly
larger patch with higher complexity.

Note objects are added to the fast-import tree structure with special mode
bits set, so that they can be recognized and restructured on-demand. The
special mode bits are ignored when generating the containing tree object,
hence the special mode bits are never visible externally.

The code keeps track of the number of note objects per branch through a
simple counter, and if/when the number of notes warrant a different fanout
level, the branch tree is traversed, renaming note objects into the
location dictated by the new fanout level.

Since note objects are stored in the same tree structure as other objects,
the unloading and reloading of a fast-import branches handle note objects
transparently.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Thursday 26 November 2009, Shawn O. Pearce wrote:
> Yea, I agree, I'm not happy with the amount of complex code added
> to implement this.  But I can't say there's a better way to do it
> and still reuse the notes code.  Maybe its just worth breaking away
> from the notes code altogether?  fast-import also implements its
> own pack formatting functions because reusing them from pack-objects
> was just too ugly.

Ok, here is the promised rewrite that does it all within fast-import
instead of reusing the notes code. It's much smaller, both in size,
and in the impact on the existing code. I'm certainly a lot happier
with this patch, than with the previous iteration.


Have fun! :)

...Johan


 fast-import.c          |  141 +++++++++++++++++++++++++++++++++++++++++---
 t/t9300-fast-import.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 276 insertions(+), 21 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b41d29f..b51ffbc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -161,6 +161,7 @@ Format of STDIN stream:
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
 #define DEPTH_BITS 13
 #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
+#define NOTE_MODE 0170000

 struct object_entry
 {
@@ -245,6 +246,7 @@ struct branch
 	const char *name;
 	struct tree_entry branch_tree;
 	uintmax_t last_commit;
+	unsigned int num_notes;
 	unsigned active : 1;
 	unsigned pack_id : PACK_ID_BITS;
 	unsigned char sha1[20];
@@ -693,6 +695,7 @@ static struct branch *new_branch(const char *name)
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
+	b->num_notes = 0;
 	b->active = 0;
 	b->pack_id = MAX_PACK_ID;
 	branch_table[hc] = b;
@@ -1306,10 +1309,12 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 	strbuf_grow(b, maxlen);
 	for (i = 0; i < t->entry_count; i++) {
 		struct tree_entry *e = t->entries[i];
-		if (!e->versions[v].mode)
+		unsigned int mode = (unsigned int) e->versions[v].mode;
+		if (!mode)
 			continue;
-		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
-					e->name->str_dat, '\0');
+		else if ((mode & NOTE_MODE) == NOTE_MODE)
+			mode = (mode & ~NOTE_MODE) | S_IFREG;
+		strbuf_addf(b, "%o %s%c", mode, e->name->str_dat, '\0');
 		strbuf_add(b, e->versions[v].sha1, 20);
 	}
 }
@@ -1860,6 +1865,115 @@ static void load_branch(struct branch *b)
 	}
 }

+static unsigned char convert_num_notes_to_fanout(unsigned int num_notes)
+{
+	unsigned char fanout = 0;
+	while ((num_notes >>= 8))
+		fanout++;
+	return fanout;
+}
+
+static void construct_path_with_fanout(const char *hex_sha1,
+		unsigned char fanout, char *path)
+{
+	unsigned int i = 0, j = 0;
+	assert(fanout < 20);
+	while (fanout) {
+		path[i++] = hex_sha1[j++];
+		path[i++] = hex_sha1[j++];
+		path[i++] = '/';
+		fanout--;
+	}
+	memcpy(path + i, hex_sha1 + j, 40 - j);
+	path[i + 40 - j] = '\0';
+}
+
+static int adjust_num_notes(struct tree_entry *root, const char *p,
+		const unsigned char *sha1)
+{
+	/* Return -1/0/1 indicating how storing sha1 at p affects #notes */
+	struct tree_entry leaf;
+	int delete_note = is_null_sha1(sha1) ? 1 : 0;
+	int nonexisting_note = !(
+		tree_content_get(root, p, &leaf) &&
+		!is_null_sha1(leaf.versions[1].sha1) &&
+		(leaf.versions[1].mode & NOTE_MODE) == NOTE_MODE) ? 1 : 0;
+	return nonexisting_note - delete_note;
+}
+
+static unsigned int do_change_note_fanout(
+		struct tree_entry *orig_root, struct tree_entry *root,
+		char *hex_sha1, unsigned int hex_sha1_len,
+		char *fullpath, unsigned int fullpath_len,
+		unsigned char fanout)
+{
+	struct tree_content *t = root->tree;
+	struct tree_entry *e, leaf;
+	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len, num_notes = 0;
+	unsigned char sha1[20];
+	char realpath[60];
+	int is_note;
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		is_note = (e->versions[1].mode & NOTE_MODE) == NOTE_MODE;
+		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
+		tmp_fullpath_len = fullpath_len;
+
+		if (tmp_hex_sha1_len <= 40 && e->name->str_len >= 2) {
+			memcpy(hex_sha1 + hex_sha1_len, e->name->str_dat,
+				e->name->str_len);
+			if (tmp_fullpath_len)
+				fullpath[tmp_fullpath_len++] = '/';
+			memcpy(fullpath + tmp_fullpath_len, e->name->str_dat,
+				e->name->str_len);
+			tmp_fullpath_len += e->name->str_len;
+			assert(tmp_fullpath_len < 60);
+			fullpath[tmp_fullpath_len] = '\0';
+		} else {
+			assert(!is_note);
+			continue;
+		}
+
+		if (is_note) {
+			num_notes++;
+			assert(tmp_hex_sha1_len == 40);
+			if (get_sha1_hex(hex_sha1, sha1))
+				die("Invalid SHA1 sum %.40s", hex_sha1);
+			construct_path_with_fanout(hex_sha1, fanout, realpath);
+			if (!strcmp(fullpath, realpath))
+				continue; /* note is already in right place */
+
+			/* Rename fullpath to realpath */
+			if (!tree_content_remove(orig_root, fullpath, &leaf))
+				die("Failed to remove path %s", fullpath);
+			if (!leaf.versions[1].mode)
+				die("Path %s not in branch", fullpath);
+			tree_content_set(orig_root, realpath,
+				leaf.versions[1].sha1,
+				leaf.versions[1].mode,
+				leaf.tree);
+		} else if (tmp_hex_sha1_len < 40 && S_ISDIR(e->versions[1].mode)) {
+			/* Found a subdir that may contain a note */
+			num_notes += do_change_note_fanout(orig_root, e,
+				hex_sha1, tmp_hex_sha1_len,
+				fullpath, tmp_fullpath_len, fanout);
+		}
+
+		/* The above may have reallocated the current tree_content */
+		if (t != root->tree)
+			t = root->tree;
+	}
+	return num_notes;
+}
+
+static unsigned int change_note_fanout(struct tree_entry *root,
+		unsigned char fanout)
+{
+	char hex_sha1[40], path[60];
+	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -2010,14 +2124,15 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }

-static void note_change_n(struct branch *b)
+static void note_change_n(struct branch *b, unsigned char fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	struct object_entry *oe = oe;
 	struct branch *s;
 	unsigned char sha1[20], commit_sha1[20];
-	uint16_t inline_data = 0;
+	char path[60];
+	uint16_t inline_data = 0, mode;

 	/* <dataref> or 'inline' */
 	if (*p == ':') {
@@ -2080,8 +2195,10 @@ static void note_change_n(struct branch *b)
 			    typename(type), command_buf.buf);
 	}

-	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
-		S_IFREG | 0644, NULL);
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), fanout, path);
+	b->num_notes += adjust_num_notes(&b->branch_tree, path, sha1);
+	mode = (is_null_sha1(sha1) ? S_IFREG : NOTE_MODE) | 0644;
+	tree_content_set(&b->branch_tree, path, sha1, mode, NULL);
 }

 static void file_change_deleteall(struct branch *b)
@@ -2090,6 +2207,7 @@ static void file_change_deleteall(struct branch *b)
 	hashclr(b->branch_tree.versions[0].sha1);
 	hashclr(b->branch_tree.versions[1].sha1);
 	load_tree(&b->branch_tree);
+	b->num_notes = 0;
 }

 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
@@ -2213,6 +2331,7 @@ static void parse_new_commit(void)
 	char *committer = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
+	unsigned char prev_fanout, new_fanout;

 	/* Obtain the branch name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2243,6 +2362,8 @@ static void parse_new_commit(void)
 		load_branch(b);
 	}

+	prev_fanout = convert_num_notes_to_fanout(b->num_notes);
+
 	/* file_change* */
 	while (command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
@@ -2254,7 +2375,7 @@ static void parse_new_commit(void)
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
 		else if (!prefixcmp(command_buf.buf, "N "))
-			note_change_n(b);
+			note_change_n(b, prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else {
@@ -2265,6 +2386,10 @@ static void parse_new_commit(void)
 			break;
 	}

+	new_fanout = convert_num_notes_to_fanout(b->num_notes);
+	if (new_fanout != prev_fanout)
+		b->num_notes = change_note_fanout(&b->branch_tree, new_fanout);
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
1.6.5.3.433.g11067
