From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Mon, 07 Dec 2009 12:27:24 +0100
Message-ID: <1260185254-1523-2-git-send-email-johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 12:29:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbmE-0007m5-UY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933899AbZLGL1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933882AbZLGL1o
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:27:44 -0500
Received: from smtp.getmail.no ([84.208.15.66]:34269 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933768AbZLGL1j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 06:27:39 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA00L0K5694350@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:45 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA002OO5616830@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:45 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.7.111518
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1260185254-1523-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134739>

This patch teaches 'git fast-import' to automatically organize note objects
in a fast-import stream into an appropriate fanout structure. The notes API
in notes.h is NOT used to accomplish this, because trying to keep the
fast-import and notes data structures in sync would yield a significantly
larger patch with higher complexity.

Note objects are added with the 'N' command, and accounted for with a
per-branch counter, which is used to trigger fanout restructuring when
needed. Note that when restructuring the branch tree, _any_ entry whose
path consists of 40 hex chars (not including directory separators) will
be recognized as a note object. It is therefore not advisable to
manipulate note entries with M/D/R/C commands.

Since note objects are stored in the same tree structure as other objects,
the unloading and reloading of a fast-import branches handle note objects
transparently.

This patch has been improved by the following contributions:
- Shawn O. Pearce: Several style- and logic-related improvements

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Johan Herland <johan@herland.net>
---

As stated in the cover letter, I simply cannot store note information in
the tree_entry mode bits. So, I chose this somewhat more simple and crude
approach, which I still think solves the problems quite nicely.


Have fun! :)

...Johan


 fast-import.c          |  134 +++++++++++++++++++++++++++++++++++++++--
 t/t9300-fast-import.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 272 insertions(+), 18 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index dd3c99d..f04cd17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -245,6 +245,7 @@ struct branch
 	const char *name;
 	struct tree_entry branch_tree;
 	uintmax_t last_commit;
+	uintmax_t num_notes;
 	unsigned active : 1;
 	unsigned pack_id : PACK_ID_BITS;
 	unsigned char sha1[20];
@@ -693,6 +694,7 @@ static struct branch *new_branch(const char *name)
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
+	b->num_notes = 0;
 	b->active = 0;
 	b->pack_id = MAX_PACK_ID;
 	branch_table[hc] = b;
@@ -1860,6 +1862,109 @@ static void load_branch(struct branch *b)
 	}
 }

