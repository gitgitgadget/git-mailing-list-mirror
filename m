From: Johan Herland <johan@herland.net>
Subject: [RFC] First draft of 256-tree structure for storing notes
Date: Sat, 01 Aug 2009 04:36:57 +0200
Message-ID: <200908010436.57480.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <alpine.DEB.1.00.0907291842360.7626@intel-tinevez-2-302>
 <200907300218.40203.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 01 04:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX4TR-000214-Ey
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 04:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbZHAChG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 22:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZHAChF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 22:37:05 -0400
Received: from mx.getmail.no ([84.208.15.66]:33628 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750859AbZHAChD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 22:37:03 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNO00878F9OVH60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 01 Aug 2009 04:37:00 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNO00CUKF9LNB10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 01 Aug 2009 04:37:00 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.1.22416
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <200907300218.40203.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124604>

This patch stores note entries and unexpanded fanout subtree entries in a
customized 256-tree structure.

Initial performance numbers are encouraging:

$ ./test_performance.sh
Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 0...
14.92user 4.84system 0:20.39elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2164780minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 1...
0.71user 0.32system 0:01.06elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+154090minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 2...
0.44user 0.18system 0:00.63elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+94183minor)pagefaults 0swaps

This is pretty much twice as fast as the existing version (which uses a hash map
for notes, and a linked list for unexpanded fanout subtrees).

Signed-off-by: Johan Herland <johan@herland.net>
---

Hi,

Just a quick update before I leave for a week of vacation (with spotty
Internet access, at best).

I've been thinking about various data structures for the notes code for
the last couple of days, and here is a quick first draft of the idea that
I found most promising: Storing both notes and unexpanded subtrees as leaf
nodes in a customized 256-tree structure. The initial performance numbers
look very promising (~twice as fast as the previous implementation at
fanout levels 0 and 1), and there are still probably several optimization
that can be done (an obvious example is reducing malloc pressure by
memory pooling leaf_node objects).

AFAICS, this implementation is semantically equivalent the previous code
(longer prefixes are preferred, no merging of notes, multiple/nested
fanout levels are allowed, etc.).


Have fun! :)

...Johan


 notes.c |  325 ++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 174 insertions(+), 151 deletions(-)

diff --git a/notes.c b/notes.c
index 7e9dc49..9282b16 100644
--- a/notes.c
+++ b/notes.c
@@ -6,79 +6,165 @@
 #include "strbuf.h"
 #include "tree-walk.h"
 
