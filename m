From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Reorganize common code
Date: Wed, 13 Apr 2005 18:00:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504131755550.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504131752410.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:01:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLpug-0000tN-SM
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVDMWEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 18:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDMWEA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:04:00 -0400
Received: from iabervon.org ([66.92.72.58]:31493 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261203AbVDMWAM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 18:00:12 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DLpuL-0000vq-00; Wed, 13 Apr 2005 18:00:25 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504131752410.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This splits read-cache.c into util.c, cache.c, and objects.c, based on
what the code is used for; similarly, cache.h becomes util.h, cache.h, and
objects.h. For simplicity, cache.h includes the other two to give the
previous overall behavior.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- 783978eb212c1402ba2612bb32626e93af78b72d/Makefile  (mode:100644 sha1:2b626ec05b2e29016d26b5cb7b4f82ec5c4e79d6)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/Makefile  (mode:100644 sha1:0b263fa693cb2addb2516a8f7af2ea05b95d3c8c)
@@ -20,7 +20,7 @@
 	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
 	gitapply.sh
 
-COMMON=	read-cache.o
+COMMON=	cache.o objects.o util.o
 
 GEN_SCRIPT= gitversion.sh
 
@@ -36,7 +36,7 @@
 $(PROG):%: %.o $(COMMON)
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-read-cache.o: cache.h
+cache.o: cache.h
 show-diff.o: cache.h
 
 gitversion.sh: $(VERSION)
Index: cache.c
===================================================================
--- /dev/null  (tree:783978eb212c1402ba2612bb32626e93af78b72d)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/cache.c  (mode:100644 sha1:fe61eae561e8ebaab9d9fe6d8f146ed7353b6a1c)
@@ -0,0 +1,224 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include <stdarg.h>
+#include "cache.h"
+
+const char *sha1_file_directory = NULL;
+struct cache_entry **active_cache = NULL;
+unsigned int active_nr = 0, active_alloc = 0;
+
+int cache_match_stat(struct cache_entry *ce, struct stat *st)
+{
+	unsigned int changed = 0;
+
+	/* nsec seems unreliable - not all filesystems support it, so
+	 * as long as it is in the inode cache you get right nsec
+	 * but after it gets flushed, you get zero nsec. */
+	if (ce->mtime.sec  != (unsigned int)st->st_mtim.tv_sec
+#ifdef NSEC
+	    || ce->mtime.nsec != (unsigned int)st->st_mtim.tv_nsec
+#endif
+	    )
+		changed |= MTIME_CHANGED;
+	if (ce->ctime.sec  != (unsigned int)st->st_ctim.tv_sec
+#ifdef NSEC
+	    || ce->ctime.nsec != (unsigned int)st->st_ctim.tv_nsec
+#endif
+	    )
+		changed |= CTIME_CHANGED;
+	if (ce->st_uid != (unsigned int)st->st_uid ||
+	    ce->st_gid != (unsigned int)st->st_gid)
+		changed |= OWNER_CHANGED;
+	if (ce->st_mode != (unsigned int)st->st_mode)
+		changed |= MODE_CHANGED;
+	if (ce->st_dev != (unsigned int)st->st_dev ||
+	    ce->st_ino != (unsigned int)st->st_ino)
+		changed |= INODE_CHANGED;
+	if (ce->st_size != (unsigned int)st->st_size)
+		changed |= DATA_CHANGED;
+	return changed;
+}
+
+int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
+{
+	int len = len1 < len2 ? len1 : len2;
+	int cmp;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp)
+		return cmp;
+	if (len1 < len2)
+		return -1;
+	if (len1 > len2)
+		return 1;
+	return 0;
+}
+
+int cache_name_pos(const char *name, int namelen)
+{
+	int first, last;
+
+	first = 0;
+	last = active_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct cache_entry *ce = active_cache[next];
+		int cmp = cache_name_compare(name, namelen, ce->name, ce->namelen);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	return -first-1;
+}
+
+int remove_file_from_cache(char *path)
+{
+	int pos = cache_name_pos(path, strlen(path));
+	if (pos >= 0) {
+		active_nr--;
+		if (pos < active_nr)
+			memmove(active_cache + pos, active_cache + pos + 1, (active_nr - pos) * sizeof(struct cache_entry *));
+	}
+	return 0;
+}
+
+int add_cache_entry(struct cache_entry *ce, int ok_to_add)
+{
+	int pos;
+
+	pos = cache_name_pos(ce->name, ce->namelen);
+
+	/* existing match? Just replace it */
+	if (pos >= 0) {
+		active_cache[pos] = ce;
+		return 0;
+	}
+	pos = -pos-1;
+
+	if (!ok_to_add)
+		return -1;
+
+	/* Make sure the array is big enough .. */
+	if (active_nr == active_alloc) {
+		active_alloc = alloc_nr(active_alloc);
+		active_cache = realloc(active_cache, active_alloc * sizeof(struct cache_entry *));
+	}
+
+	/* Add it in.. */
+	active_nr++;
+	if (active_nr > pos)
+		memmove(active_cache + pos + 1, active_cache + pos, (active_nr - pos - 1) * sizeof(ce));
+	active_cache[pos] = ce;
+	return 0;
+}
+
+static int verify_hdr(struct cache_header *hdr, unsigned long size)
+{
+	SHA_CTX c;
+	unsigned char sha1[20];
+
+	if (hdr->signature != CACHE_SIGNATURE)
+		return error("bad signature");
+	if (hdr->version != 1)
+		return error("bad version");
+	SHA1_Init(&c);
+	SHA1_Update(&c, hdr, offsetof(struct cache_header, sha1));
+	SHA1_Update(&c, hdr+1, size - sizeof(*hdr));
+	SHA1_Final(sha1, &c);
+	if (memcmp(sha1, hdr->sha1, 20))
+		return error("bad header sha1");
+	return 0;
+}
+
+int read_cache(void)
+{
+	int fd, i;
+	struct stat st;
+	unsigned long size, offset;
+	void *map;
+	struct cache_header *hdr;
+
+	errno = EBUSY;
+	if (active_cache)
+		return error("more than one cachefile");
+	errno = ENOENT;
+	sha1_file_directory = getenv(DB_ENVIRONMENT);
+	if (!sha1_file_directory)
+		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+	if (access(sha1_file_directory, X_OK) < 0)
+		return error("no access to SHA1 file directory");
+	fd = open(".git/index", O_RDONLY);
+	if (fd < 0)
+		return (errno == ENOENT) ? 0 : error("open failed");
+
+	size = 0; // avoid gcc warning
+	map = (void *)-1;
+	if (!fstat(fd, &st)) {
+		size = st.st_size;
+		errno = EINVAL;
+		if (size >= sizeof(struct cache_header))
+			map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	}
+	close(fd);
+	if (-1 == (int)(long)map)
+		return error("mmap failed");
+
+	hdr = map;
+	if (verify_hdr(hdr, size) < 0)
+		goto unmap;
+
+	active_nr = hdr->entries;
+	active_alloc = alloc_nr(active_nr);
+	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
+
+	offset = sizeof(*hdr);
+	for (i = 0; i < hdr->entries; i++) {
+		struct cache_entry *ce = map + offset;
+		offset = offset + ce_size(ce);
+		active_cache[i] = ce;
+	}
+	return active_nr;
+
+unmap:
+	munmap(map, size);
+	errno = EINVAL;
+	return error("verify header failed");
+}
+
+int write_cache(int newfd, struct cache_entry **cache, int entries)
+{
+	SHA_CTX c;
+	struct cache_header hdr;
+	int i;
+
+	hdr.signature = CACHE_SIGNATURE;
+	hdr.version = 1;
+	hdr.entries = entries;
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		int size = ce_size(ce);
+		SHA1_Update(&c, ce, size);
+	}
+	SHA1_Final(hdr.sha1, &c);
+
+	if (write(newfd, &hdr, sizeof(hdr)) != sizeof(hdr))
+		return -1;
+
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		int size = ce_size(ce);
+		if (write(newfd, ce, size) != size)
+			return -1;
+	}
+	return 0;
+}
Index: cache.h
===================================================================
--- 783978eb212c1402ba2612bb32626e93af78b72d/cache.h  (mode:100644 sha1:d3e9a21b7d9a2ac32abacf5cc40ee1a4d83f9fe8)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/cache.h  (mode:100644 sha1:e3302b454e5d55d4d7bd46bbfe870cb34733ce46)
@@ -14,6 +14,9 @@
 #include <openssl/sha.h>
 #include <zlib.h>
 
