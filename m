From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 03/16] pack-objects: use a faster hash table
Date: Tue, 25 Jun 2013 01:23:00 +0200
Message-ID: <1372116193-32762-4-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG70-00037D-84
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab3FXXXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:48 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:36849 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab3FXXXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:46 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so8673287wes.39
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Kqg8hGoi0WsZZ7StFRtVrjKQqu4aclLJgJMbEvLMYI=;
        b=V6q3fKMyRy/PXWIps+8Mj50YBjuzftB0eZpUIgTVFUNhPj5JQkVSxmEfJITmL9pwEh
         MdD4uGb4W7biGUyxiX6B87zLXBw93TZ1657Rw0J61KaJ//hxvggU0GBegVOtM9LjIJaA
         idKGpivCrTFZp67r8PSR41cAhfIm/QZ7YefY16PnhHfNmdFK0edgj5SI8J7tWaVx5ny+
         MVhfsdImH8VfJGJQ29X4J4kSbjeKZTUBQu4r32gUwxeGMXV0DZ0r0OtXfnSRiLDWQ51g
         qwCviwgQjp9gkCVFK+rF4VIZYavr+6+h4/xXzZ1K4dwqTBwoonIxUORjXrwhQ50UiajN
         AKSQ==
X-Received: by 10.195.13.195 with SMTP id fa3mr17988862wjd.80.1372116224762;
        Mon, 24 Jun 2013 16:23:44 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228922>

In a normal pack-objects invocations runtime is dominated by the
counting objects phase and the time spent performing hash operations
with the `object_entry` structs is not particularly relevant.

If the Counting Objects phase however gets optimized to perform batch
insertions (like it is the goal of this patch series), the current
hash table implementation starts to bottleneck in both insertion times
and memory reallocations caused by the fast growth of the hash table.

For instance, these are function timings in a hotspot profiling of a
pack-objects run:

	locate_object_entry_hash :: 563.935ms
	hashcmp :: 195.991ms
	add_object_entry_1 :: 47.962ms

This commit brings `khash.h`, a header only hash table implementation
that while remaining rather simple (uses quadratic probing and a
standard hashing scheme) and self-contained, offers a significant
performance improvement in both insertion and lookup times.

`khash` is a generic hash table implementation that can be 'templated'
for any given type while maintaining good performance by using preprocessor
macros. This specific version has been modified to define by default a
`khash_sha1` type, a map of SHA1s (const unsigned char[20]) to void *
pointers.

When replacing the old hash table implementation in `pack-objects` with
the khash_sha1 table, the insertion time is greatly reduced:

	kh_put_sha1 :: 284.011ms
	add_object_entry_1 : 36.06ms
	hashcmp :: 24.045ms

This reduction of more than 50% in the insertion and lookup times,
although nice, is not particularly noticeable for normal `pack-objects`
operation: `pack-objects` performs massive batch insertions and
relatively few lookups, so `khash` doesn't get a chance to shine here.

The big win here, however, is in the massively reduced amount of hash
collisions (as you can see from the huge reduction of time spent in
`hashcmp` after the change). These greatly improved lookup times
will result critical once we implement the writing algorithm for bitmap
indxes in a later patch of this series.

The bitmap writing phase for a repository like `linux` requires several
million table lookups: using the new hash table saves 1min and 20s from
a `pack-objects` invocation that also writes out bitmaps.
---
 Makefile               |    1 +
 builtin/pack-objects.c |  210 ++++++++++++++++---------------
 khash.h                |  329 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+), 99 deletions(-)
 create mode 100644 khash.h

diff --git a/Makefile b/Makefile
index 79f961e..e01506d 100644
--- a/Makefile
+++ b/Makefile
@@ -683,6 +683,7 @@ LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
 LIB_H += http.h
+LIB_H += khash.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
 LIB_H += line-log.h
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..fc12df8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "khash.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -57,7 +58,7 @@ struct object_entry {
  * in the order we see -- typically rev-list --objects order that gives us
  * nice "minimum seek" order.
  */
-static struct object_entry *objects;
+static struct object_entry **objects;
 static struct pack_idx_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
@@ -93,8 +94,8 @@ static unsigned long window_memory_limit = 0;
  * to help looking up the entry by object name.
  * This hashtable is built after all the objects are seen.
  */
