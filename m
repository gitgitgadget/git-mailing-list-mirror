From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-local-pull updates
Date: Sun, 01 May 2005 20:41:51 -0700
Message-ID: <7vfyx6pa4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 05:36:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSRj4-0000xh-CD
	for gcvg-git@gmane.org; Mon, 02 May 2005 05:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVEBDmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 23:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVEBDl7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 23:41:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1942 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261454AbVEBDlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 23:41:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502034151.GCFX23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 23:41:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is to be applied on top of the previous patch to add
git-local-pull command.  In addition to the '-l' (attempt
hardlink before anything else) and the '-s' (then attempt
symlink) flags, it adds '-n' (do not fall back to file copy)
flag.  Also it updates the comments.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

local-pull.c |   65 +++++++++++++++++++++++++++++++++++++----------------------
1 files changed, 41 insertions(+), 24 deletions(-)

# jit-diff -1:
# - Roll-up patches missing from Linus tree.
# + working-tree
--- k/local-pull.c
+++ l/local-pull.c
@@ -1,3 +1,6 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
@@ -10,6 +13,7 @@
 
 static int use_link = 0;
 static int use_symlink = 0;
+static int use_filecopy = 1;
 static int verbose = 0;
 
 static char *path;
@@ -25,9 +29,6 @@ int fetch(unsigned char *sha1)
 	static char filename[PATH_MAX];
 	char *hex = sha1_to_hex(sha1);
 	const char *dest_filename = sha1_file_name(sha1);
-	int ifd, ofd, status;
-	struct stat st;
-	void *map;
 
 	if (object_name_start < 0) {
 		strcpy(filename, path); /* e.g. git.git */
@@ -46,33 +47,47 @@ int fetch(unsigned char *sha1)
 		say("Symlinked %s.\n", hex);
 		return 0;
 	}
-	ifd = open(filename, O_RDONLY);
-	if (ifd < 0 || fstat(ifd, &st) < 0) {
+	if (use_filecopy) {
+		int ifd, ofd, status;
+		struct stat st;
+		void *map;
+		ifd = open(filename, O_RDONLY);
+		if (ifd < 0 || fstat(ifd, &st) < 0) {
+			close(ifd);
+			fprintf(stderr, "Cannot open %s\n", filename);
+			return -1;
+		}
+		map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
 		close(ifd);
-		fprintf(stderr, "Cannot open %s\n", filename);
-		return -1;
-	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
-	close(ifd);
-	if (-1 == (int)(long)map) {
-		fprintf(stderr, "Cannot mmap %s\n", filename);
-		return -1;
+		if (-1 == (int)(long)map) {
+			fprintf(stderr, "Cannot mmap %s\n", filename);
+			return -1;
+		}
+		ofd = open(dest_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		status = ((ofd < 0) ||
+			  (write(ofd, map, st.st_size) != st.st_size));
+		munmap(map, st.st_size);
+		close(ofd);
+		if (status)
+			fprintf(stderr, "Cannot write %s (%ld bytes)\n",
+				dest_filename, st.st_size);
+		else
+			say("Copied %s.\n", hex);
+		return status;
 	}
-	ofd = open(dest_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	status = ((ofd < 0) || (write(ofd, map, st.st_size) != st.st_size));
-	munmap(map, st.st_size);
-	close(ofd);
-	if (status)
-		fprintf(stderr, "Cannot write %s (%ld bytes)\n",
-			dest_filename, st.st_size);
-	else
-		say("Copied %s.\n", hex);
-	return status;
+	fprintf(stderr, "No copy method was provided to copy %s.\n", hex);
+	return -1;
 }
 
 static const char *local_pull_usage = 
-"git-local-pull [-c] [-t] [-a] [-l] [-s] [-v] commit-id path";
+"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path";
 
+/* 
+ * By default we only use file copy.
+ * If -l is specified, a hard link is attempted.
+ * If -s is specified, then a symlink is attempted.
+ * If -n is _not_ specified, then a regular file-to-file copy is done.
+ */
 int main(int argc, char **argv)
 {
 	char *commit_id;
@@ -92,6 +107,8 @@ int main(int argc, char **argv)
 			use_link = 1;
 		else if (argv[arg][1] == 's')
 			use_symlink = 1;
+		else if (argv[arg][1] == 'n')
+			use_filecopy = 0;
 		else if (argv[arg][1] == 'v')
 			verbose = 1;
 		else

