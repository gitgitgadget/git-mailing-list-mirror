From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 11:56:18 -0400
Message-ID: <200505041156.19499.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org> <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jCPeCKamiGmt7gh"
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 17:53:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTMAb-0007yZ-Ti
	for gcvg-git@gmane.org; Wed, 04 May 2005 17:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVEDP6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 11:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVEDP6l
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 11:58:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64478 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261892AbVEDP40 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 11:56:26 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 646069EAC;
	Wed,  4 May 2005 17:56:25 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 98BC1150D20; Wed,  4 May 2005 17:56:23 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_jCPeCKamiGmt7gh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 03 May 2005 04:06, Nicolas Pitre wrote:
> On Mon, 2 May 2005, Linus Torvalds wrote:
> > If you do something like this, you want such a delta-blob to be named by
> > the sha1 of the result, so that things that refer to it can transparently
> > see either the original blob _or_ the "deltified" one, and will never
> > care.
>
> Yep, that's what I've done last weekend (and just made it actually
> work since people are getting interested).
>

My first run didn't go well, diff_delta generates an invalid delta when passed 
a buffer of length 0.  I really should not have been calling it this way, but 
it should do a quick check and return an error instead of something 
invalid ;)

I did two additional runs, first where I fixed the delta chain length at 1 as 
in the zdelta patch.   In this mode, if it tried to diff against a delta it 
would find the delta's parent and diff against that instead.  Even though 
zdelta had the same speeds for applying patches as xdiff(1), zdelta used 
significantly more cpu (53m vs 40m).

The next run was with the patch I've attached below, it allows chains up to 16 
deltas in length.  
                             git         zdelta       xdiff (1)      xdiff(16)
apply                  150m       117m       117m         104m
checkout             4m30s      3m41      4m43s        7m11s
checkout (hot)     56s           12s         14s             16s
space usage        2.5G         1G           1.2G           800m

The longer delta chains trigger more random io on checkout, negating the speed 
improvements from the packed item patch.  The hot cache times show that xdiff 
isn't using a huge amount of cpu to patch things in, and so there's room for 
smarter packing and regenerating deltas in order to keep checkout times low.  
This patch still doesn't pack commits and trees in with the blob files, and 
it doesn't delta trees, and so I expect better space/speed numbers in later 
revs.

I won't be able to work on this until next week, but here's my plan:

1) update to current git.  My patch is from before the safe file generation 
changes.

2) change update-cache and write-tree so that packing/deltas are off by 
default.  Add --packed and --delta options to both.

3) create a git-pack tool that can pack/unpack existing changesets,trees and 
files, optionally adding/removing deltas.

My current code should preserve the delta object header used by Nicolas, and 
removes all knowledge of deltas from the packed item headers.  This is not 
quite as efficient, but the resulting code is much cleaner.  I haven't tried, 
but it should be able to read a file created by his mkdelta.c.

-chris

--Boundary-00=_jCPeCKamiGmt7gh
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="delta-tree-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delta-tree-3.diff"

diff -urN --exclude .git linus.diff/cache.h linus.mine/cache.h
--- linus.diff/cache.h	2005-05-04 09:54:49.154735216 -0400
+++ linus.mine/cache.h	2005-05-04 08:47:28.618990016 -0400
@@ -64,6 +64,16 @@
 	char name[0];
 };
 
+struct packed_item {
+	/* length of compressed data */
+	unsigned long len;
+	struct packed_item *next;
+	/* sha1 of uncompressed data */
+	char sha1[20];
+	/* compressed data */
+	char *data;
+};
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_STAGESHIFT 12
@@ -119,8 +129,9 @@
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
+extern void * unpack_sha1_file(const unsigned char *sha1, void *map, unsigned long mapsize, char *type, unsigned long *size, int *chain);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern void * read_sha1_delta_ref(const unsigned char *sha1, char *type, unsigned long *size, int *chain);
 extern int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
@@ -135,6 +146,10 @@
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int pack_sha1_buffer(void *buf, unsigned long buf_len, char *type,
+                            unsigned char *returnsha1, unsigned char *refsha1, 
+			    struct packed_item **);
+int write_packed_buffer(struct packed_item *head);
 
 /* General helper functions */
 extern void usage(const char *err);
