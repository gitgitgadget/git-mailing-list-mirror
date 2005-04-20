From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Accept commit in some places when tree is needed.
Date: Tue, 19 Apr 2005 23:08:51 -0700
Message-ID: <7vis2ikmj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:05:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8Ke-0006Im-2B
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDTGJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDTGJN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:09:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12990 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261426AbVDTGI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 02:08:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420060851.BLPV9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 02:08:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Similar to the diff-cache command, we should accept commit ID
when tree ID is required but the end-user intent is unambiguous.

This patch lifts the tree-from-tree-or-commit logic from
diff-cache.c and moves it to sha1_file.c, which is a common
library source for the SHA1 storage part.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h      |    1 +
 diff-cache.c |   18 ++----------------
 sha1_file.c  |   28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 16 deletions(-)

Makefile: needs update
--- a/cache.h
+++ b/cache.h
@@ -124,5 +124,6 @@ extern void die(const char *err, ...);
 extern int error(const char *err, ...);
 
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern void *tree_from_tree_or_commit(unsigned char *sha1, char *type, unsigned long *size);
 
 #endif /* CACHE_H */
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -245,23 +245,9 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
 		usage("diff-cache [-r] [-z] <tree sha1>");
 
+	tree = tree_from_tree_or_commit(tree_sha1, type, &size);
 	tree = read_sha1_file(tree_sha1, type, &size);
 	if (!tree)
-		die("bad tree object %s", argv[1]);
-
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
+		die("cannot get tree object from %s", argv[1]);
 	return diff_cache(tree, size, active_cache, active_nr, "");
 }
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -245,3 +245,31 @@ int write_sha1_buffer(const unsigned cha
 	close(fd);
 	return 0;
 }
+
+void *tree_from_tree_or_commit(unsigned char *sha1, char *type,
+			       unsigned long *size)
+{
+	void *tree = read_sha1_file(sha1, type, size);
+	if (!tree)
+		return tree;
+
+	/* We allow people to feed us a commit object,
+	 * just because we're nice.
+	 */
+	if (!strcmp(type, "commit")) {
+		/* tree sha1 is always at offset 5 ("tree ") */
+		if (get_sha1_hex(tree + 5, sha1)) {
+			free(tree);
+			return NULL;
+		}
+		free(tree);
+		tree = read_sha1_file(sha1, type, size);
+		if (!tree)
+			return NULL;
+	}
+	if (strcmp(type , "tree")) {
+		free(tree);
+		return NULL;
+	}
+	return tree;
+}

