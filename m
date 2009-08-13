From: Johan Herland <johan@herland.net>
Subject: [RFC] Store subtree entries in the same hash map as the note entries
Date: Thu, 13 Aug 2009 05:00:50 +0200
Message-ID: <200908130500.51135.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <200907300218.40203.johan@herland.net> <200908010436.57480.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 05:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQYs-0001ro-De
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZHMDAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZHMDAz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:00:55 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53073 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752145AbZHMDAy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 23:00:54 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA004D1ODIDK90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 05:00:54 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA00EMMODF32B0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 05:00:54 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.13.25120
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <200908010436.57480.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125766>

This is a first draft at implementing Dscho's idea of improving note parser
performance by storing the subtree entries in the same hash map as the note
entries.

In order to tell subtree entries and note entries apart, another member has
been added to struct entry: unsigned char commit_sha1_len. This member
stores the number of "valid" bytes in the commit_sha1 member, meaning that
a value of 1-19 indicates a subtree entry, and a value of 20 indicates a
note entry. There are two more special values for this new member as well:

- Since a null SHA1 is also a valid subtree entry (e.g. the "00/*" subtree
  in a 2/38 fanout scheme), we can no longer use is_null_sha1() to identify
  unused entries in the hash map. Instead, a value of 0 in the new
  commit_sha1_len member indicates that this is entry is null/unused.

  There is one exception to this rule: the root notes tree which is just a
  special case of a subtree entry with 0 "valid" bytes in the commit_sha1
  member. However, this exception is acceptable, as the root entry is never
  stored in the hash map (the hash map is initialized by unpacking this
  root tree entry).

- The second special commit_sha1_len value is 255, and is used to indicate
  a subtree entry that has already been unpacked, and should therefore be
  removed from the hash map. It is expensive and non-trivial to _delete_
  an entry in the hash map, and we therefore use this special value to
  _ignore_ the entry. If/when the hash map is grown/reallocated, we simply
  avoid bringing the unpacked subtree entries into the new hash map.

$ ./test_performance.sh
Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 0...
21.80user 2.15system 0:24.12elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1051886minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 1...
1.24user 0.24system 0:01.49elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+120478minor)pagefaults 0swaps

Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 2...
0.73user 0.20system 0:00.95elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+105782minor)pagefaults 0swaps

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 29 July 2009, Johannes Schindelin wrote:
> I know you want to have something working first and optimize then, but I
> imagined that the hashmap can actually contain the entries of the partial
> hashes, too.  You'll need to extend the data type, of course, to be able
> to say just how many digits of the SHA-1 are valid, and I guess for
> consistency you'll need to pad with 0s.

Ok. Here's a draft implementation of your proposal to store the subtree
entries in the same hash map as the note entries.

This code is somewhat faster than my first subtree-in-linked-list draft,
but considerably slower than my 256-tree proposal:

                    fanout level 0   fanout level 1   fanout level 2
  subtree-in-ll         32.71s            1.88s            0.65s
  all-in-hash-map       24.12s            1.49s            0.95s
  all-in-256-tree       20.39s            1.06s            0.63s

I'm not sure how closely my implementation follows your vision, so please
suggest improvements, fixes, etc.


Have fun! :)

...Johan


 notes.c |  155 +++++++++++++++++++++++++--------------------------------------
 1 files changed, 62 insertions(+), 93 deletions(-)

