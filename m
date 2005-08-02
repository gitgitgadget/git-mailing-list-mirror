From: barkalow@iabervon.org
Subject: [PATCH 3/3] Parallelize pulling by ssh
Date: Tue, 2 Aug 2005 19:46:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508021946130.23721@iabervon.org>
References: <Pine.LNX.4.62.0508021939320.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 01:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E06QA-0005Pc-KC
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 01:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVHBXng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVHBXng
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 19:43:36 -0400
Received: from iabervon.org ([66.92.72.58]:5387 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261928AbVHBXne (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 19:43:34 -0400
Received: (qmail 5097 invoked by uid 1000); 2 Aug 2005 19:46:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Aug 2005 19:46:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.62.0508021939320.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This causes ssh-pull to request objects in prefetch() and read then in
fetch(), such that it reduces the unpipelined round-trip time.

This also makes sha1_write_from_fd() support having a buffer of data
which it accidentally read from the fd after the object; this was
formerly not a problem, because it would always get a short read at
the end of an object, because the next object had not been
requested. This is no longer true.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 cache.h     |    3 ++-
 sha1_file.c |   37 ++++++++++++++++++++++---------------
 ssh-pull.c  |   44 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 24 deletions(-)

9bd15230cb65acc78a97550c9467f98a04720ee8
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -198,7 +198,8 @@ extern int check_sha1_signature(const un
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage, const char **paths);
 
-extern int write_sha1_from_fd(const unsigned char *sha1, int fd);
+extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
+			      size_t bufsize, size_t *bufposn);
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 
 extern int has_sha1_pack(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1389,14 +1389,14 @@ int write_sha1_to_fd(int fd, const unsig
 	return 0;
 }
 
-int write_sha1_from_fd(const unsigned char *sha1, int fd)
+int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
+		       size_t bufsize, size_t *bufposn)
 {
 	char *filename = sha1_file_name(sha1);
 
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
-	unsigned char buf[4096];
 	unsigned char discard[4096];
 	int ret;
 	SHA_CTX c;
@@ -1414,7 +1414,24 @@ int write_sha1_from_fd(const unsigned ch
 
 	do {
 		ssize_t size;
-		size = read(fd, buf, 4096);
+		if (*bufposn) {
+			stream.avail_in = *bufposn;
+			stream.next_in = buffer;
+			do {
+				stream.next_out = discard;
+				stream.avail_out = sizeof(discard);
+				ret = inflate(&stream, Z_SYNC_FLUSH);
+				SHA1_Update(&c, discard, sizeof(discard) -
+					    stream.avail_out);
+			} while (stream.avail_in && ret == Z_OK);
+			write(local, buffer, *bufposn - stream.avail_in);
+			memmove(buffer, buffer + *bufposn - stream.avail_in,
+				stream.avail_in);
+			*bufposn = stream.avail_in;
+			if (ret != Z_OK)
+				break;
+		}
+		size = read(fd, buffer + *bufposn, bufsize - *bufposn);
 		if (size <= 0) {
 			close(local);
 			unlink(filename);
@@ -1423,18 +1440,8 @@ int write_sha1_from_fd(const unsigned ch
 			perror("Reading from connection");
 			return -1;
 		}
-		write(local, buf, size);
-		stream.avail_in = size;
-		stream.next_in = buf;
-		do {
-			stream.next_out = discard;
-			stream.avail_out = sizeof(discard);
-			ret = inflate(&stream, Z_SYNC_FLUSH);
-			SHA1_Update(&c, discard, sizeof(discard) -
-				    stream.avail_out);
-		} while (stream.avail_in && ret == Z_OK);
-		
-	} while (ret == Z_OK);
+		*bufposn += size;
+	} while (1);
 	inflateEnd(&stream);
 
 	close(local);
diff --git a/ssh-pull.c b/ssh-pull.c
--- a/ssh-pull.c
+++ b/ssh-pull.c
@@ -10,24 +10,49 @@ static int fd_out;
 static unsigned char remote_version = 0;
 static unsigned char local_version = 1;
 
+ssize_t force_write(int fd, void *buffer, size_t length)
+{
+	ssize_t ret = 0;
+	while (ret < length) {
+		ssize_t size = write(fd, buffer + ret, length - ret);
+		if (size < 0) {
+			return size;
+		}
+		if (size == 0) {
+			return ret;
+		}
+		ret += size;
+	}
+	return ret;
+}
+
 void prefetch(unsigned char *sha1)
 {
+	char type = 'o';
+	force_write(fd_out, &type, 1);
+	force_write(fd_out, sha1, 20);
+	//memcpy(requested + 20 * prefetches++, sha1, 20);
 }
 
+static char conn_buf[4096];
+static size_t conn_buf_posn = 0;
+
 int fetch(unsigned char *sha1)
 {
 	int ret;
 	signed char remote;
-	char type = 'o';
-	if (has_sha1_file(sha1))
-		return 0;
-	write(fd_out, &type, 1);
-	write(fd_out, sha1, 20);
-	if (read(fd_in, &remote, 1) < 1)
-		return -1;
+
+	if (conn_buf_posn) {
+		remote = conn_buf[0];
+		memmove(conn_buf, conn_buf + 1, --conn_buf_posn);
+	} else {
+		if (read(fd_in, &remote, 1) < 1)
+			return -1;
+	}
+	//fprintf(stderr, "Got %d\n", remote);
 	if (remote < 0)
 		return remote;
-	ret = write_sha1_from_fd(sha1, fd_in);
+	ret = write_sha1_from_fd(sha1, fd_in, conn_buf, 4096, &conn_buf_posn);
 	if (!ret)
 		pull_say("got %s\n", sha1_to_hex(sha1));
 	return ret;
