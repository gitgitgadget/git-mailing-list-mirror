From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] write_sha1_to_fd()
Date: Sun, 10 Jul 2005 18:25:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101822210.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507101811390.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 00:34:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrkNo-0005h4-Iz
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 00:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVGJWeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 18:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGJWcT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 18:32:19 -0400
Received: from iabervon.org ([66.92.72.58]:49926 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262144AbVGJW1f (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 18:27:35 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrkF0-00064L-00; Sun, 10 Jul 2005 18:25:38 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0507101811390.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add write_sha1_to_fd(), which writes an object to a file descriptor. This
includes support for unpacking it and recompressing it.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
commit 264ff9f3dcde5553728b34fa08e04643b2b55946
tree 353fe33ae9c7265d7b685bca864d657e3efe2849
parent c3eb461762b1d65e424fc4ede6a1d4f3e0a679f7
author Daniel Barkalow <barkalow@iabervon.org> 1121033477 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1121033477 -0400

Index: cache.h
===================================================================
--- 545ef8191b517b7f9e4ea558edaf526038ed1895/cache.h  (mode:100644 sha1:719a77dfabb24e58abd21b7f3a4b846a114e000a)
+++ 353fe33ae9c7265d7b685bca864d657e3efe2849/cache.h  (mode:100644 sha1:38dac6d6a413f1c788e5331ef4741fc15d72d9bd)
@@ -187,6 +187,7 @@
 extern int read_tree(void *buffer, unsigned long size, int stage);
 
 extern int write_sha1_from_fd(const unsigned char *sha1, int fd);
+extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
Index: sha1_file.c
===================================================================
--- 545ef8191b517b7f9e4ea558edaf526038ed1895/sha1_file.c  (mode:100644 sha1:27136fdba0fbf2dd943f2634cb49660cdbf95ec4)
+++ 353fe33ae9c7265d7b685bca864d657e3efe2849/sha1_file.c  (mode:100644 sha1:08560b2c7a6dff400a46160501c247081f9bb4c7)
@@ -1326,6 +1326,65 @@
 	return 0;
 }
 
+int write_sha1_to_fd(int fd, const unsigned char *sha1)
+{
+	ssize_t size;
+	unsigned long objsize;
+	int posn = 0;
+	char *buf = map_sha1_file_internal(sha1, &objsize, 0);
+	z_stream stream;
+	if (!buf) {
+		unsigned char *unpacked;
+		unsigned long len;
+		char type[20];
+		char hdr[50];
+		int hdrlen;
+		// need to unpack and recompress it by itself
+		unpacked = read_packed_sha1(sha1, type, &len);
+
+		hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
+
+		/* Set it up */
+		memset(&stream, 0, sizeof(stream));
+		deflateInit(&stream, Z_BEST_COMPRESSION);
+		size = deflateBound(&stream, len + hdrlen);
+		buf = xmalloc(size);
+
+		/* Compress it */
+		stream.next_out = buf;
+		stream.avail_out = size;
+		
+		/* First header.. */
+		stream.next_in = hdr;
+		stream.avail_in = hdrlen;
+		while (deflate(&stream, 0) == Z_OK)
+			/* nothing */;
+
+		/* Then the data itself.. */
+		stream.next_in = unpacked;
+		stream.avail_in = len;
+		while (deflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&stream);
+		
+		objsize = stream.total_out;
+	}
+
+	do {
+		size = write(fd, buf + posn, objsize - posn);
+		if (size <= 0) {
+			if (!size) {
+				fprintf(stderr, "write closed");
+			} else {
+				perror("write ");
+			}
+			return -1;
+		}
+		posn += size;
+	} while (posn < objsize);
+	return 0;
+}
+
 int write_sha1_from_fd(const unsigned char *sha1, int fd)
 {
 	char *filename = sha1_file_name(sha1);
Index: ssh-push.c
===================================================================
--- 545ef8191b517b7f9e4ea558edaf526038ed1895/ssh-push.c  (mode:100644 sha1:090d6f9f8fbde2d736ac5bf563415b0fa402b5aa)
+++ 353fe33ae9c7265d7b685bca864d657e3efe2849/ssh-push.c  (mode:100644 sha1:aac70af514e0dc5507fa4997ebad54352c973215)
@@ -7,13 +7,13 @@
 static unsigned char local_version = 1;
 static unsigned char remote_version = 0;
 
+static int verbose = 0;
+
 static int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
-	int posn = 0;
 	unsigned char sha1[20];
-	unsigned long objsize;
-	void *buf;
 	signed char remote;
+	int posn = 0;
 	do {
 		size = read(fd_in, sha1 + posn, 20 - posn);
 		if (size < 0) {
@@ -25,12 +25,12 @@
 		posn += size;
 	} while (posn < 20);
 	
-	/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
+	if (verbose)
+		fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1));
+
 	remote = 0;
 	
-	buf = map_sha1_file(sha1, &objsize);
-	
-	if (!buf) {
+	if (!has_sha1_file(sha1)) {
 		fprintf(stderr, "git-ssh-push: could not find %s\n", 
 			sha1_to_hex(sha1));
 		remote = -1;
@@ -41,20 +41,7 @@
 	if (remote < 0)
 		return 0;
 	
-	posn = 0;
-	do {
-		size = write(fd_out, buf + posn, objsize - posn);
-		if (size <= 0) {
-			if (!size) {
-				fprintf(stderr, "git-ssh-push: write closed");
-			} else {
-				perror("git-ssh-push: write ");
-			}
-			return -1;
-		}
-		posn += size;
-	} while (posn < objsize);
-	return 0;
+	return write_sha1_to_fd(fd_out, sha1);
 }
 
 static int serve_version(int fd_in, int fd_out)
@@ -76,6 +63,10 @@
 			return -1;
 		posn++;
 	} while (ref[posn - 1]);
+
+	if (verbose)
+		fprintf(stderr, "Serving %s\n", ref);
+
 	if (get_ref_sha1(ref, sha1))
 		remote = -1;
 	write(fd_out, &remote, 1);
