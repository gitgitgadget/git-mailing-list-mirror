From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: big code simplification
Date: Tue, 21 Feb 2006 20:43:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602212041480.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:43:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBj2K-0001sp-5s
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWBVBnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWBVBnT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:43:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41945 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932497AbWBVBnS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:43:18 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV2003LIFG5WY30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Feb 2006 20:43:17 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16581>


This is much smaller and hopefully clearer code now.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

 diff-delta.c |  235 +++++++++++++++++++++-------------------------------------
 1 files changed, 87 insertions(+), 148 deletions(-)

167f85034d634944e90f6bff683d74ec680bb331
diff --git a/diff-delta.c b/diff-delta.c
index ac992e2..2ed5984 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -19,8 +19,9 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
+#include <zlib.h>
 #include "delta.h"
-#include "zlib.h"
 
 
 /* block size: min = 16, max = 64k, power of 2 */
@@ -29,123 +30,54 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 
 #define GR_PRIME 0x9e370001
-#define HASH(v, b) (((unsigned int)(v) * GR_PRIME) >> (32 - (b)))
-	
-static unsigned int hashbits(unsigned int size)
-{
-	unsigned int val = 1, bits = 0;
-	while (val < size && bits < 32) {
-		val <<= 1;
-	       	bits++;
-	}
-	return bits ? bits: 1;
-}
-
-typedef struct s_chanode {
-	struct s_chanode *next;
-	int icurr;
-} chanode_t;
-
-typedef struct s_chastore {
-	int isize, nsize;
-	chanode_t *ancur;
-} chastore_t;
-
-static void cha_init(chastore_t *cha, int isize, int icount)
-{
-	cha->isize = isize;
-	cha->nsize = icount * isize;
-	cha->ancur = NULL;
-}
-
-static void *cha_alloc(chastore_t *cha)
-{
-	chanode_t *ancur;
-	void *data;
-
-	ancur = cha->ancur;
-	if (!ancur || ancur->icurr == cha->nsize) {
-		ancur = malloc(sizeof(chanode_t) + cha->nsize);
-		if (!ancur)
-			return NULL;
-		ancur->icurr = 0;
-		ancur->next = cha->ancur;
-		cha->ancur = ancur;
-	}
-
-	data = (void *)ancur + sizeof(chanode_t) + ancur->icurr;
-	ancur->icurr += cha->isize;
-	return data;
-}
-
-static void cha_free(chastore_t *cha)
-{
-	chanode_t *cur = cha->ancur;
-	while (cur) {
-		chanode_t *tmp = cur;
-		cur = cur->next;
-		free(tmp);
-	}
-}
+#define HASH(v, shift) (((unsigned int)(v) * GR_PRIME) >> (shift))
 