diff -urN --exclude .git linus.diff/delta.h linus.mine/delta.h
--- linus.diff/delta.h	1969-12-31 19:00:00.000000000 -0500
+++ linus.mine/delta.h	2005-05-03 08:22:32.000000000 -0400
@@ -0,0 +1,6 @@
+extern void *diff_delta(void *from_buf, unsigned long from_size,
+			void *to_buf, unsigned long to_size,
+		        unsigned long *delta_size);
+extern void *patch_delta(void *src_buf, unsigned long src_size,
+			 void *delta_buf, unsigned long delta_size,
+			 unsigned long *dst_size);
diff -urN --exclude .git linus.diff/diff-delta.c linus.mine/diff-delta.c
--- linus.diff/diff-delta.c	1969-12-31 19:00:00.000000000 -0500
+++ linus.mine/diff-delta.c	2005-05-03 12:40:58.000000000 -0400
@@ -0,0 +1,315 @@
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
+	if (delta_prepare(from_buf, from_size, &bdf))
+		return NULL;
+	
+	outpos = 0;
+	outsize = 4096;
+	out = malloc(outsize);
+	if (!out) {
+		delta_cleanup(&bdf);
+		return NULL;
+	}
+
+	data = to_buf;
+	top = to_buf + to_size;
+
+	out[outpos++] = from_size; from_size >>= 8;
+	out[outpos++] = from_size; from_size >>= 8;
+	out[outpos++] = from_size; from_size >>= 8;
+	out[outpos++] = from_size;
+	out[outpos++] = to_size; to_size >>= 8;
+	out[outpos++] = to_size; to_size >>= 8;
+	out[outpos++] = to_size; to_size >>= 8;
+	out[outpos++] = to_size;
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
diff -urN --exclude .git linus.diff/fsck-cache.c linus.mine/fsck-cache.c
--- linus.diff/fsck-cache.c	2005-05-04 09:54:49.158734608 -0400
+++ linus.mine/fsck-cache.c	2005-05-04 08:44:49.778137496 -0400
@@ -142,7 +142,7 @@
 		if (map) {
 			char type[100];
 			unsigned long size;
-			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+			void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size, NULL);
 			if (!buffer)
 				return -1;
 			if (check_sha1_signature(sha1, buffer, size, type) < 0)
diff -urN --exclude .git linus.diff/git-mktag.c linus.mine/git-mktag.c
--- linus.diff/git-mktag.c	2005-05-04 09:54:49.158734608 -0400
+++ linus.mine/git-mktag.c	2005-05-04 08:45:04.763859320 -0400
@@ -31,7 +31,7 @@
 	if (map) {
 		char type[100];
 		unsigned long size;
-		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+		void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size, NULL);
 
 		if (buffer) {
 			if (!strcmp(type, expected_type))
diff -urN --exclude .git linus.diff/Makefile linus.mine/Makefile
--- linus.diff/Makefile	2005-05-04 09:54:49.153735368 -0400
+++ linus.mine/Makefile	2005-05-03 16:28:15.000000000 -0400
@@ -25,7 +25,8 @@
 install: $(PROG) $(SCRIPTS)
 	install $(PROG) $(SCRIPTS) $(HOME)/bin/
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o diff-delta.o \
+	 patch-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
diff -urN --exclude .git linus.diff/patch-delta.c linus.mine/patch-delta.c
--- linus.diff/patch-delta.c	1969-12-31 19:00:00.000000000 -0500
+++ linus.mine/patch-delta.c	2005-05-04 09:57:53.520707328 -0400
@@ -0,0 +1,80 @@
+/*
+ * patch-delta.c:
+ * recreate a buffer from a source and the delta produced by diff-delta.c
+ *
+ * (C) 2005 Nicolas Pitre <nico@cam.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include "delta.h"
+
+void *patch_delta(void *src_buf, unsigned long src_size,
+		  void *delta_buf, unsigned long delta_size,
+		  unsigned long *dst_size)
+{
+	const unsigned char *data, *top;
+	unsigned char *dst, *out;
+	int size;
+
+	/* the smallest delta size possible is 10 bytes */
+	if (delta_size < 10) {
+		return NULL;
+	}
+	data = delta_buf;
+	top = delta_buf + delta_size;
+
+	/* make sure the orig file size matches what we expect */
+	size = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	data += 4;
+	if (size != src_size) {
+		return NULL;
+	}
+	/* now the result size */
+	size = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	data += 4;
+	dst = malloc(size);
+	if (!dst) {
+		return NULL;
+	}
+	out = dst;
+	while (data < top) {
+		unsigned char cmd = *data++;
+		if (cmd & 0x80) {
+			unsigned int cp_off = 0, cp_size = 0;
+			if (cmd & 0x01) cp_off = *data++;
+			if (cmd & 0x02) cp_off |= (*data++ << 8);
+			if (cmd & 0x04) cp_off |= (*data++ << 16);
+			if (cmd & 0x08) cp_off |= (*data++ << 24);
+			if (cmd & 0x10) cp_size = *data++;
+			if (cmd & 0x20) cp_size |= (*data++ << 8);
+			if (cp_size == 0) cp_size = 0x10000;
+			memcpy(out, src_buf + cp_off, cp_size);
+			out += cp_size;
+			if (out > dst + size) {
+				*(char *)0 = 0;
+			}
+		} else {
+			memcpy(out, data, cmd);
+			out += cmd;
+			data += cmd;
+			if (out > dst + size) {
+				*(char *)0 = 0;
+			}
+		}
+	}
+
+	/* sanity check */
+	if (data != top || out - dst != size) {
+		free(dst);
+		return NULL;
+	}
+
+	*dst_size = size;
+	return dst;
+}
diff -urN --exclude .git linus.diff/sha1_file.c linus.mine/sha1_file.c
--- linus.diff/sha1_file.c	2005-05-04 09:54:49.165733544 -0400
+++ linus.mine/sha1_file.c	2005-05-04 10:42:07.002316808 -0400
@@ -8,6 +8,7 @@
  */
 #include <stdarg.h>
 #include "cache.h"
