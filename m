From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 22/22] fast-import: Proper notes tree manipulation using
 the notes API
Date: Fri, 09 Oct 2009 12:22:18 +0200
Message-ID: <1255083738-23263-24-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClW-0004PL-NH
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760715AbZJIKY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760713AbZJIKYz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:55 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58012 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760704AbZJIKYy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:54 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BW8SUQ8I20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:14 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:14 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129782>

This patch teaches 'git fast-import' to use the notes API to organize
the manipulation of note objects through a fast-import stream. Note
objects are added to the notes tree through the 'N' command, and when
we're about to store the tree object for the current commit, we walk
through the notes tree and insert all the notes into the stored tree.

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c          |   98 ++++++++++++++++++++++++++++--
 t/t9300-fast-import.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 235 insertions(+), 19 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fcdcfaa..5837875 100644
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
@@ -277,6 +279,11 @@ struct recent_command
 	char *buf;
 };
 
+struct notes_tree_list {
+	struct notes_tree tree;
+	struct notes_tree_list *next;
+};
+
 /* Configured limits on output */
 static unsigned long max_depth = 10;
 static off_t max_packsize = (1LL << 32) - 1;
@@ -345,6 +352,9 @@ static struct branch *active_branches;
 static struct tag *first_tag;
 static struct tag *last_tag;
 
+/* Notes data */
+static struct notes_tree_list *notes_trees;
+
 /* Input stream parsing */
 static whenspec_type whenspec = WHENSPEC_RAW;
 static struct strbuf command_buf = STRBUF_INIT;
@@ -2060,7 +2070,7 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }
 
-static void note_change_n(struct branch *b)
+static void note_change_n(struct branch *b, struct notes_tree *notes)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
@@ -2130,8 +2140,8 @@ static void note_change_n(struct branch *b)
 			    typename(type), command_buf.buf);
 	}
 
-	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
-		S_IFREG | 0644, NULL);
+	assert(notes);
+	add_note(notes, commit_sha1, sha1, NULL);
 }
 
 static void file_change_deleteall(struct branch *b)
@@ -2254,6 +2264,68 @@ static struct hash_list *parse_merge(unsigned int *count)
 	return list;
 }
 
+static struct notes_tree *new_notes_tree(struct branch *b)
+{
+	struct notes_tree_list *ret = (struct notes_tree_list *)
+		xcalloc(sizeof(struct notes_tree_list), 1);
+	init_notes(&ret->tree, b->name, combine_notes_overwrite, NOTES_INIT_EMPTY);
+	ret->next = notes_trees;
+	notes_trees = ret;
+	b->has_notes = 1;
+	return &ret->tree;
+}
+
+static struct notes_tree *get_notes_tree(struct branch *b)
+{
+	struct notes_tree_list *cur = notes_trees;
+	if (!b->has_notes)
+		return NULL;
+	while (cur && strcmp(cur->tree.ref, b->name))
+		cur = cur->next;
+	assert(cur);
+	return &cur->tree;
+}
+
+static void delete_notes_tree(struct branch *b, struct notes_tree **tree)
+{
+	struct notes_tree_list *cur = notes_trees, *prev = NULL;
+	while (cur && strcmp(cur->tree.ref, b->name)) {
+		prev = cur;
+		cur = cur->next;
+	}
+	assert(cur && &cur->tree == *tree);
+	if (prev)
+		prev->next = cur->next;
+	else
+		notes_trees = cur->next;
+	free_notes(&cur->tree);
+	free(cur);
+	*tree = NULL;
+	b->has_notes = 0;
+}
+
+static int write_notes_set_helper(
+	const unsigned char *object_sha1,
+	const unsigned char *note_sha1,
+	const char *note_tree_path,
+	void *cb_data)
+{
+	struct tree_entry *t = (struct tree_entry *) cb_data;
+	tree_content_set(t, note_tree_path, note_sha1, S_IFREG | 0644, NULL);
+	return 0;
+}
+
+static int write_notes_remove_helper(
+	const unsigned char *object_sha1,
+	const unsigned char *note_sha1,
+	const char *note_tree_path,
+	void *cb_data)
+{
+	struct tree_entry *t = (struct tree_entry *) cb_data;
+	tree_content_remove(t, note_tree_path, NULL);
+	return 0;
+}
+
 static void parse_new_commit(void)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2263,6 +2335,7 @@ static void parse_new_commit(void)
 	char *committer = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
+	struct notes_tree *notes;
 
 	/* Obtain the branch name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2293,6 +2366,11 @@ static void parse_new_commit(void)
 		load_branch(b);
 	}
 
+	/* Retrieve notes tree, if needed */
+	notes = get_notes_tree(b);
+	if (notes)
+		for_each_note(notes, write_notes_remove_helper, &b->branch_tree);
+
 	/* file_change* */
 	while (command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
@@ -2303,10 +2381,16 @@ static void parse_new_commit(void)
 			file_change_cr(b, 1);
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
-		else if (!prefixcmp(command_buf.buf, "N "))
-			note_change_n(b);
-		else if (!strcmp("deleteall", command_buf.buf))
+		else if (!prefixcmp(command_buf.buf, "N ")) {
+			if (!notes)
+				notes = new_notes_tree(b);
+			note_change_n(b, notes);
+		}
+		else if (!strcmp("deleteall", command_buf.buf)) {
+			if (notes)
+				delete_notes_tree(b, &notes);
 			file_change_deleteall(b);
+		}
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2316,6 +2400,8 @@ static void parse_new_commit(void)
 	}
 
 	/* build the tree and the commit */
+	if (notes)
+		for_each_note(notes, write_notes_set_helper, &b->branch_tree);
 	store_tree(&b->branch_tree);
 	hashcpy(b->branch_tree.versions[0].sha1,
 		b->branch_tree.versions[1].sha1);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2f5c323..50a2b8a 100755
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
@@ -1235,24 +1276,113 @@ cat >expect.unsorted <<EOF
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
 
 ###
 ### series R (feature and option)
-- 
1.6.4.304.g1365c.dirty
