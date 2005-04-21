From: Chris Mason <mason@suse.com>
Subject: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 11:13:13 -0400
Message-ID: <200504211113.13630.mason@suse.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JM8ZCEgis9HJICk"
X-From: git-owner@vger.kernel.org Thu Apr 21 17:11:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOdJt-0000tu-L6
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 17:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVDUPOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 11:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVDUPOi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 11:14:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:55949 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261427AbVDUPNU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 11:13:20 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 04F84160ABD8;
	Thu, 21 Apr 2005 17:13:17 +0200 (CEST)
To: git@vger.kernel.org, torvalds@osdl.org
User-Agent: KMail/1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_JM8ZCEgis9HJICk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

There have been a few threads on making git more space efficient, and 
eventually someone mentions tiny files and space fragmentation.  Now that git 
object names are decoupled from their compression, it's easier to consider a 
a variety of compression algorithms.  I whipped up a really silly "pack files 
together" compression.

This would maintain the write once semantics but allow a simple mechanism 
where objects are combined together.  Choosing which objects to combine is 
easy, things put together into update-cache go together.  This gives us more 
space efficiency and no seeks when reading that packed file off disk.

A natural extension to this is to make update-cache --commit-tree, which 
includes the files produced by write-tree and commit-tree into the same 
packed file.  (I haven't coded this).

The layout works like this:

1) a new object type "packed" is added.
2) new objects are buffered into a packed object, until it gets to around 32k 
in size.  This is complete arbitrary but felt about right.
3) The packed object is writting to git storage and then hard links are made 
to the packed object from the sha1 filename of each object inside.
4) read_sha1_file is changed to recognize the packed object and search inside.

I did a simple test on the 2.6.11 tree with my 100 patches applied.  Without 
packing, .git is 99MB.  With packing it only needs 62MB:

read speeds don't suffer with this, time to read-tree ; checkout-cache -a -f 
from a cold cache were the same.  I could get the times lower with the patch 
by caching the uncompressed data, since in theory I should be faster here.

Using this on data you care about would be a really bad idea right now.  I'm 
only posting the patch to get the basic idea across for benchmarking and 
discussion.

-chris

--Boundary-00=_JM8ZCEgis9HJICk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="comp-tree.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="comp-tree.diff"