+static unsigned char convert_num_notes_to_fanout(uintmax_t num_notes)
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
+	if (fanout >= 20)
+		die("Too large fanout (%u)", fanout);
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
+static uintmax_t do_change_note_fanout(
+		struct tree_entry *orig_root, struct tree_entry *root,
+		char *hex_sha1, unsigned int hex_sha1_len,
+		char *fullpath, unsigned int fullpath_len,
+		unsigned char fanout)
+{
+	struct tree_content *t = root->tree;
+	struct tree_entry *e, leaf;
+	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
+	uintmax_t num_notes = 0;
+	unsigned char sha1[20];
+	char realpath[60];
+
+	for (i = 0; t && i < t->entry_count; i++) {
+		e = t->entries[i];
+		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
+		tmp_fullpath_len = fullpath_len;
+
+		/*
+		 * We're interested in EITHER existing note entries (entries
+		 * with exactly 40 hex chars in path, not including directory
+		 * separators), OR directory entries that may contain note
+		 * entries (with < 40 hex chars in path).
+		 * Also, each path component in a note entry must be a multiple
+		 * of 2 chars.
+		 */
+		if (!e->versions[1].mode ||
+		    tmp_hex_sha1_len > 40 ||
+		    e->name->str_len % 2)
+			continue;
+
+		/* This _may_ be a note entry, or a subdir containing notes */
+		memcpy(hex_sha1 + hex_sha1_len, e->name->str_dat,
+		       e->name->str_len);
+		if (tmp_fullpath_len)
+			fullpath[tmp_fullpath_len++] = '/';
+		memcpy(fullpath + tmp_fullpath_len, e->name->str_dat,
+		       e->name->str_len);
+		tmp_fullpath_len += e->name->str_len;
+		fullpath[tmp_fullpath_len] = '\0';
+
+		if (tmp_hex_sha1_len == 40 && !get_sha1_hex(hex_sha1, sha1)) {
+			/* This is a note entry */
+			construct_path_with_fanout(hex_sha1, fanout, realpath);
+			if (!strcmp(fullpath, realpath)) {
+				/* Note entry is in correct location */
+				num_notes++;
+				continue;
+			}
+
+			/* Rename fullpath to realpath */
+			if (!tree_content_remove(orig_root, fullpath, &leaf))
+				die("Failed to remove path %s", fullpath);
+			tree_content_set(orig_root, realpath,
+				leaf.versions[1].sha1,
+				leaf.versions[1].mode,
+				leaf.tree);
+		} else if (S_ISDIR(e->versions[1].mode)) {
+			/* This is a subdir that may contain note entries */
+			if (!e->tree)
+				load_tree(e);
+			num_notes += do_change_note_fanout(orig_root, e,
+				hex_sha1, tmp_hex_sha1_len,
+				fullpath, tmp_fullpath_len, fanout);
+		}
+
+		/* The above may have reallocated the current tree_content */
+		t = root->tree;
+	}
+	return num_notes;
+}
+
+static uintmax_t change_note_fanout(struct tree_entry *root,
+		unsigned char fanout)
+{
+	char hex_sha1[40], path[60];
+	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -2010,14 +2115,16 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }

-static void note_change_n(struct branch *b)
+static void note_change_n(struct branch *b, unsigned char old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	struct object_entry *oe = oe;
 	struct branch *s;
 	unsigned char sha1[20], commit_sha1[20];
+	char path[60];
 	uint16_t inline_data = 0;
+	unsigned char new_fanout;

 	/* <dataref> or 'inline' */
 	if (*p == ':') {
@@ -2071,7 +2178,7 @@ static void note_change_n(struct branch *b)
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
-	} else {
+	} else if (!is_null_sha1(sha1)) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
@@ -2080,8 +2187,17 @@ static void note_change_n(struct branch *b)
 			    typename(type), command_buf.buf);
 	}

-	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
-		S_IFREG | 0644, NULL);
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), old_fanout, path);
+	if (tree_content_remove(&b->branch_tree, path, NULL))
+		b->num_notes--;
+
+	if (is_null_sha1(sha1))
+		return; /* nothing to insert */
+
+	b->num_notes++;
+	new_fanout = convert_num_notes_to_fanout(b->num_notes);
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), new_fanout, path);
+	tree_content_set(&b->branch_tree, path, sha1, S_IFREG | 0644, NULL);
 }

 static void file_change_deleteall(struct branch *b)
@@ -2090,6 +2206,7 @@ static void file_change_deleteall(struct branch *b)
 	hashclr(b->branch_tree.versions[0].sha1);
 	hashclr(b->branch_tree.versions[1].sha1);
 	load_tree(&b->branch_tree);
+	b->num_notes = 0;
 }

 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
@@ -2213,6 +2330,7 @@ static void parse_new_commit(void)
 	char *committer = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
+	unsigned char prev_fanout, new_fanout;

 	/* Obtain the branch name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2243,6 +2361,8 @@ static void parse_new_commit(void)
 		load_branch(b);
 	}

+	prev_fanout = convert_num_notes_to_fanout(b->num_notes);
+
 	/* file_change* */
 	while (command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
@@ -2254,7 +2374,7 @@ static void parse_new_commit(void)
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
 		else if (!prefixcmp(command_buf.buf, "N "))
-			note_change_n(b);
+			note_change_n(b, prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else {
@@ -2265,6 +2385,10 @@ static void parse_new_commit(void)
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