+#include "delta.h"
 
 const char *sha1_file_directory = NULL;
 
@@ -139,39 +140,117 @@
 	return map;
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+/*
+ * looks through buf for the header entry corresponding to sha1.  returns
+ * 0 an entry is found and sets offset to the offset of the packed item
+ * in the file.  The offset is relative to the start of the packed items
+ * so you have to add in the length of the header before using it
+ * -1 is returned if the sha1 could not be found
+ */
+static int find_packed_header(const unsigned char *sha1, char *buf, unsigned long buf_len, unsigned long *offset)
+{
+	char *p;
+	p = buf;
+
+	*offset = 0;
+	while(p < buf + buf_len) {
+		unsigned long item_len;
+		unsigned char item_sha[20];
+		memcpy(item_sha, p, 20);
+		sscanf(p + 20, "%lu", &item_len);
+		p += 20 + strlen(p + 20) + 1;
+		if (memcmp(item_sha, sha1, 20) == 0)
+			return 0;
+		*offset += item_len;
+	}
+	return -1;
+}
+
+
+/*
+ * uncompresses a data segment without any extra delta/packed processing
+ */
+static void * _unpack_sha1_file(z_stream *stream, void *map, 
+                                unsigned long mapsize, char *type, 
+				unsigned long *size)
 {
 	int ret, bytes;
-	z_stream stream;
 	char buffer[8192];
 	char *buf;
 
 	/* Get the data stream */
-	memset(&stream, 0, sizeof(stream));
-	stream.next_in = map;
-	stream.avail_in = mapsize;
-	stream.next_out = buffer;
-	stream.avail_out = sizeof(buffer);
-
-	inflateInit(&stream);
-	ret = inflate(&stream, 0);
-	if (ret < Z_OK)
+	memset(stream, 0, sizeof(*stream));
+	stream->next_in = map;
+	stream->avail_in = mapsize;
+	stream->next_out = buffer;
+	stream->avail_out = sizeof(buffer);
+
+	inflateInit(stream);
+	ret = inflate(stream, 0);
+	if (ret < Z_OK) {
 		return NULL;
-	if (sscanf(buffer, "%10s %lu", type, size) != 2)
+	}
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
 		return NULL;
-
+	}
 	bytes = strlen(buffer) + 1;
 	buf = xmalloc(*size);
 
