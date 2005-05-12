From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improved delta support for git
Date: Wed, 11 May 2005 23:51:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 12 05:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW4eR-0007Ow-Hs
	for gcvg-git@gmane.org; Thu, 12 May 2005 05:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVELDxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 23:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVELDxv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 23:53:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10439 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261330AbVELDvM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 23:51:12 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGC00KETYP7SU@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 May 2005 23:51:08 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


OK, here's some improved support for delta objects in a git repository. 
This patch adds the ability to create and restore delta objects with the 
git-mkdelta command.  A list of objects is provided and the 
corresponding delta chain is created.  The maximum depth of a delta 
chain can be specified with the -d argument.  If a max depth of 0 is 
provided then all given objects are undeltafied and replaced by their 
original version.  With the -v argument a lot of lovely details are 
printed out.

Also included is a script to deltafy an entire repository.  Simply 
execute git-deltafy-script to create deltas of objects corresponding to 
successive previous versions of every files.  Running 
'git-deltafy-script -d 0' will revert everything to non deltafied form.

I've yet to add suport to fsck-cache to understand delta objects.  It is 
advised to undeltafy your repository before running it otherwise you'll 
see lots of reported errors.  Once undeltafied you should have good 
output from fsck-cache again.

Please backup your repository before playing with this for now... just 
in case.

If you happen to have the whole kernel history in your repository I'd be 
interested to know what the space figure is and how it performs.  So far 
I tested a tar of the .git/objects directory from git's git repository.  
This is to estimate the real data size without the filesystem block 
round up. The undeltafied repository created a 1708kb tar file while the 
deltafied repository created a 1173kb tar file.  The chunking storage 
code should be considered for real life usage of course.

There are probably things to experiment in order to save space further, 
such as deltafying tree objects, and in the context of Linux, deltafying 
files with lots of similitudes between content in diferent include/asm-* 
subdirectories.

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
@@ -29,7 +29,7 @@
 	install $(PROG) $(SCRIPTS) $(HOME)/bin/
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o diff-delta.o patch-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
@@ -63,6 +63,9 @@
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
Index: git/sha1_file.c
===================================================================
--- git.orig/sha1_file.c
+++ git/sha1_file.c
@@ -8,6 +8,7 @@
  */
 #include <stdarg.h>
 #include "cache.h"
+#include "delta.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -224,6 +225,19 @@
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
+		if (buf && !strcmp(type, "delta")) {
+			void *ref = NULL, *delta = buf;
+			unsigned long ref_size, delta_size = *size;
+			buf = NULL;
+			if (delta_size > 20)
+				ref = read_sha1_file(delta, type, &ref_size);
+			if (ref)
+				buf = patch_delta(ref, ref_size,
+						  delta+20, delta_size-20, 
+						  size);
+			free(delta);
+			free(ref);
+		}
 		return buf;
 	}
 	return NULL;
Index: git/Makefile
===================================================================
--- git.orig/Makefile
+++ git/Makefile
@@ -13,7 +13,7 @@
 AR=ar
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script
+	git-pull-script git-tag-script git-resolve-script git-deltafy-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -21,7 +21,8 @@
 	git-check-files git-ls-tree git-merge-base git-merge-cache \
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
-	git-diff-tree-helper git-tar-tree git-local-pull git-write-blob
+	git-diff-tree-helper git-tar-tree git-local-pull git-write-blob \
+	git-mkdelta
 
 all: $(PROG)
 
@@ -95,6 +96,7 @@
 git-rpull: rsh.c pull.c
 git-rev-list: rev-list.c
 git-mktag: mktag.c
+git-mkdelta: mkdelta.c
 git-diff-tree-helper: diff-tree-helper.c
 git-tar-tree: tar-tree.c
 git-write-blob: write-blob.c
