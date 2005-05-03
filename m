From: Chris Mason <mason@suse.com>
Subject: [PATCH] delta compressed git
Date: Mon, 2 May 2005 21:30:08 -0400
Message-ID: <200505022130.10958.mason@suse.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iQtdCAw7levnxJ9"
X-From: git-owner@vger.kernel.org Tue May 03 03:35:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSmK5-0006RB-Tx
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVECBkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVECBjU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:39:20 -0400
Received: from ns1.suse.de ([195.135.220.2]:16558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261282AbVECBaY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 21:30:24 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id E91B6160E572
	for <git@vger.kernel.org>; Tue,  3 May 2005 03:30:22 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_iQtdCAw7levnxJ9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

Here's an early form of some code for delta compression in git archives.  It 
builds on top of my packed item patch from before.  Using this patch will 
create repositories that can't be read by unpatched git, and it is only ready 
for light testing.  The file format might change slightly in later revs.

deltas live as subfiles in packed files, and the packed item header has the 
sha1 of the file the delta is against. deltas are never taken against deltas, 
only whole files (so the chain length is only 1).  

When importing all of Ingo's bk->cvs patches into git (28,000 changesets), 
delta git applies the patches faster (2hrs vs 2.5hrs), consumes less space 
(900MB vs 2.5GB), and checks out the resulting git tree faster in hot and 
cold caches.

Another 200MB or so would be saved by packing trees and commits into the same 
files as the blobs.  This is easy to do, but makes the patch harder to 
maintain because I need to move code around in commit-tree.c and 
write-tree.c.  So I've left those bits out for now.

Because the packed files are created per changeset, if a changeset only 
modifies one file the delta will still end up using a whole block.  So, you 
could get much higher space savings with a tool to walk back over existing 
changesets and pack them together.  This doesn't exist yet, but wouldn't be 
difficult, and I expect it to get close to the mercurial/bk repository sizes.

The patch uses zdelta for delta compression, which you can download here:
http://cis.poly.edu/zdelta/

I'm open to suggestions on better delta libs.  I picked this one because it 
was easy to code.  In order for things to work with git you need to apply the 
attached zdelta.diff to the zdelta-2.1 sources.  It fixes a silly default in 
the Makefile and a symbol collision with zlib.

-chris

--Boundary-00=_iQtdCAw7levnxJ9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="zdelta.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="zdelta.diff"

diff -ur zdelta-2.1.orig/infcodes.c zdelta-2.1/infcodes.c
--- zdelta-2.1.orig/infcodes.c	2003-10-26 19:30:09.000000000 -0500
+++ zdelta-2.1/infcodes.c	2005-05-02 16:03:37.000000000 -0400
@@ -145,7 +145,7 @@
     if (m >= MAX_MATCH && n >= 10) 
     {
       UPDATE
-      r = inflate_fast(c->lbits, c->dbits, c->zdbits, 
+      r = zd_inflate_fast(c->lbits, c->dbits, c->zdbits, 
 		       c->ltree, c->dtree, c->zdtree, s, z);
       LOAD
       if (r != ZD_OK)
Only in zdelta-2.1: infcodes.o
diff -ur zdelta-2.1.orig/inffast.c zdelta-2.1/inffast.c
--- zdelta-2.1.orig/inffast.c	2003-10-26 19:30:09.000000000 -0500
+++ zdelta-2.1/inffast.c	2005-05-02 16:03:20.000000000 -0400
@@ -8,7 +8,7 @@
 /* zdelta:
  *
  * modified: 
- *          inflate_fast
+ *          zd_inflate_fast
  * added:
  *          --
  * removed:
@@ -41,7 +41,7 @@
 /*
  * zdelta: modified
  */
-int inflate_fast(bl, bd, bzd, tl, td, tzd, s, z)
+int zd_inflate_fast(bl, bd, bzd, tl, td, tzd, s, z)
 uInt bl, bd, bzd;
 inflate_huft *tl;
 inflate_huft *td;
diff -ur zdelta-2.1.orig/inffast.h zdelta-2.1/inffast.h
--- zdelta-2.1.orig/inffast.h	2003-10-26 19:30:13.000000000 -0500
+++ zdelta-2.1/inffast.h	2005-05-02 16:02:58.000000000 -0400
@@ -22,7 +22,7 @@
 
 #ifndef ZD_INFFAST_H
 #define ZD_INFFAST_H
-extern int inflate_fast OF((
+extern int zd_inflate_fast OF((
     uInt,
     uInt,
     uInt,
diff -ur zdelta-2.1.orig/Makefile zdelta-2.1/Makefile
--- zdelta-2.1.orig/Makefile	2004-02-13 18:19:51.000000000 -0500
+++ zdelta-2.1/Makefile	2005-05-02 15:30:08.000000000 -0400
@@ -35,7 +35,7 @@
 
 CC=gcc
 
-CFLAGS= -O2 -W -Wall -pedantic -ansi -g -DREFNUM=2
+CFLAGS= -O2 -W -Wall -pedantic -ansi -g -DREFNUM=1
 
 LDSHARED=$(CC)
 CPP=$(CC) -E

--Boundary-00=_iQtdCAw7levnxJ9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="delta-tree.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delta-tree.diff"

Index: Makefile
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/Makefile  (mode:100644 sha1:2d2913b6b98ac836b43755b1304d2a838dad87dd)
+++ uncommitted/Makefile  (mode:100644)
@@ -36,7 +36,7 @@
 LIB_OBJS += diff.o
 
 LIBS = $(LIB_FILE)
-LIBS += -lz
+LIBS += -lzd -lz
 
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
Index: cache.h
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/cache.h  (mode:100644 sha1:3277d48708f885fa1b7cc56c9d16061c65a2eeb9)
+++ uncommitted/cache.h  (mode:100644)
@@ -16,6 +16,7 @@
 
 #include SHA1_HEADER
 #include <zlib.h>
+#include <zdlib.h>
 
 /*
  * Basic data structures for the directory cache
@@ -64,6 +65,18 @@
 	char name[0];
 };
 
+struct packed_item {
+	/* length of compressed data */
+	unsigned long len;
+	struct packed_item *next;
+	/* sha1 of uncompressed data */
+	char sha1[20];
+	char refsha1[20];
+	char type[20];
+	/* compressed data */
+	char *data;
+};
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_STAGESHIFT 12
@@ -119,7 +132,7 @@
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
+extern void * unpack_sha1_file(const unsigned char *sha1, void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
@@ -135,6 +148,10 @@
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int pack_sha1_buffer(void *buf, unsigned long buf_len, char *type,
+                            unsigned char *returnsha1, unsigned char *refsha1, 
+			    struct packed_item **);
+int write_packed_buffer(struct packed_item *head);
 
 /* General helper functions */
 extern void usage(const char *err);
Index: fsck-cache.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/fsck-cache.c  (mode:100644 sha1:f9b1431dd8f4f3b426a7e410de952277aaa11401)
+++ uncommitted/fsck-cache.c  (mode:100644)
@@ -142,7 +142,7 @@
 		if (map) {
 			char type[100];
 			unsigned long size;
-			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+			void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size);
 			if (!buffer)
 				return -1;
 			if (check_sha1_signature(sha1, buffer, size, type) < 0)
Index: git-mktag.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/git-mktag.c  (mode:100644 sha1:5d2830dc2bdfa2e76afc3fd4687db8faffaefba2)
+++ uncommitted/git-mktag.c  (mode:100644)
@@ -31,7 +31,7 @@
 	if (map) {
 		char type[100];
 		unsigned long size;
-		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+		void *buffer = unpack_sha1_file(sha1,map,mapsize,type,&size);
 
 		if (buffer) {
 			if (!strcmp(type, expected_type))
Index: sha1_file.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/sha1_file.c  (mode:100644 sha1:db2880e389e556dd3a5eef02aa8a3bb235528057)
+++ uncommitted/sha1_file.c  (mode:100644)
@@ -139,31 +139,195 @@
 	return map;
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+static int find_packed_header(const unsigned char *sha1, char *buf, unsigned long buf_len,
+		              unsigned char *refsha1, char *type, unsigned long *offset)
+{
+	char *p;
+	p = buf;
+
+	*offset = 0;
+	while(p < buf + buf_len) {
+		unsigned long item_len;
+		unsigned char item_sha[20];
+		memcpy(item_sha, p, 20);
+		sscanf(p + 20, "%s %lu ", type, &item_len);
+		p += 20 + strlen(p + 20) + 1;
+		if (strcmp(type, "delta") == 0) {
+			memcpy(refsha1, p, 20);
+			p += 20;
+		}
+		if (memcmp(item_sha, sha1, 20) == 0)
+			return 0;
+		*offset += item_len;
+	}
+	return -1;
+}
+
+
+static void * _unpack_sha1_file(z_stream *stream, const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size)
 {
 	int ret, bytes;
+	char buffer[8192];
+	char *buf;
+
+	/* Get the data stream */
+	memset(stream, 0, sizeof(*stream));
+	stream->next_in = map;
+	stream->avail_in = mapsize;
+	stream->next_out = buffer;
+	stream->avail_out = sizeof(buffer);
+
+	inflateInit(stream);
+	ret = inflate(stream, 0);
+	if (ret < Z_OK) {
+		return NULL;
+	}
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
+		return NULL;
+	}
+	bytes = strlen(buffer) + 1;
+	buf = xmalloc(*size);
+
+	memcpy(buf, buffer + bytes, stream->total_out - bytes);
+	bytes = stream->total_out - bytes;
+	if (bytes < *size && ret == Z_OK) {
+		stream->next_out = buf + bytes;
+		stream->avail_out = *size - bytes;
+		while (inflate(stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+	}
+	inflateEnd(stream);
+	return buf;
+}
+static int find_sha1_ref(unsigned char *sha1)
+{
+	unsigned char foundsha1[20];
 	z_stream stream;
+	char *buf;
+	unsigned long header_len;
+	char type[20];
+	char *map;
+	unsigned long mapsize;
+	unsigned long offset;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (!map)
+		return -1;
+	buf = _unpack_sha1_file(&stream, sha1, map, mapsize, type, &header_len);
+
+	if (!buf)
+		goto fail;
+	if (strcmp(type, "packed"))
+		goto fail;
+        if (find_packed_header(sha1, buf, header_len, foundsha1, type, &offset))
+		goto fail;
+	munmap(map, mapsize);
+	free(buf);
+
+	if (strcmp(type, "delta"))
+		return 0;
+	memcpy(sha1, foundsha1, 20);
+	return 0;
+fail:
+	munmap(map, mapsize);
+	free(buf);
+	return -1;
+}
+
+static void * unpack_delta(char *refsha1, char *delta_start, 
+			   unsigned long delta_len, char *type, 
+			   unsigned long *size)
+{
+	zd_stream dstream;
+	int ret, bytes;
 	char buffer[8192];
 	char *buf;
+	char *refbuffer = NULL;
+	unsigned long refsize = 0;
 
+	memset(&dstream, 0, sizeof(dstream));
+	refbuffer = read_sha1_file(refsha1, type, &refsize);
+	if (!refbuffer) {
+		return NULL;
+	}
+	dstream.base[0] = refbuffer;
+	dstream.base_avail[0] = refsize;
+	dstream.refnum = 1;
+	dstream.next_in = delta_start;
+	dstream.avail_in = delta_len;
+	dstream.next_out = buffer;
+	dstream.avail_out = sizeof(buffer);
+	ret = zd_inflateInit(&dstream);
+	ret = zd_inflate(&dstream, 0);
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
+		free(refbuffer);
+		return NULL;
+	}
+	bytes = strlen(buffer) + 1;
+	buf = xmalloc(*size);
+	memcpy(buf, buffer + bytes, 
+		dstream.total_out - bytes);
+	bytes = dstream.total_out - bytes;
+	if (bytes < *size && ret == ZD_OK) {
+		dstream.next_out = buf + bytes;
+		dstream.avail_out = *size - bytes;
+		while (zd_inflate(&dstream, ZD_FINISH) == ZD_OK)
+			/* nothing */;
+	}
+	zd_inflateEnd(&dstream);
+	free(refbuffer);
+	return buf;
+}
+
+void * unpack_sha1_file(const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size)
+{
+	int ret, bytes;
+	z_stream stream;
+	char buffer[8192];
+	char *buf;
+	unsigned long offset;
+	unsigned long header_len;
+	unsigned char refsha1[20];
+	unsigned char headertype[20];
+
+	buf = _unpack_sha1_file(&stream, sha1, map, mapsize, type, size);
+	if (!buf)
+		return buf;
+	if (strcmp(type, "packed"))
+		return buf;
+
+	if (!sha1) {
+		free(buf);
+		return NULL;
+	}
+	header_len = *size;
+        if (find_packed_header(sha1, buf, header_len, refsha1, headertype, &offset)) {
+		free(buf);
+		return NULL;
+	}
+	offset += stream.total_in;
+	free(buf);
+	if (!strcmp(headertype, "delta"))
+		return unpack_delta(refsha1, map+offset, mapsize-offset, type,size);
 	/* Get the data stream */
 	memset(&stream, 0, sizeof(stream));
-	stream.next_in = map;
-	stream.avail_in = mapsize;
+	buf = NULL;
+	stream.next_in = map + offset;
+	stream.avail_in = mapsize - offset;
 	stream.next_out = buffer;
 	stream.avail_out = sizeof(buffer);
+	ret = inflateInit(&stream);
 
-	inflateInit(&stream);
 	ret = inflate(&stream, 0);
-	if (ret < Z_OK)
-		return NULL;
-	if (sscanf(buffer, "%10s %lu", type, size) != 2)
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
 		return NULL;
-
+	}
 	bytes = strlen(buffer) + 1;
 	buf = xmalloc(*size);
-
-	memcpy(buf, buffer + bytes, stream.total_out - bytes);
+	memcpy(buf, buffer + bytes, 
+		stream.total_out - bytes);
 	bytes = stream.total_out - bytes;
 	if (bytes < *size && ret == Z_OK) {
 		stream.next_out = buf + bytes;
@@ -182,7 +346,7 @@
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size);
 		munmap(map, mapsize);
 		return buf;
 	}
@@ -268,7 +432,8 @@
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
-	size = deflateBound(&stream, len+hdrlen);
+	// size = zd_deflateBound(&stream, len+hdrlen);
+	size = len + hdrlen + 12;
 	compressed = xmalloc(size);
 
 	/* Compress it */
@@ -413,3 +578,323 @@
 		return 1;
 	return 0;
 }
+
+static void *pack_delta_buffer(void *buf, unsigned long buf_len, char *metadata, int metadata_size, unsigned long *compsize, unsigned char *refsha1)
+{
+	char *compressed;
+	zd_stream stream;
+	unsigned long size;
+	char *refbuffer = NULL;
+	char reftype[20];
+	unsigned long refsize = 0;
+	int ret;
+
+	if (find_sha1_ref(refsha1)) {
+		return NULL;
+	}
+	refbuffer = read_sha1_file(refsha1, reftype, &refsize);
+
+	/* note, we could just continue without the delta here */
+	if (!refbuffer) {
+		free(refbuffer);
+		return NULL;
+	}
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	/* TODO, real deflate bound here */
+	size = buf_len + metadata_size + 12;
+	compressed = xmalloc(size);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.base[0] = refbuffer;
+	stream.base_avail[0] = refsize;
+	stream.refnum = 1;
+	stream.next_in = metadata;
+	stream.avail_in = metadata_size;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	ret = zd_deflateInit(&stream, ZD_BEST_COMPRESSION);
+	/* TODO check for -ENOMEM */
+	while ((ret = zd_deflate(&stream, 0)) == ZD_OK)
+		/* nothing */;
+
+	stream.next_in = buf;
+	stream.avail_in = buf_len;
+	/* Compress it */
+	while ((ret = zd_deflate(&stream, ZD_FINISH)) == ZD_OK)
+		/* nothing */;
+	ret = zd_deflateEnd(&stream);
+	size = stream.total_out;
+	*compsize = size;
+
+	/* ugh, we're comparing the compressed size against the uncompressed size
+	 * of the reference buffer.  But, this is as good as we can do without
+	 * an extra read
+	 */
+	if (size > refsize) {
+		free(refbuffer);
+		free(compressed);
+		return NULL;
+	}
+	free(refbuffer);
+	return compressed;
+}
+
+static void *pack_buffer(void *buf, unsigned long buf_len, char *metadata, int metadata_size, unsigned long *compsize)
+{
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+	int ret;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	/* TODO, real deflate bound here */
+	size = buf_len + metadata_size + 12;
+	compressed = xmalloc(size);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.next_in = metadata;
+	stream.avail_in = metadata_size;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	ret = deflateInit(&stream, Z_BEST_COMPRESSION);
+	/* TODO check for -ENOMEM */
+	while ((ret = deflate(&stream, 0)) == Z_OK)
+		/* nothing */;
+
+	stream.next_in = buf;
+	stream.avail_in = buf_len;
+	/* Compress it */
+	while ((ret = deflate(&stream, Z_FINISH)) == Z_OK)
+		/* nothing */;
+	ret = deflateEnd(&stream);
+	size = stream.total_out;
+	*compsize = size;
+	return compressed;
+}
+
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
+	int delta = 0;
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
+		compressed = pack_delta_buffer(buf, buf_len, metadata, metadata_size, &size, refsha1);
+		delta = (compressed != NULL);
+	}
+	if (!compressed) {
+		compressed = pack_buffer(buf, buf_len, metadata, metadata_size, &size);
+	}
+	free(metadata);
+	if (!compressed) {
+		return -1;
+	}
+	item = xmalloc(sizeof(struct packed_item));
+	memcpy(item->sha1, sha1, 20);
+	if (delta) {
+		strcpy(item->type, "delta");
+		memcpy(item->refsha1, refsha1, 20);
+	} else {
+		strcpy(item->type, type);
+		memset(item->refsha1, 0, 20);
+	}
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
+		entry_size = 1 + sprintf(p, "%s %lu", head->type, head->len);
+		metadata_size += entry_size + 20;
+		if (strcmp(head->type, "delta") == 0) {
+			memcpy(p + entry_size, head->refsha1, 20);
+			metadata_size += 20;
+		}
+
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
+	int zdret;
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
+	/* TODO, bounds check */
+	size = header_len + metadata_size + 12;
+        compressed = xmalloc(size);
+
+        stream.next_in = metadata;
+        stream.avail_in = metadata_size;
+        stream.next_out = compressed;
+        stream.avail_out = size;
+        while ((zdret = deflate(&stream, 0)) == Z_OK)
+                /* nothing */;
+        stream.next_in = header;
+        stream.avail_in = header_len;
+        while ((zdret = deflate(&stream, Z_FINISH)) == Z_OK)
+                /* nothing */;
+        zdret = deflateEnd(&stream);
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
Index: update-cache.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/update-cache.c  (mode:100644 sha1:16e1bb9aea6413db35039042289605124d759501)
+++ uncommitted/update-cache.c  (mode:100644)
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
Index: write-tree.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/write-tree.c  (mode:100644 sha1:168352853d37bdca71d68ad8312b87b84477dea1)
+++ uncommitted/write-tree.c  (mode:100644)
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

--Boundary-00=_iQtdCAw7levnxJ9--
