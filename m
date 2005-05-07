From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-tar-tree: Lift path length limit
Date: Sat, 7 May 2005 02:57:06 +0200
Message-ID: <20050507005706.GA6093@lsrfire.ath.cx>
References: <20050507002527.GA5082@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUDX6-0003iK-Ly
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVEGA5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEGA5q
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:57:46 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:26556 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261428AbVEGA5K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 20:57:10 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 54FDD19D; Sat,  7 May 2005 02:57:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050507002527.GA5082@lsrfire.ath.cx>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 07, 2005 at 02:25:27AM +0200, Rene Scharfe wrote:
> Last minute patch?

This leaks memory.  D'oh!

Petr, would you add the (hopefully) fixed version below to your tree now
that Linus is on vacation?  (Patch applies to tip of GIT tree.)

Thanks,
Rene



Lift path length limits from git-tar-tree.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
commit d36797f64ee0431e6a73aa1c77a7fe7c18b6ce9f
tree ab8e6967a08ac343b69b527f663e6a9722fcea08
parent bf60144c0ab50e88c0086a90c5cb35b81613ad14
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115322098 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115322098 +0200

Index: tar-tree.c
===================================================================
--- 8ef25a2788d6c225641a3040622b82c364f987b8/tar-tree.c  (mode:100644 sha1:9d9bd7be98502f64e4a643ef0973182f3483251e)
+++ ab8e6967a08ac343b69b527f663e6a9722fcea08/tar-tree.c  (mode:100644 sha1:8b0d75bd2cf12a531aee3d51e59a8ac8102ba6be)
@@ -212,7 +212,7 @@
                                   const char *path, unsigned int namelen,
                                   void *content, unsigned int contentsize)
 {
-	char *p;
+	char *buffer, *p;
 	unsigned int pathlen, size, linkpathlen = 0;
 
 	size = pathlen = extended_header_len("path", namelen);
@@ -220,18 +220,19 @@
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
+	free(buffer);
 }
 
 static void write_global_extended_header(const char *sha1)
@@ -269,9 +270,7 @@
 	}
 
 	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
-	if (namelen > 500)
-		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
-	else if (namelen > 100)
+	if (namelen > 100)
 		ext_header |= EXT_HEADER_PATH;
 	if (typeflag == TYPEFLAG_LNK && size > 100)
 		ext_header |= EXT_HEADER_LINKPATH;
