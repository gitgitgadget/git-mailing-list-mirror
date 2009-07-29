From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 6/8] First draft of notes tree parser with support for fanout
 subtrees
Date: Wed, 29 Jul 2009 04:25:24 +0200
Message-ID: <1248834326-31488-7-git-send-email-johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 04:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVytg-00086P-Hi
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZG2C1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 22:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbZG2C1y
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:27:54 -0400
Received: from mx.getmail.no ([84.208.15.66]:38538 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756161AbZG2C1x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 22:27:53 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI00GPQUUHX1B0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:27:53 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI004NXUQPO310@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:27:53 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.29.21516
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248834326-31488-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124300>

This is a relatively straightforward implementation of parsing notes trees
that use fanout directories to limit the size of individual tree objects.
This first draft uses a simple linked list for holding unparsed subtree
references (to be parsed on demand), and as such, this first draft
concentrates more on correctness than performance (AFAICS from t3302, there
is no measurable performance impact when no fanout subtrees are present).

The semantics used when parsing notes trees (with regards to fanout subtrees)
follow Dscho's proposal fairly closely:
- No concatenation/merging of notes is performed. If there are several notes
  objects referencing a given commit, only one of those objects are used.
- If a notes object for a given commit is present in the "root" notes tree,
  no subtrees are consulted; the object in the root tree is used directly.
- If there are more than one subtree that prefix-matches the given commit,
  only the subtree with the _longest_ matching prefix is consulted. This
  means that if the given commit is e.g. "deadbeef", and the notes tree have
  subtrees "de" and "dead", then the following paths in the notes tree are
  searched: "deadbeef", "dead/beef". Note that "de/adbeef" is NOT searched.
  (This might change in the future)
- Fanout directories (subtrees) must references a whole number of bytes
  from the SHA1 sum they subdivide. E.g. subtrees "dead" and "de" are
  acceptable; "d" and "dea" are not.
- Multiple levels of fanout is allowed. All the above rules apply recursively.
  E.g. "de/adbeef" is preferred over "de/adbe/ef", etc.

The patch includes new selftests for verifying the expected behaviour when
loading notes trees with various fanout schemes.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c                   |  165 ++++++++++++++++++++++++++++++++----
 t/t3303-notes-subtrees.sh |  206 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 356 insertions(+), 15 deletions(-)
 create mode 100755 t/t3303-notes-subtrees.sh

diff --git a/notes.c b/notes.c
index bd73784..7b50a70 100644
--- a/notes.c
+++ b/notes.c
@@ -16,8 +16,19 @@ struct hash_map {
 	off_t count, size;
 };
 
+struct subtree_entry {
+	/*
+	 * SHA1 prefix is stored in the first 19 bytes (w/trailing NUL bytes);
+	 * length of SHA1 prefix is stored in the last byte
+	 */
+	unsigned char sha1_prefix_w_len[20];
+	unsigned char subtree_sha1[20];
+	struct subtree_entry *next;
+};
+
 static int initialized;
 static struct hash_map hash_map;
+static struct subtree_entry *subtree_list;
 
 static int hash_index(struct hash_map *map, const unsigned char *sha1)
 {
@@ -70,39 +81,163 @@ static void add_entry(const unsigned char *commit_sha1,
 	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
 }
 
+/*
+ * Convert a partial SHA1 sum (hex format) to a SHA1 value.
+ * - hex      - ASCII hex SHA1 segment
+ * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
+ * - sha1     - Value of SHA1 is written here
+ * - sha1_len - Max #bytes to store in sha1, Must be between 0 and 20,
+ *              and >= hex_len / 2
+ * Returns -1 on error (invalid arguments or invalid ASCII hex SHA1 format).
+ * Otherwise, returns number of bytes written to sha1 (hex_len / 2).
+ * Pads sha1 with NULs up to sha1_len (not included in returned length).
+ */
+static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
+		unsigned char *sha1, unsigned int sha1_len)
+{
+	unsigned int i, len = hex_len >> 1;
+	if (hex_len % 2 != 0 || len > sha1_len)
+		return -1;
+	for (i = 0; i < len; i++) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		if (val & ~0xff)
+			return -1;
+		*sha1++ = val;
+		hex += 2;
+	}
+	for (; i < sha1_len; i++)
+		*sha1++ = 0;
+	return len;
+}
+
+static void load_subtree(struct subtree_entry *se)
+{
+	unsigned char commit_sha1[20];
+	unsigned int prefix_len;
+	void *buf;
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct subtree_entry *tmp_list = NULL, *tmp_last = NULL;
+
+	buf = fill_tree_descriptor(&desc, se->subtree_sha1);
+	if (!buf)
+		die("Could not read %s for notes-index",
+		     sha1_to_hex(se->subtree_sha1));
+
+	prefix_len = se->sha1_prefix_w_len[19];
+	memcpy(commit_sha1, se->sha1_prefix_w_len, prefix_len);
+	while (tree_entry(&desc, &entry)) {
+		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
+				commit_sha1 + prefix_len, 20 - prefix_len);
+		if (len < 0)
+			continue; /* entry.path is not a SHA1 sum. Skip */
+		len += prefix_len;
+
+		/* If commit SHA1 is complete, assume note object */
+		if (len == 20)
+			add_entry(commit_sha1, entry.sha1);
+		/* If commit SHA1 is incomplete, assume note subtree */
+		else if (len < 20 && entry.mode == S_IFDIR) {
+			struct subtree_entry *n = (struct subtree_entry *)
+				xcalloc(sizeof(struct subtree_entry), 1);
+			hashcpy(n->sha1_prefix_w_len, commit_sha1);
+			n->sha1_prefix_w_len[19] = (unsigned char) len;
+			hashcpy(n->subtree_sha1, entry.sha1);
+
+			if (!tmp_list) {
+				tmp_list = n;
+				tmp_last = n;
+			}
+			else {
+				assert(!tmp_last->next);
+				assert(hashcmp(n->sha1_prefix_w_len,
+					tmp_last->sha1_prefix_w_len) > 0);
+				tmp_last->next = n;
+				tmp_last = n;
+			}
+		}
+	}
+	free(buf);
+	if (tmp_list) {
+		/* insert tmp_list immediately after se */
+		assert(hashcmp(tmp_list->sha1_prefix_w_len,
+				se->sha1_prefix_w_len) > 0);
+		if (se->next) {
+			assert(hashcmp(se->next->sha1_prefix_w_len,
+					tmp_last->sha1_prefix_w_len) > 0);
+			tmp_last->next = se->next;
+		}
+		se->next = tmp_list;
+	}
+}
+
 static void initialize_hash_map(const char *notes_ref_name)
 {
 	unsigned char sha1[20], commit_sha1[20];
 	unsigned mode;
-	struct tree_desc desc;
-	struct name_entry entry;
-	void *buf;
+	struct subtree_entry root_tree;
 
 	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
 	    get_tree_entry(commit_sha1, "", sha1, &mode))
 		return;
 