-struct entry {
-	unsigned char commit_sha1[20];
-	unsigned char notes_sha1[20];
+/*
+ * Use a non-balancing simple 256-tree structure with struct int_node as
+ * internal nodes, and struct leaf_node as leaf nodes. Each int_node has a
+ * 256-array of pointers to its children
+ * The bottom 2 bits of each pointer is used to identify the pointer type
+ * - ptr & 3 == 0 - NULL pointer, assert(ptr == NULL)
+ * - ptr & 3 == 1 - pointer to next internal node - cast to struct int_node *
+ * - ptr & 3 == 2 - pointer to note entry - cast to struct leaf_node *
+ * - ptr & 3 == 3 - pointer to subtree entry - cast to struct leaf_node *
+ *
+ * The root node is always an inline struct int_node.
+ * An array_entry always starts out with all pointers set to NULL.
+ *
+ * To add a leaf_node:
+ * 1. Start at the root node, with n = 0
+ * 2. Use the nth byte of the key as an index into a:
+ *    - If NULL, store the tweaked pointer directly into a[n]
+ *    - If an int_node, recurse into that node and increment n
+ *    - If a leaf_node:
+ *      1. Check if they're equal, and handle that (abort? overwrite?)
+ *      2. Create a new int_node, and store both leaf_nodes there
+ *      3. Store the new int_node into a[n].
+ *
+ * To find a leaf_node:
+ * 1. Start at the root node, with n = 0
+ * 2. Use the nth byte of the key as an index into a:
+ *    - If an int_node, recurse into that node and increment n
+ *    - If a leaf_node with matching key, return leaf_node (assert note entry)
+ *    - If a matching subtree entry, unpack that subtree entry (and remove it);
+ *      restart search at the current level.
+ *    - Otherwise, we end up at a NULL pointer, or a non-matching leaf_node.
+ *      Backtrack out of the recursion, one level at a time and check a[0]:
+ *      - If a[0] at the current level is a matching subtree entry, unpack that
+ *        subtree entry (and remove it); restart search at the current level.
+ */
+struct int_node {
+	void *a[256];
 };
 
-struct hash_map {
-	struct entry *entries;
-	off_t count, size;
+/*
+ * Leaf nodes come in two variants, note entries and subtree entries,
+ * distinguished by the LSb of the leaf node pointer (see above).
+ * As a note entry, the key is the SHA1 of the referenced commit, and the value
+ * is the SHA1 of the note object.
+ * As a subtree entry, the key is the prefix SHA1 (w/trailing NULs) of the
+ * referenced commit, including the prefix length in the last byte of the key.
+ * The value is the SHA1 of the tree object containing the notes subtree.
+ */
+struct leaf_node {
+	unsigned char key_sha1[20];
+	unsigned char val_sha1[20];
 };
 
-struct subtree_entry {
-	/*
-	 * SHA1 prefix is stored in the first 19 bytes (w/trailing NUL bytes);
-	 * length of SHA1 prefix is stored in the last byte
-	 */
-	unsigned char sha1_prefix_w_len[20];
-	unsigned char subtree_sha1[20];
-	struct subtree_entry *next;
-};
+#define PTR_TYPE_NULL     0
+#define PTR_TYPE_INTERNAL 1
+#define PTR_TYPE_NOTE     2
+#define PTR_TYPE_SUBTREE  3
 
-static int initialized;
-static struct hash_map hash_map;
-static struct subtree_entry *subtree_list;
+#define GET_PTR_TYPE(ptr)       ((uintptr_t) (ptr) & 3)
+#define CLR_PTR_TYPE(ptr)       ((void *) ((uintptr_t) (ptr) & ~3))
+#define SET_PTR_TYPE(ptr, type) ((void *) ((uintptr_t) (ptr) | (type)))
 
-static int hash_index(struct hash_map *map, const unsigned char *sha1)
-{
-	int i = ((*(unsigned int *)sha1) % map->size);
+#define MATCHING_SUBTREE(key_sha1, subtree_sha1) \
+	(!memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
 
-	for (;;) {
-		unsigned char *current = map->entries[i].commit_sha1;
+static struct int_node root_node;
 
-		if (!hashcmp(sha1, current))
-			return i;
+static int initialized;
 
-		if (is_null_sha1(current))
-			return -1 - i;
 
-		if (++i == map->size)
-			i = 0;
-	}
-}
+static void load_subtree(struct leaf_node *subtree, struct int_node *node,
+		unsigned int n);
 
-static void add_entry(const unsigned char *commit_sha1,
-		const unsigned char *notes_sha1)
+static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
+		const unsigned char *key_sha1)
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
+	struct leaf_node *l;
+	unsigned char i = key_sha1[n];
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
+		if (MATCHING_SUBTREE(key_sha1, l->key_sha1)) {
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
 
-	index = hash_index(&hash_map, commit_sha1);
-	if (index < 0) {
-		index = -1 - index;
-		hash_map.count++;
+	/*
+	 * Did not find key at this (or any lower) level.
+	 * Check if there's a matching subtree entry in tree->a[0].
+	 * If so, unpack tree and resume search.
+	 */
+	p = tree->a[0];
+	if (GET_PTR_TYPE(p) != PTR_TYPE_SUBTREE)
+		return NULL;
+	l = (struct leaf_node *) CLR_PTR_TYPE(p);
+	if (MATCHING_SUBTREE(key_sha1, l->key_sha1)) {
+		/* unpack tree and resume search */
+		tree->a[0] = NULL;
+		load_subtree(l, tree, n);
+		free(l);
+		return note_tree_find(tree, n, key_sha1);
 	}
+	return NULL;
+}
 
-	hashcpy(hash_map.entries[index].commit_sha1, commit_sha1);
-	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
+static int note_tree_insert(struct int_node *tree, unsigned char n,
+		const struct leaf_node *entry, unsigned char type)
+{
+	struct int_node *new_node;
+	const struct leaf_node *l;
+	int ret;
+	unsigned char i = entry->key_sha1[n];
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
+	}
 }
 
 /*
@@ -110,22 +196,23 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 	return len;
 }
 
-static void load_subtree(struct subtree_entry *se)
+static void load_subtree(struct leaf_node *subtree, struct int_node *node,
+		unsigned int n)
 {
 	unsigned char commit_sha1[20];
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct subtree_entry *tmp_list = NULL, *tmp_last = NULL;
 
-	buf = fill_tree_descriptor(&desc, se->subtree_sha1);
+	buf = fill_tree_descriptor(&desc, subtree->val_sha1);
 	if (!buf)
 		die("Could not read %s for notes-index",
-		     sha1_to_hex(se->subtree_sha1));
+		     sha1_to_hex(subtree->val_sha1));
 
-	prefix_len = se->sha1_prefix_w_len[19];
-	memcpy(commit_sha1, se->sha1_prefix_w_len, prefix_len);
+	prefix_len = subtree->key_sha1[19];
+	assert(prefix_len >= n);
+	memcpy(commit_sha1, subtree->key_sha1, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
 				commit_sha1 + prefix_len, 20 - prefix_len);
@@ -133,111 +220,47 @@ static void load_subtree(struct subtree_entry *se)
 			continue; /* entry.path is not a SHA1 sum. Skip */
 		len += prefix_len;
 
-		/* If commit SHA1 is complete, assume note object */
-		if (len == 20)
-			add_entry(commit_sha1, entry.sha1);
-		/* If commit SHA1 is incomplete, assume note subtree */
-		else if (len < 20 && entry.mode == S_IFDIR) {
-			struct subtree_entry *n = (struct subtree_entry *)
-				xcalloc(sizeof(struct subtree_entry), 1);
-			hashcpy(n->sha1_prefix_w_len, commit_sha1);
-			n->sha1_prefix_w_len[19] = (unsigned char) len;
-			hashcpy(n->subtree_sha1, entry.sha1);
-
-			if (!tmp_list) {
-				tmp_list = n;
-				tmp_last = n;
-			}
-			else {
-				assert(!tmp_last->next);
-				assert(hashcmp(n->sha1_prefix_w_len,
-					tmp_last->sha1_prefix_w_len) > 0);
-				tmp_last->next = n;
-				tmp_last = n;
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
 			}
+			assert(!note_tree_insert(node, n, l, type));
 		}
 	}
 	free(buf);
-	if (tmp_list) {
-		/* insert tmp_list immediately after se */
-		assert(hashcmp(tmp_list->sha1_prefix_w_len,
-				se->sha1_prefix_w_len) > 0);
-		if (se->next) {
-			assert(hashcmp(se->next->sha1_prefix_w_len,
-					tmp_last->sha1_prefix_w_len) > 0);
-			tmp_last->next = se->next;
-		}
-		se->next = tmp_list;
-	}
 }
 