-static int *object_ix;
-static int object_ix_hashsz;
+
+static khash_sha1 *packed_objects;
 static struct object_entry *locate_object_entry(const unsigned char *sha1);
 
 /*
@@ -104,6 +105,35 @@ static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
 
+static struct object_slab {
+	struct object_slab *next;
+	uint32_t count;
+	struct object_entry data[0];
+} *slab;
+
+#define OBJECTS_PER_SLAB 2048
+
+static void push_slab(void)
+{
+	static const size_t slab_size =
+		(OBJECTS_PER_SLAB * sizeof(struct object_entry)) + sizeof(struct object_slab);
+
+	struct object_slab *new_slab = calloc(1, slab_size);
+
+	new_slab->count = 0;
+	new_slab->next = slab;
+	slab = new_slab;
+}
+
+static struct object_entry *alloc_object_entry(void)
+{
+	if (!slab || slab->count == OBJECTS_PER_SLAB)
+		push_slab();
+
+	return &slab->data[slab->count++];
+}
+
+
 static void *get_delta(struct object_entry *entry)
 {
 	unsigned long size, base_size, delta_size;
@@ -635,10 +665,10 @@ static struct object_entry **compute_write_order(void)
 	struct object_entry **wo = xmalloc(nr_objects * sizeof(*wo));
 
 	for (i = 0; i < nr_objects; i++) {
-		objects[i].tagged = 0;
-		objects[i].filled = 0;
-		objects[i].delta_child = NULL;
-		objects[i].delta_sibling = NULL;
+		objects[i]->tagged = 0;
+		objects[i]->filled = 0;
+		objects[i]->delta_child = NULL;
+		objects[i]->delta_sibling = NULL;
 	}
 
 	/*
@@ -647,7 +677,7 @@ static struct object_entry **compute_write_order(void)
 	 * recency order.
 	 */
 	for (i = nr_objects; i > 0;) {
-		struct object_entry *e = &objects[--i];
+		struct object_entry *e = objects[--i];
 		if (!e->delta)
 			continue;
 		/* Mark me as the first child */
@@ -665,9 +695,9 @@ static struct object_entry **compute_write_order(void)
 	 * we see a tagged tip.
 	 */
 	for (i = wo_end = 0; i < nr_objects; i++) {
-		if (objects[i].tagged)
+		if (objects[i]->tagged)
 			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, &wo_end, objects[i]);
 	}
 	last_untagged = i;
 
@@ -675,35 +705,35 @@ static struct object_entry **compute_write_order(void)
 	 * Then fill all the tagged tips.
 	 */
 	for (; i < nr_objects; i++) {
-		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
+		if (objects[i]->tagged)
+			add_to_write_order(wo, &wo_end, objects[i]);
 	}
 
 	/*
 	 * And then all remaining commits and tags.
 	 */
 	for (i = last_untagged; i < nr_objects; i++) {
-		if (objects[i].type != OBJ_COMMIT &&
-		    objects[i].type != OBJ_TAG)
+		if (objects[i]->type != OBJ_COMMIT &&
+		    objects[i]->type != OBJ_TAG)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, &wo_end, objects[i]);
 	}
 
 	/*
 	 * And then all the trees.
 	 */
 	for (i = last_untagged; i < nr_objects; i++) {
-		if (objects[i].type != OBJ_TREE)
+		if (objects[i]->type != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, &wo_end, objects[i]);
 	}
 
 	/*
 	 * Finally all the rest in really tight order
 	 */
 	for (i = last_untagged; i < nr_objects; i++) {
-		if (!objects[i].filled)
-			add_family_to_write_order(wo, &wo_end, &objects[i]);
+		if (!objects[i]->filled)
+			add_family_to_write_order(wo, &wo_end, objects[i]);
 	}
 
 	if (wo_end != nr_objects)
@@ -804,61 +834,26 @@ static void write_pack_file(void)
 		nr_remaining -= nr_written;
 	} while (nr_remaining && i < nr_objects);
 
+	stop_progress(&progress_state);
+
 	free(written_list);
 	free(write_order);
