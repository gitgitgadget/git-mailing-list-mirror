From: Junio C Hamano <junkio@cox.net>
Subject: [preview] diff-helper rename detection.
Date: Wed, 18 May 2005 19:05:28 -0700
Message-ID: <7vr7g4m0lz.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
	<7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 04:06:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYaQc-00070M-7I
	for gcvg-git@gmane.org; Thu, 19 May 2005 04:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVESCG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 22:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVESCG4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 22:06:56 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4065 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262442AbVESCFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 22:05:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519020528.YXON7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 22:05:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 11:14:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> About the built-in diff not doing the rename , I have a bit
>> longer term (knowing _my_ timescale I'd imagine you would
>> understand that is not that long ;-) plan to have -p option for
>> diff-* family to use the same rename detection logic that I
>> added to diff-helper in the patch you are commenting on.

LT> Goodie. I was hoping that was the case, but felt that the diff-helper 
LT> thing should be pretty easy to do.

This is not yet a request for inclusion but is a preview
requesting for testing and comments, especially from Linus (for
general usability comments and suggestions for cut-off-points in
heuristics) and Nico (in case I had blatantly misused the
diff-delta interface).

I stole diff-delta part from the delta support patch (but I
dropped the part that actually touches sha1_file part, hence
this does not introduce the deltified object store), and used it
as an "extent-of-damage estimator".  The rename detector logic
in the previous round was detecting exact renames only (and did
not even look at the filesystem so the raw-diff could not come
from diff-files or diff-cache without --cached), but this round
it actually checks the content.  The interim heuristics is:

  - If exact match in SHA1, or exact match comparing the files,
    then that is a rename (trivial);

  - If size changed more than 20% that cannot be a rename;

  - If delta produced by the deltification stuff between two is
    more than 20% of the original, that cannot be a rename;

  - Otherwise pick the deleted-created file pair that has the
    smallest delta between them.

I've only very lightly tested it but it seems to do the right
thing.  I fed soemthing like this when I had heavily modified
diff-helper.c (diff-helpee.c was taken from the git-ls-files
output for diff-helper.c from the cache) and lightly modified
diff.c (diffo.c was from the cache), and diffo.c -> diff.c were
reported as rename, while helpee -> helper was not.

-100644	blob	cde27275fad8103084d7ed2d08d246ba4ce6eb9c	Makefile
+100644	blob	cde27275fad8103084d7ed2d08d246ba4ce6eb9c	GNUMakefile
-100644	blob	2877ddc4df85179c03cdcc8c7a66831951ec5d97	diff-helpee.c
+100644	blob	0000000000000000000000000000000000000000	diff-helper.c
-100644	blob	74004e5a3f9fa491b30ab3d5f231826593e4eae4	diffo.c
+100644	blob	0000000000000000000000000000000000000000	diff.c