-	memcpy(buf, buffer + bytes, stream.total_out - bytes);
-	bytes = stream.total_out - bytes;
+	memcpy(buf, buffer + bytes, stream->total_out - bytes);
+	bytes = stream->total_out - bytes;
 	if (bytes < *size && ret == Z_OK) {
-		stream.next_out = buf + bytes;
-		stream.avail_out = *size - bytes;
-		while (inflate(&stream, Z_FINISH) == Z_OK)
+		stream->next_out = buf + bytes;
+		stream->avail_out = *size - bytes;
+		while (inflate(stream, Z_FINISH) == Z_OK)
 			/* nothing */;
 	}
-	inflateEnd(&stream);
+	inflateEnd(stream);
+	return buf;
+}
+
+void * unpack_sha1_file(const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size, 
+			int *chain)
+{
+	z_stream stream;
+	char *buf;
+	unsigned long offset;
+	unsigned long header_len;
+	buf = _unpack_sha1_file(&stream, map, mapsize, type, size);
+	if (!buf)
+		return buf;
+	if (!strcmp(type, "delta")) {
+		char *delta_ref;
+		unsigned long delta_size;
+		char *newbuf;
+		unsigned long newsize;
+		if (chain)
+			*chain += 1;
+		delta_ref = read_sha1_delta_ref(buf, type, &delta_size, chain);
+		if (!delta_ref) {
+			free(buf);
+			return NULL;
+		}
+		newbuf = patch_delta(delta_ref, delta_size, buf+20, *size-20, &newsize);
+		free(buf);
+		free(delta_ref);
+		*size = newsize;
+		return newbuf;
+
+	} else if (!strcmp(type, "packed")) {
+		if (!sha1) {
+			free(buf);
+			return NULL;
+		}
+		header_len = *size;
+		if (find_packed_header(sha1, buf, header_len, &offset)) {
+			free(buf);
+			return NULL;
+		}
+		offset += stream.total_in;
+		free(buf);
+		buf = unpack_sha1_file(sha1, map+offset, mapsize-offset, type, size, chain);
+	}
 	return buf;
 }
 
@@ -182,7 +261,25 @@
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size, NULL);
+		munmap(map, mapsize);
+		return buf;
+	}
+	return NULL;
+}
+
+/*
+ * the same as read_sha1_file except chain is used to count the length
+ * of any delta chains hit while unpacking
+ */
+void * read_sha1_delta_ref(const unsigned char *sha1, char *type, unsigned long *size, int *chain)
+{
+	unsigned long mapsize;
+	void *map, *buf;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size, chain);
 		munmap(map, mapsize);
 		return buf;
 	}
@@ -413,3 +510,306 @@
 		return 1;
 	return 0;
 }
