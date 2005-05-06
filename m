From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] git-tar-tree: add symlink support
Date: Fri, 6 May 2005 22:56:16 +0200
Message-ID: <20050506205616.GF19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:51:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9ms-0000df-5R
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEFU5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFU5w
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:57:52 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:28091 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261266AbVEFU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:56:17 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 896CC40A; Fri,  6 May 2005 22:56:16 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add symlink support to git-tar-tree.

---
commit 7cc9bcd638b69e7cb7fed5b9aa8887e71f88c6c7
tree 8326e0ed584a22abfe510f7cf71a5a569157920d
parent 2da87ce547b59294d4d1cf527009395fbec7bf91
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115312885 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115312885 +0200

Index: tar-tree.c
===================================================================
--- 9eedd772d20dd5a66735f49efe80e17ced40f258/tar-tree.c  (mode:100644 sha1:e99adc7dd781cf46efbed82221bf62975a4a3996)
+++ 8326e0ed584a22abfe510f7cf71a5a569157920d/tar-tree.c  (mode:100644 sha1:a09cb416595094e493a52dd7f45d943c81c0310a)
@@ -6,10 +6,14 @@
 
 #define TYPEFLAG_AUTO		'\0'
 #define TYPEFLAG_REG		'0'
+#define TYPEFLAG_LNK		'2'
 #define TYPEFLAG_DIR		'5'
 #define TYPEFLAG_GLOBAL_HEADER	'g'
 #define TYPEFLAG_EXT_HEADER	'x'
 
+#define EXT_HEADER_PATH		1
+#define EXT_HEADER_LINKPATH	2
+
 static const char *tar_tree_usage = "tar-tree <key> [basedir]";
 
 static char block[BLOCKSIZE];
@@ -209,9 +213,13 @@
                                   void *content, unsigned int contentsize)
 {
 	char *p;
-	unsigned int pathlen, size;
+	unsigned int pathlen, size, linkpathlen = 0;
 
 	size = pathlen = extended_header_len("path", namelen);
+	if (flags & EXT_HEADER_LINKPATH) {
+		linkpathlen = extended_header_len("linkpath", contentsize);
+		size += linkpathlen;
+	}
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
 	write_header(NULL, TYPEFLAG_EXT_HEADER, NULL, NULL, headerfilename,
@@ -221,6 +229,8 @@
 	append_extended_header_prefix(&p, pathlen, "path");
 	append_path(&p, is_dir, basepath, prefix, path);
 	append_char(&p, '\n');
+	if (flags & EXT_HEADER_LINKPATH)
+		append_extended_header(&p, "linkpath", content, contentsize);
 	write_if_needed();
 }
 
@@ -244,38 +254,60 @@
                          unsigned int mode, void *buffer, unsigned long size)
 {
 	unsigned int namelen; 
-	char *p, *header = NULL;
+	char *header = NULL;
 	unsigned int checksum = 0;
 	int i;
+	unsigned int ext_header = 0;
 
 	if (typeflag == TYPEFLAG_AUTO) {
 		if (S_ISDIR(mode))
 			typeflag = TYPEFLAG_DIR;
+		else if (S_ISLNK(mode))
+			typeflag = TYPEFLAG_LNK;
 		else
 			typeflag = TYPEFLAG_REG;
 	}
 
 	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
-	if (namelen > 500) {
+	if (namelen > 500)
 		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
-	} else if (namelen > 100) {
-		char *sha1_hex = sha1_to_hex(sha1);
+	else if (namelen > 100)
+		ext_header |= EXT_HEADER_PATH;
+	if (typeflag == TYPEFLAG_LNK && size > 100)
+		ext_header |= EXT_HEADER_LINKPATH;
+
+	/* the extended header must be written before the normal one */
+	if (ext_header) {
 		char headerfilename[51];
-		sprintf(headerfilename, "%s.paxheader", sha1_hex);
-		/* the extended header must be written before the normal one */
+		sprintf(headerfilename, "%s.paxheader", sha1_to_hex(sha1));
 		write_extended_header(headerfilename, S_ISDIR(mode),
-		                      0, basepath, prefix, path,
+		                      ext_header, basepath, prefix, path,
 		                      namelen, buffer, size);
+	}
 
-		header = get_record();
-		sprintf(header, "%s.data", sha1_hex);
+	header = get_record();
+
+	if (ext_header) {
+		sprintf(header, "%s.data", sha1_to_hex(sha1));
 	} else {
-		p = header = get_record();
+		char *p = header;
 		append_path(&p, S_ISDIR(mode), basepath, prefix, path);
 	}
 
+	if (typeflag == TYPEFLAG_LNK) {
+		if (ext_header & EXT_HEADER_LINKPATH) {
+			sprintf(&header[157], "see %s.paxheader",
+			        sha1_to_hex(sha1));
+		} else {
+			if (buffer)
+				strncpy(&header[157], buffer, size);
+		}
+	}
+
 	if (S_ISDIR(mode))
 		mode |= 0755;	/* GIT doesn't store permissions of dirs */
+	if (S_ISLNK(mode))
+		mode |= 0777;   /* ... nor of symlinks */
 	sprintf(&header[100], "%07o", mode & 07777);
 
 	/* XXX: should we provide more meaningful info here? */
@@ -284,7 +316,9 @@
 	strncpy(&header[265], "git", 31);	/* uname */
 	strncpy(&header[297], "git", 31);	/* gname */
 
-	sprintf(&header[124], "%011lo", S_ISDIR(mode) ? 0 : size);
+	if (S_ISDIR(mode) || S_ISLNK(mode))
+		size = 0;
+	sprintf(&header[124], "%011lo", size);
 	sprintf(&header[136], "%011lo", archive_time);
 
 	header[156] = typeflag;
@@ -331,7 +365,7 @@
 		if (!strcmp(elttype, "tree")) {
 			this_prefix.name = path;
 			traverse_tree(eltbuf, eltsize, &this_prefix);
-		} else if (!strcmp(elttype, "blob")) {
+		} else if (!strcmp(elttype, "blob") && !S_ISLNK(mode)) {
 			write_blocked(eltbuf, eltsize);
 		}
 		free(eltbuf);



!-------------------------------------------------------------flip-


