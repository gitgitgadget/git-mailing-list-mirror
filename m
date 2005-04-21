From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: [PATCH] Make -p flag optional from commit-tree.
Date: Thu, 21 Apr 2005 15:42:59 -0700
Message-ID: <7v4qdzeop8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:39:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkKB-0000q4-9k
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVDUWnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDUWnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:43:25 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15319 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261157AbVDUWnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:43:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421224259.GDLH13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 18:42:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We cannot currently say:

 $ commit-tree $(write-tree) $(cat .git/heads/junio .git/heads/linus)

The above must be written as:

 $ commit-tree $(write-tree) \
     -p $(cat .git/heads/junio) \
     -p $(cat .git/heads/linus)

This patch makes -p flag optional.  Existing scripts are
hopefully not affected because they are passing -p properly.  If
we want to introduce non parent-ID parameters to commit-tree
later, we can give them their own -flag letters.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 commit-tree.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

commit-tree.c: c0b07f89286c3f6cceae8122b4c3142c8efaf8e1
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -297,10 +297,17 @@ int main(int argc, char **argv)
 		usage(commit_tree_usage);
 
 	check_valid(tree_sha1, "tree");
-	for (i = 2; i < argc; i += 2) {
-		char *a, *b;
-		a = argv[i]; b = argv[i+1];
-		if (!b || strcmp(a, "-p") || get_sha1_hex(b, parent_sha1[parents]))
+	for (i = 2; i < argc; i++) {
+		/* Historically commit-tree required -p in front of
+		 * each parent commit ID.  This is confusing.  We can
+		 * add non parent commit ID parameter later by defining
+		 * flags other than "-p" so let's just ignore them. 
+		 */
+		if (! strcmp(argv[i], "-p"))
+			continue;
+
+		/* Currently it just expects parent IDs. */
+		if (get_sha1_hex(argv[i], parent_sha1[parents]))
 			usage(commit_tree_usage);
 		check_valid(parent_sha1[parents], "commit");
 		parents++;

