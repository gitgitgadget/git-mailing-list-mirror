From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] index-pack: use hash_sha1_file()
Date: Tue, 20 Mar 2007 16:02:09 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703201557280.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 21:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTkXg-00025g-W0
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 21:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbXCTUCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 16:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbXCTUCM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 16:02:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55482 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbXCTUCK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 16:02:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF700HE0WZLF2Q0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 16:02:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42759>

Use hash_sha1_file() instead of duplicating code to compute object SHA1.
While at it make it accept a const pointer.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

This applies on top of my previous patch.

diff --git a/cache.h b/cache.h
index 1b50a74..384b260 100644
--- a/cache.h
+++ b/cache.h
@@ -283,7 +283,7 @@ char *enter_repo(char *path, int strict);
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
-extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
+extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 
diff --git a/index-pack.c b/index-pack.c
index 4effb2d..f314937 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -348,26 +348,7 @@ static void sha1_object(const void *data, unsigned long size,
 			enum object_type type, unsigned char *sha1,
 			int test_for_collision)
 {
-	SHA_CTX ctx;
-	char header[50];
-	int header_size;
-	const char *type_str;
-
-	switch (type) {
-	case OBJ_COMMIT: type_str = commit_type; break;
-	case OBJ_TREE:   type_str = tree_type; break;
-	case OBJ_BLOB:   type_str = blob_type; break;
-	case OBJ_TAG:    type_str = tag_type; break;
-	default:
-		die("bad type %d", type);
-	}
-
-	header_size = sprintf(header, "%s %lu", type_str, size) + 1;
-
-	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, header, header_size);
-	SHA1_Update(&ctx, data, size);
-	SHA1_Final(sha1, &ctx);
+	hash_sha1_file(data, size, typename(type), sha1);
 
 	if (test_for_collision && has_sha1_file(sha1)) {
 		void *has_data;
diff --git a/sha1_file.c b/sha1_file.c
index c445a24..64d9813 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1808,7 +1808,7 @@ void *read_object_with_reference(const unsigned char *sha1,
 	}
 }
 
-static void write_sha1_file_prepare(void *buf, unsigned long len,
+static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
                                     char *hdr, int *hdrlen)
 {
@@ -1936,7 +1936,7 @@ static void setup_object_header(z_stream *stream, const char *type, unsigned lon
 	stream->avail_out -= hdrlen;
 }
 
-int hash_sha1_file(void *buf, unsigned long len, const char *type,
+int hash_sha1_file(const void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
 	char hdr[32];
