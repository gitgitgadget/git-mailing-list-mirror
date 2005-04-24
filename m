From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/5] Additional functions for the objects database
Date: Sat, 23 Apr 2005 20:15:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232010360.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:11:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUik-0007DY-Oc
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVDXAQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVDXAQO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:16:14 -0400
Received: from iabervon.org ([66.92.72.58]:6663 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262196AbVDXAPs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:15:48 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUmw-00007Z-00; Sat, 23 Apr 2005 20:15:54 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds two functions: one to check if an object is present in the local
database, and one to add an object to the local database by reading it
from a file descriptor and checking its hash.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: cache.h
===================================================================
--- 144a13fb75a39538ec4578792d2c374c6ef50f46/cache.h  (mode:100644 sha1:bf30ac4741d2eeeb483079f566182505898082f3)
+++ cae140a16189361d8c9f1f7e68ef519956fd26d9/cache.h  (mode:100644 sha1:794d676a5cf5c9a03309c4b368840f8707cfcf46)
@@ -122,11 +122,16 @@
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
+
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage);
 
+extern int write_sha1_from_fd(const unsigned char *sha1, int fd);
+
+extern int has_sha1_file(const unsigned char *sha1);
+
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
Index: sha1_file.c
===================================================================
--- 144a13fb75a39538ec4578792d2c374c6ef50f46/sha1_file.c  (mode:100644 sha1:66308ede85c2dad6b184fb74a7215b06a173d8f7)
+++ cae140a16189361d8c9f1f7e68ef519956fd26d9/sha1_file.c  (mode:100644 sha1:97a515a073fec5870dfaaa279868ce9330853d3d)
@@ -328,3 +328,75 @@
 	close(fd);
 	return 0;
 }
+
+int write_sha1_from_fd(const unsigned char *sha1, int fd)
+{
+	char *filename = sha1_file_name(sha1);
+
+	int local;
+	z_stream stream;
+	unsigned char real_sha1[20];
+	char buf[4096];
+	char discard[4096];
+	int ret;
+	SHA_CTX c;
+
+	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+
+	if (local < 0)
+		return error("Couldn't open %s\n", filename);
+
+	memset(&stream, 0, sizeof(stream));
+
+	inflateInit(&stream);
+
+	SHA1_Init(&c);
+
+	do {
+		ssize_t size;
+		size = read(fd, buf, 4096);
+		if (size <= 0) {
+			close(local);
+			unlink(filename);
+			if (!size)
+				return error("Connection closed?");
+			perror("Reading from connection");
+			return -1;
+		}
+		write(local, buf, size);
+		stream.avail_in = size;
+		stream.next_in = buf;
+		do {
+			stream.next_out = discard;
+			stream.avail_out = sizeof(discard);
+			ret = inflate(&stream, Z_SYNC_FLUSH);
+			SHA1_Update(&c, discard, sizeof(discard) -
+				    stream.avail_out);
+		} while (stream.avail_in && ret == Z_OK);
+		
+	} while (ret == Z_OK);
+	inflateEnd(&stream);
+
+	close(local);
+	SHA1_Final(real_sha1, &c);
+	if (ret != Z_STREAM_END) {
+		unlink(filename);
+		return error("File %s corrupted", sha1_to_hex(sha1));
+	}
+	if (memcmp(sha1, real_sha1, 20)) {
+		unlink(filename);
+		return error("File %s has bad hash\n", sha1_to_hex(sha1));
+	}
+	
+	return 0;
+}
+
+int has_sha1_file(const unsigned char *sha1)
+{
+	char *filename = sha1_file_name(sha1);
+	struct stat st;
+
+	if (!stat(filename, &st))
+		return 1;
+	return 0;
+}

