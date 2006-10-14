From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] Add hash_sha1_file()
Date: Sat, 14 Oct 2006 12:45:36 +0200
Message-ID: <4530BFD0.6040008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 14 12:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYh1E-0005AE-Qk
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 12:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbWJNKpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 06:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWJNKpR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 06:45:17 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:45291
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1752135AbWJNKpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 06:45:15 -0400
Received: from [10.0.1.3] (p508E51C5.dip.t-dialin.net [80.142.81.197])
	by neapel230.server4you.de (Postfix) with ESMTP id 051C02603B;
	Sat, 14 Oct 2006 12:45:13 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28874>

Most callers of write_sha1_file_prepare() are only interested in the
resulting hash but don't care about the returned file name or the header.
This patch adds a simple wrapper named hash_sha1_file() which does just
that, and converts potential callers.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-apply.c   |    8 ++------
 cache-tree.c      |    8 ++------
 cache.h           |    1 +
 merge-recursive.c |    5 +----
 sha1_file.c       |   34 ++++++++++++++++------------------
 5 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e3ef044..cbe5977 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1783,8 +1783,6 @@ static int apply_binary(struct buffer_de
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
-	unsigned char hdr[50];
-	int hdrlen;
 
 	/* For safety, we require patch index line to contain
 	 * full 40-byte textual SHA1 for old and new, at least for now.
@@ -1800,8 +1798,7 @@ static int apply_binary(struct buffer_de
 		/* See if the old one matches what the patch
 		 * applies to.
 		 */
-		write_sha1_file_prepare(desc->buffer, desc->size,
-					blob_type, sha1, hdr, &hdrlen);
+		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
 			return error("the patch applies to '%s' (%s), "
 				     "which does not match the "
@@ -1846,8 +1843,7 @@ static int apply_binary(struct buffer_de
 				     name);
 
 		/* verify that the result matches */
-		write_sha1_file_prepare(desc->buffer, desc->size, blob_type,
-					sha1, hdr, &hdrlen);
+		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
 			return error("binary patch to '%s' creates incorrect result (expecting %s, got %s)", name, patch->new_sha1_prefix, sha1_to_hex(sha1));
 	}
diff --git a/cache-tree.c b/cache-tree.c
index 323c68a..d388848 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -344,12 +344,8 @@ #if DEBUG
 #endif
 	}
 
-	if (dryrun) {
-		unsigned char hdr[200];
-		int hdrlen;
-		write_sha1_file_prepare(buffer, offset, tree_type, it->sha1,
-					hdr, &hdrlen);
-	}
+	if (dryrun)
+		hash_sha1_file(buffer, offset, tree_type, it->sha1);
 	else
 		write_sha1_file(buffer, offset, tree_type, it->sha1);
 	free(buffer);
diff --git a/cache.h b/cache.h
index 97debd0..aa3a562 100644
--- a/cache.h
+++ b/cache.h
@@ -245,6 +245,7 @@ char *enter_repo(char *path, int strict)
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern char *write_sha1_file_prepare(void *buf,
 				     unsigned long len,
diff --git a/merge-recursive.c b/merge-recursive.c
index 611cd95..2ba43ae 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1235,13 +1235,10 @@ int merge(struct commit *h1,
 	if (merged_common_ancestors == NULL) {
 		/* if there is no common ancestor, make an empty tree */
 		struct tree *tree = xcalloc(1, sizeof(struct tree));
-		unsigned char hdr[40];
-		int hdrlen;
 
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
-		write_sha1_file_prepare(NULL, 0, tree_type, tree->object.sha1,
-					hdr, &hdrlen);
+		hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/sha1_file.c b/sha1_file.c
index 27b1ebb..6c64ec4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1501,6 +1501,15 @@ static void setup_object_header(z_stream
 	stream->avail_out -= hdr;
 }
 
+int hash_sha1_file(void *buf, unsigned long len, const char *type,
+                   unsigned char *sha1)
+{
+	unsigned char hdr[50];
+	int hdrlen;
+	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	return 0;
+}
+
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
@@ -1784,8 +1793,6 @@ int index_pipe(unsigned char *sha1, int 
 	unsigned long size = 4096;
 	char *buf = xmalloc(size);
 	int ret;
-	unsigned char hdr[50];
-	int hdrlen;
 
 	if (read_pipe(fd, &buf, &size)) {
 		free(buf);
@@ -1796,10 +1803,8 @@ int index_pipe(unsigned char *sha1, int 
 		type = blob_type;
 	if (write_object)
 		ret = write_sha1_file(buf, size, type, sha1);
-	else {
-		write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
-		ret = 0;
-	}
+	else
+		ret = hash_sha1_file(buf, size, type, sha1);
 	free(buf);
 	return ret;
 }
@@ -1809,8 +1814,6 @@ int index_fd(unsigned char *sha1, int fd
 	unsigned long size = st->st_size;
 	void *buf;
 	int ret;
-	unsigned char hdr[50];
-	int hdrlen;
 
 	buf = "";
 	if (size)
@@ -1823,10 +1826,8 @@ int index_fd(unsigned char *sha1, int fd
 		type = blob_type;
 	if (write_object)
 		ret = write_sha1_file(buf, size, type, sha1);
-	else {
-		write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
-		ret = 0;
-	}
+	else
+		ret = hash_sha1_file(buf, size, type, sha1);
 	if (size)
 		munmap(buf, size);
 	return ret;
@@ -1855,12 +1856,9 @@ int index_path(unsigned char *sha1, cons
 			return error("readlink(\"%s\"): %s", path,
 			             errstr);
 		}
-		if (!write_object) {
-			unsigned char hdr[50];
-			int hdrlen;
-			write_sha1_file_prepare(target, st->st_size, blob_type,
-						sha1, hdr, &hdrlen);
-		} else if (write_sha1_file(target, st->st_size, blob_type, sha1))
+		if (!write_object)
+			hash_sha1_file(target, st->st_size, blob_type, sha1);
+		else if (write_sha1_file(target, st->st_size, blob_type, sha1))
 			return error("%s: failed to insert into database",
 				     path);
 		free(target);
-- 
1.4.3.rc2.gdce3
