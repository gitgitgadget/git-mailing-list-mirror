From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: Lift path length limit
Date: Sat, 7 May 2005 02:25:27 +0200
Message-ID: <20050507002527.GA5082@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat May 07 02:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUD1y-0000Wj-JO
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVEGAZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVEGAZj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:25:39 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:19644 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261333AbVEGAZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 20:25:28 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 6321F19D; Sat,  7 May 2005 02:25:27 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Last minute patch?  This lifts the limits from path length and link
path length that are in git-tar-tree.

Have a nice vacation!

Rene


Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
commit 2d7b8f2afc47c753aaab4bf48587fdea730b0db3
tree 378fae86e43460c1c53feccbde3573ced26818f6
parent a02ebff6127c5fc981668fb570f0a80f2b7657ca
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115320521 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115320521 +0200

Index: tar-tree.c
===================================================================
--- 8477488c1965186c98b59ad0da04d221aff3c9a1/tar-tree.c  (mode:100644 sha1:a09cb416595094e493a52dd7f45d943c81c0310a)
+++ 378fae86e43460c1c53feccbde3573ced26818f6/tar-tree.c  (mode:100644 sha1:0fb6514c27a0f0edc2fc6e9850c361c8a58c0a9f)
@@ -212,7 +212,7 @@
                                   const char *path, unsigned int namelen,
                                   void *content, unsigned int contentsize)
 {
-	char *p;
+	char *buffer, *p;
 	unsigned int pathlen, size, linkpathlen = 0;
 
 	size = pathlen = extended_header_len("path", namelen);
@@ -220,18 +220,18 @@
 		linkpathlen = extended_header_len("linkpath", contentsize);
 		size += linkpathlen;
 	}
-	if (size > RECORDSIZE)
-		die("tar-tree: extended header too big, wtf?");
 	write_header(NULL, TYPEFLAG_EXT_HEADER, NULL, NULL, headerfilename,
 	             0100600, NULL, size);
 
-	p = get_record();
+	buffer = p = malloc(size);
+	if (!buffer)
+		die("git-tar-tree: %s", strerror(errno));
 	append_extended_header_prefix(&p, pathlen, "path");
 	append_path(&p, is_dir, basepath, prefix, path);
 	append_char(&p, '\n');
 	if (flags & EXT_HEADER_LINKPATH)
 		append_extended_header(&p, "linkpath", content, contentsize);
-	write_if_needed();
+	write_blocked(buffer, size);
 }
 
 static void write_global_extended_header(const char *sha1)
@@ -269,9 +269,7 @@
 	}
 
 	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
-	if (namelen > 500)
-		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
-	else if (namelen > 100)
+	if (namelen > 100)
 		ext_header |= EXT_HEADER_PATH;
 	if (typeflag == TYPEFLAG_LNK && size > 100)
 		ext_header |= EXT_HEADER_LINKPATH;
