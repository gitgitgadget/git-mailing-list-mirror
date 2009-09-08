From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 11/14] Teach the notes lookup code to parse notes trees with
 various fanout schemes
Date: Tue, 08 Sep 2009 04:26:59 +0200
Message-ID: <1252376822-6138-12-git-send-email-johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqRd-0005lE-J8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbZIHC1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZIHC1f
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34077 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753431AbZIHC1d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:33 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CZCS5ZLI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:35 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:35 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1252376822-6138-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127960>

The semantics used when parsing notes trees (with regards to fanout subtrees)
follow Dscho's proposal fairly closely:
- No concatenation/merging of notes is performed. If there are several notes
  objects referencing a given commit, only one of those objects are used.
- If a notes object for a given commit is present in the "root" notes tree,
  no subtrees are consulted; the object in the root tree is used directly.
- If there are more than one subtree that prefix-matches the given commit,
  only the subtree with the longest matching prefix is consulted. This
  means that if the given commit is e.g. "deadbeef", and the notes tree have
  subtrees "de" and "dead", then the following paths in the notes tree are
  searched: "deadbeef", "dead/beef". Note that "de/adbeef" is NOT searched.
- Fanout directories (subtrees) must references a whole number of bytes
  from the SHA1 sum they subdivide. E.g. subtrees "dead" and "de" are
  acceptable; "d" and "dea" are not.
- Multiple levels of fanout are allowed. All the above rules apply
  recursively. E.g. "de/adbeef" is preferred over "de/adbe/ef", etc.

This patch changes the in-memory datastructure for holding parsed notes:
Instead of holding all note (and subtree) entries in a hash table, a
simple 16-tree structure is used instead. The tree structure consists of
16-arrays as internal nodes, and note/subtree entries as leaf nodes. The
tree is traversed by indexing subsequent nibbles of the search key until
a leaf node is encountered. If a subtree entry is encountered while
searching for a note, the subtree is unpacked into the 16-tree structure,
and the search continues into that subtree.

The new algorithm performs significantly better in the cases where only
a fraction of the notes need to be looked up (this is assumed to be the
common case for notes lookup). The new code even performs marginally
better in the worst case (where _all_ the notes are looked up).

In addition to this, comes the massive performance win associated with
organizing the notes tree according to some fanout scheme. Even a simple
2/38 fanout scheme is dramatically quicker to traverse (going from tens of
seconds to sub-second runtimes).

As for memory usage, the new code is marginally better than the old code in
the worst case, but in the case of looking up only some notes from a notes
tree with proper fanout, the new code uses only a small fraction of the
memory needed to hold the entire notes tree.

However, there is one casualty of this patch. The old notes lookup code was
able to parse notes that were associated with non-SHA1s (e.g. refs). The new
code requires the referenced object to be named by a SHA1 sum. Still, this
is not considered a major setback, since the notes infrastructure was not
originally intended to annotate objects outside the Git object database.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  317 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 248 insertions(+), 69 deletions(-)

diff --git a/notes.c b/notes.c
index 008c3d4..6926aa6 100644
--- a/notes.c
+++ b/notes.c
@@ -6,103 +6,282 @@
 #include "strbuf.h"
 #include "tree-walk.h"