Index: git/mkdelta.c
===================================================================
--- /dev/null
+++ git/mkdelta.c
@@ -0,0 +1,283 @@
+/*
+ * Deltafication of a GIT database.
+ *
+ * (C) 2005 Nicolas Pitre <nico@cam.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cache.h"
+#include "delta.h"
+
+static int replace_object(char *buf, unsigned long len, unsigned char *sha1,
+			  char *hdr, int hdrlen)
+{
+	char tmpfile[PATH_MAX];
+	int size;
+	char *compressed;
+	z_stream stream;
+	int fd;
+
+	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	fd = mkstemp(tmpfile);
+	if (fd < 0)
+		return error("%s: %s\n", tmpfile, strerror(errno));
+	
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, len+hdrlen);
+	compressed = xmalloc(size);
+
+	/* Compress it */
+	stream.next_out = compressed;
+	stream.avail_out = size;
+
+	/* First header.. */
+	stream.next_in = hdr;
+	stream.avail_in = hdrlen;
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	/* Then the data itself.. */
+	stream.next_in = buf;
+	stream.avail_in = len;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	size = stream.total_out;
+
+	if (write(fd, compressed, size) != size) {
+		perror("unable to write file");
+		close(fd);
+		unlink(tmpfile);
+		return -1;
+	}
+	fchmod(fd, 0444);
+	close(fd);
+
+	if (rename(tmpfile, sha1_file_name(sha1))) {
+		perror("unable to replace original object");
+		unlink(tmpfile);
+		return -1;
+	}
+	return 0;
+}
+
+static int write_delta_file(char *buf, unsigned long len,
+			    unsigned char *sha1_ref, unsigned char *sha1_trg)
+{
+	char hdr[50];
+	int hdrlen;
+
+	/* Generate the header + sha1 of reference for delta */
+	hdrlen = sprintf(hdr, "delta %lu", len+20)+1;
+	memcpy(hdr + hdrlen, sha1_ref, 20);
+	hdrlen += 20;
+
+	return replace_object(buf, len, sha1_trg, hdr, hdrlen);
+}
+
+static int replace_sha1_file(char *buf, unsigned long len,
+			     char *type, unsigned char *sha1)
+{
+	char hdr[50];
+	int hdrlen;
+
+	hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+	return replace_object(buf, len, sha1, hdr, hdrlen);
+}
+
+static void *get_buffer(unsigned char *sha1, char *type, unsigned long *size)
+{
+	unsigned long mapsize;
+	void *map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		void *buffer = unpack_sha1_file(map, mapsize, type, size);
+		munmap(map, mapsize);
+		if (buffer)
+			return buffer;
+	}
+	error("unable to get object %s", sha1_to_hex(sha1));
+	return NULL;
+}
+
+static void *expand_delta(void *delta, unsigned long delta_size, char *type,
+			  unsigned long *size, unsigned int *depth, char *head)
+{
+	void *buf = NULL;
+	*depth++;
+	if (delta_size < 20) {
+		error("delta object is bad");
+		free(delta);
+	} else {
+		unsigned long ref_size;
+		void *ref = get_buffer(delta, type, &ref_size);
+		if (ref && !strcmp(type, "delta"))
+			ref = expand_delta(ref, ref_size, type, &ref_size,
+					   depth, head);
+		else
+			memcpy(head, delta, 20);
+		if (ref)
+			buf = patch_delta(ref, ref_size, delta+20,
+					  delta_size-20, size);
+		free(ref);
+		free(delta);
+	}
+	return buf;
+}
+
+static char *mkdelta_usage =
+"mkdelta [ --max-depth=N ] <reference_sha1> <target_sha1> [ <next_sha1> ... ]";
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1_ref[20], sha1_trg[20], head_ref[20], head_trg[20];
+	char type_ref[20], type_trg[20];
+	void *buf_ref, *buf_trg, *buf_delta;
+	unsigned long size_ref, size_trg, size_orig, size_delta;
+	unsigned int depth_ref, depth_trg, depth_max = -1;
+	int i, verbose = 0;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-v")) {
+			verbose = 1;
+		} else if (!strcmp(argv[i], "-d") && i+1 < argc) {
+			depth_max = atoi(argv[++i]);
+		} else if (!strncmp(argv[i], "--max-depth=", 12)) {
+			depth_max = atoi(argv[i]+12);
+		} else
+			break;
+	}
+
+	if (i + (depth_max != 0) >= argc)
+		usage(mkdelta_usage);
+
+	if (get_sha1(argv[i], sha1_ref))
+		die("bad sha1 %s", argv[i]);
+	depth_ref = 0;
+	buf_ref = get_buffer(sha1_ref, type_ref, &size_ref);
+	if (buf_ref && !strcmp(type_ref, "delta"))
+		buf_ref = expand_delta(buf_ref, size_ref, type_ref,
+				       &size_ref, &depth_ref, head_ref);
+	else
+		memcpy(head_ref, sha1_ref, 20);
+	if (!buf_ref)
+		die("unable to obtain initial object %s", argv[i]);
+
+	if (depth_ref > depth_max) {
+		if (replace_sha1_file(buf_ref, size_ref, type_ref, sha1_ref))
+			die("unable to restore %s", argv[i]);
+		if (verbose)
+			printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
+		depth_ref = 0;
+	}
+
+	while (++i < argc) {
+		if (get_sha1(argv[i], sha1_trg))
+			die("bad sha1 %s", argv[i]);
+		depth_trg = 0;
+		buf_trg = get_buffer(sha1_trg, type_trg, &size_trg);
+		if (buf_trg && !size_trg) {
+			if (verbose)
+				printf("skip    %s (object is empty)\n", argv[i]);
+			continue;
+		}
+		size_orig = size_trg;
+		if (buf_trg && !strcmp(type_trg, "delta")) {
+			if (!memcmp(buf_trg, sha1_ref, 20)) {
+				/* delta already in place */
+				depth_ref++;
+				memcpy(sha1_ref, sha1_trg, 20);
+				buf_ref = patch_delta(buf_ref, size_ref,
+						      buf_trg+20, size_trg-20,
+						      &size_ref);
+				if (!buf_ref)
+					die("unable to apply delta %s", argv[i]);
+				if (depth_ref > depth_max) {
+					if (replace_sha1_file(buf_ref, size_ref,
+							      type_ref, sha1_ref))
+						die("unable to restore %s", argv[i]);
+					if (verbose)
+						printf("undelta %s (depth was %d)\n", argv[i], depth_ref);
+					depth_ref = 0;
+					continue;
+				}
+				if (verbose)
+					printf("skip    %s (delta already in place)\n", argv[i]);
+				continue;
+			}
+			buf_trg = expand_delta(buf_trg, size_trg, type_trg,
+					       &size_trg, &depth_trg, head_trg);
+		} else
+			memcpy(head_trg, sha1_trg, 20);
+		if (!buf_trg)
+			die("unable to read target object %s", argv[i]);
+
+		if (depth_trg > depth_max) {
+			if (replace_sha1_file(buf_trg, size_trg, type_trg, sha1_trg))
+				die("unable to restore %s", argv[i]);
+			if (verbose)
+				printf("undelta %s (depth was %d)\n", argv[i], depth_trg);
+			depth_trg = 0;
+			size_orig = size_trg;
+		}
+
+		if (depth_max == 0)
+			goto skip;
+
+		if (strcmp(type_ref, type_trg))
+			die("type mismatch for object %s", argv[i]);
+
+		if (!size_ref) {
+			if (verbose)
+				printf("skip    %s (initial object is empty)\n", argv[i]);
+			goto skip;
+		}
+		
+		depth_ref++;
+		if (depth_ref > depth_max) {
+			if (verbose)
+				printf("skip    %s (exceeding max link depth)\n", argv[i]);
+			goto skip;
+		}
+
+		if (!memcmp(head_ref, sha1_trg, 20)) {
+			if (verbose)
+				printf("skip    %s (would create a loop)\n", argv[i]);
+			goto skip;
+		}
+
+		buf_delta = diff_delta(buf_ref, size_ref, buf_trg, size_trg, &size_delta);
+		if (!buf_delta)
+			die("out of memory");
+
+		if (size_delta+20 < size_orig) {
+			if (write_delta_file(buf_delta, size_delta,
+					     sha1_ref, sha1_trg))
+				die("unable to write delta for %s", argv[i]);
+			free(buf_delta);
+			if (verbose)
+				printf("delta   %s (size=%ld.%02ld%%, depth=%d)\n",
+				       argv[i], (size_delta+20)*100 / size_trg,
+				       ((size_delta+20)*10000 / size_trg)%100,
+				       depth_ref);
+		} else {
+			free(buf_delta);
+			if (verbose)
+				printf("skip    %s (original is smaller)\n", argv[i]);
+			skip:
+			depth_ref = depth_trg;
+			memcpy(head_ref, head_trg, 20);
+		}
+
+		free(buf_ref);
+		buf_ref = buf_trg;
+		size_ref = size_trg;
+		memcpy(sha1_ref, sha1_trg, 20);
+	}
+
+	return 0;
+}
Index: git/mktag.c
===================================================================
--- git.orig/mktag.c
+++ git/mktag.c
@@ -25,20 +25,14 @@
 static int verify_object(unsigned char *sha1, const char *expected_type)
 {
 	int ret = -1;
-	unsigned long mapsize;
-	void *map = map_sha1_file(sha1, &mapsize);
+	char type[100];
+	unsigned long size;
+	void *buffer = read_sha1_file(sha1, type, &size);
 
-	if (map) {
-		char type[100];
-		unsigned long size;
-		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
-
-		if (buffer) {
-			if (!strcmp(type, expected_type))
-				ret = check_sha1_signature(sha1, buffer, size, type);
-			free(buffer);
-		}
-		munmap(map, mapsize);
+	if (buffer) {
+		if (!strcmp(type, expected_type))
+			ret = check_sha1_signature(sha1, buffer, size, type);
+		free(buffer);
 	}
 	return ret;
 }
Index: git/git-deltafy-script
===================================================================
--- /dev/null
+++ git/git-deltafy-script
@@ -0,0 +1,33 @@
+#!/bin/bash
+
+# Script to deltafy an entire GIT repository based on the commit list.
+# The most recent version of a file is the reference and the previous version
+# is changed into a delta from that most recent version. And so on for
+# successive versions going back in time.
+#
+# The -d argument allows to provide a limit on the delta chain depth.
+# If 0 is passed then everything is undeltafied.
+
+set -e
+
+depth=
+[ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
+
+curr_file=""
+
+git-rev-list HEAD |
+git-diff-tree -r --stdin |
+sed -n '/^\*/ s/^.*->\(.\{41\}\)\(.*\)$/\2 \1/p' | sort | uniq |
+while read file sha1; do
+	if [ "$file" == "$curr_file" ]; then
+		list="$list $sha1"
+	else
+		if [ "$list" ]; then
+			echo "Processing $curr_file"
+			echo "$head $list" | xargs git-mkdelta $depth -v
+		fi
+		curr_file="$file"
+		list=""
+		head="$sha1"
+	fi
+done
