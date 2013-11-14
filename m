From: Jeff King <peff@peff.net>
Subject: [PATCH v3 03/21] pack-objects: Refactor the packing list
Date: Thu, 14 Nov 2013 07:42:59 -0500
Message-ID: <20131114124258.GC10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:43:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwGI-0006pt-KF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab3KNMnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:43:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:39104 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753712Ab3KNMnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:43:00 -0500
Received: (qmail 11296 invoked by uid 102); 14 Nov 2013 12:43:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:43:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:42:59 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237827>

From: Vicent Marti <tanoku@gmail.com>

The hash table that stores the packing list for a given `pack-objects`
run was tightly coupled to the pack-objects code.

In this commit, we refactor the hash table and the underlying storage
array into a `packing_data` struct. The functionality for accessing and
adding entries to the packing list is hence accessible from other parts
of Git besides the `pack-objects` builtin.

This refactoring is a requirement for further patches in this series
that will require accessing the commit packing list from outside of
`pack-objects`.

The hash table implementation has been minimally altered: we now
use table sizes which are always a power of two, to ensure a uniform
index distribution in the array.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile               |   2 +
 builtin/pack-objects.c | 175 +++++++++++--------------------------------------
 pack-objects.c         | 111 +++++++++++++++++++++++++++++++
 pack-objects.h         |  47 +++++++++++++
 4 files changed, 200 insertions(+), 135 deletions(-)
 create mode 100644 pack-objects.c
 create mode 100644 pack-objects.h

diff --git a/Makefile b/Makefile
index af847f8..48ff0bd 100644
--- a/Makefile
+++ b/Makefile
@@ -694,6 +694,7 @@ LIB_H += notes-merge.h
 LIB_H += notes-utils.h
 LIB_H += notes.h
 LIB_H += object.h
+LIB_H += pack-objects.h
 LIB_H += pack-revindex.h
 LIB_H += pack.h
 LIB_H += parse-options.h
@@ -831,6 +832,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
+LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 36273dd..f3f0cf9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -14,6 +14,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
 #include "streaming.h"
@@ -25,42 +26,15 @@ static const char *pack_usage[] = {
 	NULL
 };
 
-struct object_entry {
-	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack; 	/* already in pack */
-	off_t in_pack_offset;
-	struct object_entry *delta;	/* delta base object */
-	struct object_entry *delta_child; /* deltified objects who bases me */
-	struct object_entry *delta_sibling; /* other deltified objects who
-					     * uses the same base as me
-					     */
-	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
-	unsigned preferred_base:1; /*
-				    * we do not pack this, but is available
-				    * to be used as the base object to delta
-				    * objects against.
-				    */
-	unsigned no_try_delta:1;
-	unsigned tagged:1; /* near the very tip of refs */
-	unsigned filled:1; /* assigned write-order */
-};
-
 /*
- * Objects we are going to pack are collected in objects array (dynamically
- * expanded).  nr_objects & nr_alloc controls this array.  They are stored
- * in the order we see -- typically rev-list --objects order that gives us
- * nice "minimum seek" order.
+ * Objects we are going to pack are collected in the `to_pack` structure.
+ * It contains an array (dynamically expanded) of the object data, and a map
+ * that can resolve SHA1s to their position in the array.
  */
-static struct object_entry *objects;
+static struct packing_data to_pack;
+
 static struct pack_idx_entry **written_list;
