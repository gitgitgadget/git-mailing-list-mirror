From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] improved delta support for git
Date: Tue, 17 May 2005 23:43:47 +0200
Message-ID: <d6dohe$dql$1@sea.gmane.org>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000020004040302060305"
X-From: git-owner@vger.kernel.org Wed May 18 00:58:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYAzq-0005C4-R0
	for gcvg-git@gmane.org; Wed, 18 May 2005 00:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVEQWEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEQWAe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 18:00:34 -0400
Received: from main.gmane.org ([80.91.229.2]:35797 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262010AbVEQVrO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:47:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DY9ra-0004C3-PI
	for git@vger.kernel.org; Tue, 17 May 2005 23:44:31 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 23:44:30 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 23:44:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000020004040302060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Nicolas (and others),

I've been trying out your delta stuff as well. It was a bit
disappointing at first, but some tweaking payed off in the end...

First, I tried the entire bkcvs history for 2.6, but storing only the
"fs" directory tree in git (hoping that would be representative
enough, since the entire tree gets *big*). I got 4678 commits.

In its original form, it looks like this (first size is "network
size", the last one disk size on ext3. Average size per object in
bytes):

trees:  16M  (15684 files)  avg: 1119, disk:  61M
blobs: 121M  (17200 files)  avg: 7414, disk: 157M
Total: 139M  (37562 files)  avg: 3883, disk: 237M

Using your code, with unlimited delta depth:

trees:  16M  (15684 files)  avg: 1119, disk:  61M
blobs:   9M   (2333 files)  avg: 4491, disk:  15M
deltas: 30M  (14867 files)  avg: 2147, disk:  71M
Total:  83M  (37562 files)  avg: 2334, disk: 188M

Same thing, with a maximum delta depth of 2:

trees:  16M  (15684 files)  avg: 1119, disk:  61M
blobs:  45M   (6940 files)  avg: 6906, disk:  60M
deltas: 20M  (10260 files)  avg: 2086, disk:  48M
Total:  83M  (37562 files)  avg: 2334, disk: 188M

So, total size from a network perspective went from 139M to 83M, which
seemed a little disappointing to me.

I think there are too reasons, as shown by these statistics:

1) Too many deltas get too big and/or compress badly.

2) Trees take up a big chunk of total space.


Therefore, I tried some other approaches. This one seemed to work
best:

1) I limit the maximum size of any delta to 10% of the size of the new
version. That guarantees a big saving, as long as any delta is
produced.

2) If the "previous" version of a blob is a delta, I produce the new
delta form the old deltas base version. This works surprisingly well.
I'm guessing the reason for this is that most changes are really
small, and they tend to be in the same area as a previous change (as
in "Commit new feature. Commit bugfix for new feature. Commit fix for
bugfix of new feature. Delete new feature as it doesn't work...").

3) I use the same method for all tree objects.

This method of "opportunistic delta compression" has some other
advantages: No risk of long delta chains (as the maximum delta depth
is one). It should be disk cache friendly, as many deltas are produced
against the same base version. And this method could easily be used
incrementally, or "on the fly", as forward deltas are used.

Using these tweaks helped a lot, size wise:

trees:   3M   (9746 files)  avg:  380, disk:  38M
blobs:  13M   (3301 files)  avg: 4208, disk:  20M
deltas: 11M  (19837 files)  avg:  586, disk:  78M
Total:  28M  (37562 files)  avg:  799, disk: 155M

As this method turned 139M worth of git repository into 28M, I decided
to try the same method on the entire bkcvs history (28203 commits).

Plain vanilla git looks like this:

trees:  246M  (156812 files)  avg: 1647, disk:  699M
blobs: 1171M  (185458 files)  avg: 6623, disk: 1573M
Total: 1422M  (370473 files)  avg: 4025, disk: 2382M

The delta compressed approach outlined above yields:

trees:   47M   (73519 files)  avg:  672, disk:  289M
blobs:  156M   (49857 files)  avg: 3285, disk:  281M
deltas: 107M  (218894 files)  avg:  515, disk:  863M
Total:  315M  (370473 files)  avg:  892, disk: 1544M

So, 1.4G became 315M. Not too bad, IMHO. Disk size is still big,
of course, but disks are apparently cheap these days.

It could probably be even better, if git didn't produce quite as many
tree objects. Some sort of chunking together of tree objects would
help delta compression a lot (and improve disk size quite a bit in the
process).

