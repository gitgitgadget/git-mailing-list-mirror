From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] git-tar-tree: make file contents accessible to write_header()
Date: Fri, 6 May 2005 22:56:08 +0200
Message-ID: <20050506205608.GE19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9mZ-0000bV-4x
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEFU5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFU5a
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:57:30 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:27579 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261265AbVEFU4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:56:11 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 9FF5B307; Fri,  6 May 2005 22:56:08 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pass pointer to filecontents to write_header() and pass pointer
to filecontents, its size and some flags to write_exntended_header().
These parameters are not used, yet.  They are added in preparation
to symlink support.

---
commit 2da87ce547b59294d4d1cf527009395fbec7bf91
tree 9eedd772d20dd5a66735f49efe80e17ced40f258
parent 07b06da34d45be748f46ce4c8ffd3a2e0bba6191
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115312682 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115312682 +0200

Index: tar-tree.c
===================================================================
--- bb298354f2340d064398c211af0a44cde2b7f48b/tar-tree.c  (mode:100644 sha1:277c882acc4f487bfc90dee76b00dc88f99f3da3)
+++ 9eedd772d20dd5a66735f49efe80e17ced40f258/tar-tree.c  (mode:100644 sha1:e99adc7dd781cf46efbed82221bf62975a4a3996)
@@ -199,13 +199,14 @@
 }
 
 static void write_header(const char *, char, const char *, struct path_prefix *,
-                         const char *, unsigned int, unsigned long);
+                         const char *, unsigned int, void *, unsigned long);
 
 /* stores a pax extended header directly in the block buffer */
 static void write_extended_header(const char *headerfilename, int is_dir,
-                                  const char *basepath,
+                                  unsigned int flags, const char *basepath,
                                   struct path_prefix *prefix,
-                                  const char *path, unsigned int namelen)
+                                  const char *path, unsigned int namelen,
+                                  void *content, unsigned int contentsize)
 {
 	char *p;
 	unsigned int pathlen, size;
@@ -214,7 +215,7 @@
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
 	write_header(NULL, TYPEFLAG_EXT_HEADER, NULL, NULL, headerfilename,
-	             0100600, size);
+	             0100600, NULL, size);
 
 	p = get_record();
 	append_extended_header_prefix(&p, pathlen, "path");
@@ -230,7 +231,7 @@
 
 	size = extended_header_len("comment", 40);
 	write_header(NULL, TYPEFLAG_GLOBAL_HEADER, NULL, NULL,
-	             "pax_global_header", 0100600, size);
+	             "pax_global_header", 0100600, NULL, size);
 
 	p = get_record();
 	append_extended_header(&p, "comment", sha1_to_hex(sha1), 40);
@@ -240,7 +241,7 @@
 /* stores a ustar header directly in the block buffer */
 static void write_header(const char *sha1, char typeflag, const char *basepath,
                          struct path_prefix *prefix, const char *path,
-                         unsigned int mode, unsigned long size)
+                         unsigned int mode, void *buffer, unsigned long size)
 {
 	unsigned int namelen; 
 	char *p, *header = NULL;
@@ -262,8 +263,9 @@
 		char headerfilename[51];
 		sprintf(headerfilename, "%s.paxheader", sha1_hex);
 		/* the extended header must be written before the normal one */
-		write_extended_header(headerfilename, S_ISDIR(mode), basepath,
-				      prefix, path, namelen);
+		write_extended_header(headerfilename, S_ISDIR(mode),
+		                      0, basepath, prefix, path,
+		                      namelen, buffer, size);
 
 		header = get_record();
 		sprintf(header, "%s.data", sha1_hex);
@@ -325,7 +327,7 @@
 		if (!eltbuf)
 			die("cannot read %s", sha1_to_hex(sha1));
 		write_header(sha1, TYPEFLAG_AUTO, basedir, prefix, path,
-		             mode, eltsize);
+		             mode, eltbuf, eltsize);
 		if (!strcmp(elttype, "tree")) {
 			this_prefix.name = path;
 			traverse_tree(eltbuf, eltsize, &this_prefix);
@@ -399,7 +401,8 @@
 	if (!archive_time)
 		archive_time = time(NULL);
 	if (basedir)
-		write_header("0", TYPEFLAG_DIR, NULL, NULL, basedir, 040755, 0);
+		write_header("0", TYPEFLAG_DIR, NULL, NULL, basedir, 040755,
+		             NULL, 0);
 	traverse_tree(buffer, size, NULL);
 	free(buffer);
 	write_trailer();



!-------------------------------------------------------------flip-


