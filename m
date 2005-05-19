From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 10:27:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 16:30:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYlzy-00041m-33
	for gcvg-git@gmane.org; Thu, 19 May 2005 16:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVESO23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVESO23
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 10:28:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25472 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262515AbVESO1P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 10:27:15 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGQ004PTQTE16@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 10:27:15 -0400 (EDT)
In-reply-to: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Junio C Hamano wrote:

> This is stolen from the deltification patch by Nicolas Pitre.
> Although the deltification patch has not been submitted for the
> inclusion, the library part here is useful for the rename
> detection logic in the diff work I have been doing.  The next
> patch will depend on this, so if Nico is OK with this one,
> please consider inclusion of this patch.

I'd prefer if the following patch was applied instead, following the 
patch separation I've done already.

=====

This patch adds basic library functions to create and replay delta 
information. Also included is a test-delta utility to validate the code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: git/diff-delta.c
===================================================================
--- /dev/null
+++ git/diff-delta.c
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
Index: git/delta.h
===================================================================
--- /dev/null
+++ git/delta.h
@@ -0,0 +1,6 @@
+extern void *diff_delta(void *from_buf, unsigned long from_size,
+			void *to_buf, unsigned long to_size,
+		        unsigned long *delta_size);
+extern void *patch_delta(void *src_buf, unsigned long src_size,
+			 void *delta_buf, unsigned long delta_size,
+			 unsigned long *dst_size);
Index: git/Makefile
===================================================================
--- git.orig/Makefile
+++ git/Makefile
@@ -36,9 +36,9 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o diff-delta.o patch-delta.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -72,6 +72,9 @@
 test-date: test-date.c date.o
 	$(CC) $(CFLAGS) -o $@ test-date.c date.o
 
+test-delta: test-delta.c diff-delta.o patch-delta.o
+	$(CC) $(CFLAGS) -o $@ $^
+
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 
Index: git/patch-delta.c
===================================================================
--- /dev/null
+++ git/patch-delta.c
@@ -0,0 +1,88 @@
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
+#include <string.h>
+#include "delta.h"
+
+void *patch_delta(void *src_buf, unsigned long src_size,
+		  void *delta_buf, unsigned long delta_size,
+		  unsigned long *dst_size)
+{
+	const unsigned char *data, *top;
+	unsigned char *dst_buf, *out, cmd;
+	unsigned long size;
+	int i;
+
+	/* the smallest delta size possible is 6 bytes */
+	if (delta_size < 6)
+		return NULL;
+
+	data = delta_buf;
+	top = delta_buf + delta_size;
+
+	/* make sure the orig file size matches what we expect */
+	size = i = 0;
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			size |= *data++ << i;
+		i += 8;
+		cmd >>= 1;
+	}
+	if (size != src_size)
+		return NULL;
+
+	/* now the result size */
+	size = i = 0;
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			size |= *data++ << i;
+		i += 8;
+		cmd >>= 1;
+	}
+	dst_buf = malloc(size);
+	if (!dst_buf)
+		return NULL;
+
+	out = dst_buf;
+	while (data < top) {
+		cmd = *data++;
+		if (cmd & 0x80) {
+			unsigned long cp_off = 0, cp_size = 0;
+			const unsigned char *buf;
+			if (cmd & 0x01) cp_off = *data++;
+			if (cmd & 0x02) cp_off |= (*data++ << 8);
+			if (cmd & 0x04) cp_off |= (*data++ << 16);
+			if (cmd & 0x08) cp_off |= (*data++ << 24);
+			if (cmd & 0x10) cp_size = *data++;
+			if (cmd & 0x20) cp_size |= (*data++ << 8);
+			if (cp_size == 0) cp_size = 0x10000;
+			buf = (cmd & 0x40) ? dst_buf : src_buf;
+			memcpy(out, buf + cp_off, cp_size);
+			out += cp_size;
+		} else {
+			memcpy(out, data, cmd);
+			out += cmd;
+			data += cmd;
+		}
+	}
+
+	/* sanity check */
+	if (data != top || out - dst_buf != size) {
+		free(dst_buf);
+		return NULL;
+	}
+
+	*dst_size = size;
+	return dst_buf;
+}
Index: git/test-delta.c
===================================================================
--- /dev/null
+++ git/test-delta.c
@@ -0,0 +1,79 @@
+/*
+ * test-delta.c: test code to exercise diff-delta.c and patch-delta.c
+ *
+ * (C) 2005 Nicolas Pitre <nico@cam.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include "delta.h"
+
+static const char *usage =
+	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	struct stat st;
+	void *from_buf, *data_buf, *out_buf;
+	unsigned long from_size, data_size, out_size;
+
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
+		fprintf(stderr, "Usage: %s\n", usage);
+		return 1;
+	}
+
+	fd = open(argv[2], O_RDONLY);
+	if (fd < 0 || fstat(fd, &st)) {
+		perror(argv[2]);
+		return 1;
+	}
+	from_size = st.st_size;
+	from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (from_buf == MAP_FAILED) {
+		perror(argv[2]);
+		return 1;
+	}
+	close(fd);
+
+	fd = open(argv[3], O_RDONLY);
+	if (fd < 0 || fstat(fd, &st)) {
+		perror(argv[3]);
+		return 1;
+	}
+	data_size = st.st_size;
+	data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (data_buf == MAP_FAILED) {
+		perror(argv[3]);
+		return 1;
+	}
+	close(fd);
+
+	if (argv[1][1] == 'd')
+		out_buf = diff_delta(from_buf, from_size,
+				     data_buf, data_size, &out_size);
+	else
+		out_buf = patch_delta(from_buf, from_size,
+				      data_buf, data_size, &out_size);
+	if (!out_buf) {
+		fprintf(stderr, "delta operation failed (returned NULL)\n");
+		return 1;
+	}
+
+	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
+	if (fd < 0 || write(fd, out_buf, out_size) != out_size) {
+		perror(argv[4]);
+		return 1;
+	}
+
+	return 0;
+}