Not-signed-off-yet-by: Junio C Hamano <junkio@cox.net>
---
# - linus: merge-base: use the new lookup_commit_reference() helper function
# + 9: diff-helper detects renames with Nico's delta stuff.
diff -git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ install: $(PROG) $(SCRIPTS)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o diff-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
diff -git a/delta.h b/delta.h
new file mode 100644
--- /dev/null
+++ b/delta.h
@@ -0,0 +1,6 @@
+extern void *diff_delta(void *from_buf, unsigned long from_size,
+			void *to_buf, unsigned long to_size,
+		        unsigned long *delta_size);
+extern void *patch_delta(void *src_buf, unsigned long src_size,
+			 void *delta_buf, unsigned long delta_size,
+			 unsigned long *dst_size);
diff -git a/diff-delta.c b/diff-delta.c
new file mode 100644
--- /dev/null
+++ b/diff-delta.c
@@ -0,0 +1,330 @@
+/*
+ * diff-delta.c: generate a delta between two buffers
+ *
+ *  Many parts of this file have been lifted from LibXDiff version 0.10.
+ *  http://www.xmailserver.org/xdiff-lib.html
+ *
+ *  LibXDiff was written by Davide Libenzi <davidel@xmailserver.org>
+ *  Copyright (C) 2003	Davide Libenzi
+ *
+ *  Many mods for GIT usage by Nicolas Pitre <nico@cam.org>, (C) 2005.
+ *
+ *  This file is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ */
+
+#include <stdlib.h>
+#include "delta.h"
+
+
+/* block size: min = 16, max = 64k, power of 2 */
+#define BLK_SIZE 16
+
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#define GR_PRIME 0x9e370001
+#define HASH(v, b) (((unsigned int)(v) * GR_PRIME) >> (32 - (b)))
+	
+/* largest prime smaller than 65536 */
+#define BASE 65521
+
+/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
+#define NMAX 5552
+
+#define DO1(buf, i)  { s1 += buf[i]; s2 += s1; }
+#define DO2(buf, i)  DO1(buf, i); DO1(buf, i + 1);
+#define DO4(buf, i)  DO2(buf, i); DO2(buf, i + 2);
+#define DO8(buf, i)  DO4(buf, i); DO4(buf, i + 4);
+#define DO16(buf)    DO8(buf, 0); DO8(buf, 8);
+
+static unsigned int adler32(unsigned int adler, const unsigned char *buf, int len)
+{
+	int k;
+	unsigned int s1 = adler & 0xffff;
+	unsigned int s2 = adler >> 16;
+
+	while (len > 0) {
+		k = MIN(len, NMAX);
+		len -= k;
+		while (k >= 16) {
+			DO16(buf);
+			buf += 16;
+			k -= 16;
+		}
+		if (k != 0)
+			do {
+				s1 += *buf++;
+				s2 += s1;
+			} while (--k);
+		s1 %= BASE;
+		s2 %= BASE;
+	}
+
+	return (s2 << 16) | s1;
+}
+
+static unsigned int hashbits(unsigned int size)
+{
+	unsigned int val = 1, bits = 0;
+	while (val < size && bits < 32) {
+		val <<= 1;
+	       	bits++;
+	}
+	return bits ? bits: 1;
+}
+
+typedef struct s_chanode {
+	struct s_chanode *next;
+	int icurr;
+} chanode_t;
+
+typedef struct s_chastore {
+	chanode_t *head, *tail;
+	int isize, nsize;
+	chanode_t *ancur;
+	chanode_t *sncur;
+	int scurr;
+} chastore_t;
+
+static void cha_init(chastore_t *cha, int isize, int icount)
+{
+	cha->head = cha->tail = NULL;
+	cha->isize = isize;
+	cha->nsize = icount * isize;
+	cha->ancur = cha->sncur = NULL;
+	cha->scurr = 0;
+}
+
+static void *cha_alloc(chastore_t *cha)
+{
+	chanode_t *ancur;
+	void *data;
+
+	ancur = cha->ancur;
+	if (!ancur || ancur->icurr == cha->nsize) {
+		ancur = malloc(sizeof(chanode_t) + cha->nsize);
+		if (!ancur)
+			return NULL;
+		ancur->icurr = 0;
+		ancur->next = NULL;
+		if (cha->tail)
+			cha->tail->next = ancur;
+		if (!cha->head)
+			cha->head = ancur;
+		cha->tail = ancur;
+		cha->ancur = ancur;
+	}
+
+	data = (void *)ancur + sizeof(chanode_t) + ancur->icurr;
+	ancur->icurr += cha->isize;
+	return data;
+}
+
+static void cha_free(chastore_t *cha)
+{
+	chanode_t *cur = cha->head;
+	while (cur) {
+		chanode_t *tmp = cur;
+		cur = cur->next;
+		free(tmp);
+	}
+}
+
+typedef struct s_bdrecord {
+	struct s_bdrecord *next;
+	unsigned int fp;
+	const unsigned char *ptr;
+} bdrecord_t;
+
+typedef struct s_bdfile {
+	const unsigned char *data, *top;
+	chastore_t cha;
+	unsigned int fphbits;
+	bdrecord_t **fphash;
+} bdfile_t;
+
+static int delta_prepare(const unsigned char *buf, int bufsize, bdfile_t *bdf)
+{
+	unsigned int fphbits;
+	int i, hsize;
+	const unsigned char *base, *data, *top;
+	bdrecord_t *brec;
+	bdrecord_t **fphash;
+
+	fphbits = hashbits(bufsize / BLK_SIZE + 1);
+	hsize = 1 << fphbits;
+	fphash = malloc(hsize * sizeof(bdrecord_t *));
+	if (!fphash)
+		return -1;
+	for (i = 0; i < hsize; i++)
+		fphash[i] = NULL;
+	cha_init(&bdf->cha, sizeof(bdrecord_t), hsize / 4 + 1);
+
+	bdf->data = data = base = buf;
+	bdf->top = top = buf + bufsize;
+	data += (bufsize / BLK_SIZE) * BLK_SIZE;
+	if (data == top)
+		data -= BLK_SIZE;
+
+	for ( ; data >= base; data -= BLK_SIZE) {
+		brec = cha_alloc(&bdf->cha);
+		if (!brec) {
+			cha_free(&bdf->cha);
+			free(fphash);
+			return -1;
+		}
+		brec->fp = adler32(0, data, MIN(BLK_SIZE, top - data));
+		brec->ptr = data;
+		i = HASH(brec->fp, fphbits);
+		brec->next = fphash[i];
+		fphash[i] = brec;
+	}
+
+	bdf->fphbits = fphbits;
+	bdf->fphash = fphash;
+
+	return 0;
+}
+
+static void delta_cleanup(bdfile_t *bdf)
+{
+	free(bdf->fphash);
+	cha_free(&bdf->cha);
+}
+
+#define COPYOP_SIZE(o, s) \
+    (!!(o & 0xff) + !!(o & 0xff00) + !!(o & 0xff0000) + !!(o & 0xff000000) + \
+     !!(s & 0xff) + !!(s & 0xff00) + 1)
+
+void *diff_delta(void *from_buf, unsigned long from_size,
+		 void *to_buf, unsigned long to_size,
+		 unsigned long *delta_size)
+{
+	int i, outpos, outsize, inscnt, csize, msize, moff;
+	unsigned int fp;
+	const unsigned char *data, *top, *ptr1, *ptr2;
+	unsigned char *out, *orig;
+	bdrecord_t *brec;
+	bdfile_t bdf;
+
+	if (!from_size || !to_size || delta_prepare(from_buf, from_size, &bdf))
+		return NULL;
+	
+	outpos = 0;
+	outsize = 8192;
+	out = malloc(outsize);
+	if (!out) {
+		delta_cleanup(&bdf);
+		return NULL;
+	}
+
+	data = to_buf;
+	top = to_buf + to_size;
+
+	/* store reference buffer size */
+	orig = out + outpos++;
+	*orig = i = 0;
+	do {
+		if (from_size & 0xff) {
+			*orig |= (1 << i);
+			out[outpos++] = from_size;
+		}
+		i++;
+		from_size >>= 8;
+	} while (from_size);
+
+	/* store target buffer size */
+	orig = out + outpos++;
+	*orig = i = 0;
+	do {
+		if (to_size & 0xff) {
+			*orig |= (1 << i);
+			out[outpos++] = to_size;
+		}
+		i++;
+		to_size >>= 8;
+	} while (to_size);
+
+	inscnt = 0;
+	moff = 0;
+	while (data < top) {
+		msize = 0;
+		fp = adler32(0, data, MIN(top - data, BLK_SIZE));
+		i = HASH(fp, bdf.fphbits);
+		for (brec = bdf.fphash[i]; brec; brec = brec->next) {
+			if (brec->fp == fp) {
+				csize = bdf.top - brec->ptr;
+				if (csize > top - data)
+					csize = top - data;
+				for (ptr1 = brec->ptr, ptr2 = data; 
+				     csize && *ptr1 == *ptr2;
+				     csize--, ptr1++, ptr2++);
+
+				csize = ptr1 - brec->ptr;
+				if (csize > msize) {
+					moff = brec->ptr - bdf.data;
+					msize = csize;
+					if (msize >= 0x10000) {
+						msize = 0x10000;
+						break;
+					}
+				}
+			}
+		}
+
+		if (!msize || msize < COPYOP_SIZE(moff, msize)) {
+			if (!inscnt)
+				outpos++;
+			out[outpos++] = *data++;
+			inscnt++;
+			if (inscnt == 0x7f) {
+				out[outpos - inscnt - 1] = inscnt;
+				inscnt = 0;
+			}
+		} else {
+			if (inscnt) {
+				out[outpos - inscnt - 1] = inscnt;
+				inscnt = 0;
+			}
+
+			data += msize;
+			orig = out + outpos++;
+			i = 0x80;
+
+			if (moff & 0xff) { out[outpos++] = moff; i |= 0x01; }
+			moff >>= 8;
+			if (moff & 0xff) { out[outpos++] = moff; i |= 0x02; }
+			moff >>= 8;
+			if (moff & 0xff) { out[outpos++] = moff; i |= 0x04; }
+			moff >>= 8;
+			if (moff & 0xff) { out[outpos++] = moff; i |= 0x08; }
+
+			if (msize & 0xff) { out[outpos++] = msize; i |= 0x10; }
+			msize >>= 8;
+			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
+
+			*orig = i;
+		}
+
+		/* next time around the largest possible output is 1 + 4 + 3 */
+		if (outpos > outsize - 8) {
+			void *tmp = out;
+			outsize = outsize * 3 / 2;
+			out = realloc(out, outsize);
+			if (!out) {
+				free(tmp);
+				delta_cleanup(&bdf);
+				return NULL;
+			}
+		}
+	}
+
+	if (inscnt)
+		out[outpos - inscnt - 1] = inscnt;
+
+	delta_cleanup(&bdf);
+	*delta_size = outpos;
+	return out;
+}
diff -git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
+#include "delta.h"
 
 static int matches_pathspec(const char *name, const char **spec, int cnt)
 {
@@ -31,8 +32,14 @@ static int detect_rename = 0;
 
 static struct diff_spec_hold {
 	struct diff_spec_hold *next;
-	struct diff_spec_hold *matched;
-	struct diff_spec old, new;
+	struct diff_spec old;
+	struct diff_spec new;
+	unsigned long size;
+	int flags;
+#define MATCHED 1
+#define SHOULD_FREE 2
+#define SHOULD_MUNMAP 4
+	void *data;
 	char path[1];
 } *createdfile, *deletedfile;
 
@@ -47,101 +54,199 @@ static void hold_spec(const char *path,
 	*list = elem;
 	elem->old = *old;
 	elem->new = *new;
-	elem->matched = 0;
+	elem->size = 0;
+	elem->data = NULL;
+	elem->flags = 0;
+}
+
+/* diff_spec sha1_valid flag tells us if mode is to be trusted
+ * and if blob_sha1 is not null_sha1 then that is also to be
+ * trusted.  Here we need to know if we need to look at the file
+ * system.
+ */
+static int look_at_fs(struct diff_spec *s)
+{
+	static const unsigned char null_sha1[20] = { 0, };
+	return (!s->sha1_valid ||
+		!memcmp(null_sha1, s->blob_sha1, sizeof(null_sha1)));
+}
+
+static int populate_data(struct diff_spec_hold *s, int use_old)
+{
+	char type[20];
+	struct diff_spec *u = use_old ? &(s->old) : &(s->new);
+
+	if (!look_at_fs(u)) {
+		s->data = read_sha1_file(u->blob_sha1, type, &s->size);
+		s->flags |= SHOULD_FREE;
+	}
+	else {
+		struct stat st;
+		int fd;
+		fd = open(s->path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		if (fstat(fd, &st)) {
+			close(fd);
+			return -1;
+		}
+		s->size = st.st_size;
+		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+		if (!s->size)
+			s->data = "";
+		else
+			s->flags |= SHOULD_MUNMAP;
+	}
+	return 0;
+}
+
+static void free_data(struct diff_spec_hold *s)
+{
+	if (s->flags & SHOULD_FREE)
+		free(s->data);
+	else if (s->flags & SHOULD_MUNMAP)
+		munmap(s->data, s->size);
+	s->flags &= ~(SHOULD_FREE|SHOULD_MUNMAP);
+}
+
+static void flush_rest(struct diff_spec_hold *elem,
+		       const char **spec, int cnt, int reverse)
+{
+	for ( ; elem ; elem = elem->next) {
+		free_data(elem);
+		if (elem->flags & MATCHED)
+			continue;
+		if (!cnt ||
+		    matches_pathspec(elem->path, spec, cnt)) {
+			if (reverse)
+				run_external_diff(elem->path, NULL,
+						  &elem->new, &elem->old);
+			else
+				run_external_diff(elem->path, NULL,
+						  &elem->old, &elem->new);
+		}
+	}
 }
 
-#define MINIMUM_SCORE 7000
-int estimate_similarity(struct diff_spec *one, struct diff_spec *two)
+#define EXACT_MATCH  10000
+#define MINIMUM_SCORE 5000
+int estimate_similarity(struct diff_spec_hold *src,
+			struct diff_spec_hold *dst,
+			int expect)
 {
-	/* Return how similar they are, representing the score as an
-	 * integer between 0 and 10000.
+	/* src points at a deleted file (src->old) and dst points at
+	 * a created file (dst->new).  They may be quite similar in which
+	 * case we want to say src->old is renamed to dst->new.
 	 *
-	 * This version is very dumb and detects exact matches only.
-	 * Wnen Nico's delta stuff gets in, I'll use the delta
-	 * algorithm to estimate the similarity score in core.
+	 * Compare them and return how similar they are, representing
+	 * the score as an integer between 0 and 10000.  10000 is
+	 * reserved for the case where they match exactly.
 	 */
+	void *delta;
+	unsigned long delta_size;
 
-	if (one->sha1_valid && two->sha1_valid &&
-	    !memcmp(one->blob_sha1, two->blob_sha1, 20))
+	if (!look_at_fs(&(src->old)) && !look_at_fs(&(dst->new)) &&
+	    !memcmp(src->old.blob_sha1, dst->new.blob_sha1, 20))
 		return 10000;
-	return 0;
+	if (populate_data(src, 1) || populate_data(dst, 0))
+		/* this is an error but will be caught downstream */
+		return 0;
+	if (src->size == dst->size &&
+	    !memcmp(src->data, dst->data, src->size))
+		return 10000;
+
+	if (expect == EXACT_MATCH)
+		return 0;
+
+	delta_size = ((src->size < dst->size) ?
+		      (dst->size - src->size) : (src->size - dst->size));
+
+	/* We would not consider rename followed by more than
+	 * 20% edits; that is, delta_size must be smaller than
+	 * (src->size + dst->size)/2 * 0.2, which means...
+	 */
+	if ((src->size + dst->size) < delta_size * 10)
+		return 0;
+
+	delta = diff_delta(src->data, src->size,
+			   dst->data, dst->size,
+			   &delta_size);
+	free(delta);
+
+	/* This "delta" is really xdiff with adler32 and all the
+	 * overheads but it is a quick and dirty approximation.
+	 * Again, we say there should be less than 20% edit.
+	 */
+	if ((src->size + dst->size) < delta_size * 10)
+		return 0;
+
+	/* Now we will give some score to it.  Let's say 20% edit gets
+	 * 5000 points and 0% edit gets 9000 points.  That is, every
+	 * 1/20000 edit gets 1 point penalty.  The amount of penalty is:
+	 *
+	 * (delta_size * 2 / (src->size + dst->size)) * 20000
+	 *
+	 */
+	return 9000 - (40000 * delta_size / (src->size+dst->size));
 }
 
-static void flush_renames(const char **spec, int cnt, int reverse)
+static void flush_rename_pairs(int floor_score,
+			       const char **spec, int cnt, int reverse)
 {
-	struct diff_spec_hold *rename_src, *rename_dst, *elem;
-	struct diff_spec_hold *leftover = NULL;
+	struct diff_spec_hold *src, *dst, *elem;
 	int score, best_score;
 
-	while (createdfile) {
-		rename_dst = createdfile;
-		createdfile = rename_dst->next;
-		best_score = MINIMUM_SCORE;
-		rename_src = NULL;
-		for (elem = deletedfile;
-		     elem;
-		     elem = elem->next) {
-			if (elem->matched)
+	for (dst = createdfile; dst; dst = dst->next) {
+		if (dst->flags & MATCHED)
+			continue;
+
+		best_score = floor_score;
+		src = NULL;
+		for (elem = deletedfile; elem; elem = elem->next) {
+			if (elem->flags & MATCHED)
 				continue;
-			score = estimate_similarity(&elem->old,
-						    &rename_dst->new);
-			if (best_score < score) {
-				rename_src = elem;
+			score = estimate_similarity(elem, dst, best_score);
+			if (best_score <= score) {
+				src = elem;
 				best_score = score;
 			}
 		}
-		if (rename_src) {
-			rename_src->matched = rename_dst;
-			rename_dst->matched = rename_src;
+		if (src) {
+			src->flags |= MATCHED;
+			dst->flags |= MATCHED;
+			free_data(src);
+			free_data(dst);
 
 			if (!cnt ||
-			    matches_pathspec(rename_src->path, spec, cnt) ||
-			    matches_pathspec(rename_dst->path, spec, cnt)) {
+			    matches_pathspec(src->path, spec, cnt) ||
+			    matches_pathspec(dst->path, spec, cnt)) {
 				if (reverse)
-					run_external_diff(rename_dst->path,
-							  rename_src->path,
-							  &rename_dst->new,
-							  &rename_src->old);
+					run_external_diff(dst->path,
+							  src->path,
+							  &dst->new,
+							  &src->old);
 				else
-					run_external_diff(rename_src->path,
-							  rename_dst->path,
-							  &rename_src->old,
-							  &rename_dst->new);
+					run_external_diff(src->path,
+							  dst->path,
+							  &src->old,
+							  &dst->new);
 			}
 		}
-		else {
-			rename_dst->next = leftover;
-			leftover = rename_dst;
-		}
 	}
+}
 
-	/* unmatched deletes */
-	for (elem = deletedfile; elem; elem = elem->next) {
-		if (elem->matched)
-			continue;
-		if (!cnt ||
-		    matches_pathspec(elem->path, spec, cnt)) {
-			if (reverse)
-				run_external_diff(elem->path, NULL,
-						  &elem->new, &elem->old);
-			else
-				run_external_diff(elem->path, NULL,
-						  &elem->old, &elem->new);
-		}
-	}
+static void flush_renames(const char **spec, int cnt, int reverse)
+{
+	/* We do this in two steps; first we pick up the exact matches
+	 * only and then closest match
+	 */
 
-	/* unmatched creates */
-	for (elem = leftover; elem; elem = elem->next) {
-		if (!cnt ||
-		    matches_pathspec(elem->path, spec, cnt)) {
-			if (reverse)
-				run_external_diff(elem->path, NULL,
-						  &elem->new, &elem->old);
-			else
-				run_external_diff(elem->path, NULL,
-						  &elem->old, &elem->new);
-		}
-	}
+	flush_rename_pairs(EXACT_MATCH, spec, cnt, reverse);
+	flush_rename_pairs(MINIMUM_SCORE, spec, cnt, reverse);
+
+	flush_rest(createdfile, spec, cnt, reverse);
+	flush_rest(deletedfile, spec, cnt, reverse);
 }
 
 static int parse_oneside_change(const char *cp, struct diff_spec *one,
diff -git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -329,7 +329,7 @@ void run_external_diff(const char *name,
 		die("unable to fork");
 	if (!pid) {
 		const char *pgm = external_diff();
-		/* not passing rename patch to external ones */
+		/* NEEDSWORK: not passing rename patch to external ones */
 		if (!other && pgm) {
 			if (one && two)
 				execlp(pgm, pgm,