+
+static void *pack_buffer(void *buf, unsigned long buf_len, char *metadata, int metadata_size, unsigned long *compsize)
+{
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	size = deflateBound(&stream, buf_len + metadata_size);
+	compressed = xmalloc(size);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.next_in = metadata;
+	stream.avail_in = metadata_size;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	stream.next_in = buf;
+	stream.avail_in = buf_len;
+	/* Compress it */
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	size = stream.total_out;
+	*compsize = size;
+	return compressed;
+}
+
+/*
+ * generates a delta for buf against refsha1 and returns a compressed buffer
+ * with the results.  NULL is returned on error, or when the delta could
+ * not be done.  This might happen if the delta is larger then either the
+ * refsha1 or the buffer, or the delta chain is too long.
+ */
+static void *pack_delta_buffer(void *buf, unsigned long buf_len, char *metadata, int metadata_size, unsigned long *compsize, unsigned char *sha1, unsigned char *refsha1)
+{
+	char *compressed;
+	char *refbuffer = NULL;
+	char reftype[20];
+	unsigned long refsize = 0;
+	char *delta;
+	unsigned long delta_size;
+	char *lmetadata = xmalloc(220);
+	unsigned long lmetadata_size;
+	int chain_length = 0;
+
+	if (buf_len == 0)
+		return NULL;
+	refbuffer = read_sha1_delta_ref(refsha1, reftype, &refsize, &chain_length);
+
+	if (chain_length > 16) {
+		free(refbuffer);
+		return NULL;
+	}
+	/* note, we could just continue without the delta here */
+	if (!refbuffer) {
+		free(refbuffer);
+		return NULL;
+	}
+	delta = diff_delta(refbuffer, refsize, buf, buf_len, &delta_size);
+	free(refbuffer);
+	if (!delta)
+		return NULL;
+	if (delta_size > refsize || delta_size > buf_len) {
+		free(delta);
+		return NULL;
+	}
+	if (delta_size < 10) {
+		free(delta);
+		return NULL;
+	}
+	lmetadata_size = 1 + sprintf(lmetadata, "%s %lu","delta",delta_size+20);
+	memcpy(lmetadata + lmetadata_size, refsha1, 20);
+	lmetadata_size += 20;
+	compressed = pack_buffer(delta, delta_size, lmetadata, lmetadata_size, compsize);
+	free(lmetadata);
+	free(delta);
+	return compressed;
+}
+
+/*
+ * returns a newly malloc'd packed item with a compressed buffer for buf.  
+ * If refsha1 is non-null, attempts a delta against it.  The sha1 of buf 
+ * is returned via returnsha1.
+ */
+int pack_sha1_buffer(void *buf, unsigned long buf_len, char *type,
+		     unsigned char *returnsha1,
+		     unsigned char *refsha1,
+		     struct packed_item **packed_item)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	struct stat st;
+	char *compressed = NULL;
+	unsigned long size;
+	struct packed_item *item;
+	char *metadata = xmalloc(200);
+	int metadata_size;
+
+	*packed_item = NULL;
+
+	metadata_size = 1 + sprintf(metadata, "%s %lu", type, buf_len);
+
+	/* Sha1.. */
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, buf, buf_len);
+	SHA1_Final(sha1, &c);
+
+	if (returnsha1)
+		memcpy(returnsha1, sha1, 20);
+
+	filename = sha1_file_name(sha1);
+	if (stat(filename, &st) == 0)
+		goto out;
+
+	
+	if (refsha1) {
+		compressed = pack_delta_buffer(buf, buf_len, metadata, 
+		                               metadata_size, &size, sha1, 
+					       refsha1);
+	}
+	if (!compressed) {
+		compressed = pack_buffer(buf, buf_len, metadata, 
+		                         metadata_size, &size);
+	}
+	free(metadata);
+	if (!compressed) {
+		return -1;
+	}
+	item = xmalloc(sizeof(struct packed_item));
+	memcpy(item->sha1, sha1, 20);
+	item->len = size;
+	item->next = NULL;
+	item->data = compressed;
+	*packed_item = item;
+out:
+	return 0;
+}
+
+static char *create_packed_header(struct packed_item *head, unsigned long *size)
+{
+	char *metadata = NULL;
+	int metadata_size = 0;
+	*size = 0;
+	int entry_size = 0;
+
+	while(head) {
+		char *p;
+		metadata = realloc(metadata, metadata_size + 220);
+		if (!metadata)
+			return NULL;
+		p = metadata+metadata_size;
+		memcpy(p, head->sha1, 20);
+		p += 20;
+		entry_size = 1 + sprintf(p, "%lu", head->len);
+		metadata_size += entry_size + 20;
+		head = head->next;
+	}
+	*size = metadata_size;
+	return metadata;
+}
+
+#define WRITE_BUFFER_SIZE 8192
+static char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned long write_buffer_len;
+
+static int c_write(int fd, void *data, unsigned int len)
+{
+	while (len) {
+		unsigned int buffered = write_buffer_len;
+		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
+		if (partial > len)
+			partial = len;
+		memcpy(write_buffer + buffered, data, partial);
+		buffered += partial;
+		if (buffered == WRITE_BUFFER_SIZE) {
+			if (write(fd, write_buffer, WRITE_BUFFER_SIZE) != WRITE_BUFFER_SIZE)
+				return -1;
+			buffered = 0;
+		}
+		write_buffer_len = buffered;
+		len -= partial;
+		data += partial;
+ 	}
+ 	return 0;
+}
+
+static int c_flush(int fd)
+{
+	if (write_buffer_len) {
+		int left = write_buffer_len;
+		if (write(fd, write_buffer, left) != left)
+			return -1;
+		write_buffer_len = 0;
+	}
+	return 0;
+}
+
+/*
+ * creates a new packed file for all the items in head.  hard links are
+ * made from the sha1 of all the items back to the packd file, and then
+ * the packed file is unlinked.
+ */
+int write_packed_buffer(struct packed_item *head)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	char *metadata = xmalloc(200);
+	char *header;
+	int metadata_size;
+	int fd;
+	int ret = 0;
+	unsigned long header_len;
+	struct packed_item *item;
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+
+	header = create_packed_header(head, &header_len);
+	metadata_size = 1+sprintf(metadata, "packed %lu", header_len);
+	/* 
+	 * the header contains the sha1 of each item, so we only sha1 the
+	 * header
+	 */ 
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, header, header_len);
+	SHA1_Final(sha1, &c);
+
+	filename = strdup(sha1_file_name(sha1));
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		/* add collision check! */
+		if (errno != EEXIST) {
+			ret = -errno;
+		}
+		goto out_nofile;
+	}
+       /* compress just the header info */
+        memset(&stream, 0, sizeof(stream));
+        deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, header_len + metadata_size);
+        compressed = xmalloc(size);
+
+        stream.next_in = metadata;
+        stream.avail_in = metadata_size;
+        stream.next_out = compressed;
+        stream.avail_out = size;
+        while (deflate(&stream, 0) == Z_OK)
+                /* nothing */;
+        stream.next_in = header;
+        stream.avail_in = header_len;
+        while (deflate(&stream, Z_FINISH) == Z_OK)
+                /* nothing */;
+        deflateEnd(&stream);
+        size = stream.total_out;
+
+	c_write(fd, compressed, size);
+	free(compressed);
+
+	item = head;
+	while(item) {
+		if (c_write(fd, item->data, item->len)) {
+			ret = -EIO;
+			goto out;
+		}
+		item = item->next;
+	}
+	if (c_flush(fd)) {
+		ret = -EIO;
+		goto out;
+	}
+	item = head;
+	while(item) {
+		char *item_file;
+		struct packed_item *next = item->next;
+		item_file = sha1_file_name(item->sha1);
+		if (link(filename, item_file) && errno != EEXIST) {
+			ret = -errno;
+			break;
+		}
+		free(item->data);
+		free(item);
+		item = next;
+	}
+	unlink(filename);
+out:
+	close(fd);
+out_nofile:
+	free(header);
+	free(metadata);
+	free(filename);
+	return ret;
+}
diff -urN --exclude .git linus.diff/update-cache.c linus.mine/update-cache.c
--- linus.diff/update-cache.c	2005-05-04 09:54:49.167733240 -0400
+++ linus.mine/update-cache.c	2005-05-02 20:51:32.000000000 -0400
@@ -31,55 +31,39 @@
 	return (unsigned long)ptr > (unsigned long)-1000L;
 }
 
