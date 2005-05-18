From: Brian Gerst <bgerst@didntduck.org>
Subject: [PATCH] Kill a bunch of pointer sign warnings for gcc4
Date: Wed, 18 May 2005 08:14:09 -0400
Message-ID: <428B3191.2090206@didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000703010200020900020309"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 14:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYNQ1-00051R-26
	for gcvg-git@gmane.org; Wed, 18 May 2005 14:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVERMNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVERMNf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 08:13:35 -0400
Received: from quark.didntduck.org ([69.55.226.66]:39063 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261254AbVERMNM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 08:13:12 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j4ICD3705460;
	Wed, 18 May 2005 08:13:03 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000703010200020900020309
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

- Raw hashes should be unsigned char.
- String functions want signed char.
- Hash and compress functions want unsigned char.

Signed-off By: Brian Gerst <bgerst@didntduck.org>
----------------------------

PS.
tar-tree.c: In function ‘main’:
tar-tree.c:437: warning: pointer targets in passing argument 1 of 
‘write_header’ differ in signedness

The "0" looks bogus, since it should be a raw hash not a text string.


--------------000703010200020900020309
Content-Type: text/x-patch;
 name="ptrsign.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptrsign.diff"

Kill a bunch of pointer sign warnings for gcc4.

---
commit 9d6d4056081ea693b9d0b28a1507921328df0b26
tree 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3
parent 02481aec2a2cfce7bc47d0d10876be5507f0b7ba
author <bgerst@citadel.(none)> Wed, 18 May 2005 07:59:28 -0400
committer <bgerst@citadel.(none)> Wed, 18 May 2005 07:59:28 -0400

 cache.h      |    4 ++--
 diff-cache.c |    2 +-
 diff-files.c |    4 ++--
 http-pull.c  |    4 ++--
 ls-tree.c    |    2 +-
 read-cache.c |    2 +-
 rpush.c      |    2 +-
 sha1_file.c  |   18 +++++++++---------
 strbuf.h     |    2 +-
 tar-tree.c   |    6 +++---
 10 files changed, 23 insertions(+), 23 deletions(-)

Index: cache.h
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/cache.h  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/cache.h  (mode:100644)
@@ -143,7 +143,7 @@
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
-extern int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
@@ -167,7 +167,7 @@
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
-					const unsigned char *required_type,
+					const char *required_type,
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
Index: diff-cache.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/diff-cache.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/diff-cache.c  (mode:100644)
@@ -63,7 +63,7 @@
 {
 	unsigned int mode, oldmode;
 	unsigned char *sha1;
-	unsigned char old_sha1_hex[60];
+	char old_sha1_hex[60];
 
 	if (get_stat_data(new, &sha1, &mode) < 0) {
 		if (report_missing)
Index: diff-files.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/diff-files.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/diff-files.c  (mode:100644)
@@ -48,7 +48,7 @@
 }
 
 static void show_modified(int oldmode, int mode,
-			  const char *old_sha1, const char *sha1,
+			  const unsigned char *old_sha1, const unsigned char *sha1,
 			  char *path)
 {
 	char old_sha1_hex[41];
@@ -64,7 +64,7 @@
 
 int main(int argc, char **argv)
 {
-	static const char null_sha1[20] = { 0, };
+	static const unsigned char null_sha1[20] = { 0, };
 	int entries = read_cache();
 	int i;
 
Index: http-pull.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/http-pull.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/http-pull.c  (mode:100644)
@@ -24,7 +24,7 @@
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb, 
 			       void *data) {
-	char expn[4096];
+	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
 	int posn = 0;
 	do {
@@ -49,7 +49,7 @@
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
-	char real_sha1[20];
+	unsigned char real_sha1[20];
 	char *url;
 	char *posn;
 
Index: ls-tree.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/ls-tree.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/ls-tree.c  (mode:100644)
@@ -24,7 +24,7 @@
 }
 
 static void list_recursive(void *buffer,
-			   const unsigned char *type,
+			   const char *type,
 			   unsigned long size,
 			   struct path_prefix *prefix)
 {
Index: read-cache.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/read-cache.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/read-cache.c  (mode:100644)
@@ -344,7 +344,7 @@
 }
 
 #define WRITE_BUFFER_SIZE 8192
-static char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
 static int ce_write(SHA_CTX *context, int fd, void *data, unsigned int len)
Index: rpush.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/rpush.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/rpush.c  (mode:100644)
@@ -6,7 +6,7 @@
 void service(int fd_in, int fd_out) {
 	ssize_t size;
 	int posn;
-	char sha1[20];
+	char unsigned sha1[20];
 	unsigned long objsize;
 	void *buf;
 	do {
Index: sha1_file.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/sha1_file.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/sha1_file.c  (mode:100644)
@@ -313,13 +313,13 @@
 	int ret, bytes;
 	z_stream stream;
 	char buffer[8192];
-	char *buf;
+	unsigned char *buf;
 
 	/* Get the data stream */
 	memset(&stream, 0, sizeof(stream));
 	stream.next_in = map;
 	stream.avail_in = mapsize;
-	stream.next_out = buffer;
+	stream.next_out = (unsigned char *)buffer;
 	stream.avail_out = sizeof(buffer);
 
 	inflateInit(&stream);
@@ -359,7 +359,7 @@
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
-				 const unsigned char *required_type,
+				 const char *required_type,
 				 unsigned long *size,
 				 unsigned char *actual_sha1_return)
 {
@@ -403,20 +403,20 @@
 	}
 }
 
-int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
-	char *compressed;
+	unsigned char *compressed;
 	z_stream stream;
 	unsigned char sha1[20];
 	SHA_CTX c;
 	char *filename;
 	static char tmpfile[PATH_MAX];
-	char hdr[50];
+	unsigned char hdr[50];
 	int fd, hdrlen, ret;
 
 	/* Generate the header */
-	hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+	hdrlen = sprintf((char *)hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	SHA1_Init(&c);
@@ -516,8 +516,8 @@
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
-	char buf[4096];
-	char discard[4096];
+	unsigned char buf[4096];
+	unsigned char discard[4096];
 	int ret;
 	SHA_CTX c;
 
Index: strbuf.h
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/strbuf.h  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/strbuf.h  (mode:100644)
@@ -4,7 +4,7 @@
 	int alloc;
 	int len;
 	int eof;
-	unsigned char *buf;
+	char *buf;
 };
 
 extern void strbuf_init(struct strbuf *);
Index: tar-tree.c
===================================================================
--- 2b3e8f627f4b8338e1479f6011052d2f6c0e2468/tar-tree.c  (mode:100644)
+++ 6da6a42bd7b97ea6ebd79544f4fb16713ac74dc3/tar-tree.c  (mode:100644)
@@ -205,7 +205,7 @@
 	append_char(p, '\n');
 }
 
-static void write_header(const char *, char, const char *, struct path_prefix *,
+static void write_header(const unsigned char *, char, const char *, struct path_prefix *,
                          const char *, unsigned int, void *, unsigned long);
 
 /* stores a pax extended header directly in the block buffer */
@@ -238,7 +238,7 @@
 	free(buffer);
 }
 
-static void write_global_extended_header(const char *sha1)
+static void write_global_extended_header(const unsigned char *sha1)
 {
 	char *p;
 	unsigned int size;
@@ -253,7 +253,7 @@
 }
 
 /* stores a ustar header directly in the block buffer */
-static void write_header(const char *sha1, char typeflag, const char *basepath,
+static void write_header(const unsigned char *sha1, char typeflag, const char *basepath,
                          struct path_prefix *prefix, const char *path,
                          unsigned int mode, void *buffer, unsigned long size)
 {


--------------000703010200020900020309--
