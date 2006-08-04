From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: fix minor memory leak
Date: Fri, 4 Aug 2006 10:54:08 +0200
Message-ID: <20060804085408.GA22305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 10:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8vRf-000766-4w
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 10:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWHDIyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 04:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHDIyL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 04:54:11 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:38553
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1030209AbWHDIyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 04:54:09 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 9F095702C; Fri,  4 Aug 2006 10:54:08 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24781>

Free the root tree object buffer when we're done, plugging a minor leak
in generate_tar().  Note: we cannot simply free(tree.buf) because this
pointer is modified by tree_entry() calls in traverse_tree().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

My first Valgrind run. :)


diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 7c48db9..215892b 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -314,6 +314,7 @@ static int generate_tar(int argc, const 
 	struct commit *commit;
 	struct tree_desc tree;
 	struct strbuf current_path;
+	void *buffer;
 
 	current_path.buf = xmalloc(PATH_MAX);
 	current_path.alloc = PATH_MAX;
@@ -341,8 +342,8 @@ static int generate_tar(int argc, const 
 	} else
 		archive_time = time(NULL);
 
-	tree.buf = read_object_with_reference(sha1, tree_type, &tree.size,
-	                                      tree_sha1);
+	tree.buf = buffer = read_object_with_reference(sha1, tree_type,
+	                                               &tree.size, tree_sha1);
 	if (!tree.buf)
 		die("not a reference to a tag, commit or tree object: %s",
 		    sha1_to_hex(sha1));
@@ -351,6 +352,7 @@ static int generate_tar(int argc, const 
 		write_entry(tree_sha1, &current_path, 040777, NULL, 0);
 	traverse_tree(&tree, &current_path);
 	write_trailer();
+	free(buffer);
 	free(current_path.buf);
 	return 0;
 }
