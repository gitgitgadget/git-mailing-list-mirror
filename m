From: mikukkon@miku.homelinux.net (Mika Kukkonen)
Subject: [PATCH] Fix several gcc4 signedness warnings
Date: Tue, 21 Jun 2005 23:04:33 +0300
Message-ID: <20050621200433.GA7302@miku.homelinux.net>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 22:02:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkowr-0006Ls-Sm
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 22:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVFUUH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVFUUGG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 16:06:06 -0400
Received: from mato.luukku.com ([193.209.83.251]:20955 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S262295AbVFUUEp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 16:04:45 -0400
Received: from localhost (mta3-o.i.luukku.com [10.0.1.132])
	by mta3-o.i.luukku.com (Postfix) with ESMTP id E792EFF8B9;
	Tue, 21 Jun 2005 23:04:39 +0300 (EEST)
Received: from srv1-elite-lanp (7781.dsl.mtv3.fi [82.203.129.119])
	by mato.luukku.com (Postfix) with ESMTP id A2A3D22EE8D;
	Tue, 21 Jun 2005 23:04:39 +0300 (EEST)
Received: by srv1-elite-lanp (Postfix, from userid 1000)
	id 68714C2FB; Tue, 21 Jun 2005 23:04:35 +0300 (EEST)
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a patch that fixes several gcc4 warnings about different signedness,
all between char and unsigned char. I tried to keep the patch minimal
so resertod to casts in three places.

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

 mkdelta.c   |   12 ++++++------
 pull.c      |    2 +-
 sha1_file.c |    4 ++--
 ssh-push.c  |    2 +-
 tar-tree.c  |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

Index: git/sha1_file.c
===================================================================
--- git.orig/sha1_file.c
+++ git/sha1_file.c
@@ -332,7 +332,7 @@ int unpack_sha1_header(z_stream *stream,
 void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
 {
 	int bytes = strlen(buffer) + 1;
-	char *buf = xmalloc(1+size);
+	unsigned char *buf = xmalloc(1+size);
 
 	memcpy(buf, buffer + bytes, stream->total_out - bytes);
 	bytes = stream->total_out - bytes;
@@ -472,7 +472,7 @@ int sha1_file_size(const unsigned char *
 	 * The initial part of the delta starts at delta_data_head +
 	 * 20.  Borrow code from patch-delta to read the result size.
 	 */
-	data = hdr + strlen(hdr) + 1 + 20;
+	data = (unsigned char *)(hdr + strlen(hdr) + 1 + 20);
 
 	/* Skip over the source size; we are not interested in
 	 * it and we cannot verify it because we do not want
Index: git/ssh-push.c
===================================================================
--- git.orig/ssh-push.c
+++ git/ssh-push.c
@@ -8,7 +8,7 @@ unsigned char remote_version = 0;
 int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
 	int posn = 0;
-	char sha1[20];
+	unsigned char sha1[20];
 	unsigned long objsize;
 	void *buf;
 	signed char remote;
Index: git/pull.c
===================================================================
--- git.orig/pull.c
+++ git/pull.c
@@ -49,7 +49,7 @@ static int make_sure_we_have_it(const ch
 		return 0;
 
 	if (get_delta) {
-		char delta_sha1[20];
+		unsigned char delta_sha1[20];
 		status = sha1_delta_base(sha1, delta_sha1);
 		if (0 < status)
 			status = make_sure_we_have_it(what, delta_sha1);
Index: git/tar-tree.c
===================================================================
--- git.orig/tar-tree.c
+++ git/tar-tree.c
@@ -430,8 +430,8 @@ int main(int argc, char **argv)
 	if (!archive_time)
 		archive_time = time(NULL);
 	if (basedir)
-		write_header("0", TYPEFLAG_DIR, NULL, NULL, basedir, 040755,
-		             NULL, 0);
+		write_header((unsigned char *)"0", TYPEFLAG_DIR, NULL, NULL,
+			basedir, 040755, NULL, 0);
 	traverse_tree(buffer, size, NULL);
 	free(buffer);
 	write_trailer();
Index: git/mkdelta.c
===================================================================
--- git.orig/mkdelta.c
+++ git/mkdelta.c
@@ -36,10 +36,10 @@ static int replace_object(char *buf, uns
 	return 0;
 }
 
-static void *create_object(char *buf, unsigned long len, char *hdr, int hdrlen,
-			   unsigned long *retsize)
+static void *create_object(unsigned char *buf, unsigned long len,
+			   char *hdr, int hdrlen, unsigned long *retsize)
 {
-	char *compressed;
+	unsigned char *compressed;
 	unsigned long size;
 	z_stream stream;
 
@@ -54,7 +54,7 @@ static void *create_object(char *buf, un
 	stream.avail_out = size;
 
 	/* First header.. */
-	stream.next_in = hdr;
+	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
 		/* nothing */;
@@ -69,7 +69,7 @@ static void *create_object(char *buf, un
 	return compressed;
 }
 
-static int restore_original_object(char *buf, unsigned long len,
+static int restore_original_object(unsigned char *buf, unsigned long len,
 				   char *type, unsigned char *sha1)
 {
 	char hdr[50];
@@ -84,7 +84,7 @@ static int restore_original_object(char 
 	return ret;
 }
 
-static void *create_delta_object(char *buf, unsigned long len,
+static void *create_delta_object(unsigned char *buf, unsigned long len,
 				 unsigned char *sha1_ref, unsigned long *size)
 {
 	char hdr[50];