-	stop_progress(&progress_state);
 	if (written != nr_result)
 		die("wrote %"PRIu32" objects while expecting %"PRIu32,
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
 static struct object_entry *locate_object_entry(const unsigned char *sha1)
 {
-	int i;
+	khiter_t pos = kh_get_sha1(packed_objects, sha1);
 
-	if (!object_ix_hashsz)
-		return NULL;
+	if (pos < kh_end(packed_objects)) {
+		return kh_value(packed_objects, pos);
+	}
 
-	i = locate_object_entry_hash(sha1);
-	if (0 <= i)
-		return &objects[object_ix[i]-1];
 	return NULL;
 }
 
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
 static unsigned name_hash(const char *name)
 {
 	unsigned c, hash = 0;
@@ -901,19 +896,19 @@ static int no_try_delta(const char *path)
 	return 0;
 }
 
-static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
+			    uint32_t hash, int exclude, struct packed_git *found_pack,
+				off_t found_offset)
 {
 	struct object_entry *entry;
-	struct packed_git *p, *found_pack = NULL;
-	off_t found_offset = 0;
-	int ix;
-	unsigned hash = name_hash(name);
+	struct packed_git *p;
+	khiter_t ix;
+	int hash_ret;
 
-	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
-	if (ix >= 0) {
+	ix = kh_put_sha1(packed_objects, sha1, &hash_ret);
+	if (hash_ret == 0) {
 		if (exclude) {
-			entry = objects + object_ix[ix] - 1;
+			entry = kh_value(packed_objects, ix);
 			if (!entry->preferred_base)
 				nr_result--;
 			entry->preferred_base = 1;
@@ -921,38 +916,42 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 	}
 
-	if (!exclude && local && has_loose_object_nonlocal(sha1))
+	if (!exclude && local && has_loose_object_nonlocal(sha1)) {
+		kh_del_sha1(packed_objects, ix);
 		return 0;
+	}
 
-	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
-		if (offset) {
-			if (!found_pack) {
-				if (!is_pack_valid(p)) {
-					warning("packfile %s cannot be accessed", p->pack_name);
-					continue;
+	if (!found_pack) {
+		for (p = packed_git; p; p = p->next) {
+			off_t offset = find_pack_entry_one(sha1, p);
+			if (offset) {
+				if (!found_pack) {
+					if (!is_pack_valid(p)) {
+						warning("packfile %s cannot be accessed", p->pack_name);
+						continue;
+					}
+					found_offset = offset;
+					found_pack = p;
+				}
+				if (exclude)
+					break;
+				if (incremental ||
+					(local && !p->pack_local) ||
+					(ignore_packed_keep && p->pack_local && p->pack_keep)) {
+					kh_del_sha1(packed_objects, ix);
+					return 0;
 				}
-				found_offset = offset;
-				found_pack = p;
 			}
-			if (exclude)
-				break;
-			if (incremental)
-				return 0;
-			if (local && !p->pack_local)
-				return 0;
-			if (ignore_packed_keep && p->pack_local && p->pack_keep)
-				return 0;
 		}
 	}
 
 	if (nr_objects >= nr_alloc) {
 		nr_alloc = (nr_alloc  + 1024) * 3 / 2;
-		objects = xrealloc(objects, nr_alloc * sizeof(*entry));
+		objects = xrealloc(objects, nr_alloc * sizeof(struct object_entry *));
 	}
 
-	entry = objects + nr_objects++;
-	memset(entry, 0, sizeof(*entry));
+	entry = alloc_object_entry();
+
 	hashcpy(entry->idx.sha1, sha1);
 	entry->hash = hash;
 	if (type)
@@ -966,19 +965,30 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		entry->in_pack_offset = found_offset;
 	}
 
-	if (object_ix_hashsz * 3 <= nr_objects * 4)
-		rehash_objects();
-	else
-		object_ix[-1 - ix] = nr_objects;
+	kh_value(packed_objects, ix) = entry;
+	kh_key(packed_objects, ix) = entry->idx.sha1;
+	objects[nr_objects++] = entry;
 
 	display_progress(progress_state, nr_objects);
 
-	if (name && no_try_delta(name))
-		entry->no_try_delta = 1;
-
 	return 1;
 }
 
+static int add_object_entry(const unsigned char *sha1, enum object_type type,
+			    const char *name, int exclude)
+{
+	if (add_object_entry_1(sha1, type, name_hash(name), exclude, NULL, 0)) {
+		struct object_entry *entry = objects[nr_objects - 1];
+
+		if (name && no_try_delta(name))
+			entry->no_try_delta = 1;
+
+		return 1;
+	}
+
+	return 0;
+}
+
 struct pbase_tree_cache {
 	unsigned char sha1[20];
 	int ref;
@@ -1404,7 +1414,7 @@ static void get_object_details(void)
 
 	sorted_by_offset = xcalloc(nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < nr_objects; i++)
-		sorted_by_offset[i] = objects + i;
+		sorted_by_offset[i] = objects[i];
 	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
 	for (i = 0; i < nr_objects; i++) {
@@ -2063,7 +2073,7 @@ static void prepare_pack(int window, int depth)
 	nr_deltas = n = 0;
 
 	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *entry = objects + i;
+		struct object_entry *entry = objects[i];
 
 		if (entry->delta)
 			/* This happens if we decided to reuse existing
@@ -2574,6 +2584,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	packed_objects = kh_init_sha1();
 	prepare_packed_git();
 
 	if (progress)
@@ -2598,5 +2609,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
 	return 0;
 }
diff --git a/khash.h b/khash.h
new file mode 100644
index 0000000..e6cdb38
--- /dev/null
+++ b/khash.h
@@ -0,0 +1,329 @@
+/* The MIT License
+
+   Copyright (c) 2008, 2009, 2011 by Attractive Chaos <attractor@live.co.uk>
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be
+   included in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+   SOFTWARE.
+*/
+
+#ifndef __AC_KHASH_H
+#define __AC_KHASH_H
+
+#define AC_VERSION_KHASH_H "0.2.8"
+
+#include <stdlib.h>
+#include <string.h>
+#include <limits.h>
+
+typedef uint32_t khint32_t;
+typedef uint64_t khint64_t;
+
+typedef khint32_t khint_t;
+typedef khint_t khiter_t;
+
+#define __ac_isempty(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&2)
+#define __ac_isdel(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&1)
+#define __ac_iseither(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&3)
+#define __ac_set_isdel_false(flag, i) (flag[i>>4]&=~(1ul<<((i&0xfU)<<1)))
+#define __ac_set_isempty_false(flag, i) (flag[i>>4]&=~(2ul<<((i&0xfU)<<1)))
+#define __ac_set_isboth_false(flag, i) (flag[i>>4]&=~(3ul<<((i&0xfU)<<1)))
+#define __ac_set_isdel_true(flag, i) (flag[i>>4]|=1ul<<((i&0xfU)<<1))
+
+#define __ac_fsize(m) ((m) < 16? 1 : (m)>>4)
+
+#define kroundup32(x) (--(x), (x)|=(x)>>1, (x)|=(x)>>2, (x)|=(x)>>4, (x)|=(x)>>8, (x)|=(x)>>16, ++(x))
+
+static const double __ac_HASH_UPPER = 0.77;
+
+#define __KHASH_TYPE(name, khkey_t, khval_t) \
+	typedef struct { \
+		khint_t n_buckets, size, n_occupied, upper_bound; \
+		khint32_t *flags; \
+		khkey_t *keys; \
+		khval_t *vals; \
+	} kh_##name##_t;
+
+#define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 					\
+	extern kh_##name##_t *kh_init_##name(void);							\
+	extern void kh_destroy_##name(kh_##name##_t *h);					\
+	extern void kh_clear_##name(kh_##name##_t *h);						\
+	extern khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
+	extern int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	extern khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
+	extern void kh_del_##name(kh_##name##_t *h, khint_t x);
+
+#define __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	SCOPE kh_##name##_t *kh_init_##name(void) {							\
+		return (kh_##name##_t*)xcalloc(1, sizeof(kh_##name##_t));		\
+	}																	\
+	SCOPE void kh_destroy_##name(kh_##name##_t *h)						\
+	{																	\
+		if (h) {														\
+			free((void *)h->keys); free(h->flags);					\
+			free((void *)h->vals);										\
+			free(h);													\
+		}																\
+	}																	\
+	SCOPE void kh_clear_##name(kh_##name##_t *h)						\
+	{																	\
+		if (h && h->flags) {											\
+			memset(h->flags, 0xaa, __ac_fsize(h->n_buckets) * sizeof(khint32_t)); \
+			h->size = h->n_occupied = 0;								\
+		}																\
+	}																	\
+	SCOPE khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key) 	\
+	{																	\
+		if (h->n_buckets) {												\
+			khint_t k, i, last, mask, step = 0; \
+			mask = h->n_buckets - 1;									\
+			k = __hash_func(key); i = k & mask;							\
+			last = i; \
+			while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
+				i = (i + (++step)) & mask; \
+				if (i == last) return h->n_buckets;						\
+			}															\
+			return __ac_iseither(h->flags, i)? h->n_buckets : i;		\
+		} else return 0;												\
+	}																	\
+	SCOPE int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
+	{ /* This function uses 0.25*n_buckets bytes of working space instead of [sizeof(key_t+val_t)+.25]*n_buckets. */ \
+		khint32_t *new_flags = 0;										\
+		khint_t j = 1;													\
+		{																\
+			kroundup32(new_n_buckets); 									\
+			if (new_n_buckets < 4) new_n_buckets = 4;					\
+			if (h->size >= (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j = 0;	/* requested size is too small */ \
+			else { /* hash table size to be changed (shrink or expand); rehash */ \
+				new_flags = (khint32_t*)xmalloc(__ac_fsize(new_n_buckets) * sizeof(khint32_t));	\
+				if (!new_flags) return -1;								\
+				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
+				if (h->n_buckets < new_n_buckets) {	/* expand */		\
+					khkey_t *new_keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
+					if (!new_keys) return -1;							\
+					h->keys = new_keys;									\
+					if (kh_is_map) {									\
+						khval_t *new_vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
+						if (!new_vals) return -1;						\
+						h->vals = new_vals;								\
+					}													\
+				} /* otherwise shrink */								\
+			}															\
+		}																\
+		if (j) { /* rehashing is needed */								\
+			for (j = 0; j != h->n_buckets; ++j) {						\
+				if (__ac_iseither(h->flags, j) == 0) {					\
+					khkey_t key = h->keys[j];							\
+					khval_t val;										\
+					khint_t new_mask;									\
+					new_mask = new_n_buckets - 1; 						\
+					if (kh_is_map) val = h->vals[j];					\
+					__ac_set_isdel_true(h->flags, j);					\
+					while (1) { /* kick-out process; sort of like in Cuckoo hashing */ \
+						khint_t k, i, step = 0; \
+						k = __hash_func(key);							\
+						i = k & new_mask;								\
+						while (!__ac_isempty(new_flags, i)) i = (i + (++step)) & new_mask; \
+						__ac_set_isempty_false(new_flags, i);			\
+						if (i < h->n_buckets && __ac_iseither(h->flags, i) == 0) { /* kick out the existing element */ \
+							{ khkey_t tmp = h->keys[i]; h->keys[i] = key; key = tmp; } \
+							if (kh_is_map) { khval_t tmp = h->vals[i]; h->vals[i] = val; val = tmp; } \
+							__ac_set_isdel_true(h->flags, i); /* mark it as deleted in the old hash table */ \
+						} else { /* write the element and jump out of the loop */ \
+							h->keys[i] = key;							\
+							if (kh_is_map) h->vals[i] = val;			\
+							break;										\
+						}												\
+					}													\
+				}														\
+			}															\
+			if (h->n_buckets > new_n_buckets) { /* shrink the hash table */ \
+				h->keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
+				if (kh_is_map) h->vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
+			}															\
+			free(h->flags); /* free the working space */				\
+			h->flags = new_flags;										\
+			h->n_buckets = new_n_buckets;								\
+			h->n_occupied = h->size;									\
+			h->upper_bound = (khint_t)(h->n_buckets * __ac_HASH_UPPER + 0.5); \
+		}																\
+		return 0;														\
+	}																	\
+	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
+	{																	\
+		khint_t x;														\
+		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
+			if (h->n_buckets > (h->size<<1)) {							\
+				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" elements */ \
+					*ret = -1; return h->n_buckets;						\
+				}														\
+			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the hash table */ \
+				*ret = -1; return h->n_buckets;							\
+			}															\
+		} /* TODO: to implement automatically shrinking; resize() already support shrinking */ \
+		{																\
+			khint_t k, i, site, last, mask = h->n_buckets - 1, step = 0; \
+			x = site = h->n_buckets; k = __hash_func(key); i = k & mask; \
+			if (__ac_isempty(h->flags, i)) x = i; /* for speed up */	\
+			else {														\
+				last = i; \
+				while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
+					if (__ac_isdel(h->flags, i)) site = i;				\
+					i = (i + (++step)) & mask; \
+					if (i == last) { x = site; break; }					\
+				}														\
+				if (x == h->n_buckets) {								\
+					if (__ac_isempty(h->flags, i) && site != h->n_buckets) x = site; \
+					else x = i;											\
+				}														\
+			}															\
+		}																\
+		if (__ac_isempty(h->flags, x)) { /* not present at all */		\
+			h->keys[x] = key;											\
+			__ac_set_isboth_false(h->flags, x);							\
+			++h->size; ++h->n_occupied;									\
+			*ret = 1;													\
+		} else if (__ac_isdel(h->flags, x)) { /* deleted */				\
+			h->keys[x] = key;											\
+			__ac_set_isboth_false(h->flags, x);							\
+			++h->size;													\
+			*ret = 2;													\
+		} else *ret = 0; /* Don't touch h->keys[x] if present and not deleted */ \
+		return x;														\
+	}																	\
+	SCOPE void kh_del_##name(kh_##name##_t *h, khint_t x)				\
+	{																	\
+		if (x != h->n_buckets && !__ac_iseither(h->flags, x)) {			\
+			__ac_set_isdel_true(h->flags, x);							\
+			--h->size;													\
+		}																\
+	}
+
+#define KHASH_DECLARE(name, khkey_t, khval_t)		 					\
+	__KHASH_TYPE(name, khkey_t, khval_t) 								\
+	__KHASH_PROTOTYPES(name, khkey_t, khval_t)
+
+#define KHASH_INIT2(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	__KHASH_TYPE(name, khkey_t, khval_t) 								\
+	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+
+#define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+
+/* Other convenient macros... */
+
+/*! @function
+  @abstract     Test whether a bucket contains data.
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       1 if containing data; 0 otherwise [int]
+ */
+#define kh_exist(h, x) (!__ac_iseither((h)->flags, (x)))
+
+/*! @function
+  @abstract     Get key given an iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Key [type of keys]
+ */
+#define kh_key(h, x) ((h)->keys[x])
+
+/*! @function
+  @abstract     Get value given an iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Value [type of values]
+  @discussion   For hash sets, calling this results in segfault.
+ */
+#define kh_val(h, x) ((h)->vals[x])
+
+/*! @function
+  @abstract     Alias of kh_val()
+ */
+#define kh_value(h, x) ((h)->vals[x])
+
+/*! @function
+  @abstract     Get the start iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       The start iterator [khint_t]
+ */
+#define kh_begin(h) (khint_t)(0)
+
+/*! @function
+  @abstract     Get the end iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       The end iterator [khint_t]
+ */
+#define kh_end(h) ((h)->n_buckets)
+
+/*! @function
+  @abstract     Get the number of elements in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       Number of elements in the hash table [khint_t]
+ */
+#define kh_size(h) ((h)->size)
+
+/*! @function
+  @abstract     Get the number of buckets in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       Number of buckets in the hash table [khint_t]
+ */
+#define kh_n_buckets(h) ((h)->n_buckets)
+
+/*! @function
+  @abstract     Iterate over the entries in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  kvar  Variable to which key will be assigned
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach(h, kvar, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+		if (!kh_exist(h,__i)) continue;						\
+		(kvar) = kh_key(h,__i);								\
+		(vvar) = kh_val(h,__i);								\
+		code;												\
+	} }
+
+/*! @function
+  @abstract     Iterate over the values in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach_value(h, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+		if (!kh_exist(h,__i)) continue;						\
+		(vvar) = kh_val(h,__i);								\
+		code;												\
+	} }
+
+static inline khint_t __kh_oid_hash(const unsigned char *oid)
+{
+	khint_t hash;
+	memcpy(&hash, oid, sizeof(hash));
+	return hash;
+}
+
+#define __kh_oid_cmp(a, b) (hashcmp(a, b) == 0)
+
+KHASH_INIT(sha1, const unsigned char *, void *, 1, __kh_oid_hash, __kh_oid_cmp)
+typedef kh_sha1_t khash_sha1;
+
+#endif /* __AC_KHASH_H */
-- 
1.7.9.5