+#include "util.h"
+#include "objects.h"
+
 /*
  * Basic data structures for the directory cache
  *
@@ -59,13 +62,9 @@
 	char name[0];
 };
 
-const char *sha1_file_directory;
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc;
 
-#define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
-#define DEFAULT_DB_ENVIRONMENT ".git/objects"
-
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 #define ce_size(ce) cache_entry_size((ce)->namelen)
 
@@ -74,7 +73,10 @@
 /* Initialize and use the cache information */
 extern int read_cache(void);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+
+/* Returns the location of the given name in the cache. */
 extern int cache_name_pos(const char *name, int namelen);
+
 extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
 extern int remove_file_from_cache(char *path);
 extern int cache_match_stat(struct cache_entry *ce, struct stat *st);
@@ -86,28 +88,7 @@
 #define INODE_CHANGED   0x0010
 #define DATA_CHANGED    0x0020
 
-/* Return a statically allocated filename matching the sha1 signature */
-extern char *sha1_file_name(const unsigned char *sha1);
-
-/* Write a memory buffer out to the sha file */
-extern int write_sha1_buffer(const unsigned char *sha1, void *buf, unsigned int size);
-
-/* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
-extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
-extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size);
-
-/* Convert to/from hex/sha1 representation */
-extern int get_sha1_hex(const char *hex, unsigned char *sha1);
-extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-
-/* General helper functions */
-extern void usage(const char *err);
-extern void die(const char *err, ...);
-extern int error(const char *err, ...);
-
-extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern int cache_name_compare(const char *name1, int len1, 
+			      const char *name2, int len2);
 
 #endif /* CACHE_H */
