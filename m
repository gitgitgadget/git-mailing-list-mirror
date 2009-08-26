From: Johan Herland <johan@herland.net>
Subject: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 12:31:01 +0200
Message-ID: <200908261231.01616.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <200907300218.40203.johan@herland.net> <200908010436.57480.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 12:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgFpb-00082v-67
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 12:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221AbZHZKbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 06:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757200AbZHZKbH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 06:31:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41548 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757253AbZHZKbE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 06:31:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOZ004AIBVRXYB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 26 Aug 2009 12:31:03 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOZ004LWBVPH900@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 26 Aug 2009 12:31:03 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.26.101815
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <200908010436.57480.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127086>

The 256-tree structure is considerably faster than storing all entries in a
hash_map. Also, the memory consumption of the 256-tree structure is lower
than the hash_map, provided that you're only loading a few notes from a
"properly fanned-out" notes tree (i.e. 100000 notes in a 2/2/36 structure).
However, in the worst case (loading all 100000 notes), the memory usage of
the 256-tree structure (62.64 MB) is significantly worse than the hash_map
approach (10.25 MB).

This patch modifies the 256-tree structure into a 16-tree structure. This
significantly improves the memory situation. The result uses less memory
than both the 256-tree structure, and the hash_map approach, with a worst
case usage of 8.54 MB. Additionally, it seems to slightly improve the
runtime performance as well (probably because of the improved memory usage).

In conclusion, this is faster and smaller than all the previous drafts.

$ ./test_performance.sh
Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 0...
15.05user 1.44system 0:16.59elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+782490minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 1...
0.68user 0.17system 0:00.87elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+99585minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 2...
0.41user 0.17system 0:00.61elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+94084minor)pagefaults 0swaps

Signed-off-by: Johan Herland <johan@herland.net>
---

Hi,

This patch goes on top of the 256-tree RFC I sent earlier.

If nobody suggests further improvements, this patch will be
included in the next iteration of the jh/notes topic.


Have fun! :)

...Johan


 notes.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/notes.c b/notes.c
index 9282b16..32b1e01 100644
--- a/notes.c
+++ b/notes.c
@@ -7,9 +7,9 @@
 #include "tree-walk.h"
 
 /*
- * Use a non-balancing simple 256-tree structure with struct int_node as
+ * Use a non-balancing simple 16-tree structure with struct int_node as
  * internal nodes, and struct leaf_node as leaf nodes. Each int_node has a
- * 256-array of pointers to its children
+ * 16-array of pointers to its children
  * The bottom 2 bits of each pointer is used to identify the pointer type
  * - ptr & 3 == 0 - NULL pointer, assert(ptr == NULL)
  * - ptr & 3 == 1 - pointer to next internal node - cast to struct int_node *
@@ -21,18 +21,18 @@
  *
  * To add a leaf_node:
  * 1. Start at the root node, with n = 0
- * 2. Use the nth byte of the key as an index into a:
- *    - If NULL, store the tweaked pointer directly into a[n]
- *    - If an int_node, recurse into that node and increment n
- *    - If a leaf_node:
+ * 2. Use the nth nibble of the key as an index into a:
+ *    - If a[n] is NULL, store the tweaked pointer directly into a[n]
+ *    - If a[n] is an int_node, recurse into that node and increment n
+ *    - If a[n] is a leaf_node:
  *      1. Check if they're equal, and handle that (abort? overwrite?)
  *      2. Create a new int_node, and store both leaf_nodes there
  *      3. Store the new int_node into a[n].
  *
  * To find a leaf_node:
  * 1. Start at the root node, with n = 0
- * 2. Use the nth byte of the key as an index into a:
- *    - If an int_node, recurse into that node and increment n
+ * 2. Use the nth nibble of the key as an index into a:
+ *    - If a[n] is an int_node, recurse into that node and increment n
  *    - If a leaf_node with matching key, return leaf_node (assert note entry)
  *    - If a matching subtree entry, unpack that subtree entry (and remove it);
  *      restart search at the current level.
@@ -42,7 +42,7 @@
  *        subtree entry (and remove it); restart search at the current level.
  */
 struct int_node {
-	void *a[256];
+	void *a[16];
 };
 
 /*
@@ -79,11 +79,13 @@ static int initialized;
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n);
 
+#define GET_NIBBLE(n, sha1) (((sha1[n >> 1]) >> ((n & 0x01) << 2)) & 0x0f)
+
 static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 		const unsigned char *key_sha1)
 {
 	struct leaf_node *l;
-	unsigned char i = key_sha1[n];
+	unsigned char i = GET_NIBBLE(n, key_sha1);
 	void *p = tree->a[i];
 
 	switch(GET_PTR_TYPE(p)) {
@@ -138,7 +140,7 @@ static int note_tree_insert(struct int_node *tree, unsigned char n,
 	struct int_node *new_node;
 	const struct leaf_node *l;
 	int ret;
-	unsigned char i = entry->key_sha1[n];
+	unsigned char i = GET_NIBBLE(n, entry->key_sha1);
 	void *p = tree->a[i];
 	assert(GET_PTR_TYPE(entry) == PTR_TYPE_NULL);
 	switch(GET_PTR_TYPE(p)) {
@@ -211,7 +213,7 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		     sha1_to_hex(subtree->val_sha1));
 
 	prefix_len = subtree->key_sha1[19];
-	assert(prefix_len >= n);
+	assert(prefix_len * 2 >= n);
 	memcpy(commit_sha1, subtree->key_sha1, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
-- 
1.6.4.304.g1365c.dirty
