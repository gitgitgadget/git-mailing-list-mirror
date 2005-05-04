From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Careful object pulling
Date: Wed, 4 May 2005 00:07:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505040004290.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 06:01:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTB4v-0001lw-NT
	for gcvg-git@gmane.org; Wed, 04 May 2005 06:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVEDEHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 00:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEDEHz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 00:07:55 -0400
Received: from iabervon.org ([66.92.72.58]:35077 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262006AbVEDEHT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 00:07:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DTBAA-0004gw-00; Wed, 4 May 2005 00:07:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This splits out the careful methods for writing a file and placing it in
the correct location from the function to write a buffer to the file and
makes the various functions used by git-*-pull programs use those
functions to write their files.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: cache.h
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/cache.h  (mode:100644 sha1:8dd812827604d510038f5d93e3718c43f9d12c30)
+++ 4e31436bacfff09ce673665a1061b41e37ffd661/cache.h  (mode:100644 sha1:0d7411c3b86a899cee45627997f4bb7ba0df2ea7)
@@ -134,6 +134,12 @@
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
+/* Open a file for writing a sha1 file. */
+extern int open_sha1_tmpfile(char tmpfile[PATH_MAX]);
+
+/* Put a sha1 file in the correct place. */
+extern int place_sha1_file(char tmpfile[PATH_MAX], const unsigned char *sha1);
+
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /* Read a tree into the cache */
Index: http-pull.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/http-pull.c  (mode:100644 sha1:f693aba61b4dcb4b738faf1335ec74aa1545e45d)
+++ 4e31436bacfff09ce673665a1061b41e37ffd661/http-pull.c  (mode:100644 sha1:793d8b9e125c1f164f774e2888d26beaa75e1df0)
@@ -52,8 +52,9 @@
 	char real_sha1[20];
 	char *url;
 	char *posn;
+	char tmpname[PATH_MAX];
 
-	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	local = open_sha1_tmpfile(tmpname);
 
 	if (local < 0)
 		return error("Couldn't open %s\n", filename);
@@ -88,15 +89,14 @@
 	inflateEnd(&stream);
 	SHA1_Final(real_sha1, &c);
 	if (zret != Z_STREAM_END) {
-		unlink(filename);
+		unlink(tmpname);
 		return error("File %s (%s) corrupt\n", hex, url);
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(filename);
+		unlink(tmpname);
 		return error("File %s has bad hash\n", hex);
 	}
-	
-	return 0;
+	return place_sha1_file(tmpname, sha1);
 }
 
 int main(int argc, char **argv)
Index: sha1_file.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/sha1_file.c  (mode:100644 sha1:e6ce455ae90bd430f2128f454bdb6e0575412486)
+++ 4e31436bacfff09ce673665a1061b41e37ffd661/sha1_file.c  (mode:100644 sha1:85daa0b0045c3f19e697d1a7aa8ab15ff54eab99)
@@ -276,6 +276,55 @@
 	}
 }
 
+int open_sha1_tmpfile(char tmpfile[PATH_MAX])
+{
+	int fd;
+
+	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	fd = mkstemp(tmpfile);
+	if (fd < 0) {
+		fprintf(stderr,
+			"unable to create temporary sha1 filename %s: %s",
+			tmpfile, strerror(errno));
+		return -1;
+	}
+	return fd;
+}
+
+int place_sha1_file(char tmpfile[PATH_MAX], const unsigned char *sha1)
+{
+	char *filename = sha1_file_name(sha1);
+	int ret;
+
+	ret = link(tmpfile, filename);
+	if (ret < 0) {
+		ret = errno;
+
+		/*
+		 * Coda hack - coda doesn't like cross-directory links,
+		 * so we fall back to a rename, which will mean that it
+		 * won't be able to check collisions, but that's not a
+		 * big deal.
+		 *
+		 * When this succeeds, we just return 0. We have nothing
+		 * left to unlink.
+		 */
+		if (ret == EXDEV && !rename(tmpfile, filename))
+			return 0;
+	}
+	unlink(tmpfile);
+	if (ret) {
+		if (ret != EEXIST) {
+			fprintf(stderr,
+				"unable to write sha1 filename %s: %s", 
+				filename, strerror(ret));
+			return -1;
+		}
+		/* FIXME!!! Collision check here ? */
+	}
+	return 0;
+}
+
 int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
@@ -286,7 +335,7 @@
 	char *filename;
 	static char tmpfile[PATH_MAX];
 	char hdr[50];
-	int fd, hdrlen, ret;
+	int fd, hdrlen;
 
 	/* Generate the header */
 	hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
@@ -316,12 +365,9 @@
 		return -1;
 	}
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
-	fd = mkstemp(tmpfile);
-	if (fd < 0) {
-		fprintf(stderr, "unable to create temporary sha1 filename %s: %s", tmpfile, strerror(errno));
-		return -1;
-	}
+	fd = open_sha1_tmpfile(tmpfile);
+	if (fd < 0)
+		return fd;
 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
@@ -349,53 +395,28 @@
 
 	if (write(fd, compressed, size) != size)
 		die("unable to write file");
+
 	fchmod(fd, 0444);
 	close(fd);
 
-	ret = link(tmpfile, filename);
-	if (ret < 0) {
-		ret = errno;
-
-		/*
-		 * Coda hack - coda doesn't like cross-directory links,
-		 * so we fall back to a rename, which will mean that it
-		 * won't be able to check collisions, but that's not a
-		 * big deal.
-		 *
-		 * When this succeeds, we just return 0. We have nothing
-		 * left to unlink.
-		 */
-		if (ret == EXDEV && !rename(tmpfile, filename))
-			return 0;
-	}
-	unlink(tmpfile);
-	if (ret) {
-		if (ret != EEXIST) {
-			fprintf(stderr, "unable to write sha1 filename %s: %s", filename, strerror(ret));
-			return -1;
-		}
-		/* FIXME!!! Collision check here ? */
-	}
-
-	return 0;
+	return place_sha1_file(tmpfile, sha1);
 }
 
 int write_sha1_from_fd(const unsigned char *sha1, int fd)
 {
-	char *filename = sha1_file_name(sha1);
-
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
 	char buf[4096];
 	char discard[4096];
+	char tmpname[PATH_MAX];
 	int ret;
 	SHA_CTX c;
 
-	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	local = open_sha1_tmpfile(tmpname);
 
 	if (local < 0)
-		return error("Couldn't open %s\n", filename);
+		return -1;
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -408,7 +429,7 @@
 		size = read(fd, buf, 4096);
 		if (size <= 0) {
 			close(local);
-			unlink(filename);
+			unlink(tmpname);
 			if (!size)
 				return error("Connection closed?");
 			perror("Reading from connection");
@@ -431,15 +452,15 @@
 	close(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
-		unlink(filename);
+		unlink(tmpname);
 		return error("File %s corrupted", sha1_to_hex(sha1));
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(filename);
+		unlink(tmpname);
 		return error("File %s has bad hash\n", sha1_to_hex(sha1));
 	}
-	
-	return 0;
+
+	return place_sha1_file(tmpname, sha1);
 }
 
 int has_sha1_file(const unsigned char *sha1)

