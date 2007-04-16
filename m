From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 9/9] pack-objects: better check_object() performances
Date: Mon, 16 Apr 2007 12:14:55 -0400 (EDT)
Message-ID: <S1030835AbXDPQPI/20070416161509Z+67@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 16 18:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTrW-0002jZ-78
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030825AbXDPQPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbXDPQPI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:15:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030837AbXDPQO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:14:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00CJBMGV58E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:14:56 -0400 (EDT)
Date-warning: Date header was inserted by VL-MH-MR001.ip.videotron.ca
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44662>

With large amount of objects, check_object() is really trashing the pack
sliding map and the filesystem cache.  It has a completely random access
pattern especially with old objects where delta replay jumps back and
forth all over the pack.

This patch improves things by:

 1) sorting objects by their offset in pack before calling check_object()
    so the pack access pattern is linear;

 2) recording the object type at add_object_entry() time since it is
    already known in most cases;

 3) recording the pack offset even for preferred_base objects;

 4) avoid calling sha1_object_info() if all possible.

This limits pack accesses to the bare minimum and makes them perfectly
linear.

In the process check_object() was made more clear (to me at least).

Note: I thought about walking the sorted_by_offset list backward in
get_object_details() so if a pack happens to be larger than the available
file cache, then the cache would have been populated with useful data from
the beginning of the pack already when find_deltas() is called.  Strangely,
testing (on Linux) showed absolutely no performance difference.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |  206 +++++++++++++++++++++++++++++-------------------
 1 files changed, 126 insertions(+), 80 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7100a76..19fae4c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -813,7 +813,8 @@ static unsigned name_hash(const char *name)
 	return hash;
 }
 
-static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclude)
+static int add_object_entry(const unsigned char *sha1, enum object_type type,
+			    unsigned hash, int exclude)
 {
 	struct object_entry *entry;
 	struct packed_git *p, *found_pack = NULL;
@@ -831,19 +832,19 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 		return 0;
 	}
 