-static int index_fd(unsigned char *sha1, int fd, struct stat *st)
+static int index_fd(unsigned char *sha1, unsigned char *refsha1, int fd, struct stat *st, struct packed_item **head, struct packed_item **tail, unsigned long *packed_size, int *packed_nr)
 {
-	z_stream stream;
 	unsigned long size = st->st_size;
-	int max_out_bytes = size + 200;
-	void *out = xmalloc(max_out_bytes);
-	void *metadata = xmalloc(200);
-	int metadata_size;
 	void *in;
-	SHA_CTX c;
+	int ret;
+	struct packed_item *new_item;
 
 	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (!out || (int)(long)in == -1)
+	if ((int)(long)in == -1) {
 		return -1;
-
-	metadata_size = 1+sprintf(metadata, "blob %lu", size);
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, metadata, metadata_size);
-	SHA1_Update(&c, in, size);
-	SHA1_Final(sha1, &c);
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_BEST_COMPRESSION);
-
-	/*
-	 * ASCII size + nul byte
-	 */	
-	stream.next_in = metadata;
-	stream.avail_in = metadata_size;
-	stream.next_out = out;
-	stream.avail_out = max_out_bytes;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
-
-	/*
-	 * File content
-	 */
-	stream.next_in = in;
-	stream.avail_in = size;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/*nothing */;
-
-	deflateEnd(&stream);
-	
-	return write_sha1_buffer(sha1, out, stream.total_out);
+	}
+	ret = pack_sha1_buffer(in, size, "blob", sha1, refsha1, &new_item);
+	if (new_item) {
+		if (*tail)
+			(*tail)->next = new_item;
+		*tail = new_item;
+		if (!*head)
+			*head = new_item;
+		*packed_size += new_item->len;
+		*packed_nr++;
+		if (*packed_size > (512 * 1024) || *packed_nr > 1024) {
+			write_packed_buffer(*head);
+			*head = NULL;
+			*tail = NULL;
+			*packed_size = 0;
+			*packed_nr = 0;
+		}
+	}
+	munmap(in, size);
+	return ret;
 }
 
 /*
@@ -102,12 +86,14 @@
 	ce->ce_size = htonl(st->st_size);
 }
 
-static int add_file_to_cache(char *path)
+static int add_file_to_cache(char *path, struct packed_item **packed_head, struct packed_item **packed_tail, unsigned long *packed_size, int *packed_nr)
 {
 	int size, namelen;
 	struct cache_entry *ce;
 	struct stat st;
 	int fd;
+	int pos;
+	unsigned char *refsha1 = NULL;
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
@@ -129,8 +115,12 @@
 	fill_stat_cache_info(ce, &st);
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
+	pos = cache_name_pos(ce->name, namelen);
+	if (pos >= 0)
+		refsha1 = active_cache[pos]->sha1;
 
-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (index_fd(ce->sha1, refsha1, fd, &st, packed_head, 
+		     packed_tail, packed_size, packed_nr) < 0)
 		return -1;
 
 	return add_cache_entry(ce, allow_add);
@@ -311,6 +301,10 @@
 	int allow_options = 1;
 	static char lockfile[MAXPATHLEN+1];
 	const char *indexfile = get_index_file();
+	struct packed_item *packed_head = NULL;
+	struct packed_item *packed_tail = NULL;
+	unsigned long packed_size = 0;
+	int packed_nr = 0;
 
 	snprintf(lockfile, sizeof(lockfile), "%s.lock", indexfile);
 
@@ -362,8 +356,13 @@
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
+		if (add_file_to_cache(path, &packed_head, &packed_tail, &packed_size, &packed_nr))
 			die("Unable to add %s to database", path);
+
+	}
+	if (packed_head) {
+		if (write_packed_buffer(packed_head))
+			die("write packed buffer failed");
 	}
 	if (write_cache(newfd, active_cache, active_nr) || rename(lockfile, indexfile))
 		die("Unable to write new cachefile");
diff -urN --exclude .git linus.diff/write-tree.c linus.mine/write-tree.c
--- linus.diff/write-tree.c	2005-05-04 09:54:49.167733240 -0400
+++ linus.mine/write-tree.c	2005-05-02 20:51:32.000000000 -0400
@@ -5,24 +5,13 @@
  */
 #include "cache.h"
 