-struct entry {
-	unsigned char commit_sha1[20];
-	unsigned char notes_sha1[20];
+/*
+ * Use a non-balancing simple 16-tree structure with struct int_node as
+ * internal nodes, and struct leaf_node as leaf nodes. Each int_node has a
+ * 16-array of pointers to its children.
+ * The bottom 2 bits of each pointer is used to identify the pointer type
+ * - ptr & 3 == 0 - NULL pointer, assert(ptr == NULL)
+ * - ptr & 3 == 1 - pointer to next internal node - cast to struct int_node *
+ * - ptr & 3 == 2 - pointer to note entry - cast to struct leaf_node *
+ * - ptr & 3 == 3 - pointer to subtree entry - cast to struct leaf_node *
+ *
+ * The root node is a statically allocated struct int_node.
+ */
+struct int_node {
+	void *a[16];
 };

-struct hash_map {
-	struct entry *entries;
-	off_t count, size;
+/*
+ * Leaf nodes come in two variants, note entries and subtree entries,
+ * distinguished by the LSb of the leaf node pointer (see above).
+ * As a note entry, the key is the SHA1 of the referenced commit, and the
+ * value is the SHA1 of the note object.
+ * As a subtree entry, the key is the prefix SHA1 (w/trailing NULs) of the
+ * referenced commit, using the last byte of the key to store the length of
+ * the prefix. The value is the SHA1 of the tree object containing the notes
+ * subtree.
+ */
+struct leaf_node {
+	unsigned char key_sha1[20];
+	unsigned char val_sha1[20];
 };

-static int initialized;
-static struct hash_map hash_map;
+#define PTR_TYPE_NULL     0
+#define PTR_TYPE_INTERNAL 1
+#define PTR_TYPE_NOTE     2
+#define PTR_TYPE_SUBTREE  3

-static int hash_index(struct hash_map *map, const unsigned char *sha1)
-{
-	int i = ((*(unsigned int *)sha1) % map->size);
+#define GET_PTR_TYPE(ptr)       ((uintptr_t) (ptr) & 3)
+#define CLR_PTR_TYPE(ptr)       ((void *) ((uintptr_t) (ptr) & ~3))
+#define SET_PTR_TYPE(ptr, type) ((void *) ((uintptr_t) (ptr) | (type)))

-	for (;;) {
-		unsigned char *current = map->entries[i].commit_sha1;
+#define GET_NIBBLE(n, sha1) (((sha1[n >> 1]) >> ((n & 0x01) << 2)) & 0x0f)

-		if (!hashcmp(sha1, current))
-			return i;
+#define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
+	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))

-		if (is_null_sha1(current))
-			return -1 - i;
+static struct int_node root_node;

-		if (++i == map->size)
-			i = 0;
+static int initialized;
+
+static void load_subtree(struct leaf_node *subtree, struct int_node *node,
+		unsigned int n);
+
+/*
+ * To find a leaf_node:
+ * 1. Start at the root node, with n = 0
+ * 2. Use the nth nibble of the key as an index into a:
+ *    - If a[n] is an int_node, recurse into that node and increment n
+ *    - If a leaf_node with matching key, return leaf_node (assert note entry)
+ *    - If a matching subtree entry, unpack that subtree entry (and remove it);
+ *      restart search at the current level.
+ *    - Otherwise, we end up at a NULL pointer, or a non-matching leaf_node.
+ *      Backtrack out of the recursion, one level at a time and check a[0]:
+ *      - If a[0] at the current level is a matching subtree entry, unpack that
+ *        subtree entry (and remove it); restart search at the current level.
+ */
+static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
+		const unsigned char *key_sha1)
+{
+	struct leaf_node *l;
+	unsigned char i = GET_NIBBLE(n, key_sha1);
+	void *p = tree->a[i];
+
+	switch(GET_PTR_TYPE(p)) {
+	case PTR_TYPE_INTERNAL:
+		l = note_tree_find(CLR_PTR_TYPE(p), n + 1, key_sha1);
+		if (l)
+			return l;
+		break;
+	case PTR_TYPE_NOTE:
+		l = (struct leaf_node *) CLR_PTR_TYPE(p);
+		if (!hashcmp(key_sha1, l->key_sha1))
+			return l; /* return note object matching given key */
+		break;
+	case PTR_TYPE_SUBTREE:
+		l = (struct leaf_node *) CLR_PTR_TYPE(p);
+		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
+			/* unpack tree and resume search */
+			tree->a[i] = NULL;
+			load_subtree(l, tree, n);
+			free(l);
+			return note_tree_find(tree, n, key_sha1);
+		}
+		break;
+	case PTR_TYPE_NULL:
+	default:
+		assert(!p);
+		break;
 	}
+
+	/*
+	 * Did not find key at this (or any lower) level.
+	 * Check if there's a matching subtree entry in tree->a[0].
+	 * If so, unpack tree and resume search.
+	 */
+	p = tree->a[0];
+	if (GET_PTR_TYPE(p) != PTR_TYPE_SUBTREE)
+		return NULL;
+	l = (struct leaf_node *) CLR_PTR_TYPE(p);
+	if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
+		/* unpack tree and resume search */
+		tree->a[0] = NULL;
+		load_subtree(l, tree, n);
+		free(l);
+		return note_tree_find(tree, n, key_sha1);
+	}
+	return NULL;
 }

