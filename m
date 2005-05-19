From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 03:28:39 -0700
Message-ID: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 12:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYiI4-0003QD-49
	for gcvg-git@gmane.org; Thu, 19 May 2005 12:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVESKa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 06:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVESK3r
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 06:29:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39147 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261656AbVESK2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 06:28:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519102840.GCOS20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 06:28:40 -0400
To: torvalds@osdl.org, Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is stolen from the deltification patch by Nicolas Pitre.
Although the deltification patch has not been submitted for the
inclusion, the library part here is useful for the rename
detection logic in the diff work I have been doing.  The next
patch will depend on this, so if Nico is OK with this one,
please consider inclusion of this patch.  This does not include
the main part of Nico's work, which is to delitify repository
objects.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile     |    2 
delta.h      |    6 +
diff-delta.c |  330 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 337 insertions(+), 1 deletion(-)
delta.h (. --> 100644)
diff-delta.c (. --> 100644)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o diff-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
diff --git a/delta.h b/delta.h
new file mode 100644
--- /dev/null
+++ b/delta.h
@@ -0,0 +1,6 @@
+/*
+ * Copyright (c) 2005 Nicolas Pitre <nico@cam.org>
+ */
+extern void *diff_delta(void *from_buf, unsigned long from_size,
+			void *to_buf, unsigned long to_size,
+		        unsigned long *delta_size);
diff --git a/diff-delta.c b/diff-delta.c
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
------------------------------------------------

