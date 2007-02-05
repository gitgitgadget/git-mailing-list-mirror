From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Use cache_sha1_file() in git-blame and git-merge-recursive.
Date: Sun, 04 Feb 2007 21:51:26 -0800
Message-ID: <7v7iuxp2xt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 06:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDwlQ-0000Er-Ni
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 06:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbXBEFv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 00:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXBEFv3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 00:51:29 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:36160 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752639AbXBEFv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 00:51:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205055127.OUBH4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 00:51:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KhrS1W00A1kojtg0000000; Mon, 05 Feb 2007 00:51:26 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38728>

git-merge-recursive wants an null tree as the fake merge base
while producing the merge result tree.  The null tree does not
have to be written out in the object store as it won't be part
of the result, and it is a prime example for using the new
cache_sha1_file() function.

git-blame needs to register an arbitrary data to in-core index
while annotating a working tree file (or standard input), but
git-blame is a read-only application and the user of it could
even lack the privilege to write into the object store; it is
another good example for cache_sha1_file().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c   |    2 +-
 merge-recursive.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 897323a..15d0707 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2005,7 +2005,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	buf[fin_size] = 0;
 	origin->file.ptr = buf;
 	origin->file.size = fin_size;
-	write_sha1_file(buf, fin_size, blob_type, origin->blob_sha1);
+	cache_sha1_file(buf, fin_size, blob_type, origin->blob_sha1);
 	commit->util = origin;
 
 	/*
diff --git a/merge-recursive.c b/merge-recursive.c
index a68fcc6..d4e2460 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1213,7 +1213,7 @@ static int merge(struct commit *h1,
 
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
-		write_sha1_file(NULL, 0, tree_type, tree->object.sha1);
+		cache_sha1_file(NULL, 0, tree_type, tree->object.sha1);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
-- 
1.5.0.rc3.58.g79812