diff -ur linus.back/cache.h linus/cache.h
--- linus.back/cache.h	2005-04-21 11:05:27.971607944 -0400
+++ linus/cache.h	2005-04-21 09:35:47.173613576 -0400
@@ -109,7 +109,7 @@
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
+extern void * unpack_sha1_file(const unsigned char *sha1, void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
@@ -117,6 +117,10 @@
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int pack_sha1_buffer(void *buf, unsigned long buf_len, 
+		     unsigned char *returnsha1, char **dest, 
+		     unsigned long *dest_size);
+int write_packed_buffer(void *buf, unsigned long len);
 
 /* General helper functions */
 extern void usage(const char *err);
diff -ur linus.back/cat-file.c linus/cat-file.c
--- linus.back/cat-file.c	2005-04-21 11:05:27.971607944 -0400
+++ linus/cat-file.c	2005-04-21 10:04:29.871723656 -0400
@@ -23,7 +23,7 @@
 		type[size] = '\n';
 		size++;
 	} else if (strcmp(type, argv[1])) {
-		die("cat-file %s: bad tag", argv[2]);
+		die("cat-file %s: bad tag (%s: %s)", argv[2], type, argv[1]);
 	}
 
 	while (size > 0) {
diff -ur linus.back/fsck-cache.c linus/fsck-cache.c
--- linus.back/fsck-cache.c	2005-04-21 11:05:27.974607488 -0400
+++ linus/fsck-cache.c	2005-04-21 09:14:03.139856840 -0400
@@ -85,7 +85,7 @@
 		if (map) {
 			char type[100];
 			unsigned long size;
-			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+			void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size);
 			if (!buffer)
 				return -1;
 			if (check_sha1_signature(sha1, buffer, size, type) < 0)
diff -ur linus.back/sha1_file.c linus/sha1_file.c
--- linus.back/sha1_file.c	2005-04-21 11:05:27.978606880 -0400
+++ linus/sha1_file.c	2005-04-21 10:41:51.280977656 -0400
@@ -116,7 +116,8 @@
 	return map;
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+void * unpack_sha1_file(const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size)
 {
 	int ret, bytes;
 	z_stream stream;
@@ -134,12 +135,12 @@
 	ret = inflate(&stream, 0);
 	if (sscanf(buffer, "%10s %lu", type, size) != 2)
 		return NULL;
-
 	bytes = strlen(buffer) + 1;
 	buf = malloc(*size);
-	if (!buf)
+	if (!buf) {
+		perror("malloc");
 		return NULL;
-
+	}
 	memcpy(buf, buffer + bytes, stream.total_out - bytes);
 	bytes = stream.total_out - bytes;
 	if (bytes < *size && ret == Z_OK) {
@@ -149,6 +150,36 @@
 			/* nothing */;
 	}
 	inflateEnd(&stream);
+
+	/* we've found a packed object */
+	if (strcmp(type, "packed") == 0) {
+		char *p = buf;
+		if (!sha1)
+			return NULL;
+		while(p < buf + *size) {
+			unsigned long item_len;
+			unsigned char sha1_hex[50];
+			unsigned char item_sha[20];
+			sscanf(p, "%50s %lu", sha1_hex, &item_len);
+			if (get_sha1_hex(sha1_hex, item_sha))
+				die("packed file corruption");
+			if (memcmp(item_sha, sha1, 20) == 0) {
+				char *temp;
+				char *r;
+				temp = p + strlen(p) + 1;
+				if (sscanf(temp, "%10s %lu", type, size) != 2)
+					return NULL;
+				r = malloc(*size);
+				if (!r)
+					return NULL;
+				memcpy(r, temp + strlen(temp) + 1, *size);
+				free(buf);
+				return r;
+			}
+			p += strlen(p) + 1 + item_len;
+		}
+		return NULL;
+	}
 	return buf;
 }
 
@@ -159,7 +190,7 @@
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size);
 		munmap(map, mapsize);
 		return buf;
 	}
@@ -305,3 +336,111 @@
 	close(fd);
 	return 0;
 }
+
+int pack_sha1_buffer(void *buf, unsigned long buf_len, 
+		     unsigned char *returnsha1, char **dest, 
+		     unsigned long *dest_size)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	struct stat st;
+	void *p;
+	int metadata_size;
+
+	/* Sha1.. */
+	SHA1_Init(&c);
+	SHA1_Update(&c, buf, buf_len);
+	SHA1_Final(sha1, &c);
+
+	if (returnsha1)
+		memcpy(returnsha1, sha1, 20);
+
+	filename = sha1_file_name(sha1);
+	if (stat(filename, &st) == 0)
+		return 0;
+
+	p = realloc(*dest, *dest_size + buf_len + 250);
+	if (!p)
+		return -1;
+	*dest = p;
+	p += *dest_size;
+	metadata_size = 1 + sprintf(p, "%s %lu", sha1_to_hex(sha1), buf_len);
+	p += metadata_size;
+	memcpy(p, buf, buf_len);
+	*dest_size += buf_len + metadata_size;
+	return 0;
+}
+
+int write_packed_buffer(void *buf, unsigned long len)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	char *p;
+	char *metadata = malloc(200);
+	unsigned char sha1_hex[50];
+	int metadata_size;
+	int fd;
+	int ret = 0;
+
+	metadata_size = 1+sprintf(metadata, "packed %lu", len);
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, buf, len);
+	SHA1_Final(sha1, &c);
+
+	filename = strdup(sha1_file_name(sha1));
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		if (errno != EEXIST)
+			return -1;
+		/* add collision check! */
+	} else {
+		char *compressed;
+		z_stream stream;
+		unsigned long size;
+		/* Set it up */
+		memset(&stream, 0, sizeof(stream));
+		deflateInit(&stream, Z_BEST_COMPRESSION);
+		size = deflateBound(&stream, len + metadata_size);
+		compressed = malloc(size);
+
+		/* Compress it */
+		stream.next_in = metadata;
+		stream.avail_in = metadata_size;
+		stream.next_out = compressed;
+		stream.avail_out = size;
+		while (deflate(&stream, 0) == Z_OK)
+			/* nothing */;
+		stream.next_in = buf;
+		stream.avail_in = len;
+		while (deflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&stream);
+		write(fd, compressed, stream.total_out);
+		close(fd);
+	}
+	free(metadata);
+	/* now we have the packed blob on disk, lets link to it */
+	p = buf;
+	while(p < (char *)buf + len) {
+		unsigned long item_len;
+		char *item_file;
+		sscanf(p, "%50s %lu\n", sha1_hex, &item_len);
+		/* + 1 for the null at the end of p */
+		p += strlen(p) + item_len + 1;
+
+		if (get_sha1_hex(sha1_hex, sha1))
+			die("packed file corruption");
+		
+		item_file = sha1_file_name(sha1);
+		if (link(filename, item_file) && errno != EEXIST) {
+			ret = -errno;
+			break;
+		}
+	}
+	free(filename);
+	return ret;
+}
diff -ur linus.back/update-cache.c linus/update-cache.c
--- linus.back/update-cache.c	2005-04-21 11:05:27.979606728 -0400
+++ linus/update-cache.c	2005-04-21 10:42:08.109419344 -0400
@@ -14,55 +14,33 @@
  */
 static int allow_add = 0, allow_remove = 0;
 
