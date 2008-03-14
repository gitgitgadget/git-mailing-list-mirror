From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault in git read-tree
Date: Thu, 13 Mar 2008 22:07:18 -0700
Message-ID: <7vskytuc55.fsf@gitster.siamese.dyndns.org>
References: <200803132359.06745.lenb@kernel.org>
 <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803132136080.3557@woody.linux-foundation.org>
 <7vejadvrk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja29H-00041K-KD
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbYCNFH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 01:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYCNFH1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:07:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYCNFH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 01:07:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5407A1322;
	Fri, 14 Mar 2008 01:07:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4557312FF; Fri, 14 Mar 2008 01:07:19 -0400 (EDT)
In-Reply-To: <7vejadvrk7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Mar 2008 21:48:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77177>

Thanks for the fix.

Let's do this right, as the two limits should be in sync.

-- >8 --
read-tree() and unpack_trees(): use consistent limit

read-tree -m can read up to MAX_TREES, which was arbitrarily set to 8 since
August 2007 (4 is needed to deal with 2 merge-base case).

However, the updated unpack_trees() code had an advertised limit of 4
(which it enforced).  In reality the code was prepared to take only 3
trees and giving 4 caused it to stomp on its stack.  Rename the MAX_TREES
constant to MAX_UNPACK_TREES, move it to the unpack-trees.h common header
file, and use it from both places to avoid future confusion.

Bug-reintroduced-and-fixed-by: Linus Torvalds <torvalds@linux-foundation.org>
Patch-munged-and-tested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c |    9 ++++-----
 unpack-trees.c      |    6 +++---
 unpack-trees.h      |    2 ++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 160456d..e9cfd2b 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -13,16 +13,15 @@
 #include "dir.h"
 #include "builtin.h"
 
-#define MAX_TREES 8
 static int nr_trees;
-static struct tree *trees[MAX_TREES];
+static struct tree *trees[MAX_UNPACK_TREES];
 
 static int list_tree(unsigned char *sha1)
 {
 	struct tree *tree;
 
-	if (nr_trees >= MAX_TREES)
-		die("I cannot read more than %d trees", MAX_TREES);
+	if (nr_trees >= MAX_UNPACK_TREES)
+		die("I cannot read more than %d trees", MAX_UNPACK_TREES);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		return -1;
@@ -97,7 +96,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
-	struct tree_desc t[MAX_TREES];
+	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 
 	memset(&opts, 0, sizeof(opts));
diff --git a/unpack-trees.c b/unpack-trees.c
index be89d52..91649f3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -123,7 +123,7 @@ static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_option
 int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
 {
 	int i;
-	struct tree_desc t[3];
+	struct tree_desc t[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
 
@@ -327,8 +327,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 {
 	static struct cache_entry *dfc;
 
-	if (len > 4)
-		die("unpack_trees takes at most four trees");
+	if (len > MAX_UNPACK_TREES)
+		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 	memset(&state, 0, sizeof(state));
 	state.base_dir = "";
 	state.force = 1;
diff --git a/unpack-trees.h b/unpack-trees.h
index e8abbcd..50453ed 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,6 +1,8 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
 
+#define MAX_UNPACK_TREES 8
+
 struct unpack_trees_options;
 
 typedef int (*merge_fn_t)(struct cache_entry **src,