-static void initialize_hash_map(const char *notes_ref_name)
+static void initialize_notes(const char *notes_ref_name)
 {
 	unsigned char sha1[20], commit_sha1[20];
 	unsigned mode;
-	struct subtree_entry root_tree;
+	struct leaf_node root_tree;
 
 	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
 	    get_tree_entry(commit_sha1, "", sha1, &mode))
 		return;
 
-	hashclr(root_tree.sha1_prefix_w_len);
-	hashcpy(root_tree.subtree_sha1, sha1);
-	root_tree.next = NULL;
-	load_subtree(&root_tree);
-	subtree_list = root_tree.next;
-}
-
-/*
- * Compare the given commit SHA1 against the given subtree entry.
- * Return -1 if the commit SHA1 cannot exist within the given subtree, or any
- * subtree following it.
- * Return 0 if the commit SHA1 _may_ exist within the given subtree.
- * Return 1 if the commit SHA1 cannot exist within the given subtree, but may
- * exist within a subtree following it.
- */
-static int commit_subtree_cmp(const unsigned char *commit_sha1,
-		const struct subtree_entry *entry)
-{
-	unsigned int prefix_len = entry->sha1_prefix_w_len[19];
-	return memcmp(commit_sha1, entry->sha1_prefix_w_len, prefix_len);
-}
-
-static struct subtree_entry *lookup_subtree(const unsigned char *commit_sha1)
-{
-	struct subtree_entry *found = NULL, *cur = subtree_list;
-	while (cur) {
-		int cmp = commit_subtree_cmp(commit_sha1, cur);
-		if (!cmp)
-			found = cur;
-		if (cmp < 0)
-			break;
-		cur = cur->next;
-	}
-	return found;
+	hashclr(root_tree.key_sha1);
+	hashcpy(root_tree.val_sha1, sha1);
+	load_subtree(&root_tree, &root_node, 0);
 }
 
 static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 {
-	int index;
-	struct subtree_entry *subtree;
-
-	/* First, try to find the commit SHA1 directly in hash map */
-	index = hash_map.size ? hash_index(&hash_map, commit_sha1) : -1;
-	if (index >= 0)
-		return hash_map.entries[index].notes_sha1;
-
-	/* Next, try finding a subtree that may contain the commit SHA1 */
-	subtree = lookup_subtree(commit_sha1);
-
-	/* Give up if no subtree found, or if subtree is already loaded */
-	if (!subtree || is_null_sha1(subtree->subtree_sha1))
-		return NULL;
-
-	/* Load subtree into hash_map, and retry lookup recursively */
-	load_subtree(subtree);
-	hashclr(subtree->subtree_sha1);
-	return lookup_notes(commit_sha1);
+	struct leaf_node *found = note_tree_find(&root_node, 0, commit_sha1);
+	if (found)
+		return found->val_sha1;
+	return NULL;
 }
 
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
@@ -255,7 +278,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
 		else if (!notes_ref_name)
 			notes_ref_name = GIT_NOTES_DEFAULT_REF;
-		initialize_hash_map(notes_ref_name);
+		initialize_notes(notes_ref_name);
 		initialized = 1;
 	}
 
-- 
1.6.4.rc3.138.ga6b98.dirty

-- 
Johan Herland, <johan@herland.net>
www.herland.net
