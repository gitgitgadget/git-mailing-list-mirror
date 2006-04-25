From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] split the diff-delta interface
Date: Mon, 24 Apr 2006 23:07:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604242258160.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 05:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYDuD-0004sm-9t
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 05:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWDYDHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 23:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDYDHu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 23:07:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11428 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932081AbWDYDHt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 23:07:49 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY90061SCOZWA90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Apr 2006 23:07:48 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19120>

This patch splits the diff-delta interface into index creation and delta
generation.  A wrapper is provided to preserve the diff-delta() call.

This will allow for an optimization in pack-objects.c where the source 
object could be fixed and a full window of objects tentatively tried 
against 
that same source object without recomputing the source index each time.

This patch only restructure things, plus a couple cleanups for good 
measure. There is no performance change yet.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---


diff --git a/delta.h b/delta.h
index 9464f3e..9ef44c1 100644
--- a/delta.h
+++ b/delta.h
@@ -1,12 +1,73 @@
 #ifndef DELTA_H
 #define DELTA_H
 
-/* handling of delta buffers */
-extern void *diff_delta(void *from_buf, unsigned long from_size,
-			void *to_buf, unsigned long to_size,
-		        unsigned long *delta_size, unsigned long max_size);
-extern void *patch_delta(void *src_buf, unsigned long src_size,
-			 void *delta_buf, unsigned long delta_size,
+/* opaque object for delta index */
+struct delta_index;
+
+/*
+ * create_delta_index: compute index data from given buffer
+ *
+ * This returns a pointer to a struct delta_index that should be passed to
+ * subsequent create_delta() calls, or to free_delta_index().  A NULL pointer
+ * is returned on failure.  The given buffer must not be freed nor altered
+ * before free_delta_index() is called.  The returned pointer must be freed
+ * using free_delta_index().
+ */
+extern struct delta_index *
+create_delta_index(const void *buf, unsigned long bufsize);
+
+/*
+ * free_delta_index: free the index created by create_delta_index()
+ */
+extern void free_delta_index(struct delta_index *index);
+
+/*
+ * create_delta: create a delta from given index for the given buffer
+ *
+ * This function may be called multiple times with different buffers using
+ * the same delta_index pointer.  If max_delta_size is non-zero and the
+ * resulting delta is to be larger than max_delta_size then NULL is returned.
+ * On success, a non-NULL pointer to the buffer with the delta data is
+ * returned and *delta_size is updated with its size.  The returned buffer
+ * must be freed by the caller.
+ */
+extern void *
+create_delta(const struct delta_index *index,
+	     const void *buf, unsigned long bufsize,
+	     unsigned long *delta_size, unsigned long max_delta_size);
+
+/*
+ * diff_delta: create a delta from source buffer to target buffer
+ *
+ * If max_delta_size is non-zero and the resulting delta is to be larger
+ * than max_delta_size then NULL is returned.  On success, a non-NULL
+ * pointer to the buffer with the delta data is returned and *delta_size is
+ * updated with its size.  The returned buffer must be freed by the caller.
+ */
+static inline void *
+diff_delta(const void *src_buf, unsigned long src_bufsize,
+	   const void *trg_buf, unsigned long trg_bufsize,
+	   unsigned long *delta_size, unsigned long max_delta_size)
+{
+	struct delta_index *index = create_delta_index(src_buf, src_bufsize);
+	if (index) {
+		void *delta = create_delta(index, trg_buf, trg_bufsize, 
+					   delta_size, max_delta_size);
+		free_delta_index(index);
+		return delta;
+	}
+	return NULL;
+}
+
+/*
+ * patch_delta: recreate target buffer given source buffer and delta data
+ *
+ * On success, a non-NULL pointer to the target buffer is returned and
+ * *trg_bufsize is updated with its size.  On failure a NULL pointer is
+ * returned.  The returned buffer must be freed by the caller.
+ */
+extern void *patch_delta(const void *src_buf, unsigned long src_size,
+			 const void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
@@ -14,7 +75,7 @@ #define DELTA_SIZE_MIN	4
 
 /*
  * This must be called twice on the delta data buffer, first to get the
- * expected reference buffer size, and again to get the result buffer size.
+ * expected source buffer size, and again to get the target buffer size.
  */
 static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
diff --git a/diff-delta.c b/diff-delta.c
index 1188b31..fdedf94 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -27,53 +27,70 @@ #include "delta.h"
 /* block size: min = 16, max = 64k, power of 2 */
 #define BLK_SIZE 16
 
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
+/* maximum hash entry list for the same hash bucket */
+#define HASH_LIMIT 64
 
 #define GR_PRIME 0x9e370001
 #define HASH(v, shift) (((unsigned int)(v) * GR_PRIME) >> (shift))
 
-struct index {
+struct index_entry {
 	const unsigned char *ptr;
 	unsigned int val;
-	struct index *next;
+	struct index_entry *next;
 };
 
-static struct index ** delta_index(const unsigned char *buf,
-				   unsigned long bufsize,
-				   unsigned long trg_bufsize,
-				   unsigned int *hash_shift)
+struct delta_index {
+	const void *src_buf;
+	unsigned long src_size;
+	unsigned int hash_shift;
+	struct index_entry *hash[0];
+};
+
+struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 {
-	unsigned int i, hsize, hshift, hlimit, entries, *hash_count;
-	const unsigned char *data;
-	struct index *entry, **hash;
+	unsigned int i, hsize, hshift, entries, *hash_count;
+	const unsigned char *data, *buffer = buf;
+	struct delta_index *index;
+	struct index_entry *entry, **hash;
 	void *mem;
 
+	if (!buf || !bufsize)
+		return NULL;
+
 	/* determine index hash size */
 	entries = bufsize  / BLK_SIZE;
 	hsize = entries / 4;
 	for (i = 4; (1 << i) < hsize && i < 31; i++);
 	hsize = 1 << i;
 	hshift = 32 - i;
-	*hash_shift = hshift;
 
 	/* allocate lookup index */
-	mem = malloc(hsize * sizeof(*hash) + entries * sizeof(*entry));
+	mem = malloc(sizeof(*index) +
+		     sizeof(*hash) * hsize +
+		     sizeof(*entry) * entries);
 	if (!mem)
 		return NULL;
+	index = mem;
+	mem = index + 1;
 	hash = mem;
-	entry = mem + hsize * sizeof(*hash);
+	mem = hash + hsize;
+	entry = mem;
+
+	index->src_buf = buf;
+	index->src_size = bufsize;
+	index->hash_shift = hshift;
 	memset(hash, 0, hsize * sizeof(*hash));
 
 	/* allocate an array to count hash entries */
 	hash_count = calloc(hsize, sizeof(*hash_count));
 	if (!hash_count) {
-		free(hash);
+		free(index);
 		return NULL;
 	}
 
 	/* then populate the index */
-	data = buf + entries * BLK_SIZE - BLK_SIZE;
-	while (data >= buf) {
+	data = buffer + entries * BLK_SIZE - BLK_SIZE;
+	while (data >= buffer) {
 		unsigned int val = adler32(0, data, BLK_SIZE);
 		i = HASH(val, hshift);
 		entry->ptr = data;
@@ -91,27 +108,18 @@ static struct index ** delta_index(const
 	 * bucket that would bring us to O(m*n) computing costs (m and n
 	 * corresponding to reference and target buffer sizes).
 	 *
-	 * The more the target buffer is large, the more it is important to
-	 * have small entry lists for each hash buckets.  With such a limit
-	 * the cost is bounded to something more like O(m+n).
-	 */
-	hlimit = (1 << 26) / trg_bufsize;
-	if (hlimit < 4*BLK_SIZE)
-		hlimit = 4*BLK_SIZE;
-
-	/*
-	 * Now make sure none of the hash buckets has more entries than
+	 * Make sure none of the hash buckets has more entries than
 	 * we're willing to test.  Otherwise we cull the entry list
 	 * uniformly to still preserve a good repartition across
 	 * the reference buffer.
 	 */
 	for (i = 0; i < hsize; i++) {
-		if (hash_count[i] < hlimit)
+		if (hash_count[i] < HASH_LIMIT)
 			continue;
 		entry = hash[i];
 		do {
-			struct index *keep = entry;
-			int skip = hash_count[i] / hlimit / 2;
+			struct index_entry *keep = entry;
+			int skip = hash_count[i] / HASH_LIMIT / 2;
 			do {
 				entry = entry->next;
 			} while(--skip && entry);
@@ -120,7 +128,12 @@ static struct index ** delta_index(const
 	}
 	free(hash_count);
 
-	return hash;
+	return index;
+}
+
+void free_delta_index(struct delta_index *index)
+{
+	free(index);
 }
 
 /* provide the size of the copy opcode given the block offset and size */
@@ -131,21 +144,17 @@ #define COPYOP_SIZE(o, s) \
 /* the maximum size for any opcode */
 #define MAX_OP_SIZE COPYOP_SIZE(0xffffffff, 0xffffffff)
 
-void *diff_delta(void *from_buf, unsigned long from_size,
-		 void *to_buf, unsigned long to_size,
-		 unsigned long *delta_size,
-		 unsigned long max_size)
+void *
+create_delta(const struct delta_index *index,
+	     const void *trg_buf, unsigned long trg_size,
+	     unsigned long *delta_size, unsigned long max_size)
 {
 	unsigned int i, outpos, outsize, hash_shift;
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
-	struct index *entry, **hash;
 
-	if (!from_size || !to_size)
-		return NULL;
-	hash = delta_index(from_buf, from_size, to_size, &hash_shift);
-	if (!hash)
+	if (!trg_buf || !trg_size)
 		return NULL;
 
 	outpos = 0;
@@ -153,60 +162,55 @@ void *diff_delta(void *from_buf, unsigne
 	if (max_size && outsize >= max_size)
 		outsize = max_size + MAX_OP_SIZE + 1;
 	out = malloc(outsize);
-	if (!out) {
-		free(hash);
+	if (!out)
 		return NULL;
-	}
-
-	ref_data = from_buf;
-	ref_top = from_buf + from_size;
-	data = to_buf;
-	top = to_buf + to_size;
 
 	/* store reference buffer size */
-	out[outpos++] = from_size;
-	from_size >>= 7;
-	while (from_size) {
-		out[outpos - 1] |= 0x80;
-		out[outpos++] = from_size;
-		from_size >>= 7;
+	i = index->src_size;
+	while (i >= 0x80) {
+		out[outpos++] = i | 0x80;
+		i >>= 7;
 	}
+	out[outpos++] = i;
 
 	/* store target buffer size */
-	out[outpos++] = to_size;
-	to_size >>= 7;
-	while (to_size) {
-		out[outpos - 1] |= 0x80;
-		out[outpos++] = to_size;
-		to_size >>= 7;
+	i = trg_size;
+	while (i >= 0x80) {
+		out[outpos++] = i | 0x80;
+		i >>= 7;
 	}
+	out[outpos++] = i;
 
+	ref_data = index->src_buf;
+	ref_top = ref_data + index->src_size;
+	data = trg_buf;
+	top = trg_buf + trg_size;
+	hash_shift = index->hash_shift;
 	inscnt = 0;
 
 	while (data < top) {
 		unsigned int moff = 0, msize = 0;
-		if (data + BLK_SIZE <= top) {
-			unsigned int val = adler32(0, data, BLK_SIZE);
-			i = HASH(val, hash_shift);
-			for (entry = hash[i]; entry; entry = entry->next) {
-				const unsigned char *ref = entry->ptr;
-				const unsigned char *src = data;
-				unsigned int ref_size = ref_top - ref;
-				if (entry->val != val)
-					continue;
-				if (ref_size > top - src)
-					ref_size = top - src;
-				if (ref_size > 0x10000)
-					ref_size = 0x10000;
-				if (ref_size <= msize)
-					break;
-				while (ref_size-- && *src++ == *ref)
-					ref++;
-				if (msize < ref - entry->ptr) {
-					/* this is our best match so far */
-					msize = ref - entry->ptr;
-					moff = entry->ptr - ref_data;
-				}
+		struct index_entry *entry;
+		unsigned int val = adler32(0, data, BLK_SIZE);
+		i = HASH(val, hash_shift);
+		for (entry = index->hash[i]; entry; entry = entry->next) {
+			const unsigned char *ref = entry->ptr;
+			const unsigned char *src = data;
+			unsigned int ref_size = ref_top - ref;
+			if (entry->val != val)
+				continue;
+			if (ref_size > top - src)
+				ref_size = top - src;
+			if (ref_size > 0x10000)
+				ref_size = 0x10000;
+			if (ref_size <= msize)
+				break;
+			while (ref_size-- && *src++ == *ref)
+				ref++;
+			if (msize < ref - entry->ptr) {
+				/* this is our best match so far */
+				msize = ref - entry->ptr;
+				moff = entry->ptr - ref_data;
 			}
 		}
 
@@ -271,7 +275,6 @@ void *diff_delta(void *from_buf, unsigne
 				out = realloc(out, outsize);
 			if (!out) {
 				free(tmp);
-				free(hash);
 				return NULL;
 			}
 		}
@@ -280,7 +283,6 @@ void *diff_delta(void *from_buf, unsigne
 	if (inscnt)
 		out[outpos - inscnt - 1] = inscnt;
 
-	free(hash);
 	*delta_size = outpos;
 	return out;
 }
diff --git a/patch-delta.c b/patch-delta.c
index d95f0d9..8f318ed 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -13,8 +13,8 @@ #include <stdlib.h>
 #include <string.h>
 #include "delta.h"
 
-void *patch_delta(void *src_buf, unsigned long src_size,
-		  void *delta_buf, unsigned long delta_size,
+void *patch_delta(const void *src_buf, unsigned long src_size,
+		  const void *delta_buf, unsigned long delta_size,
 		  unsigned long *dst_size)
 {
 	const unsigned char *data, *top;