-	buf = fill_tree_descriptor(&desc, sha1);
-	if (!buf)
-		die("Could not read %s for notes-index", sha1_to_hex(sha1));
+	hashclr(root_tree.sha1_prefix_w_len);
+	hashcpy(root_tree.subtree_sha1, sha1);
+	root_tree.next = NULL;
+	load_subtree(&root_tree);
+	subtree_list = root_tree.next;
+}
 
-	while (tree_entry(&desc, &entry))
-		if (!get_sha1(entry.path, commit_sha1))
-			add_entry(commit_sha1, entry.sha1);
-	free(buf);
+/*
+ * Compare the given commit SHA1 against the given subtree entry.
+ * Return -1 if the commit SHA1 cannot exist within the given subtree, or any
+ * subtree following it.
+ * Return 0 if the commit SHA1 _may_ exist within the given subtree.
+ * Return 1 if the commit SHA1 cannot exist within the given subtree, but may
+ * exist within a subtree following it.
+ */
+static int commit_subtree_cmp(const unsigned char *commit_sha1,
+		const struct subtree_entry *entry)
+{
+	unsigned int prefix_len = entry->sha1_prefix_w_len[19];
+	return memcmp(commit_sha1, entry->sha1_prefix_w_len, prefix_len);
+}
+
+static struct subtree_entry *lookup_subtree(const unsigned char *commit_sha1)
+{
+	struct subtree_entry *found = NULL, *cur = subtree_list;
+	while (cur) {
+		int cmp = commit_subtree_cmp(commit_sha1, cur);
+		if (!cmp)
+			found = cur;
+		if (cmp < 0)
+			break;
+		cur = cur->next;
+	}
+	return found;
 }
 
 static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 {
 	int index;
+	struct subtree_entry *subtree;
 
-	if (!hash_map.size)
-		return NULL;
+	/* First, try to find the commit SHA1 directly in hash map */
+	index = hash_map.size ? hash_index(&hash_map, commit_sha1) : -1;
+	if (index >= 0)
+		return hash_map.entries[index].notes_sha1;
 
-	index = hash_index(&hash_map, commit_sha1);
-	if (index < 0)
+	/* Next, try finding a subtree that may contain the commit SHA1 */
+	subtree = lookup_subtree(commit_sha1);
+
+	/* Give up if no subtree found, or if subtree is already loaded */
+	if (!subtree || is_null_sha1(subtree->subtree_sha1))
 		return NULL;
-	return hash_map.entries[index].notes_sha1;
+
+	/* Load subtree into hash_map, and retry lookup recursively */
+	load_subtree(subtree);
+	hashclr(subtree->subtree_sha1);
+	return lookup_notes(commit_sha1);
 }
 
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
new file mode 100755
index 0000000..40bb3f4
--- /dev/null
+++ b/t/t3303-notes-subtrees.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+
+test_description='Test commit notes organized in subtrees'
+
+. ./test-lib.sh
+
+number_of_commits=100
+
+start_note_commit () {
+	test_tick &&
+	cat <<INPUT_END
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes
+COMMIT
+
+from refs/notes/commits^0
+deleteall
+INPUT_END
+
+}
+
+verify_notes () {
+	git log | grep "^    " > output &&
+	i=$number_of_commits &&
+	while [ $i -gt 0 ]; do
+		echo "    commit #$i" &&
+		echo "    note for commit #$i" &&
+		i=$(($i-1));
+	done > expect &&
+	test_cmp expect output
+}
+
+test_expect_success 'setup: create $number_of_commits commits' '
+
+	(
+		nr=0 &&
+		while [ $nr -lt $number_of_commits ]; do
+			nr=$(($nr+1)) &&
+			test_tick &&
+			cat <<INPUT_END
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #$nr
+COMMIT
+
+M 644 inline file
+data <<EOF
+file in commit #$nr
+EOF
+
+INPUT_END
+
+		done &&
+		test_tick &&
+		cat <<INPUT_END
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+no notes
+COMMIT
+
+deleteall
+
+INPUT_END
+
+	) |
+	git fast-import --quiet &&
+	git config core.notesRef refs/notes/commits
+'
+
+test_expect_success 'test notes in 2/38-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 4/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^....|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 4/36-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 4/36-fanout overriding 2/38-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			ignored_note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			preferred_note_path=$(echo "$sha1" | sed "s|^....|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $ignored_note_path
+data <<EOF
+IGNORED note for commit #$nr
+EOF
+
+M 100644 inline $preferred_note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 4/36-fanout overriding 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/2/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^\(..\)\(..\)|\1/\2/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/2/36-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/38-fanout overriding 2/2/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			ignored_note_path=$(echo "$sha1" | sed "s|^\(..\)\(..\)|\1/\2/|")
+			preferred_note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $ignored_note_path
+data <<EOF
+IGNORED note for commit #$nr
+EOF
+
+M 100644 inline $preferred_note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/38-fanout overriding 2/2/36-fanout' 'verify_notes'
+
+test_done
-- 
1.6.4.rc3.138.ga6b98.dirty
