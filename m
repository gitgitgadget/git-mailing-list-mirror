From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Allow saving an object from a pipe
Date: Sat, 10 Dec 2005 17:25:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512101724290.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 23:24:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElD8y-0005Uf-Cw
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 23:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLJWYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVLJWYh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 17:24:37 -0500
Received: from iabervon.org ([66.92.72.58]:37637 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750731AbVLJWYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 17:24:37 -0500
Received: (qmail 4245 invoked by uid 1000); 10 Dec 2005 17:25:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2005 17:25:25 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13474>

In order to support getting data into git with scripts, this adds a
--stdin option to git-hash-object, which will make it read from stdin.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 Documentation/git-hash-object.txt |    3 +++
 cache.h                           |    1 +
 hash-object.c                     |   15 +++++++++++++--
 sha1_file.c                       |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

fac4c3a5c27839006e5d086ef282b252bd5f390e
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index db12e92..eaac4c9 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -29,6 +29,9 @@ OPTIONS
 -w::
 	Actually write the object into the object database.
 
+--stdin::
+	Read the object from standard input instead of from a file.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
diff --git a/cache.h b/cache.h
index 86fc250..c78d8ae 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ extern int ce_match_stat(struct cache_en
 extern int ce_modified(struct cache_entry *ce, struct stat *st);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
+extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
diff --git a/hash-object.c b/hash-object.c
index 6227936..6502b5b 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -21,8 +21,16 @@ static void hash_object(const char *path
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
+static void hash_stdin(const char *type, int write_object)
+{
+	unsigned char sha1[20];
+	if (index_pipe(sha1, 0, type, write_object))
+		die("Unable to add stdin to database");
+	printf("%s\n", sha1_to_hex(sha1));
+}
+
 static const char hash_object_usage[] =
-"git-hash-object [-t <type>] [-w] <file>...";
+"git-hash-object [-t <type>] [-w] [--stdin] <file>...";
 
 int main(int argc, char **argv)
 {
@@ -53,9 +61,12 @@ int main(int argc, char **argv)
 			}
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
+			else if (!strcmp(argv[i], "--stdin")) {
+				hash_stdin(type, write_object);
+			}
 			else
 				die(hash_object_usage);
-		}
+		} 
 		else {
 			const char *arg = argv[i];
 			if (0 <= prefix_length)
diff --git a/sha1_file.c b/sha1_file.c
index 111a71d..fa22e9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1528,6 +1528,40 @@ int has_sha1_file(const unsigned char *s
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
+int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
+{
+	unsigned long size = 4096;
+	char *buf = malloc(size);
+	int iret, ret;
+	unsigned long off = 0;
+	unsigned char hdr[50];
+	int hdrlen;
+	do {
+		iret = read(fd, buf + off, size - off);
+		if (iret > 0) {
+			off += iret;
+			if (off == size) {
+				size *= 2;
+				buf = realloc(buf, size);
+			}
+		}
+	} while (iret > 0);
+	if (iret < 0) {
+		free(buf);
+		return -1;
+	}
+	if (!type)
+		type = "blob";
+	if (write_object)
+		ret = write_sha1_file(buf, off, type, sha1);
+	else {
+		write_sha1_file_prepare(buf, off, type, sha1, hdr, &hdrlen);
+		ret = 0;
+	}
+	free(buf);
+	return ret;
+}
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type)
 {
 	unsigned long size = st->st_size;
-- 
0.99.9.GIT