-static void add_entry(const unsigned char *commit_sha1,
-		const unsigned char *notes_sha1)
+/*
+ * To insert a leaf_node:
+ * 1. Start at the root node, with n = 0
+ * 2. Use the nth nibble of the key as an index into a:
+ *    - If a[n] is NULL, store the tweaked pointer directly into a[n]
+ *    - If a[n] is an int_node, recurse into that node and increment n
+ *    - If a[n] is a leaf_node:
+ *      1. Check if they're equal, and handle that (abort? overwrite?)
+ *      2. Create a new int_node, and store both leaf_nodes there
+ *      3. Store the new int_node into a[n].
+ */
+static int note_tree_insert(struct int_node *tree, unsigned char n,
+		const struct leaf_node *entry, unsigned char type)
 {
-	int index;
-
-	if (hash_map.count + 1 > hash_map.size >> 1) {
-		int i, old_size = hash_map.size;
-		struct entry *old = hash_map.entries;
-
-		hash_map.size = old_size ? old_size << 1 : 64;
-		hash_map.entries = (struct entry *)
-			xcalloc(sizeof(struct entry), hash_map.size);
-
-		for (i = 0; i < old_size; i++)
-			if (!is_null_sha1(old[i].commit_sha1)) {
-				index = -1 - hash_index(&hash_map,
-						old[i].commit_sha1);
-				memcpy(hash_map.entries + index, old + i,
-					sizeof(struct entry));
-			}
-		free(old);
+	struct int_node *new_node;
+	const struct leaf_node *l;
+	int ret;
+	unsigned char i = GET_NIBBLE(n, entry->key_sha1);
+	void *p = tree->a[i];
+	assert(GET_PTR_TYPE(entry) == PTR_TYPE_NULL);
+	switch(GET_PTR_TYPE(p)) {
+	case PTR_TYPE_NULL:
+		assert(!p);
+		tree->a[i] = SET_PTR_TYPE(entry, type);
+		return 0;
+	case PTR_TYPE_INTERNAL:
+		return note_tree_insert(CLR_PTR_TYPE(p), n + 1, entry, type);
+	default:
+		assert(GET_PTR_TYPE(p) == PTR_TYPE_NOTE ||
+			GET_PTR_TYPE(p) == PTR_TYPE_SUBTREE);
+		l = (const struct leaf_node *) CLR_PTR_TYPE(p);
+		if (!hashcmp(entry->key_sha1, l->key_sha1))
+			return -1; /* abort insert on matching key */
+		new_node = (struct int_node *)
+			xcalloc(sizeof(struct int_node), 1);
+		ret = note_tree_insert(new_node, n + 1,
+			CLR_PTR_TYPE(p), GET_PTR_TYPE(p));
+		if (ret) {
+			free(new_node);
+			return -1;
+		}
+		tree->a[i] = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
+		return note_tree_insert(new_node, n + 1, entry, type);
 	}
+}

-	index = hash_index(&hash_map, commit_sha1);
-	if (index < 0) {
-		index = -1 - index;
-		hash_map.count++;
+/* Free the entire notes data contained in the given tree */
+static void note_tree_free(struct int_node *tree)
+{
+	unsigned int i;
+	for (i = 0; i < 16; i++) {
+		void *p = tree->a[i];
+		switch(GET_PTR_TYPE(p)) {
+		case PTR_TYPE_INTERNAL:
+			note_tree_free(CLR_PTR_TYPE(p));
+			/* fall through */
+		case PTR_TYPE_NOTE:
+		case PTR_TYPE_SUBTREE:
+			free(CLR_PTR_TYPE(p));
+		}
 	}
+}

-	hashcpy(hash_map.entries[index].commit_sha1, commit_sha1);
-	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
+/*
+ * Convert a partial SHA1 hex string to the corresponding partial SHA1 value.
+ * - hex      - Partial SHA1 segment in ASCII hex format
+ * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
+ * - sha1     - Partial SHA1 value is written here
+ * - sha1_len - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
+ * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format).
+ * Otherwise, returns number of bytes written to sha1 (i.e. hex_len / 2).
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
 }

-static void initialize_hash_map(const char *notes_ref_name)
+static void load_subtree(struct leaf_node *subtree, struct int_node *node,
+		unsigned int n)
 {
-	unsigned char sha1[20], commit_sha1[20];
-	unsigned mode;
+	unsigned char commit_sha1[20];
+	unsigned int prefix_len;
+	int status;
+	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
-	void *buf;
+
+	buf = fill_tree_descriptor(&desc, subtree->val_sha1);
+	if (!buf)
+		die("Could not read %s for notes-index",
+		     sha1_to_hex(subtree->val_sha1));
+
+	prefix_len = subtree->key_sha1[19];
+	assert(prefix_len * 2 >= n);
+	memcpy(commit_sha1, subtree->key_sha1, prefix_len);
+	while (tree_entry(&desc, &entry)) {
+		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
+				commit_sha1 + prefix_len, 20 - prefix_len);
+		if (len < 0)
+			continue; /* entry.path is not a SHA1 sum. Skip */
+		len += prefix_len;
+
+		/*
+		 * If commit SHA1 is complete (len == 20), assume note object
+		 * If commit SHA1 is incomplete (len < 20), assume note subtree
+		 */
+		if (len <= 20) {
+			unsigned char type = PTR_TYPE_NOTE;
+			struct leaf_node *l = (struct leaf_node *)
+				xcalloc(sizeof(struct leaf_node), 1);
+			hashcpy(l->key_sha1, commit_sha1);
+			hashcpy(l->val_sha1, entry.sha1);
+			if (len < 20) {
+				l->key_sha1[19] = (unsigned char) len;
+				type = PTR_TYPE_SUBTREE;
+			}
+			status = note_tree_insert(node, n, l, type);
+			assert(!status);
+		}
+	}
+	free(buf);
+}
+
+static void initialize_notes(const char *notes_ref_name)
+{
+	unsigned char sha1[20], commit_sha1[20];
+	unsigned mode;
+	struct leaf_node root_tree;

 	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
 	    get_tree_entry(commit_sha1, "", sha1, &mode))
 		return;

