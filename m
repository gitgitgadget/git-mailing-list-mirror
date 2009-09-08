From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 13/14] Allow flexible organization of notes trees,
 using both commit date and SHA1
Date: Tue, 08 Sep 2009 04:27:01 +0200
Message-ID: <1252376822-6138-14-git-send-email-johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqRf-0005lE-W1
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZIHC1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZIHC1l
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34092 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753485AbZIHC1h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:37 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CZOS63LI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:39 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:39 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1252376822-6138-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127962>

This is a major expansion of the notes lookup code to allow for variations
in the notes tree organization. The variations allowed include mixing fanout
schemes based on the commit dates of the annotated commits (aka. date-based
fanout) with fanout schemes based on the SHA1 of the annotated commits (aka.
SHA1-based fanout).

Using date-based fanout in the notes tree structure enables considerable
speedup in the notes lookup process, since notes are almost always looked up
sequentially in the (reverse) chronological order of their associated commits.
Furthermore, organizing notes in a way that allow (near) sequential lookup,
enables us to decrease memory consumption both by lazily loading parts of the
notes tree structure on-demand, and freeing parts of the notes structure that
are unlikely to be used again soon.

The new flexible organization of the notes tree changes the rules for valid
note tree entries. The new rules are as follows:

1. Note objects are named by the SHA1 of the commit they annotate, possibly
   split across several SHA1-based fanout levels (this is the same as is
   implemented earlier in this series).

2. Note entries are located within zero or more date-based fanout levels.

3. Date-based fanout schemes may use the year, month and day values of the
   associated commit's timestamp. The values must be prefixed by 'y', 'm'
   and 'd' (respectively) in the notes tree.

4. The date-based components can be combined in one fanout level, or split
   across multiple fanout levels. Individual components may not be split
   across multiple fanout levels.

5. The year/month/date values must be specified in that order, and month or
   date values may not occur without the preceding year or month value.

6. All entries of a tree object in the notes tree structure must follow the
   same scheme used at that level.

Thus, the following example note entries are all valid locations for a note
annotating commit 123456789abcdef0123456789abcdef0123456789 at 2009-09-01:
- 123456789abcdef0123456789abcdef0123456789
- 12/3456789abcdef0123456789abcdef0123456789
- 1234/56789abcdef0123456789abcdef0123456789
- 12/34/56789abcdef0123456789abcdef0123456789
- 1234/5678/9abcdef0123456789abcdef0123456789
- 1234/56/78/9abcdef0123456789abcdef0123456789
- y2009/123456789abcdef0123456789abcdef0123456789
- y2009/m09/12/3456789abcdef0123456789abcdef0123456789
- y2009/m09/d01/123456789abcdef0123456789abcdef0123456789
- y2009m09/12/34/56789abcdef0123456789abcdef0123456789
- y2009m09/d01/1234/567/89abcdef0123456789abcdef0123456789
- y2009/m09d01/12/34/56/78/9abcdef0123456789abcdef0123456789
- y2009m09d01/123456789abcdef0123456789abcdef0123456789