-static int check_valid_sha1(unsigned char *sha1)
-{
-	char *filename = sha1_file_name(sha1);
-	int ret;
-
-	/* If we were anal, we'd check that the sha1 of the contents actually matches */
-	ret = access(filename, R_OK);
-	if (ret)
-		perror(filename);
-	return ret;
-}
-
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
+static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1, struct packed_item **head)
 {
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
 	char *buffer;
 	int nr;
+	struct packed_item *item;
 
 	/* Guess at some random initial size */
 	size = 8192;
@@ -50,7 +39,7 @@
 		if (dirname) {
 			int subdir_written;
 
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
+			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1, head);
 			nr += subdir_written;
 
 			/* Now we need to write out the directory entry into this tree.. */
@@ -62,9 +51,6 @@
 			sha1 = subdir_sha1;
 		}
 
-		if (check_valid_sha1(sha1) < 0)
-			exit(1);
-
 		entrylen = pathlen - baselen;
 		if (offset + entrylen + 100 > size) {
 			size = alloc_nr(offset + entrylen + 100);
@@ -77,7 +63,11 @@
 		nr++;
 	} while (nr < maxentries);
 
-	write_sha1_file(buffer, offset, "tree", returnsha1);
+	pack_sha1_buffer(buffer, offset, "tree", returnsha1, NULL, &item);
+	if (item) {
+		item->next = *head;
+		*head = item;
+	}
 	free(buffer);
 	return nr;
 }
@@ -87,6 +77,7 @@
 	int i, unmerged;
 	int entries = read_cache();
 	unsigned char sha1[20];
+	struct packed_item *head = NULL;
 
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
@@ -107,8 +98,12 @@
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+	if (write_tree(active_cache, entries, "", 0, sha1, &head) != entries)
 		die("write-tree: internal error");
+	if (head) {
+		if (write_packed_buffer(head))
+			die("write_packed_buffer error");
+	}
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;
 }

--Boundary-00=_jCPeCKamiGmt7gh--
