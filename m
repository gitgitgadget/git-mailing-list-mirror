From: Junio C Hamano <junkio@cox.net>
Subject: (rework) [PATCH 3/5] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:22:30 -0700
Message-ID: <7v1x95htbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPP0-00030k-Fw
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVDUAWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDUAWy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:22:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47020 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261856AbVDUAWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:22:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421002230.YJQN2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:22:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updates diff-tree.c to use read_tree_with_tree_or_commit_sha1()
function.  The command can take either tree or commit IDs with this patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-tree.c |   25 ++++---------------------
 1 files changed, 4 insertions(+), 21 deletions(-)

diff-tree.c: 65bb9d66c5610b2ede11f03a9120da48c59629f8
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -164,14 +164,13 @@ static int diff_tree_sha1(const unsigned
 {
 	void *tree1, *tree2;
 	unsigned long size1, size2;
-	char type[20];
 	int retval;
 
-	tree1 = read_sha1_file(old, type, &size1);
-	if (!tree1 || strcmp(type, "tree"))
+	tree1 = read_tree_with_tree_or_commit_sha1(old, &size1, 0);
+	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_sha1_file(new, type, &size2);
-	if (!tree2 || strcmp(type, "tree"))
+	tree2 = read_tree_with_tree_or_commit_sha1(new, &size2, 0);
+	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	retval = diff_tree(tree1, size1, tree2, size2, base);
 	free(tree1);
@@ -179,20 +178,6 @@ static int diff_tree_sha1(const unsigned
 	return retval;
 }
 
-static void commit_to_tree(unsigned char *sha1)
-{
-	void *buf;
-	char type[20];
-	unsigned long size;
-
-	buf = read_sha1_file(sha1, type, &size);
-	if (buf) {
-		if (!strcmp(type, "commit"))
-			get_sha1_hex(buf+5, sha1);
-		free(buf);
-	}
-}
-
 int main(int argc, char **argv)
 {
 	unsigned char old[20], new[20];
@@ -214,7 +199,5 @@ int main(int argc, char **argv)
 
 	if (argc != 3 || get_sha1_hex(argv[1], old) || get_sha1_hex(argv[2], new))
 		usage("diff-tree <tree sha1> <tree sha1>");
-	commit_to_tree(old);
-	commit_to_tree(new);
 	return diff_tree_sha1(old, new, "");
 }