diff --git a/notes.c b/notes.c
index 7e9dc49..34b8892 100644
--- a/notes.c
+++ b/notes.c
@@ -9,6 +9,15 @@
 struct entry {
 	unsigned char commit_sha1[20];
 	unsigned char notes_sha1[20];
+	/*
+	 * The following member can have the following values:
+	 * 0    - This is a NULL/blank entry in the hash_map
+	 *        (Exception: The root_tree entry in initialize_hash_map())
+	 * 1-19 - This is a subtree with the given number of valid prefix bytes
+	 * 20   - This is a note
+	 * 255  - This is a subtree which has been unpacked, please ignore
+	 */
+	unsigned char commit_sha1_len;
 };
 
 struct hash_map {
@@ -16,43 +25,35 @@ struct hash_map {
 	off_t count, size;
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
-
 static int initialized;
 static struct hash_map hash_map;
-static struct subtree_entry *subtree_list;
 
 static int hash_index(struct hash_map *map, const unsigned char *sha1)
 {
 	int i = ((*(unsigned int *)sha1) % map->size);
 
 	for (;;) {
-		unsigned char *current = map->entries[i].commit_sha1;
+		struct entry *current = &(map->entries[i]);
 
-		if (!hashcmp(sha1, current))
-			return i;
-
-		if (is_null_sha1(current))
+		if (!current->commit_sha1_len)
 			return -1 - i;
 
+		if (!hashcmp(sha1, current->commit_sha1)
+		 && current->commit_sha1_len <= 20)
+			return i;
+
 		if (++i == map->size)
 			i = 0;
 	}
 }
 
 static void add_entry(const unsigned char *commit_sha1,
-		const unsigned char *notes_sha1)
+		const unsigned char *notes_sha1,
+		unsigned char commit_sha1_len)
 {
 	int index;
 
+	assert(commit_sha1_len > 0 && commit_sha1_len <= 20);
 	if (hash_map.count + 1 > hash_map.size >> 1) {
 		int i, old_size = hash_map.size;
 		struct entry *old = hash_map.entries;
@@ -61,13 +62,20 @@ static void add_entry(const unsigned char *commit_sha1,
 		hash_map.entries = (struct entry *)
 			xcalloc(sizeof(struct entry), hash_map.size);
 
-		for (i = 0; i < old_size; i++)
-			if (!is_null_sha1(old[i].commit_sha1)) {
+		for (i = 0; i < old_size; i++) {
+			switch (old[i].commit_sha1_len) {
+			case 255:
+				hash_map.count--;
+				/* fall through */
+			case 0:
+				continue;
+			default:
 				index = -1 - hash_index(&hash_map,
 						old[i].commit_sha1);
 				memcpy(hash_map.entries + index, old + i,
 					sizeof(struct entry));
 			}
+		}
 		free(old);
 	}
 
@@ -79,6 +87,7 @@ static void add_entry(const unsigned char *commit_sha1,
 
 	hashcpy(hash_map.entries[index].commit_sha1, commit_sha1);
 	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
+	hash_map.entries[index].commit_sha1_len = commit_sha1_len;
 }
 
 /*
@@ -110,22 +119,26 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 	return len;
 }
 
-static void load_subtree(struct subtree_entry *se)
+static void load_subtree(struct entry *subtree)
 {
 	unsigned char commit_sha1[20];
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct subtree_entry *tmp_list = NULL, *tmp_last = NULL;
 
-	buf = fill_tree_descriptor(&desc, se->subtree_sha1);
+	buf = fill_tree_descriptor(&desc, subtree->notes_sha1);
 	if (!buf)
 		die("Could not read %s for notes-index",
-		     sha1_to_hex(se->subtree_sha1));
+		     sha1_to_hex(subtree->notes_sha1));
+
+	prefix_len = subtree->commit_sha1_len;
+	assert(prefix_len < 20);
+	memcpy(commit_sha1, subtree->commit_sha1, prefix_len);
+
+	/* Invalidate this subtree from further consideration */
+	subtree->commit_sha1_len = 255;
 
-	prefix_len = se->sha1_prefix_w_len[19];
-	memcpy(commit_sha1, se->sha1_prefix_w_len, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
 				commit_sha1 + prefix_len, 20 - prefix_len);
@@ -133,110 +146,66 @@ static void load_subtree(struct subtree_entry *se)
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
-			}
-		}
+		if (len == 20 || (len < 20 && entry.mode == S_IFDIR))
+			add_entry(commit_sha1, entry.sha1, len);
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
 
 static void initialize_hash_map(const char *notes_ref_name)
 {
 	unsigned char sha1[20], commit_sha1[20];
 	unsigned mode;
-	struct subtree_entry root_tree;
+	struct entry root_tree;
 
 	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
 	    get_tree_entry(commit_sha1, "", sha1, &mode))
 		return;
 
-	hashclr(root_tree.sha1_prefix_w_len);
-	hashcpy(root_tree.subtree_sha1, sha1);
-	root_tree.next = NULL;
+	hashclr(root_tree.commit_sha1);
+	hashcpy(root_tree.notes_sha1, sha1);
+	root_tree.commit_sha1_len = 0;
 	load_subtree(&root_tree);
-	subtree_list = root_tree.next;
 }
 
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
+static struct entry *lookup_subtree(const unsigned char *commit_sha1)
 {
-	unsigned int prefix_len = entry->sha1_prefix_w_len[19];
-	return memcmp(commit_sha1, entry->sha1_prefix_w_len, prefix_len);
-}
+	unsigned char prefix_sha1[20];
+	unsigned char i;
+	int index;
 
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
+	hashcpy(prefix_sha1, commit_sha1);
+	for (i = 19; i; --i) {
+		prefix_sha1[i] = 0;
+		index = hash_index(&hash_map, prefix_sha1);
+		if (index >= 0 && hash_map.entries[index].commit_sha1_len == i)
+			return &(hash_map.entries[index]);
 	}
-	return found;
+	return NULL;
 }
 
 static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 {
 	int index;
-	struct subtree_entry *subtree;
+	struct entry *subtree;
+
+	if (!hash_map.size)
+		return NULL;
 
 	/* First, try to find the commit SHA1 directly in hash map */
-	index = hash_map.size ? hash_index(&hash_map, commit_sha1) : -1;
+	index = hash_index(&hash_map, commit_sha1);
 	if (index >= 0)
 		return hash_map.entries[index].notes_sha1;
 
 	/* Next, try finding a subtree that may contain the commit SHA1 */
 	subtree = lookup_subtree(commit_sha1);
 
-	/* Give up if no subtree found, or if subtree is already loaded */
-	if (!subtree || is_null_sha1(subtree->subtree_sha1))
+	/* Give up if no subtree found */
+	if (!subtree)
 		return NULL;
 
 	/* Load subtree into hash_map, and retry lookup recursively */
 	load_subtree(subtree);
-	hashclr(subtree->subtree_sha1);
 	return lookup_notes(commit_sha1);
 }
 
-- 
1.6.4.rc3.138.ga6b98.dirty