Attached is a patch (against current cogito). It is basically the same
as yours, Nicolas, except for some hackery to make the above possible.
I'm sure I've made lots of stupid mistakes in it (and the 10% limit is
hardcoded right now; I'm lazy).

/dan

--------------070000020004040302060305
Content-Type: text/x-patch;
 name="delta.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delta.patch"

Index: Makefile
===================================================================
--- 4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -35,7 +35,7 @@
 INSTALL?=install
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script
+	git-pull-script git-tag-script git-resolve-script git-deltafy-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -44,7 +44,7 @@
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
-	git-get-tar-commit-id
+	git-get-tar-commit-id git-mkdelta
 
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
@@ -60,7 +60,7 @@
 COMMON=	read-cache.o
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o diff-delta.o patch-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
@@ -94,6 +94,9 @@
 all: $(PROG) $(GEN_SCRIPT)
 
 
+test-delta: test-delta.c diff-delta.o patch-delta.o
+	$(CC) $(CFLAGS) -o $@ $^
+
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 
Index: delta.h
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/delta.h  (mode:100644)
@@ -0,0 +1,6 @@
+extern void *diff_delta(void *from_buf, unsigned long from_size,
+			void *to_buf, unsigned long to_size,
+		        unsigned long *delta_size);
+extern void *patch_delta(void *src_buf, unsigned long src_size,
+			 void *delta_buf, unsigned long delta_size,
+			 unsigned long *dst_size);
Index: diff-delta.c
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/diff-delta.c  (mode:100644)
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
Index: git-deltafy-script
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/git-deltafy-script  (mode:100755)
@@ -0,0 +1,64 @@
+#!/bin/bash
+
+# Script to deltafy an entire GIT repository based on the commit list.
+
+# git-deltafy-script --pack deltafies a repository, from current HEAD
+# down.
+# git-deltafy-script --unpack undeltafies all objects.
+
+export LANG=C
+
+depth=
+[ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
+
+prevcommit=
+prevtree=
+
+treeid() {
+	git-cat-file commit "$1" | sed -e 's/tree //;q'
+}
+
+mkdelta() {
+	git-mkdelta --max-depth=1 -o -v "$@" || exit 1
+}
+
+if [ "$1" = --pack ] ; then
+git-rev-list HEAD | tac |
+while read commit; do
+	if [ "$prevcommit" ]; then
+		git-diff-tree -r -z $prevcommit $commit |
+		while IFS=$'\t' read -d $'\0' a1 a2 sha file; do
+			to=${sha#*->}
+			from=${sha%->*}
+			[ "$from" != "$to" ] && mkdelta $from $to 
+		done
+
+		prevdir=
+		prevsha=
+		tree=$(treeid "$commit") 
+		[ "$prevtree" ] || prevtree=$(treeid $prevcommit)
+		[ $prevtree != $tree ] && mkdelta $prevtree $tree 
+
+		( git-ls-tree -r $prevtree; git-ls-tree -r $tree ) |
+		grep $'^[0-9]*\ttree' | sort -k4 -s | uniq -u -s4 |
+		while IFS=$'\t' read a1 a2 sha dir; do
+			if [ "$prevdir" = "$dir" -a "$prevsha" != "$sha" ]; then
+				echo "deltafying tree $dir"
+				mkdelta $prevsha $sha 
+			fi
+			prevdir=$dir
+			prevsha=$sha
+		done
+
+	fi
+	prevcommit=$commit
+	prevtree=$tree
+done
+elif [ "$1" = --unpack ]; then
+	( cd .git/objects && find -type f ) | sed 's,[./],,g' | 
+	xargs git-mkdelta --max-depth=0 -v
+else
+	echo "usage: $(basename "$0") [--pack|--unpack]" >&2
+	exit 1
+fi
+exit 0
Index: mkdelta.c
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/mkdelta.c  (mode:100644)
@@ -0,0 +1,306 @@
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
+"mkdelta [ --max-depth=N ] [ -o ] <reference_sha1> <target_sha1> [ <next_sha1> ... ]";
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1_ref[20], sha1_trg[20], head_ref[20], head_trg[20];
+	char type_ref[20], type_trg[20];
+	void *buf_ref, *buf_trg, *buf_delta;
+	unsigned long size_ref, size_trg, size_orig, size_delta;
+	unsigned int depth_ref, depth_trg, depth_max = -1;
+	int i, verbose = 0, oneparent = 0;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-v")) {
+			verbose = 1;
+		} else if (!strcmp(argv[i], "-o")) {
+			oneparent = 1;
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
+	if (oneparent && depth_max > 0) {
+		while (buf_ref && !strcmp(type_ref, "delta")) {
+			if (size_ref < 20)
+				die("bad delta object");
+			//printf ("getting parent for %s %i\n", 
+					//sha1_to_hex(sha1_ref), depth_max);
+			memcpy(sha1_ref, buf_ref, 20);
+			free(buf_ref);
+			//printf("loading parent %s\n",
+					//sha1_to_hex(sha1_ref));
+			buf_ref = get_buffer(sha1_ref, 
+					type_ref, &size_ref);
+			if (!buf_ref) die("broken get_buffer!");
+		}
+	}
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
+		if (depth_trg > depth_max || depth_max == 0) {
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
+		//if (size_delta+20 < size_orig) {
+		if ((size_delta+20)*100/size_trg < 10) {
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
+			if (verbose) {
+				printf("skip    %s (original is smaller)", argv[i]);
+				printf(" (size=%ld.%02ld%%, depth=%d)\n",
+				       (size_delta+20)*100 / size_trg,
+				       ((size_delta+20)*10000 / size_trg)%100,
+				       depth_ref);
+			}
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
Index: mktag.c
===================================================================
--- 4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2/mktag.c  (mode:100644)
+++ uncommitted/mktag.c  (mode:100644)
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
Index: patch-delta.c
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/patch-delta.c  (mode:100644)
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
Index: sha1_file.c
===================================================================
--- 4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2/sha1_file.c  (mode:100644)
+++ uncommitted/sha1_file.c  (mode:100644)
@@ -9,6 +9,7 @@
 #include <stdarg.h>
 #include <limits.h>
 #include "cache.h"
+#include "delta.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -353,6 +354,19 @@
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
Index: test-delta.c
===================================================================
--- /dev/null  (tree:4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2)
+++ uncommitted/test-delta.c  (mode:100644)
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

--------------070000020004040302060305--

