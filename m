From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] Expose more sha1_file.c interfaces
Date: Fri, 3 Jun 2005 11:08:16 -0400
Message-ID: <20050603150816.GA3738@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 03 17:06:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDjq-00007F-Rv
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 17:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFCPIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 11:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFCPIl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 11:08:41 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:54956 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261316AbVFCPIR
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 11:08:17 -0400
Received: by timesys.com (Postfix, from userid 623)
	id AC53B16E0B; Fri,  3 Jun 2005 11:08:16 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Expose more SHA1 file interfaces:

/* Unpack the rest of a SHA1 file, after using unpack_sha1_header()
 */
void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size);

/* Copy SHA1 object file between FDs, and verify that the SHA1 is as
 * expected. Useful for pulling from a socket into a temporary file
 * before you run object reference dependency checks. (Hint Hint people
 * maintaining pull.c!)
 */
int write_sha1_from_fd_to_fd(const unsigned char *sha1, int fd, int fd_local);

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -153,6 +153,7 @@ extern char *sha1_file_name(const unsign
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
 extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
+extern void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
@@ -162,6 +163,7 @@ extern int check_sha1_signature(const un
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage);
 
+extern int write_sha1_from_fd_to_fd(const unsigned char *sha1, int fd, int fd_local);
 extern int write_sha1_from_fd(const unsigned char *sha1, int fd);
 
 extern int has_sha1_file(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -579,23 +579,15 @@ int write_sha1_file(void *buf, unsigned 
 	return 0;
 }
 
-int write_sha1_from_fd(const unsigned char *sha1, int fd)
+int write_sha1_from_fd_to_fd(const unsigned char *sha1, int fd, int local)
 {
-	char *filename = sha1_file_name(sha1);
-
-	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
 	unsigned char buf[4096];
 	unsigned char discard[4096];
-	int ret;
+	int ret, compressed_size=0;
 	SHA_CTX c;
 
-	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-
-	if (local < 0)
-		return error("Couldn't open %s\n", filename);
-
 	memset(&stream, 0, sizeof(stream));
 
 	inflateInit(&stream);
@@ -606,13 +598,12 @@ int write_sha1_from_fd(const unsigned ch
 		ssize_t size;
 		size = read(fd, buf, 4096);
 		if (size <= 0) {
-			close(local);
-			unlink(filename);
 			if (!size)
 				return error("Connection closed?");
 			perror("Reading from connection");
 			return -1;
 		}
+		compressed_size += size;
 		write(local, buf, size);
 		stream.avail_in = size;
 		stream.next_in = buf;
@@ -627,18 +618,35 @@ int write_sha1_from_fd(const unsigned ch
 	} while (ret == Z_OK);
 	inflateEnd(&stream);
 
-	close(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
-		unlink(filename);
 		return error("File %s corrupted", sha1_to_hex(sha1));
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(filename);
 		return error("File %s has bad hash\n", sha1_to_hex(sha1));
 	}
 	
-	return 0;
+	return compressed_size;
+}
+
+int write_sha1_from_fd(const unsigned char *sha1, int fd)
+{
+	char *filename = sha1_file_name(sha1);
+
+	int local;
+	int ret;
+
+	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+
+	if (local < 0)
+		return error("Couldn't open %s\n", filename);
+
+	ret = write_sha1_from_fd_to_fd(sha1, fd, local);
+	close(local);
+	if (ret < 0)
+		unlink(filename);
+
+	return ret;
 }
 
 int has_sha1_file(const unsigned char *sha1)
======== end ========

-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