-typedef struct s_bdrecord {
-	struct s_bdrecord *next;
-	unsigned int fp;
+struct index {
 	const unsigned char *ptr;
-} bdrecord_t;
-
-typedef struct s_bdfile {
-	chastore_t cha;
-	unsigned int fphbits;
-	bdrecord_t **fphash;
-} bdfile_t;
-
-static int delta_prepare(const unsigned char *buf, int bufsize, bdfile_t *bdf)
-{
-	unsigned int fphbits;
-	int i, hsize;
-	const unsigned char *data, *top;
-	bdrecord_t *brec;
-	bdrecord_t **fphash;
-
-	fphbits = hashbits(bufsize / BLK_SIZE + 1);
-	hsize = 1 << fphbits;
-	fphash = malloc(hsize * sizeof(bdrecord_t *));
-	if (!fphash)
-		return -1;
-	for (i = 0; i < hsize; i++)
-		fphash[i] = NULL;
-	cha_init(&bdf->cha, sizeof(bdrecord_t), hsize / 4 + 1);
-
-	top = buf + bufsize;
-	data = buf + (bufsize / BLK_SIZE) * BLK_SIZE;
-	if (data == top)
+	unsigned int val;
+	struct index *next;
+};
+
+static struct index ** delta_index(const unsigned char *buf,
+				   unsigned long bufsize,
+				   unsigned int *hash_shift)
+{
+	unsigned int hsize, hshift, entries, blksize, i;
+	const unsigned char *data;
+	struct index *entry, **hash;
+	void *mem;
+
+	/* determine index hash size */
+	entries = (bufsize + BLK_SIZE - 1) / BLK_SIZE;
+	hsize = entries / 4;
+	for (i = 4; (1 << i) < hsize && i < 16; i++);
+	hsize = 1 << i;
+	hshift = 32 - i;
+	*hash_shift = hshift;
+
+	/* allocate lookup index */
+	mem = malloc(hsize * sizeof(*hash) + entries * sizeof(*entry));
+	if (!mem)
+		return NULL;
+	hash = mem;
+	entry = mem + hsize * sizeof(*hash);
+	memset(hash, 0, hsize * sizeof(*hash));
+
+	/* then populate it */
+	data = buf + entries * BLK_SIZE - BLK_SIZE;
+	blksize = bufsize - (data - buf);
+	while (data >= buf) {
+		unsigned int val = adler32(0, data, blksize);
+		i = HASH(val, hshift);
+		entry->ptr = data;
+		entry->val = val;
+		entry->next = hash[i];
+		hash[i] = entry++;
+		blksize = BLK_SIZE;
 		data -= BLK_SIZE;
+ 	}
 
-	for ( ; data >= buf; data -= BLK_SIZE) {
-		brec = cha_alloc(&bdf->cha);
-		if (!brec) {
-			cha_free(&bdf->cha);
-			free(fphash);
-			return -1;
-		}
-		brec->fp = adler32(0, data, MIN(BLK_SIZE, top - data));
-		brec->ptr = data;
-		i = HASH(brec->fp, fphbits);
-		brec->next = fphash[i];
-		fphash[i] = brec;
-	}
-
-	bdf->fphbits = fphbits;
-	bdf->fphash = fphash;
-
-	return 0;
-}
-
-static void delta_cleanup(bdfile_t *bdf)
-{
-	free(bdf->fphash);
-	cha_free(&bdf->cha);
+	return hash;
 }
 
 /* provide the size of the copy opcode given the block offset and size */
@@ -161,23 +93,24 @@ void *diff_delta(void *from_buf, unsigne
 		 unsigned long *delta_size,
 		 unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, inscnt, csize, msize, moff;
-	unsigned int fp;
-	const unsigned char *ref_data, *ref_top, *data, *top, *ptr1, *ptr2;
-	unsigned char *out, *orig;
-	bdrecord_t *brec;
-	bdfile_t bdf;
+	unsigned int i, outpos, outsize, inscnt, hash_shift;
+	const unsigned char *ref_data, *ref_top, *data, *top;
+	unsigned char *out;
+	struct index *entry, **hash;
 
-	if (!from_size || !to_size || delta_prepare(from_buf, from_size, &bdf))
+	if (!from_size || !to_size)
+		return NULL;
+	hash = delta_index(from_buf, from_size, &hash_shift);
+	if (!hash)
 		return NULL;
-	
+
 	outpos = 0;
 	outsize = 8192;
 	if (max_size && outsize >= max_size)
 		outsize = max_size + MAX_OP_SIZE + 1;
 	out = malloc(outsize);
 	if (!out) {
-		delta_cleanup(&bdf);
+		free(hash);
 		return NULL;
 	}
 
@@ -205,28 +138,32 @@ void *diff_delta(void *from_buf, unsigne
 	}
 
 	inscnt = 0;
-	moff = 0;
+
 	while (data < top) {
-		msize = 0;
-		fp = adler32(0, data, MIN(top - data, BLK_SIZE));
-		i = HASH(fp, bdf.fphbits);
-		for (brec = bdf.fphash[i]; brec; brec = brec->next) {
-			if (brec->fp == fp) {
-				csize = ref_top - brec->ptr;
-				if (csize > top - data)
-					csize = top - data;
-				for (ptr1 = brec->ptr, ptr2 = data; 
-				     csize && *ptr1 == *ptr2;
-				     csize--, ptr1++, ptr2++);
-
-				csize = ptr1 - brec->ptr;
-				if (csize > msize) {
-					moff = brec->ptr - ref_data;
-					msize = csize;
-					if (msize >= 0x10000) {
-						msize = 0x10000;
-						break;
-					}
+		unsigned int moff = 0, msize = 0;
+		unsigned int blksize = MIN(top - data, BLK_SIZE);
+		unsigned int val = adler32(0, data, blksize);
+		i = HASH(val, hash_shift);
+		for (entry = hash[i]; entry; entry = entry->next) {
+			const unsigned char *ref = entry->ptr;
+			const unsigned char *src = data;
+			unsigned int ref_size = ref_top - ref;
+			if (entry->val != val)
+				continue;
+			if (ref_size > top - src)
+				ref_size = top - src;
+			while (ref_size && *src++ == *ref) {
+				ref++;
+				ref_size--;
+			}
+			ref_size = ref - entry->ptr;
+			if (ref_size > msize) {
+				/* this is our best match so far */
+				moff = entry->ptr - ref_data;
+				msize = ref_size;
+				if (msize >= 0x10000) {
+					msize = 0x10000;
+					break;
 				}
 			}
 		}
@@ -241,13 +178,15 @@ void *diff_delta(void *from_buf, unsigne
 				inscnt = 0;
 			}
 		} else {
+			unsigned char *op;
+
 			if (inscnt) {
 				out[outpos - inscnt - 1] = inscnt;
 				inscnt = 0;
 			}
 
 			data += msize;
-			orig = out + outpos++;
+			op = out + outpos++;
 			i = 0x80;
 
 			if (moff & 0xff) { out[outpos++] = moff; i |= 0x01; }
@@ -262,7 +201,7 @@ void *diff_delta(void *from_buf, unsigne
 			msize >>= 8;
 			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
 
-			*orig = i;
+			*op = i;
 		}
 
 		if (outpos >= outsize - MAX_OP_SIZE) {
@@ -276,7 +215,7 @@ void *diff_delta(void *from_buf, unsigne
 				out = realloc(out, outsize);
 			if (!out) {
 				free(tmp);
-				delta_cleanup(&bdf);
+				free(hash);
 				return NULL;
 			}
 		}
@@ -285,7 +224,7 @@ void *diff_delta(void *from_buf, unsigne
 	if (inscnt)
 		out[outpos - inscnt - 1] = inscnt;
 
-	delta_cleanup(&bdf);
+	free(hash);
 	*delta_size = outpos;
 	return out;
 }
-- 
1.2.2.g6643-dirty