-static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
+static uint32_t nr_result, nr_written;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -90,21 +64,11 @@ static unsigned long cache_max_small_delta_size = 1000;
 static unsigned long window_memory_limit = 0;
 
 /*
- * The object names in objects array are hashed with this hashtable,
- * to help looking up the entry by object name.
- * This hashtable is built after all the objects are seen.
- */
-static int *object_ix;
-static int object_ix_hashsz;
-static struct object_entry *locate_object_entry(const unsigned char *sha1);
-
-/*
  * stats
  */
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
-
 static void *get_delta(struct object_entry *entry)
 {
 	unsigned long size, base_size, delta_size;
@@ -553,12 +517,12 @@ static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
 		       void *cb_data)
 {
 	unsigned char peeled[20];
-	struct object_entry *entry = locate_object_entry(sha1);
+	struct object_entry *entry = packlist_find(&to_pack, sha1, NULL);
 
 	if (entry)
 		entry->tagged = 1;
 	if (!peel_ref(path, peeled)) {
-		entry = locate_object_entry(peeled);
+		entry = packlist_find(&to_pack, peeled, NULL);
 		if (entry)
 			entry->tagged = 1;
 	}
@@ -633,9 +597,10 @@ static struct object_entry **compute_write_order(void)
 {
 	unsigned int i, wo_end, last_untagged;
 
-	struct object_entry **wo = xmalloc(nr_objects * sizeof(*wo));
+	struct object_entry **wo = xmalloc(to_pack.nr_objects * sizeof(*wo));
+	struct object_entry *objects = to_pack.objects;
 
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
 		objects[i].delta_child = NULL;
@@ -647,7 +612,7 @@ static struct object_entry **compute_write_order(void)
 	 * Make sure delta_sibling is sorted in the original
 	 * recency order.
 	 */
-	for (i = nr_objects; i > 0;) {
+	for (i = to_pack.nr_objects; i > 0;) {
 		struct object_entry *e = &objects[--i];
 		if (!e->delta)
 			continue;
@@ -665,7 +630,7 @@ static struct object_entry **compute_write_order(void)
 	 * Give the objects in the original recency order until
 	 * we see a tagged tip.
 	 */
-	for (i = wo_end = 0; i < nr_objects; i++) {
+	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			break;
 		add_to_write_order(wo, &wo_end, &objects[i]);
@@ -675,7 +640,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Then fill all the tagged tips.
 	 */
-	for (; i < nr_objects; i++) {
+	for (; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -683,7 +648,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * And then all remaining commits and tags.
 	 */
-	for (i = last_untagged; i < nr_objects; i++) {
+	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (objects[i].type != OBJ_COMMIT &&
 		    objects[i].type != OBJ_TAG)
 			continue;
@@ -693,7 +658,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * And then all the trees.
 	 */
-	for (i = last_untagged; i < nr_objects; i++) {
+	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (objects[i].type != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
@@ -702,13 +667,13 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Finally all the rest in really tight order
 	 */
-	for (i = last_untagged; i < nr_objects; i++) {
+	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (!objects[i].filled)
 			add_family_to_write_order(wo, &wo_end, &objects[i]);
 	}
 
-	if (wo_end != nr_objects)
-		die("ordered %u objects, expected %"PRIu32, wo_end, nr_objects);
+	if (wo_end != to_pack.nr_objects)
+		die("ordered %u objects, expected %"PRIu32, wo_end, to_pack.nr_objects);
 
 	return wo;
 }
@@ -724,7 +689,7 @@ static void write_pack_file(void)
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress("Writing objects", nr_result);
-	written_list = xmalloc(nr_objects * sizeof(*written_list));
+	written_list = xmalloc(to_pack.nr_objects * sizeof(*written_list));
 	write_order = compute_write_order();
 
 	do {
@@ -740,7 +705,7 @@ static void write_pack_file(void)
 		if (!offset)
 			die_errno("unable to write pack header");
 		nr_written = 0;
-		for (; i < nr_objects; i++) {
+		for (; i < to_pack.nr_objects; i++) {
 			struct object_entry *e = write_order[i];
 			if (write_one(f, e, &offset) == WRITE_ONE_BREAK)
 				break;
@@ -803,7 +768,7 @@ static void write_pack_file(void)
 			written_list[j]->offset = (off_t)-1;
 		}
 		nr_remaining -= nr_written;
-	} while (nr_remaining && i < nr_objects);
+	} while (nr_remaining && i < to_pack.nr_objects);
 
 	free(written_list);
 	free(write_order);
@@ -813,53 +778,6 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static int locate_object_entry_hash(const unsigned char *sha1)
-{
-	int i;
-	unsigned int ui;
-	memcpy(&ui, sha1, sizeof(unsigned int));
-	i = ui % object_ix_hashsz;
-	while (0 < object_ix[i]) {
-		if (!hashcmp(sha1, objects[object_ix[i] - 1].idx.sha1))
-			return i;
-		if (++i == object_ix_hashsz)
-			i = 0;
-	}
-	return -1 - i;
-}
-
-static struct object_entry *locate_object_entry(const unsigned char *sha1)
-{
-	int i;
-
-	if (!object_ix_hashsz)
-		return NULL;
-
-	i = locate_object_entry_hash(sha1);
-	if (0 <= i)
-		return &objects[object_ix[i]-1];
-	return NULL;
-}
-
-static void rehash_objects(void)
-{
-	uint32_t i;
-	struct object_entry *oe;
-
-	object_ix_hashsz = nr_objects * 3;
-	if (object_ix_hashsz < 1024)
-		object_ix_hashsz = 1024;
-	object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
-	memset(object_ix, 0, sizeof(int) * object_ix_hashsz);
-	for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
-		int ix = locate_object_entry_hash(oe->idx.sha1);
-		if (0 <= ix)
-			continue;
-		ix = -1 - ix;
-		object_ix[ix] = i + 1;
-	}
-}
-
 static uint32_t name_hash(const char *name)
 {
 	uint32_t c, hash = 0;
@@ -908,13 +826,12 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	struct object_entry *entry;
 	struct packed_git *p, *found_pack = NULL;
 	off_t found_offset = 0;
-	int ix;
 	uint32_t hash = name_hash(name);
+	uint32_t index_pos;
 
-	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
-	if (ix >= 0) {
+	entry = packlist_find(&to_pack, sha1, &index_pos);
+	if (entry) {
 		if (exclude) {
-			entry = objects + object_ix[ix] - 1;
 			if (!entry->preferred_base)
 				nr_result--;
 			entry->preferred_base = 1;
@@ -947,14 +864,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		}
 	}
 
-	if (nr_objects >= nr_alloc) {
-		nr_alloc = (nr_alloc  + 1024) * 3 / 2;
-		objects = xrealloc(objects, nr_alloc * sizeof(*entry));
-	}
-
-	entry = objects + nr_objects++;
-	memset(entry, 0, sizeof(*entry));
-	hashcpy(entry->idx.sha1, sha1);
+	entry = packlist_alloc(&to_pack, sha1, index_pos);
 	entry->hash = hash;
 	if (type)
 		entry->type = type;
@@ -967,12 +877,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		entry->in_pack_offset = found_offset;
 	}
 
-	if (object_ix_hashsz * 3 <= nr_objects * 4)
-		rehash_objects();
-	else
-		object_ix[-1 - ix] = nr_objects;
-
-	display_progress(progress_state, nr_objects);
+	display_progress(progress_state, to_pack.nr_objects);
 
 	if (name && no_try_delta(name))
 		entry->no_try_delta = 1;
@@ -1329,7 +1234,7 @@ static void check_object(struct object_entry *entry)
 			break;
 		}
 
-		if (base_ref && (base_entry = locate_object_entry(base_ref))) {
+		if (base_ref && (base_entry = packlist_find(&to_pack, base_ref, NULL))) {
 			/*
 			 * If base_ref was set above that means we wish to
 			 * reuse delta data, and we even found that base
@@ -1403,12 +1308,12 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
-	sorted_by_offset = xcalloc(nr_objects, sizeof(struct object_entry *));
-	for (i = 0; i < nr_objects; i++)
-		sorted_by_offset[i] = objects + i;
-	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
+	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
+	for (i = 0; i < to_pack.nr_objects; i++)
+		sorted_by_offset[i] = to_pack.objects + i;
+	qsort(sorted_by_offset, to_pack.nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
 		if (big_file_threshold < entry->size)
@@ -2034,7 +1939,7 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 
 	if (!prefixcmp(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, peeled)        && /* peelable? */
-	    locate_object_entry(peeled))      /* object packed? */
+	    packlist_find(&to_pack, peeled, NULL))      /* object packed? */
 		add_object_entry(sha1, OBJ_TAG, NULL, 0);
 	return 0;
 }
@@ -2057,14 +1962,14 @@ static void prepare_pack(int window, int depth)
 	if (!pack_to_stdout)
 		do_check_packed_object_crc = 1;
 
-	if (!nr_objects || !window || !depth)
+	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
-	delta_list = xmalloc(nr_objects * sizeof(*delta_list));
+	delta_list = xmalloc(to_pack.nr_objects * sizeof(*delta_list));
 	nr_deltas = n = 0;
 
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *entry = objects + i;
+	for (i = 0; i < to_pack.nr_objects; i++) {
+		struct object_entry *entry = to_pack.objects + i;
 
 		if (entry->delta)
 			/* This happens if we decided to reuse existing
@@ -2342,7 +2247,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 
 		for (i = 0; i < p->num_objects; i++) {
 			sha1 = nth_packed_object_sha1(p, i);
-			if (!locate_object_entry(sha1) &&
+			if (!packlist_find(&to_pack, sha1, NULL) &&
 				!has_sha1_pack_kept_or_nonlocal(sha1))
 				if (force_object_loose(sha1, p->mtime))
 					die("unable to force loose object");
diff --git a/pack-objects.c b/pack-objects.c
new file mode 100644
index 0000000..d01d851
--- /dev/null
+++ b/pack-objects.c
@@ -0,0 +1,111 @@
+#include "cache.h"
+#include "object.h"
+#include "pack.h"
+#include "pack-objects.h"
+
+static uint32_t locate_object_entry_hash(struct packing_data *pdata,
+					 const unsigned char *sha1,
+					 int *found)
+{
+	uint32_t i, hash, mask = (pdata->index_size - 1);
+
+	memcpy(&hash, sha1, sizeof(uint32_t));
+	i = hash & mask;
+
+	while (pdata->index[i] > 0) {
+		uint32_t pos = pdata->index[i] - 1;
+
+		if (!hashcmp(sha1, pdata->objects[pos].idx.sha1)) {
+			*found = 1;
+			return i;
+		}
+
+		i = (i + 1) & mask;
+	}
+
+	*found = 0;
+	return i;
+}
+
+static inline uint32_t closest_pow2(uint32_t v)
+{
+	v = v - 1;
+	v |= v >> 1;
+	v |= v >> 2;
+	v |= v >> 4;
+	v |= v >> 8;
+	v |= v >> 16;
+	return v + 1;
+}
+
+static void rehash_objects(struct packing_data *pdata)
+{
+	uint32_t i;
+	struct object_entry *entry;
+
+	pdata->index_size = closest_pow2(pdata->nr_objects * 3);
+	if (pdata->index_size < 1024)
+		pdata->index_size = 1024;
+
+	pdata->index = xrealloc(pdata->index, sizeof(uint32_t) * pdata->index_size);
+	memset(pdata->index, 0, sizeof(int) * pdata->index_size);
+
+	entry = pdata->objects;
+
+	for (i = 0; i < pdata->nr_objects; i++) {
+		int found;
+		uint32_t ix = locate_object_entry_hash(pdata, entry->idx.sha1, &found);
+
+		if (found)
+			die("BUG: Duplicate object in hash");
+
+		pdata->index[ix] = i + 1;
+		entry++;
+	}
+}
+
+struct object_entry *packlist_find(struct packing_data *pdata,
+				   const unsigned char *sha1,
+				   uint32_t *index_pos)
+{
+	uint32_t i;
+	int found;
+
+	if (!pdata->index_size)
+		return NULL;
+
+	i = locate_object_entry_hash(pdata, sha1, &found);
+
+	if (index_pos)
+		*index_pos = i;
+
+	if (!found)
+		return NULL;
+
+	return &pdata->objects[pdata->index[i] - 1];
+}
+
+struct object_entry *packlist_alloc(struct packing_data *pdata,
+				    const unsigned char *sha1,
+				    uint32_t index_pos)
+{
+	struct object_entry *new_entry;
+
+	if (pdata->nr_objects >= pdata->nr_alloc) {
+		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
+		pdata->objects = xrealloc(pdata->objects,
+					  pdata->nr_alloc * sizeof(*new_entry));
+	}
+
+	new_entry = pdata->objects + pdata->nr_objects++;
+
+	memset(new_entry, 0, sizeof(*new_entry));
+	hashcpy(new_entry->idx.sha1, sha1);
+
+	if (pdata->index_size * 3 <= pdata->nr_objects * 4)
+		rehash_objects(pdata);
+	else
+		pdata->index[index_pos] = pdata->nr_objects;
+
+	return new_entry;
+}
diff --git a/pack-objects.h b/pack-objects.h
new file mode 100644
index 0000000..f528215
--- /dev/null
+++ b/pack-objects.h
@@ -0,0 +1,47 @@
+#ifndef PACK_OBJECTS_H
+#define PACK_OBJECTS_H
+
+struct object_entry {
+	struct pack_idx_entry idx;
+	unsigned long size;	/* uncompressed size */
+	struct packed_git *in_pack;	/* already in pack */
+	off_t in_pack_offset;
+	struct object_entry *delta;	/* delta base object */
+	struct object_entry *delta_child; /* deltified objects who bases me */
+	struct object_entry *delta_sibling; /* other deltified objects who
+					     * uses the same base as me
+					     */
+	void *delta_data;	/* cached delta (uncompressed) */
+	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned long z_delta_size;	/* delta data size (compressed) */
+	enum object_type type;
+	enum object_type in_pack_type;	/* could be delta */
+	uint32_t hash;			/* name hint hash */
+	unsigned char in_pack_header_size;
+	unsigned preferred_base:1; /*
+				    * we do not pack this, but is available
+				    * to be used as the base object to delta
+				    * objects against.
+				    */
+	unsigned no_try_delta:1;
+	unsigned tagged:1; /* near the very tip of refs */
+	unsigned filled:1; /* assigned write-order */
+};
+
+struct packing_data {
+	struct object_entry *objects;
+	uint32_t nr_objects, nr_alloc;
+
+	int32_t *index;
+	uint32_t index_size;
+};
+
+struct object_entry *packlist_alloc(struct packing_data *pdata,
+				    const unsigned char *sha1,
+				    uint32_t index_pos);
+
+struct object_entry *packlist_find(struct packing_data *pdata,
+				   const unsigned char *sha1,
+				   uint32_t *index_pos);
+
+#endif
-- 
1.8.5.rc0.443.g2df7f3f