-	if (!exclude) {
-		for (p = packed_git; p; p = p->next) {
-			off_t offset = find_pack_entry_one(sha1, p);
-			if (offset) {
-				if (incremental)
-					return 0;
-				if (local && !p->pack_local)
-					return 0;
-				if (!found_pack) {
-					found_offset = offset;
-					found_pack = p;
-				}
+	for (p = packed_git; p; p = p->next) {
+		off_t offset = find_pack_entry_one(sha1, p);
+		if (offset) {
+			if (!found_pack) {
+				found_offset = offset;
+				found_pack = p;
 			}
+			if (exclude)
+				break;
+			if (incremental)
+				return 0;
+			if (local && !p->pack_local)
+				return 0;
 		}
 	}
 
@@ -856,6 +857,8 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 	memset(entry, 0, sizeof(*entry));
 	hashcpy(entry->sha1, sha1);
 	entry->hash = hash;
+	if (type)
+		entry->type = type;
 	if (exclude)
 		entry->preferred_base = 1;
 	else
@@ -1008,7 +1011,9 @@ static void add_pbase_object(struct tree_desc *tree,
 			return;
 		if (name[cmplen] != '/') {
 			unsigned hash = name_hash(fullname);
-			add_object_entry(entry.sha1, hash, 1);
+			add_object_entry(entry.sha1,
+					 S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB,
+					 hash, 1);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
@@ -1079,7 +1084,7 @@ static void add_preferred_base_object(const char *name, unsigned hash)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(it->pcache.sha1, 0, 1);
+			add_object_entry(it->pcache.sha1, OBJ_TREE, 0, 1);
 		}
 		else {
 			struct tree_desc tree;
@@ -1121,87 +1126,105 @@ static void add_preferred_base(unsigned char *sha1)
 
 static void check_object(struct object_entry *entry)
 {
-	if (entry->in_pack && !entry->preferred_base) {
+	if (entry->in_pack) {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
-		unsigned long size, used;
+		const unsigned char *base_ref = NULL;
+		struct object_entry *base_entry;
+		unsigned long used, used_0;
 		unsigned int avail;
-		unsigned char *buf;
-		struct object_entry *base_entry = NULL;
+		off_t ofs;
+		unsigned char *buf, c;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
-		/* We want in_pack_type even if we do not reuse delta.
+		/*
+		 * We want in_pack_type even if we do not reuse delta.
 		 * There is no point not reusing non-delta representations.
 		 */
 		used = unpack_object_header_gently(buf, avail,
-						   &entry->in_pack_type, &size);
+						   &entry->in_pack_type,
+						   &entry->size);
 
-		/* Check if it is delta, and the base is also an object
-		 * we are going to pack.  If so we will reuse the existing
-		 * delta.
+		/*
+		 * Determine if this is a delta and if so whether we can
+		 * reuse it or not.  Otherwise let's find out as cheaply as
+		 * possible what the actual type and size for this object is.
 		 */
-		if (!no_reuse_delta) {
-			unsigned char c;
-			const unsigned char *base_name;
-			off_t ofs;
-			unsigned long used_0;
-			/* there is at least 20 bytes left in the pack */
-			switch (entry->in_pack_type) {
-			case OBJ_REF_DELTA:
-				base_name = use_pack(p, &w_curs,
-					entry->in_pack_offset + used, NULL);
-				used += 20;
-				break;
-			case OBJ_OFS_DELTA:
-				buf = use_pack(p, &w_curs,
-					entry->in_pack_offset + used, NULL);
-				used_0 = 0;
-				c = buf[used_0++];
-				ofs = c & 127;
-				while (c & 128) {
-					ofs += 1;
-					if (!ofs || MSB(ofs, 7))
-						die("delta base offset overflow in pack for %s",
-						    sha1_to_hex(entry->sha1));
-					c = buf[used_0++];
-					ofs = (ofs << 7) + (c & 127);
-				}
-				if (ofs >= entry->in_pack_offset)
-					die("delta base offset out of bound for %s",
+		switch (entry->in_pack_type) {
+		default:
+			/* Not a delta hence we've already got all we need. */
+			entry->type = entry->in_pack_type;
+			entry->in_pack_header_size = used;
+			unuse_pack(&w_curs);
+			return;
+		case OBJ_REF_DELTA:
+			if (!no_reuse_delta && !entry->preferred_base)
+				base_ref = use_pack(p, &w_curs,
+						entry->in_pack_offset + used, NULL);
+			entry->in_pack_header_size = used + 20;
+			break;
+		case OBJ_OFS_DELTA:
+			buf = use_pack(p, &w_curs,
+				       entry->in_pack_offset + used, NULL);
+			used_0 = 0;
+			c = buf[used_0++];
+			ofs = c & 127;
+			while (c & 128) {
+				ofs += 1;
+				if (!ofs || MSB(ofs, 7))
+					die("delta base offset overflow in pack for %s",
 					    sha1_to_hex(entry->sha1));
-				ofs = entry->in_pack_offset - ofs;
-				base_name = find_packed_object_name(p, ofs);
-				used += used_0;
-				break;
-			default:
-				base_name = NULL;
+				c = buf[used_0++];
+				ofs = (ofs << 7) + (c & 127);
 			}
-			if (base_name)
-				base_entry = locate_object_entry(base_name);
+			if (ofs >= entry->in_pack_offset)
+				die("delta base offset out of bound for %s",
+				    sha1_to_hex(entry->sha1));
+			ofs = entry->in_pack_offset - ofs;
+			if (!no_reuse_delta && !entry->preferred_base)
+				base_ref = find_packed_object_name(p, ofs);
+			entry->in_pack_header_size = used + used_0;
+			break;
 		}
-		unuse_pack(&w_curs);
-		entry->in_pack_header_size = used;
 
-		if (base_entry) {
-
-			/* Depth value does not matter - find_deltas()
-			 * will never consider reused delta as the
-			 * base object to deltify other objects
-			 * against, in order to avoid circular deltas.
+		if (base_ref && (base_entry = locate_object_entry(base_ref))) {
+			/*
+			 * If base_ref was set above that means we wish to
+			 * reuse delta data, and we even found that base
+			 * in the list of objects we want to pack. Goodie!
+			 *
+			 * Depth value does not matter - find_deltas() will
+			 * never consider reused delta as the base object to
+			 * deltify other objects against, in order to avoid
+			 * circular deltas.
 			 */
-
-			/* uncompressed size of the delta data */
-			entry->size = size;
-			entry->delta = base_entry;
 			entry->type = entry->in_pack_type;
-
+			entry->delta = base_entry;
 			entry->delta_sibling = base_entry->delta_child;
 			base_entry->delta_child = entry;
+			unuse_pack(&w_curs);
+			return;
+		}
 
+		if (entry->type) {
+			/*
+			 * This must be a delta and we already know what the
+			 * final object type is.  Let's extract the actual
+			 * object size from the delta header.
+			 */
+			entry->size = get_size_from_delta(p, &w_curs,
+					entry->in_pack_offset + entry->in_pack_header_size);
+			unuse_pack(&w_curs);
 			return;
 		}
-		/* Otherwise we would do the usual */
+
+		/*
+		 * No choice but to fall back to the recursive delta walk
+		 * with sha1_object_info() to find about the object type
+		 * at this point...
+		 */
+		unuse_pack(&w_curs);
 	}
 
 	entry->type = sha1_object_info(entry->sha1, &entry->size);
@@ -1210,14 +1233,37 @@ static void check_object(struct object_entry *entry)
 		    sha1_to_hex(entry->sha1));
 }
 
+static int pack_offset_sort(const void *_a, const void *_b)
+{
+	const struct object_entry *a = *(struct object_entry **)_a;
+	const struct object_entry *b = *(struct object_entry **)_b;
+
+	/* avoid filesystem trashing with loose objects */
+	if (!a->in_pack && !b->in_pack)
+		return hashcmp(a->sha1, b->sha1);
+
+	if (a->in_pack < b->in_pack)
+		return -1;
+	if (a->in_pack > b->in_pack)
+		return 1;
+	return a->in_pack_offset < b->in_pack_offset ? -1 :
+			(a->in_pack_offset > b->in_pack_offset);
+}
+
 static void get_object_details(void)
 {
 	uint32_t i;
-	struct object_entry *entry;
+	struct object_entry **sorted_by_offset;
+
+	sorted_by_offset = xcalloc(nr_objects, sizeof(struct object_entry *));
+	for (i = 0; i < nr_objects; i++)
+		sorted_by_offset[i] = objects + i;
+	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
 	prepare_pack_ix();
-	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
-		check_object(entry);
+	for (i = 0; i < nr_objects; i++)
+		check_object(sorted_by_offset[i]);
+	free(sorted_by_offset);
 }
 
 static int type_size_sort(const void *_a, const void *_b)
@@ -1520,20 +1566,20 @@ static void read_object_list_from_stdin(void)
 
 		hash = name_hash(line+41);
 		add_preferred_base_object(line+41, hash);
-		add_object_entry(sha1, hash, 0);
+		add_object_entry(sha1, 0, hash, 0);
 	}
 }
 
 static void show_commit(struct commit *commit)
 {
-	add_object_entry(commit->object.sha1, 0, 0);
+	add_object_entry(commit->object.sha1, OBJ_COMMIT, 0, 0);
 }
 
 static void show_object(struct object_array_entry *p)
 {
 	unsigned hash = name_hash(p->name);
 	add_preferred_base_object(p->name, hash);
-	add_object_entry(p->item->sha1, hash, 0);
+	add_object_entry(p->item->sha1, p->item->type, hash, 0);
 }
 
 static void show_edge(struct commit *commit)
-- 
1.5.1.1.781.g65e8