-static int index_fd(unsigned char *sha1, int fd, struct stat *st)
+static int index_fd(unsigned char *sha1, int fd, struct stat *st, char **packed_buffer, unsigned long *packed_len)
 {
-	z_stream stream;
 	unsigned long size = st->st_size;
-	int max_out_bytes = size + 200;
-	void *out = malloc(max_out_bytes);
 	void *metadata = malloc(200);
 	int metadata_size;
 	void *in;
-	SHA_CTX c;
+	char *copy;
+	int ret;
 
 	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (!out || (int)(long)in == -1)
+	if (!metadata || (int)(long)in == -1)
 		return -1;
 
 	metadata_size = 1+sprintf(metadata, "blob %lu", size);
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
+	copy = malloc(metadata_size + size);
+	if (!copy)
+		return -1;
+	memcpy(copy, metadata, metadata_size);
+	memcpy(copy + metadata_size, in, size);
+	ret = pack_sha1_buffer(copy, metadata_size + size,
+			       sha1, packed_buffer, packed_len);
+	munmap(in, size);
+	free(copy);
+	return ret;
 }
 
 /*
@@ -85,7 +63,7 @@
 	ce->ce_size = htonl(st->st_size);
 }
 
-static int add_file_to_cache(char *path)
+static int add_file_to_cache(char *path, char **packed_buffer, unsigned long *packed_len)
 {
 	int size, namelen;
 	struct cache_entry *ce;
@@ -113,9 +91,14 @@
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
 
-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (index_fd(ce->sha1, fd, &st, packed_buffer, packed_len) < 0)
 		return -1;
 
+	if (*packed_len > 32768) {
+		if (write_packed_buffer(*packed_buffer, *packed_len))
+			return -1;
+		*packed_len = 0;
+	}
 	return add_cache_entry(ce, allow_add);
 }
 
@@ -286,6 +269,8 @@
 {
 	int i, newfd, entries;
 	int allow_options = 1;
+	char *packed_buffer = NULL;
+	unsigned long packed_len = 0;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -330,9 +315,14 @@
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
+		if (add_file_to_cache(path, &packed_buffer, &packed_len))
 			die("Unable to add %s to database", path);
 	}
+	if (packed_buffer) {
+		if (packed_len)
+	    		if (write_packed_buffer(packed_buffer, packed_len))
+		free(packed_buffer);
+	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("Unable to write new cachefile");

--Boundary-00=_JM8ZCEgis9HJICk--
