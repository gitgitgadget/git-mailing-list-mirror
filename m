From: Junio C Hamano <junkio@cox.net>
Subject: (rework) [PATCH 2/5] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:21:42 -0700
Message-ID: <7v64yhhtd5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:18:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPON-0002x1-Ok
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVDUAWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDUAWD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:22:03 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38650 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261856AbVDUAVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:21:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421002144.SVQG13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:21:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updates diff-cache.c to use read_tree_with_tree_or_commit_sha1()
function.  The end-user visible result is the same --- the command
takes either tree or commit ID.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-cache.c |   17 +----------------
 1 files changed, 1 insertion(+), 16 deletions(-)

diff-cache.c: fcbc4900d32f4ca24f67bb8f0fe344c6c5642ac9
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -220,7 +220,6 @@ int main(int argc, char **argv)
 	unsigned char tree_sha1[20];
 	void *tree;
 	unsigned long size;
-	char type[20];
 
 	read_cache();
 	while (argc > 2) {
@@ -245,23 +244,9 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
 		usage("diff-cache [-r] [-z] <tree sha1>");
 
-	tree = read_sha1_file(tree_sha1, type, &size);
+	tree = read_tree_with_tree_or_commit_sha1(tree_sha1, &size, 0);
 	if (!tree)
 		die("bad tree object %s", argv[1]);
 
-	/* We allow people to feed us a commit object, just because we're nice */
-	if (!strcmp(type, "commit")) {
-		/* tree sha1 is always at offset 5 ("tree ") */
-		if (get_sha1_hex(tree + 5, tree_sha1))
-			die("bad commit object %s", argv[1]);
-		free(tree);
-		tree = read_sha1_file(tree_sha1, type, &size);       
-		if (!tree)
-			die("unable to read tree object %s", sha1_to_hex(tree_sha1));
-	}
-
-	if (strcmp(type, "tree"))
-		die("bad tree object %s (%s)", sha1_to_hex(tree_sha1), type);
-
 	return diff_cache(tree, size, active_cache, active_nr, "");
 }