Index: objects.c
===================================================================
--- /dev/null  (tree:783978eb212c1402ba2612bb32626e93af78b72d)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/objects.c  (mode:100644 sha1:ee0aed670a76e0af9e4150c93915dad53a198ba5)
@@ -0,0 +1,240 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include <stdarg.h>
+#include "cache.h"
+#include "objects.h"
+#include <openssl/sha.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <zlib.h>
+
+
+static unsigned hexval(char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return ~0;
+}
+
+int get_sha1_hex(const char *hex, unsigned char *sha1)
+{
+	int i;
+	for (i = 0; i < 20; i++) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		if (val & ~0xff)
+			return -1;
+		*sha1++ = val;
+		hex += 2;
+	}
+	return 0;
+}
+
+char * sha1_to_hex(const unsigned char *sha1)
+{
+	static char buffer[50];
+	static const char hex[] = "0123456789abcdef";
+	char *buf = buffer;
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	return buffer;
+}
+
+/*
+ * NOTE! This returns a statically allocated buffer, so you have to be
+ * careful about using it. Do a "strdup()" if you need to save the
+ * filename.
+ */
+char *sha1_file_name(const unsigned char *sha1)
+{
+	int i;
+	static char *name, *base;
+
+	if (!base) {
+		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+		int len = strlen(sha1_file_directory);
+		base = malloc(len + 60);
+		memcpy(base, sha1_file_directory, len);
+		memset(base+len, 0, 60);
+		base[len] = '/';
+		base[len+3] = '/';
+		name = base + len + 1;
+	}
+	for (i = 0; i < 20; i++) {
+		static char hex[] = "0123456789abcdef";
+		unsigned int val = sha1[i];
+		char *pos = name + i*2 + (i > 0);
+		*pos++ = hex[val >> 4];
+		*pos = hex[val & 0xf];
+	}
+	return base;
+}
+
+int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size)
+{
+	unsigned char real_sha1[20];
+	SHA_CTX c;
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, map, size);
+	SHA1_Final(real_sha1, &c);
+	return memcmp(sha1, real_sha1, 20) ? -1 : 0;
+}
+
+void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+{
+	char *filename = sha1_file_name(sha1);
+	int fd = open(filename, O_RDONLY);
+	struct stat st;
+	void *map;
+
+	if (fd < 0) {
+		perror(filename);
+		return NULL;
+	}
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return NULL;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (-1 == (int)(long)map)
+		return NULL;
+	*size = st.st_size;
+	return map;
+}
+
+void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+{
+	int ret, bytes;
+	z_stream stream;
+	char buffer[8192];
+	char *buf;
+
+	/* Get the data stream */
+	memset(&stream, 0, sizeof(stream));
+	stream.next_in = map;
+	stream.avail_in = mapsize;
+	stream.next_out = buffer;
+	stream.avail_out = sizeof(buffer);
+
+	inflateInit(&stream);
+	ret = inflate(&stream, 0);
+	if (sscanf(buffer, "%10s %lu", type, size) != 2)
+		return NULL;
+
+	bytes = strlen(buffer) + 1;
+	buf = malloc(*size);
+	if (!buf)
+		return NULL;
+
+	memcpy(buf, buffer + bytes, stream.total_out - bytes);
+	bytes = stream.total_out - bytes;
+	if (bytes < *size && ret == Z_OK) {
+		stream.next_out = buf + bytes;
+		stream.avail_out = *size - bytes;
+		while (inflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+	}
+	inflateEnd(&stream);
+	return buf;
+}
+
+void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+{
+	unsigned long mapsize;
+	void *map, *buf;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		buf = unpack_sha1_file(map, mapsize, type, size);
+		munmap(map, mapsize);
+		return buf;
+	}
+	return NULL;
+}
+
+int write_sha1_file(char *buf, unsigned len, unsigned char *returnsha1)
+{
+	int size;
+	char *compressed;
+	z_stream stream;
+	unsigned char sha1[20];
+	SHA_CTX c;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, len);
+	compressed = malloc(size);
+
+	/* Compress it */
+	stream.next_in = buf;
+	stream.avail_in = len;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	size = stream.total_out;
+
+	/* Sha1.. */
+	SHA1_Init(&c);
+	SHA1_Update(&c, compressed, size);
+	SHA1_Final(sha1, &c);
+
+	if (write_sha1_buffer(sha1, compressed, size) < 0)
+		return -1;
+	if (returnsha1)
+		memcpy(returnsha1, sha1, 20);
+	return 0;
+}
+
+int write_sha1_buffer(const unsigned char *sha1, void *buf, unsigned int size)
+{
+	char *filename = sha1_file_name(sha1);
+	int fd;
+
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		void *map;
+
+		if (errno != EEXIST)
+			return -1;
+		/* #define NO_COLLISION_CHECK to possibly speed things up,
+		 * but the speedup should be really negligible. */
+#ifndef NO_COLLISION_CHECK
+		fd = open(filename, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (map == MAP_FAILED)
+			return -1;
+		if (memcmp(buf, map, size))
+			return error("SHA1 collision detected!"
+					" This is bad, bad, BAD!\a\n");
+#endif
+		return 0;
+	}
+	write(fd, buf, size);
+	close(fd);
+	return 0;
+}
Index: objects.h
===================================================================
--- /dev/null  (tree:783978eb212c1402ba2612bb32626e93af78b72d)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/objects.h  (mode:100644 sha1:b6469e3e2ef191b36a23da23cbb8bf70ad54da0e)
@@ -0,0 +1,43 @@
+#ifndef OBJECTS_H
+#define OBJECTS_H
+
+/* Operations on the object database. */
+const char *sha1_file_directory;
+
+#define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
+#define DEFAULT_DB_ENVIRONMENT ".git/objects"
+
+/* Takes a key and returns the contents, and sets *type to its type
+ * and size to its size.  
+ */
+extern void * read_sha1_file(const unsigned char *sha1, char *type,
+			     unsigned long *size);
+
+/* Writes the given data and length to a file, and returns the key. */
+extern int write_sha1_file(char *buf, unsigned len, 
+			   unsigned char *return_sha1);
+
+/* mmap the given file, and put its size in *size. */
+extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
+
+/* Given a map, its size, and its expected type, return its contents and set
+ * *size to the size of the contents. 
+ */
+extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type,
+			       unsigned long *size);
+
+/* Return a statically allocated filename matching the sha1 signature */
+extern char *sha1_file_name(const unsigned char *sha1);
+
+/* Write a memory buffer out to the sha file */
+extern int write_sha1_buffer(const unsigned char *sha1, void *buf, 
+			     unsigned int size);
+/* compares the given buffer against its expected sha1 hash. */
+extern int check_sha1_signature(const unsigned char *sha1, void *buf, 
+				unsigned long size);
+
+/* Convert to/from hex/sha1 representation */
+extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+extern char * sha1_to_hex(const unsigned char *sha1); /* static buffer ret! */
+
+#endif /* OBJECTS_H */
Index: read-cache.c
===================================================================
--- 783978eb212c1402ba2612bb32626e93af78b72d/read-cache.c  (mode:100644 sha1:7cdd0f82992789e64f6ea272e43ee4af8cdf7f2a)
+++ /dev/null  (tree:e8194c62bfc68725972a6847fa2c6d529ca64137)
@@ -1,478 +0,0 @@
-/*
- * GIT - The information manager from hell
- *
- * Copyright (C) Linus Torvalds, 2005
- */
-#include <stdarg.h>
-#include "cache.h"
-
-const char *sha1_file_directory = NULL;
-struct cache_entry **active_cache = NULL;
-unsigned int active_nr = 0, active_alloc = 0;
-
-void usage(const char *err)
-{
-	fprintf(stderr, "usage: %s\n", err);
-	exit(1);
-}
-
-static void report(const char *prefix, const char *err, va_list params)
-{
-	fputs(prefix, stderr);
-	vfprintf(stderr, err, params);
-	fputs("\n", stderr);
-}
-
-void die(const char *err, ...)
-{
-	va_list params;
-
-	va_start(params, err);
-	report("fatal: ", err, params);
-	va_end(params);
-	exit(1);
-}
-
-int error(const char *err, ...)
-{
-	va_list params;
-
-	va_start(params, err);
-	report("error: ", err, params);
-	va_end(params);
-	return -1;
-}
-
-
-static unsigned hexval(char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if (c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return ~0;
-}
-
-int get_sha1_hex(const char *hex, unsigned char *sha1)
-{
-	int i;
-	for (i = 0; i < 20; i++) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-		if (val & ~0xff)
-			return -1;
-		*sha1++ = val;
-		hex += 2;
-	}
-	return 0;
-}
-
-char * sha1_to_hex(const unsigned char *sha1)
-{
-	static char buffer[50];
-	static const char hex[] = "0123456789abcdef";
-	char *buf = buffer;
-	int i;
-
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
-	}
-	return buffer;
-}
-
-/*
- * NOTE! This returns a statically allocated buffer, so you have to be
- * careful about using it. Do a "strdup()" if you need to save the
- * filename.
- */
-char *sha1_file_name(const unsigned char *sha1)
-{
-	int i;
-	static char *name, *base;
-
-	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
-		int len = strlen(sha1_file_directory);
-		base = malloc(len + 60);
-		memcpy(base, sha1_file_directory, len);
-		memset(base+len, 0, 60);
-		base[len] = '/';
-		base[len+3] = '/';
-		name = base + len + 1;
-	}
-	for (i = 0; i < 20; i++) {
-		static char hex[] = "0123456789abcdef";
-		unsigned int val = sha1[i];
-		char *pos = name + i*2 + (i > 0);
-		*pos++ = hex[val >> 4];
-		*pos = hex[val & 0xf];
-	}
-	return base;
-}
-
-int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size)
-{
-	unsigned char real_sha1[20];
-	SHA_CTX c;
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, map, size);
-	SHA1_Final(real_sha1, &c);
-	return memcmp(sha1, real_sha1, 20) ? -1 : 0;
-}
-
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
-{
-	char *filename = sha1_file_name(sha1);
-	int fd = open(filename, O_RDONLY);
-	struct stat st;
-	void *map;
-
-	if (fd < 0) {
-		perror(filename);
-		return NULL;
-	}
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return NULL;
-	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (-1 == (int)(long)map)
-		return NULL;
-	*size = st.st_size;
-	return map;
-}
-
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
-{
-	int ret, bytes;
-	z_stream stream;
-	char buffer[8192];
-	char *buf;
-
-	/* Get the data stream */
-	memset(&stream, 0, sizeof(stream));
-	stream.next_in = map;
-	stream.avail_in = mapsize;
-	stream.next_out = buffer;
-	stream.avail_out = sizeof(buffer);
-
-	inflateInit(&stream);
-	ret = inflate(&stream, 0);
-	if (sscanf(buffer, "%10s %lu", type, size) != 2)
-		return NULL;
-
-	bytes = strlen(buffer) + 1;
-	buf = malloc(*size);
-	if (!buf)
-		return NULL;
-
-	memcpy(buf, buffer + bytes, stream.total_out - bytes);
-	bytes = stream.total_out - bytes;
-	if (bytes < *size && ret == Z_OK) {
-		stream.next_out = buf + bytes;
-		stream.avail_out = *size - bytes;
-		while (inflate(&stream, Z_FINISH) == Z_OK)
-			/* nothing */;
-	}
-	inflateEnd(&stream);
-	return buf;
-}
-
-void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
-{
-	unsigned long mapsize;
-	void *map, *buf;
-
-	map = map_sha1_file(sha1, &mapsize);
-	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
-		munmap(map, mapsize);
-		return buf;
-	}
-	return NULL;
-}
-
-int write_sha1_file(char *buf, unsigned len, unsigned char *returnsha1)
-{
-	int size;
-	char *compressed;
-	z_stream stream;
-	unsigned char sha1[20];
-	SHA_CTX c;
-
-	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_BEST_COMPRESSION);
-	size = deflateBound(&stream, len);
-	compressed = malloc(size);
-
-	/* Compress it */
-	stream.next_in = buf;
-	stream.avail_in = len;
-	stream.next_out = compressed;
-	stream.avail_out = size;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&stream);
-	size = stream.total_out;
-
-	/* Sha1.. */
-	SHA1_Init(&c);
-	SHA1_Update(&c, compressed, size);
-	SHA1_Final(sha1, &c);
-
-	if (write_sha1_buffer(sha1, compressed, size) < 0)
-		return -1;
-	if (returnsha1)
-		memcpy(returnsha1, sha1, 20);
-	return 0;
-}
-
-int write_sha1_buffer(const unsigned char *sha1, void *buf, unsigned int size)
-{
-	char *filename = sha1_file_name(sha1);
-	int fd;
-
-	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0) {
-		void *map;
-
-		if (errno != EEXIST)
-			return -1;
-		/* #define NO_COLLISION_CHECK to possibly speed things up,
-		 * but the speedup should be really negligible. */
-#ifndef NO_COLLISION_CHECK
-		fd = open(filename, O_RDONLY);
-		if (fd < 0)
-			return -1;
-		map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		if (map == MAP_FAILED)
-			return -1;
-		if (memcmp(buf, map, size))
-			return error("SHA1 collision detected!"
-					" This is bad, bad, BAD!\a\n");
-#endif
-		return 0;
-	}
-	write(fd, buf, size);
-	close(fd);
-	return 0;
-}
-
-int cache_match_stat(struct cache_entry *ce, struct stat *st)
-{
-	unsigned int changed = 0;
-
-	/* nsec seems unreliable - not all filesystems support it, so
-	 * as long as it is in the inode cache you get right nsec
-	 * but after it gets flushed, you get zero nsec. */
-	if (ce->mtime.sec  != (unsigned int)st->st_mtim.tv_sec
-#ifdef NSEC
-	    || ce->mtime.nsec != (unsigned int)st->st_mtim.tv_nsec
-#endif
-	    )
-		changed |= MTIME_CHANGED;
-	if (ce->ctime.sec  != (unsigned int)st->st_ctim.tv_sec
-#ifdef NSEC
-	    || ce->ctime.nsec != (unsigned int)st->st_ctim.tv_nsec
-#endif
-	    )
-		changed |= CTIME_CHANGED;
-	if (ce->st_uid != (unsigned int)st->st_uid ||
-	    ce->st_gid != (unsigned int)st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->st_mode != (unsigned int)st->st_mode)
-		changed |= MODE_CHANGED;
-	if (ce->st_dev != (unsigned int)st->st_dev ||
-	    ce->st_ino != (unsigned int)st->st_ino)
-		changed |= INODE_CHANGED;
-	if (ce->st_size != (unsigned int)st->st_size)
-		changed |= DATA_CHANGED;
-	return changed;
-}
-
-int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
-{
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
-	if (cmp)
-		return cmp;
-	if (len1 < len2)
-		return -1;
-	if (len1 > len2)
-		return 1;
-	return 0;
-}
-
-int cache_name_pos(const char *name, int namelen)
-{
-	int first, last;
-
-	first = 0;
-	last = active_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ce->namelen);
-		if (!cmp)
-			return next;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-	return -first-1;
-}
-
-int remove_file_from_cache(char *path)
-{
-	int pos = cache_name_pos(path, strlen(path));
-	if (pos >= 0) {
-		active_nr--;
-		if (pos < active_nr)
-			memmove(active_cache + pos, active_cache + pos + 1, (active_nr - pos) * sizeof(struct cache_entry *));
-	}
-	return 0;
-}
-
-int add_cache_entry(struct cache_entry *ce, int ok_to_add)
-{
-	int pos;
-
-	pos = cache_name_pos(ce->name, ce->namelen);
-
-	/* existing match? Just replace it */
-	if (pos >= 0) {
-		active_cache[pos] = ce;
-		return 0;
-	}
-	pos = -pos-1;
-
-	if (!ok_to_add)
-		return -1;
-
-	/* Make sure the array is big enough .. */
-	if (active_nr == active_alloc) {
-		active_alloc = alloc_nr(active_alloc);
-		active_cache = realloc(active_cache, active_alloc * sizeof(struct cache_entry *));
-	}
-
-	/* Add it in.. */
-	active_nr++;
-	if (active_nr > pos)
-		memmove(active_cache + pos + 1, active_cache + pos, (active_nr - pos - 1) * sizeof(ce));
-	active_cache[pos] = ce;
-	return 0;
-}
-
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
-{
-	SHA_CTX c;
-	unsigned char sha1[20];
-
-	if (hdr->signature != CACHE_SIGNATURE)
-		return error("bad signature");
-	if (hdr->version != 1)
-		return error("bad version");
-	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, offsetof(struct cache_header, sha1));
-	SHA1_Update(&c, hdr+1, size - sizeof(*hdr));
-	SHA1_Final(sha1, &c);
-	if (memcmp(sha1, hdr->sha1, 20))
-		return error("bad header sha1");
-	return 0;
-}
-
-int read_cache(void)
-{
-	int fd, i;
-	struct stat st;
-	unsigned long size, offset;
-	void *map;
-	struct cache_header *hdr;
-
-	errno = EBUSY;
-	if (active_cache)
-		return error("more than one cachefile");
-	errno = ENOENT;
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
-	if (access(sha1_file_directory, X_OK) < 0)
-		return error("no access to SHA1 file directory");
-	fd = open(".git/index", O_RDONLY);
-	if (fd < 0)
-		return (errno == ENOENT) ? 0 : error("open failed");
-
-	size = 0; // avoid gcc warning
-	map = (void *)-1;
-	if (!fstat(fd, &st)) {
-		size = st.st_size;
-		errno = EINVAL;
-		if (size >= sizeof(struct cache_header))
-			map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	}
-	close(fd);
-	if (-1 == (int)(long)map)
-		return error("mmap failed");
-
-	hdr = map;
-	if (verify_hdr(hdr, size) < 0)
-		goto unmap;
-
-	active_nr = hdr->entries;
-	active_alloc = alloc_nr(active_nr);
-	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
-
-	offset = sizeof(*hdr);
-	for (i = 0; i < hdr->entries; i++) {
-		struct cache_entry *ce = map + offset;
-		offset = offset + ce_size(ce);
-		active_cache[i] = ce;
-	}
-	return active_nr;
-
-unmap:
-	munmap(map, size);
-	errno = EINVAL;
-	return error("verify header failed");
-}
-
-int write_cache(int newfd, struct cache_entry **cache, int entries)
-{
-	SHA_CTX c;
-	struct cache_header hdr;
-	int i;
-
-	hdr.signature = CACHE_SIGNATURE;
-	hdr.version = 1;
-	hdr.entries = entries;
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = cache[i];
-		int size = ce_size(ce);
-		SHA1_Update(&c, ce, size);
-	}
-	SHA1_Final(hdr.sha1, &c);
-
-	if (write(newfd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		return -1;
-
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = cache[i];
-		int size = ce_size(ce);
-		if (write(newfd, ce, size) != size)
-			return -1;
-	}
-	return 0;
-}
Index: util.h
===================================================================
--- /dev/null  (tree:783978eb212c1402ba2612bb32626e93af78b72d)
+++ e8194c62bfc68725972a6847fa2c6d529ca64137/util.h  (mode:100644 sha1:d81ccd0b3363ff2a883e8d9e543af043728fd32a)
@@ -0,0 +1,9 @@
+#ifndef UTIL_H
+#define UTIL_H
+
+/* General helper functions */
+extern void usage(const char *err);
+extern void die(const char *err, ...);
+extern int error(const char *err, ...);
+
+#endif