Conversely, the following example note entries are all invalid:
- 1/23456789abcdef0123456789abcdef0123456789 (violates #1)
- 123/456789abcdef0123456789abcdef0123456789 (violates #1)
- 12/345/6789abcdef0123456789abcdef0123456789 (violates #1)
- y2009123456789abcdef0123456789abcdef0123456789 (violates #2)
- 2009/09/01/123456789abcdef0123456789abcdef0123456789 (violates #3)
- y20/09/m09/12/3456789abcdef0123456789abcdef0123456789 (violates #4)
- y20/09m09/d01/123456789abcdef0123456789abcdef0123456789 (violates #4)
- y2009m/09/12/34/56789abcdef0123456789abcdef0123456789 (violates #4)
- y2009/d01/1234/5678/9abcdef0123456789abcdef0123456789 (violates #5)
- m09/y2009/d01/12/34/56/78/9abcdef0123456789abcdef0123456789 (violates #5)

>From rule #6, we see that the following example notes tree is valid:
- y2009m09/0123456789abcdef0123456789abcdef012345678
- y2009m09/123456789abcdef0123456789abcdef0123456789
- y2008m01/d31/23/456789abcdef0123456789abcdef0123456789a
- y2008m01/d31/34/56789abcdef0123456789abcdef0123456789ab
- y2008m01/d16/4567/89abcdef0123456789abcdef0123456789abc
- y2008m01/d16/5678/9abcdef0123456789abcdef0123456789abcd

Conversely the following structure is invalid (violates rule #6):
- y2009m09/0123456789abcdef0123456789abcdef012345678
- y2009m09/12/3456789abcdef0123456789abcdef0123456789
- y2008m01/d31/23/456789abcdef0123456789abcdef0123456789a
- y2008m01/34/56789abcdef0123456789abcdef0123456789ab
- y2008m01/d16/45/6789abcdef0123456789abcdef0123456789abc
- y2008/m01d16/5678/9abcdef0123456789abcdef0123456789abcd

The flexibility added by this patch adds considerable complexity to the notes
tree parser, but the runtime and memory usage is not significantly affected
(except for the effects introduced by the chosen notes tree structure).

Internally, the 16-tree data structure introduced in earlier patches is still
used to hold the SHA1-based fanout levels and the note entries themselves.
However, this patch adds a hierarchical date-based linked-list structure
around the 16-tree structure that mirrors the fanout scheme used in the
actual notes tree.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  403 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 364 insertions(+), 39 deletions(-)

diff --git a/notes.c b/notes.c
index 6926aa6..a3e3f83 100644
--- a/notes.c
+++ b/notes.c
@@ -7,6 +7,70 @@
 #include "tree-walk.h"
 
 /*
+ * Format of entries in the notes tree structure:
+ *
+ * note-entry   ::= (period sep)? sha1-spec
+ * period       ::= year sep?
+ *                  (month sep?
+ *                   (date sep?)?
+ *                  )?;
+ * year         ::= 'y' yearnum;
+ * month        ::= 'm' monthnum;
+ * date         ::= 'd' datenum;
+ * yearnum      ::= # 4-digit decimal year, from annotated commit's timestamp;
+ * monthnum     ::= # 2-digit decimal month, from annotated commit's timestamp;
+ * datenum      ::= # 2-digit decimal date, from annotated commit's timestamp;
+ * sha1-spec    ::= (hex-fragment sep?){20}
+ * sep          ::= '/';
+ * hex-fragment ::= # Fragment of hexsha1 (2 bytes);
+ * hexsha1      ::= # SHA1 of annotated commit in hex format (40 bytes);
+ *
+ * Thus, the following example note entries are all valid:
+ * - 0123456789abcdef0123456789abcdef012345678
+ * - 01/23456789abcdef0123456789abcdef012345678
+ * - 0123/456789abcdef0123456789abcdef012345678
+ * - 01/23/456789abcdef0123456789abcdef012345678
+ * - 0123/4567/89abcdef0123456789abcdef012345678
+ * - 0123/45/67/89abcdef0123456789abcdef012345678
+ * - y2009/0123456789abcdef0123456789abcdef012345678
+ * - y2009/m09/01/23456789abcdef0123456789abcdef012345678
+ * - y2009/m09/d01/0123456789abcdef0123456789abcdef012345678
+ * - y2009m09/01/23/456789abcdef0123456789abcdef012345678
+ * - y2009m09/d01/0123/4567/89abcdef0123456789abcdef012345678
+ * - y2009/m09d01/01/23/45/67/89abcdef0123456789abcdef012345678
+ * - y2009m09d01/0123456789abcdef0123456789abcdef012345678
+ *
+ * and the following example note entries are all invalid:
+ * - 0/123456789abcdef0123456789abcdef012345678
+ * - 012/3456789abcdef0123456789abcdef012345678
+ * - 01/234/56789abcdef0123456789abcdef012345678
+ * - y20090123456789abcdef0123456789abcdef012345678
+ * - y20/09/m09/01/23456789abcdef0123456789abcdef012345678
+ * - y20/09m09/d01/0123456789abcdef0123456789abcdef012345678
+ * - y2009m/09/01/23/456789abcdef0123456789abcdef012345678
+ * - y2009/d01/0123/4567/89abcdef0123456789abcdef012345678
+ * - m09/y2009/d01/01/23/45/67/89abcdef0123456789abcdef012345678
+ *
+ * In addition to the above per-entry rules, we require that _all_ entries at
+ * a given level in the notes tree (levels are separated by '/') follow the
+ * exact same format at that level. Thus the following structure is valid:
+ * - y2009m09/0123456789abcdef0123456789abcdef012345678
+ * - y2009m09/123456789abcdef0123456789abcdef0123456789
+ * - y2008m01/d31/23/456789abcdef0123456789abcdef0123456789a
+ * - y2008m01/d31/34/56789abcdef0123456789abcdef0123456789ab
+ * - y2008m01/d16/4567/89abcdef0123456789abcdef0123456789abc
+ * - y2008m01/d16/5678/9abcdef0123456789abcdef0123456789abcd
+ *
+ * but the following structure is invalid:
+ * - y2009m09/0123456789abcdef0123456789abcdef012345678
+ * - y2009m09/12/3456789abcdef0123456789abcdef0123456789
+ * - y2008m01/d31/23/456789abcdef0123456789abcdef0123456789a
+ * - y2008m01/34/56789abcdef0123456789abcdef0123456789ab
+ * - y2008m01/d16/45/6789abcdef0123456789abcdef0123456789abc
+ * - y2008/m01d16/5678/9abcdef0123456789abcdef0123456789abcd
+ */
+
+/*
  * Use a non-balancing simple 16-tree structure with struct int_node as
  * internal nodes, and struct leaf_node as leaf nodes. Each int_node has a
  * 16-array of pointers to its children.
@@ -17,9 +81,45 @@
  * - ptr & 3 == 3 - pointer to subtree entry - cast to struct leaf_node *
  *
  * The root node is a statically allocated struct int_node.
+ *
+ * In order to allow date-based fanout schemes in addition to the original
+ * SHA1-based fanout schemes, we need to overload this structure, as follows:
+ * If the first pointer in the 16-array is ~0 (i.e. 0xffffffff on 32-bit
+ * systems and 0xffffffffffffffff on 64-bit systems), then the int_node is NOT
+ * to be interpreted as a 16-array of child node pointers. Rather, the int_node
+ * now represents a period-based node with the following properties:
+ * - The node has a pointer to a "child" node of type struct int_node, which is
+ *   EITHER a "regular" int_node object representing the root node of a 16-tree
+ *   structure holding notes associated with commits with timestamps within
+ *   that time period, OR another period-based int_node representing some
+ *   subdivision of the time period.
+ * - The node also has a pointer to a "previous" period-based int_node, which
+ *   represents the previous time period for which there exist note objects.
+ * - The node has a pointer to a "parent" node, which is the period-based
+ *   int_node that has this int_node as one of its children. This is needed
+ *   when traversing the date-based int_nodes looking for a period matching the
+ *   given commit. For top-level objects, this is set to NULL.
+ * - The node stores the SHA1 sum of the tree object that represents its child
+ *   (within the notes tree structure). Thus, we keep a reference to the child
+ *   structure that without necessarily allocating the child node (and
+ *   underlying structure).
+ * - Finally, the node has a period string, which indicates the time period of
+ *   the notes contained within, typically of the form "YYYY", "YYYY-MM" or
+ *   "YYYY-MM-DD", depending on the granularity of the corresponding
+ *   period-based entries in the notes tree structure.
  */
 struct int_node {
-	void *a[16];
+	union {
+		void *a[16];
+		struct {
+			void *magic;  /* ~0 "enables" this part of the union */
+			struct int_node *child;
+			struct int_node *prev;
+			struct int_node *parent;
+			unsigned char tree_sha1[20];
+			char period[11];  /* Enough to hold "YYYY-MM-DD" */
+		};
+	};
 };
 
 /*
@@ -51,12 +151,18 @@ struct leaf_node {
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
 
+#define SUBTREE_DATE_PREFIXCMP(commit_date, subtree_date) \
+	(prefixcmp(commit_date, subtree_date))
+
 static struct int_node root_node;
 
+static struct int_node *cur_node;
+
 static int initialized;
 
-static void load_subtree(struct leaf_node *subtree, struct int_node *node,
-		unsigned int n);
+static void load_subtree(const unsigned char *sha1,
+		const unsigned char *prefix, unsigned int prefix_len,
+		struct int_node *node, struct int_node *parent, int n);
 
 /*
  * To find a leaf_node:
@@ -94,7 +200,8 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 			/* unpack tree and resume search */
 			tree->a[i] = NULL;
-			load_subtree(l, tree, n);
+			load_subtree(l->val_sha1, l->key_sha1, l->key_sha1[19],
+				     tree, NULL, (int) n);
 			free(l);
 			return note_tree_find(tree, n, key_sha1);
 		}
@@ -117,7 +224,8 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 	if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 		/* unpack tree and resume search */
 		tree->a[0] = NULL;
-		load_subtree(l, tree, n);
+		load_subtree(l->val_sha1, l->key_sha1, l->key_sha1[19], tree,
+			     NULL, (int) n);
 		free(l);
 		return note_tree_find(tree, n, key_sha1);
 	}
@@ -173,16 +281,28 @@ static int note_tree_insert(struct int_node *tree, unsigned char n,
 /* Free the entire notes data contained in the given tree */
 static void note_tree_free(struct int_node *tree)
 {
-	unsigned int i;
-	for (i = 0; i < 16; i++) {
-		void *p = tree->a[i];
-		switch(GET_PTR_TYPE(p)) {
-		case PTR_TYPE_INTERNAL:
-			note_tree_free(CLR_PTR_TYPE(p));
-			/* fall through */
-		case PTR_TYPE_NOTE:
-		case PTR_TYPE_SUBTREE:
-			free(CLR_PTR_TYPE(p));
+	if (tree->magic == (void *) ~0) {
+		if (tree->prev) {
+			note_tree_free(tree->prev);
+			free(tree->prev);
+		}
+		if (tree->child) {
+			note_tree_free(tree->child);
+			free(tree->child);
+		}
+	}
+	else {
+		unsigned int i;
+		for (i = 0; i < 16; i++) {
+			void *p = tree->a[i];
+			switch(GET_PTR_TYPE(p)) {
+			case PTR_TYPE_INTERNAL:
+				note_tree_free(CLR_PTR_TYPE(p));
+				/* fall through */
+			case PTR_TYPE_NOTE:
+			case PTR_TYPE_SUBTREE:
+				free(CLR_PTR_TYPE(p));
+			}
 		}
 	}
 }
@@ -215,29 +335,139 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 	return len;
 }
 
-static void load_subtree(struct leaf_node *subtree, struct int_node *node,
-		unsigned int n)
+/*
+ * Parse year/month/date strings, and generate the corresponding period string
+ * for the given path entry:
+ * - prefix must follow one of these forms: "", "YYYY", "YYYY-MM"
+ * - path should follow one of these forms: "yYYYY", "yYYYYmMM", "yYYYYmMMdDD",
+ *   "mMMdDD", "mMM" or "dDD"
+ * The resulting string (which follows the form "YYYY", "YYYY-MM" or
+ * "YYYY-MM-DD") is returned as a static string. If path is not valid in the
+ * given (prefix) context, NULL is returned.
+ */
+static const char *parse_period(const char *prefix, unsigned int prefix_len,
+		const char *path, unsigned int path_len)
+{
+	static char result[11];
+	char expect_type;  /* y/m/d for year/month/day-based fanout */
+	unsigned int expect_len, value;
+	char *endptr, *target = result;
+
+	switch (prefix_len) {
+	case 0:
+		/* No prefix, expect year-based fanout in path */
+		expect_type = 'y';
+		expect_len = 4;
+		break;
+	case 4:
+		/* Year in prefix, expect month-based fanout in path */
+		expect_type = 'm';
+		expect_len = 2;
+		break;
+	case 7:
+		/* "YYYY-MM" in prefix, expect day-based fanout in path */
+		expect_type = 'd';
+		expect_len = 2;
+		break;
+	default:
+		die("Date-based notes tree loading invoked with invalid "
+		    "prefix '%.*s'", prefix_len, prefix);
+	}
+
+	if (path[0] != expect_type) {
+		warning("Unexpected entry path in date-based notes tree: '%s' "
+			"(skipping)", path);
+		return NULL;
+	}
+	value = (unsigned int) strtoul(path + 1, &endptr, 10);
+	switch (expect_type) {
+	case 'y':
+		if (value < 1969 || value >= 3000) {
+			warning("Invalid year value in date-based notes tree:"
+				" '%s' (skipping)", path);
+			return NULL;
+		}
+		break;
+	case 'm':
+		if (value < 1 || value > 12) {
+			warning("Invalid month value in date-based notes tree:"
+				" '%s' (skipping)", path);
+			return NULL;
+		}
+		break;
+	case 'd':
+		if (value < 1 || value > 31) {
+			warning("Invalid day value in date-based notes tree:"
+				" '%s' (skipping)", path);
+			return NULL;
+		}
+		break;
+	}
+
+	if (prefix == result) {
+		target = result + prefix_len;
+		prefix = NULL;
+		prefix_len = 0;
+	}
+	prefix_len = snprintf(target, 11, "%.*s%s%0*u", prefix_len, prefix,
+			      expect_len == 2 ? "-" : "", expect_len, value);
+	prefix_len += target - result;
+	assert(prefix_len < 11);
+
+	if (*endptr)  /* there are more components in this path */
+		return parse_period(result, prefix_len, endptr,
+				    path_len - (endptr - path));
+	return result;
+}
+
+static void load_date_subtree(struct tree_desc *tree_desc,
+		const char *prefix, unsigned int prefix_len,
+		struct int_node *node, struct int_node *parent)
+{
+	struct name_entry entry;
+	struct int_node *cur_node = NULL;
+	struct int_node *new_node;
+
+	while (tree_entry(tree_desc, &entry)) {
+		const char *period = parse_period(
+			prefix, prefix_len, entry.path, strlen(entry.path));
+		if (!period)
+			continue;
+		if (tree_desc->size)  /* this is not the last tree entry */
+			new_node = (struct int_node *)
+				xmalloc(sizeof(struct int_node));
+		else  /* this is the last entry, store directly into node */
+			new_node = node;
+
+		new_node->magic = (void *) ~0;
+		new_node->child = NULL;
+		new_node->prev = cur_node;
+		new_node->parent = parent;
+		hashcpy(new_node->tree_sha1, entry.sha1);
+		strcpy(new_node->period, period);
+		cur_node = new_node;
+	}
+	assert(!cur_node || cur_node == node);
+}
+
+static void load_sha1_subtree(struct tree_desc *tree_desc,
+		const unsigned char *prefix, unsigned int prefix_len,
+		struct int_node *node, unsigned char n)
 {
 	unsigned char commit_sha1[20];
-	unsigned int prefix_len;
 	int status;
-	void *buf;
-	struct tree_desc desc;
 	struct name_entry entry;
 
-	buf = fill_tree_descriptor(&desc, subtree->val_sha1);
-	if (!buf)
-		die("Could not read %s for notes-index",
-		     sha1_to_hex(subtree->val_sha1));
-
-	prefix_len = subtree->key_sha1[19];
 	assert(prefix_len * 2 >= n);
-	memcpy(commit_sha1, subtree->key_sha1, prefix_len);
-	while (tree_entry(&desc, &entry)) {
+	memcpy(commit_sha1, prefix, prefix_len);
+	while (tree_entry(tree_desc, &entry)) {
 		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
 				commit_sha1 + prefix_len, 20 - prefix_len);
-		if (len < 0)
+		if (len < 0) {
+			warning("Invalid value in notes tree: '%s' (skipping)",
+				entry.path);
 			continue; /* entry.path is not a SHA1 sum. Skip */
+		}
 		len += prefix_len;
 
 		/*
@@ -258,6 +488,42 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 			assert(!status);
 		}
 	}
+}
+
+static void load_subtree(const unsigned char *sha1,
+		const unsigned char *prefix, unsigned int prefix_len,
+		struct int_node *node, struct int_node *parent, int n)
+{
+	void *buf;
+	struct tree_desc desc;
+
+	buf = fill_tree_descriptor(&desc, sha1);
+	if (!buf)
+		die("Could not read notes subtree at %s", sha1_to_hex(sha1));
+	/*
+	 * After fill_tree_descriptor(), we can peek at the first tree entry
+	 * in desc.entry.
+	 */
+	switch (desc.entry.path[0]) {
+	case 'd':
+		if (strlen(desc.entry.path) != 3)
+			break;
+		/* fall-through */
+	case 'm':
+	case 'y':
+		/* path cannot be a SHA1 fragment */
+		load_date_subtree(&desc, (const char *) prefix, prefix_len,
+				  node, parent);
+		free(buf);
+		return;
+	}
+	if (n < 0) {
+		/* Arriving from a date-based subtree; reset prefix */
+		n = 0;
+		prefix = NULL;
+		prefix_len = 0;
+	}
+	load_sha1_subtree(&desc, prefix, prefix_len, node, n);
 	free(buf);
 }
 
@@ -265,23 +531,81 @@ static void initialize_notes(const char *notes_ref_name)
 {
 	unsigned char sha1[20], commit_sha1[20];
 	unsigned mode;
-	struct leaf_node root_tree;
 
 	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
 	    get_tree_entry(commit_sha1, "", sha1, &mode))
 		return;
 
-	hashclr(root_tree.key_sha1);
-	hashcpy(root_tree.val_sha1, sha1);
-	load_subtree(&root_tree, &root_node, 0);
+	load_subtree(sha1, NULL, 0, &root_node, NULL, 0);
+	cur_node = &root_node;
 }
 
-static unsigned char *lookup_notes(const unsigned char *commit_sha1)
+static unsigned char *lookup_notes(const struct commit *commit)
 {
-	struct leaf_node *found = note_tree_find(&root_node, 0, commit_sha1);
-	if (found)
-		return found->val_sha1;
-	return NULL;
+	struct int_node *node = cur_node, *seen_node = cur_node;
+	struct leaf_node *found;
+	const char *short_date;
+
+	if (!node)
+		return NULL;
+
+	/* Convert commit->date to YYYY-MM-DD format */
+	short_date = show_date(commit->date, 0, DATE_SHORT);
+
+	while (node->magic == (void *) ~0) {  /* date-based node */
+		int cmp = SUBTREE_DATE_PREFIXCMP(short_date, node->period);
+		if (cmp == 0) {
+			/* Search inside child node */
+			if (!node->child) {
+				/* Must unpack child node first */
+				node->child = (struct int_node *)
+					xcalloc(sizeof(struct int_node), 1);
+				load_subtree(node->tree_sha1,
+					(const unsigned char *) node->period,
+					strlen(node->period), node->child,
+					node, -1);
+			}
+			seen_node = node;
+			node = node->child;
+		}
+		else if (cmp > 0) {
+			/* Search in past node */
+			if (node->prev)
+				node = node->prev;
+			else
+				node = node->parent;
+		}
+		else {
+			/* Search in future node */
+			if (!node->parent) {
+				/* Restart from root_node */
+				seen_node = node;
+				node = &root_node;
+			}
+			else
+				node = node->parent;
+		}
+		if (!node || node == seen_node) {
+			/* We've been here before, give up search */
+			return NULL;
+		}
+	}
+	while (cur_node &&
+	       SUBTREE_DATE_PREFIXCMP(cur_node->period, seen_node->period) < 0)
+	{
+		/*
+		 * We're about to move cur_node backwards in history. We are
+		 * unlikely to need this cur_node in the future, so free() it.
+		 */
+		note_tree_free(cur_node->child);
+		cur_node->child = NULL;
+		cur_node = cur_node->parent;
+	}
+	cur_node = seen_node;
+
+	/* Drill down further with SHA1-based lookup */
+	found = note_tree_find(node, 0, commit->object.sha1);
+	return found ? found->val_sha1 : NULL;
 }
 
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
@@ -303,7 +627,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		initialized = 1;
 	}
 
-	sha1 = lookup_notes(commit->object.sha1);
+	sha1 = lookup_notes(commit);
 	if (!sha1)
 		return;
 
@@ -342,6 +666,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 
 void free_commit_notes()
 {
+	cur_node = NULL;
 	note_tree_free(&root_node);
 	memset(&root_node, 0, sizeof(struct int_node));
 	initialized = 0;
-- 
1.6.4.304.g1365c.dirty
