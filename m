From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] git-tar-tree: add get_record()
Date: Fri, 6 May 2005 22:55:42 +0200
Message-ID: <20050506205542.GB19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:50:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9lY-0000Tr-SG
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEFU4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFU4X
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:56:23 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:25531 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261249AbVEFUzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:55:42 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 731F540A; Fri,  6 May 2005 22:55:42 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add get_record() which returns a pointer to the next record in the block.

---
commit 487c69a1df2a28471e1cefc1ae592cb61a57530e
tree 2179101bba7891ba96b070265068edeb9233d435
parent e0965d83c533e8b6a51f1c6c1be12f5edee5ca65
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115304529 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115304529 +0200

Index: tar-tree.c
===================================================================
--- c5ee2c11b8d4214dd6fde6388a12060e5d86b06c/tar-tree.c  (mode:100644 sha1:2c64f690e52093af13585521de4df478ac6e85e5)
+++ 2179101bba7891ba96b070265068edeb9233d435/tar-tree.c  (mode:100644 sha1:06f4ca480e0d212b51970debdbf97a3379225330)
@@ -45,6 +45,15 @@
 	}
 }
 
+/* acquire the next record from the buffer; user must call write_if_needed() */
+static char *get_record(void)
+{
+	char *p = block + offset;
+	memset(p, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	return p;
+}
+
 /*
  * The end of tar archives is marked by 1024 nul bytes and after that
  * follows the rest of the block (if any).
@@ -178,9 +187,7 @@
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
 	write_header(NULL, 'x', NULL, NULL, headerfilename, 0100600, size);
-	p = block + offset;
-	memset(p, 0, RECORDSIZE);
-	offset += RECORDSIZE;
+	p = get_record();
 	append_long(&p, size);
 	append_string(&p, " path=");
 	append_path(&p, is_dir, basepath, prefix, path);
@@ -192,9 +199,7 @@
 {
 	char *p;
 	write_header(NULL, 'g', NULL, NULL, "pax_global_header", 0, 52);
-	p = block + offset;
-	memset(p, 0, RECORDSIZE);
-	offset += RECORDSIZE;
+	p = get_record();
 	append_long(&p, 52);	/* 2 + 9 + 40 + 1 */
 	append_string(&p, " comment=");
 	append_string(&p, sha1_to_hex(sha1));
@@ -223,15 +228,10 @@
 		write_extended_header(headerfilename, S_ISDIR(mode), basepath,
 				      prefix, path, namelen);
 
-		header = block + offset;
-		memset(header, 0, RECORDSIZE);
-		offset += RECORDSIZE;
+		header = get_record();
 		sprintf(header, "%s.data", sha1_hex);
 	} else {
-		header = block + offset;
-		memset(header, 0, RECORDSIZE);
-		offset += RECORDSIZE;
-		p = header;
+		p = header = get_record();
 		append_path(&p, S_ISDIR(mode), basepath, prefix, path);
 	}
 



!-------------------------------------------------------------flip-


