From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] GIT: Create tar archives of tree on the fly
Date: Sat, 30 Apr 2005 03:22:58 +0200
Message-ID: <20050430012258.GA13930@lsrfire.ath.cx>
References: <20050426144222.GA12035@lsrfire.ath.cx> <Pine.LNX.4.58.0504291522250.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 04:18:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRhXf-0003a3-6g
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 04:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbVD3BXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 21:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbVD3BXQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 21:23:16 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:48543 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S263117AbVD3BW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 21:22:59 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id A832441A; Sat, 30 Apr 2005 03:22:58 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291522250.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 03:26:14PM -0700, Linus Torvalds wrote:
> 
> 
> Having just done the git-0.7.tar.gz file with git-tar-tree, I started 
> wondering if there is some nice way to encode the commit version that got 
> tarred up into the tar archive itself.

... and here is the patch that changes git-tar-tree to add the commit ID
as a comment in a global pax header to the tar file.  Archivers ignore
this field.  A little sample program is included to read the ID from a
previously prepared archive.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Write commit ID to global extended pax header at the beginning of the tar
file, if possible.  get-tar-commit-id.c is an example program to get the
ID back out of such a tar archive.

---
commit 716d21c45ba1c329fb88febf4704a4ab629a3933
tree 72f4d42eac2cd9099a663c16cb8201f90a8ff9c9
parent 0fc65a4572625405ff6dd9d8c16d835f2b1ebd49
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1114812895 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1114812895 +0200

Index: get-tar-commit-id.c
===================================================================
--- /dev/null  (tree:c1546808797f6a3c4e6ae82069cee3dc316fbf24)
+++ 72f4d42eac2cd9099a663c16cb8201f90a8ff9c9/get-tar-commit-id.c  (mode:100644 sha1:a1a17e53d29136df431d2a128292d7aefefaea41)
@@ -0,0 +1,27 @@
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#define HEADERSIZE	1024
+
+int main(int argc, char **argv)
+{
+	char buffer[HEADERSIZE];
+	ssize_t n;
+
+	n = read(0, buffer, HEADERSIZE);
+	if (n < HEADERSIZE) {
+		fprintf(stderr, "read error\n");
+		return 3;
+	}
+	if (buffer[156] != 'g')
+		return 1;
+	if (memcmp(&buffer[512], "52 comment=", 11))
+		return 1;
+	n = write(1, &buffer[523], 41);
+	if (n < 41) {
+		fprintf(stderr, "write error\n");
+		return 2;
+	}
+	return 0;
+}
Index: tar-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/tar-tree.c  (mode:100644 sha1:5cc7cfef6db1269d81589b82255537fb64ba02fa)
+++ 72f4d42eac2cd9099a663c16cb8201f90a8ff9c9/tar-tree.c  (mode:100644 sha1:ea7ea91add54532c38dde9e343efe34d56805341)
@@ -160,7 +160,7 @@
 	return len;
 }
 
-static void write_header(const char *, const char *, struct path_prefix *,
+static void write_header(const char *, char, const char *, struct path_prefix *,
                          const char *, unsigned int, unsigned long);
 
 /* stores a pax extended header directly in the block buffer */
@@ -169,7 +169,7 @@
                                   struct path_prefix *prefix,
                                   const char *path, unsigned int namelen)
 {
-	char *records, *p;
+	char *p;
 	unsigned int size = 1 + 6 + namelen + 1;
 	if (size > 9)
 		size++;
@@ -177,12 +177,10 @@
 		size++;
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
-	write_header(NULL, NULL, NULL, headerfilename, 0100600, size);
-
-	records = block + offset;
-	memset(records, 0, RECORDSIZE);
+	write_header(NULL, 'x', NULL, NULL, headerfilename, 0100600, size);
+	p = block + offset;
+	memset(p, 0, RECORDSIZE);
 	offset += RECORDSIZE;
-	p = records;
 	append_long(&p, size);
 	append_string(&p, " path=");
 	append_path(&p, is_dir, basepath, prefix, path);
@@ -190,8 +188,22 @@
 	write_if_needed();
 }
 
+static void write_global_extended_header(const char *sha1)
+{
+	char *p;
+	write_header(NULL, 'g', NULL, NULL, "pax_global_header", 0, 52);
+	p = block + offset;
+	memset(p, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	append_long(&p, 52);	/* 2 + 9 + 40 + 1 */
+	append_string(&p, " comment=");
+	append_string(&p, sha1_to_hex(sha1));
+	append_char(&p, '\n');
+	write_if_needed();
+}
+
 /* stores a ustar header directly in the block buffer */
-static void write_header(const char *sha1, const char *basepath,
+static void write_header(const char *sha1, char typeflag, const char *basepath,
                          struct path_prefix *prefix, const char *path,
                          unsigned int mode, unsigned long size)
 {
@@ -236,11 +248,7 @@
 	sprintf(&header[124], "%011lo", S_ISDIR(mode) ? 0 : size);
 	sprintf(&header[136], "%011lo", archive_time);
 
-	/* typeflag */
-	if (!sha1)
-		header[156] = 'x';	/* extended header */
-	else
-		header[156] = S_ISDIR(mode) ? '5' : '0';
+	header[156] = typeflag;
 
 	memcpy(&header[257], "ustar", 6);
 	memcpy(&header[263], "00", 2);
@@ -279,7 +287,8 @@
 		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
 		if (!eltbuf)
 			die("cannot read %s", sha1_to_hex(sha1));
-		write_header(sha1, basedir, prefix, path, mode, eltsize);
+		write_header(sha1, S_ISDIR(mode) ? '5' : '0', basedir,
+		             prefix, path, mode, eltsize);
 		if (!strcmp(elttype, "tree")) {
 			this_prefix.name = path;
 			traverse_tree(eltbuf, eltsize, &this_prefix);
@@ -320,6 +329,7 @@
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
+	unsigned char commit_sha1[20];
 	void *buffer;
 	unsigned long size;
 
@@ -339,8 +349,9 @@
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
 
-	buffer = read_object_with_reference(sha1, "commit", &size, NULL);
+	buffer = read_object_with_reference(sha1, "commit", &size, commit_sha1);
 	if (buffer) {
+		write_global_extended_header(commit_sha1);
 		archive_time = commit_time(buffer, size);
 		free(buffer);
 	}
@@ -351,7 +362,7 @@
 	if (!archive_time)
 		archive_time = time(NULL);
 	if (basedir)
-		write_header("0", NULL, NULL, basedir, 040755, 0);
+		write_header("0", '5', NULL, NULL, basedir, 040755, 0);
 	traverse_tree(buffer, size, NULL);
 	free(buffer);
 	write_trailer();