-	buf = fill_tree_descriptor(&desc, sha1);
-	if (!buf)
-		die("Could not read %s for notes-index", sha1_to_hex(sha1));
-
-	while (tree_entry(&desc, &entry))
-		if (!get_sha1(entry.path, commit_sha1))
-			add_entry(commit_sha1, entry.sha1);
-	free(buf);
+	hashclr(root_tree.key_sha1);
+	hashcpy(root_tree.val_sha1, sha1);
+	load_subtree(&root_tree, &root_node, 0);
 }

 static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 {
-	int index;
-
-	if (!hash_map.size)
-		return NULL;
-
-	index = hash_index(&hash_map, commit_sha1);
-	if (index < 0)
-		return NULL;
-	return hash_map.entries[index].notes_sha1;
+	struct leaf_node *found = note_tree_find(&root_node, 0, commit_sha1);
+	if (found)
+		return found->val_sha1;
+	return NULL;
 }

 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
@@ -120,7 +299,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
 		else if (!notes_ref_name)
 			notes_ref_name = GIT_NOTES_DEFAULT_REF;
-		initialize_hash_map(notes_ref_name);
+		initialize_notes(notes_ref_name);
 		initialized = 1;
 	}

@@ -163,7 +342,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,

 void free_commit_notes()
 {
-	free(hash_map.entries);
-	memset(&hash_map, 0, sizeof(struct hash_map));
+	note_tree_free(&root_node);
+	memset(&root_node, 0, sizeof(struct int_node));
 	initialized = 0;
 }
--
1.6.4.304.g1365c.dirty
