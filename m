From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: [PATCH 1/2] Again: remove the artificial restriction tagsize < 8kb
Date: Tue, 23 May 2006 20:19:04 +0200
Message-ID: <44735218.7070801@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090807030908060409010401"
X-From: git-owner@vger.kernel.org Tue May 23 20:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FibTE-0001vm-52
	for gcvg-git@gmane.org; Tue, 23 May 2006 20:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWEWSTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 14:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWEWSS7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 14:18:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:3767 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932116AbWEWSS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 14:18:59 -0400
Received: (qmail invoked by alias); 23 May 2006 18:18:57 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp043) with SMTP; 23 May 2006 20:18:57 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20616>

This is a multi-part message in MIME format.
--------------090807030908060409010401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------090807030908060409010401
Content-Type: text/plain;
 name="0001-remove-the-artificial-restriction-tagsize-8kb.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename*0="0001-remove-the-artificial-restriction-tagsize-8kb.txt"


Signed-off-by: Björn Engelmann <BjEngelmann@gmx.de>


---

430953ceafbc722226e2300b489e38938220d435
 cache.h     |    1 +
 mktag.c     |   19 +++++++++----------
 sha1_file.c |   46 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 46 insertions(+), 20 deletions(-)

430953ceafbc722226e2300b489e38938220d435
diff --git a/cache.h b/cache.h
index 4b7a439..19e90eb 100644
--- a/cache.h
+++ b/cache.h
@@ -154,6 +154,7 @@ extern int ce_match_stat(struct cache_en
 extern int ce_modified(struct cache_entry *ce, struct stat *st, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
+extern int read_pipe(int fd, char** return_buf, unsigned long* return_size);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
diff --git a/mktag.c b/mktag.c
index 2328878..f1598db 100644
--- a/mktag.c
+++ b/mktag.c
@@ -45,7 +45,7 @@ static int verify_tag(char *buffer, unsi
 	unsigned char sha1[20];
 	const char *object, *type_line, *tag_line, *tagger_line;
 
-	if (size < 64 || size > MAXSIZE-1)
+	if (size < 64)
 		return -1;
 	buffer[size] = 0;
 
@@ -105,8 +105,8 @@ static int verify_tag(char *buffer, unsi
 
 int main(int argc, char **argv)
 {
-	unsigned long size;
-	char buffer[MAXSIZE];
+	unsigned long size = 4096;
+	char *buffer = malloc(size);
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
@@ -114,13 +114,9 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
-	// Read the signature
-	size = 0;
-	for (;;) {
-		int ret = xread(0, buffer + size, MAXSIZE - size);
-		if (ret <= 0)
-			break;
-		size += ret;
+	if (read_pipe(0, &buffer, &size)) {
+		free(buffer);
+		die("could not read from stdin");
 	}
 
 	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
@@ -129,6 +125,9 @@ int main(int argc, char **argv)
 
 	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
 		die("unable to write tag file");
+
+	free(buffer);
+
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 2230010..e444d9d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1645,16 +1645,24 @@ int has_sha1_file(const unsigned char *s
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
-int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
+/*
+ * reads from fd as long as possible into a supplied buffer of size bytes.
+ * If neccessary the buffer's size is increased using realloc()
+ *
+ * returns 0 if anything went fine and -1 otherwise
+ *
+ * NOTE: both buf and size may change, but even when -1 is returned
+ * you still have to free() it yourself.
+ */
+int read_pipe(int fd, char** return_buf, unsigned long* return_size)
 {
-	unsigned long size = 4096;
-	char *buf = malloc(size);
-	int iret, ret;
+	char* buf = *return_buf;
+	unsigned long size = *return_size;
+	int iret;
 	unsigned long off = 0;
-	unsigned char hdr[50];
-	int hdrlen;
+
 	do {
-		iret = read(fd, buf + off, size - off);
+		iret = xread(fd, buf + off, size - off);
 		if (iret > 0) {
 			off += iret;
 			if (off == size) {
@@ -1663,16 +1671,34 @@ int index_pipe(unsigned char *sha1, int 
 			}
 		}
 	} while (iret > 0);
-	if (iret < 0) {
+
+	*return_buf = buf;
+	*return_size = off;
+
+	if (iret < 0)
+		return -1;
+	return 0;
+}
+
+int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
+{
+	unsigned long size = 4096;
+	char *buf = malloc(size);
+	int ret;
+	unsigned char hdr[50];
+	int hdrlen;
+
+	if (read_pipe(fd, &buf, &size)) {
 		free(buf);
 		return -1;
 	}
+
 	if (!type)
 		type = blob_type;
 	if (write_object)
-		ret = write_sha1_file(buf, off, type, sha1);
+		ret = write_sha1_file(buf, size, type, sha1);
 	else {
-		write_sha1_file_prepare(buf, off, type, sha1, hdr, &hdrlen);
+		write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
 		ret = 0;
 	}
 	free(buf);
-- 
1.3.3.g4309-dirty


--------------090807030908060409010401--
