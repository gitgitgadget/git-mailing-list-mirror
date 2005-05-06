From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] git-tar-tree: add TYPEFLAG_ constants
Date: Fri, 6 May 2005 22:55:52 +0200
Message-ID: <20050506205552.GC19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:51:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9ly-0000X9-B5
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEFU4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFU4s
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:56:48 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:26043 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261260AbVEFUzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:55:53 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id D8CDB307; Fri,  6 May 2005 22:55:52 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add TYPEFLAG_ constants.

---
commit c0507f354f3637ce2fc6d8665685a7007e97002e
tree c20d5f820ce6cd1763af5a3eccfe4d4cff1ac719
parent 487c69a1df2a28471e1cefc1ae592cb61a57530e
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115304862 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115304862 +0200

Index: tar-tree.c
===================================================================
--- 2179101bba7891ba96b070265068edeb9233d435/tar-tree.c  (mode:100644 sha1:06f4ca480e0d212b51970debdbf97a3379225330)
+++ c20d5f820ce6cd1763af5a3eccfe4d4cff1ac719/tar-tree.c  (mode:100644 sha1:a5b9fc937c6c54a8155dd8d28772ecb5ba5dd303)
@@ -4,6 +4,12 @@
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
+#define TYPEFLAG_AUTO		'\0'
+#define TYPEFLAG_REG		'0'
+#define TYPEFLAG_DIR		'5'
+#define TYPEFLAG_GLOBAL_HEADER	'g'
+#define TYPEFLAG_EXT_HEADER	'x'
+
 static const char *tar_tree_usage = "tar-tree <key> [basedir]";
 
 static char block[BLOCKSIZE];
@@ -186,7 +192,8 @@
 		size++;
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
-	write_header(NULL, 'x', NULL, NULL, headerfilename, 0100600, size);
+	write_header(NULL, TYPEFLAG_EXT_HEADER, NULL, NULL, headerfilename,
+	             0100600, size);
 	p = get_record();
 	append_long(&p, size);
 	append_string(&p, " path=");
@@ -198,7 +205,8 @@
 static void write_global_extended_header(const char *sha1)
 {
 	char *p;
-	write_header(NULL, 'g', NULL, NULL, "pax_global_header", 0, 52);
+	write_header(NULL, TYPEFLAG_GLOBAL_HEADER, NULL, NULL,
+	             "pax_global_header", 0100600, 52);
 	p = get_record();
 	append_long(&p, 52);	/* 2 + 9 + 40 + 1 */
 	append_string(&p, " comment=");
@@ -217,6 +225,13 @@
 	unsigned int checksum = 0;
 	int i;
 
+	if (typeflag == TYPEFLAG_AUTO) {
+		if (S_ISDIR(mode))
+			typeflag = TYPEFLAG_DIR;
+		else
+			typeflag = TYPEFLAG_REG;
+	}
+
 	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
 	if (namelen > 500) {
 		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
@@ -287,8 +302,8 @@
 		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
 		if (!eltbuf)
 			die("cannot read %s", sha1_to_hex(sha1));
-		write_header(sha1, S_ISDIR(mode) ? '5' : '0', basedir,
-		             prefix, path, mode, eltsize);
+		write_header(sha1, TYPEFLAG_AUTO, basedir, prefix, path,
+		             mode, eltsize);
 		if (!strcmp(elttype, "tree")) {
 			this_prefix.name = path;
 			traverse_tree(eltbuf, eltsize, &this_prefix);
@@ -362,7 +377,7 @@
 	if (!archive_time)
 		archive_time = time(NULL);
 	if (basedir)
-		write_header("0", '5', NULL, NULL, basedir, 040755, 0);
+		write_header("0", TYPEFLAG_DIR, NULL, NULL, basedir, 040755, 0);
 	traverse_tree(buffer, size, NULL);
 	free(buffer);
 	write_trailer();



!-------------------------------------------------------------flip-


