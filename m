From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2.1/5] Add merge-base
Date: Sun, 17 Apr 2005 12:51:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171251150.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCwF-00036d-8E
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDQQvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDQQvv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:51:51 -0400
Received: from iabervon.org ([66.92.72.58]:57348 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261360AbVDQQvl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:51:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DND03-0000oB-00; Sun, 17 Apr 2005 12:51:59 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

merge-base finds one of the best common ancestors of a pair of commits. In
particular, it finds one of the ones which is fewest commits away from the
further of the heads.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/Makefile  (mode:100644 sha1:346e3850de026485802e41e16a1180be2df85e4a)
+++ 7d806c2d3be8f87d3d4d87e5254500d7fc24476b/Makefile  (mode:100644 sha1:0e84e3cd12f836602b420c197e08fabefe975493)
@@ -14,7 +17,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree
+	check-files ls-tree merge-base
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
Index: merge-base.c
===================================================================
--- /dev/null  (tree:45f926575d2c44072bfcf2317dbf3f0fbb513a4e)
+++ 7d806c2d3be8f87d3d4d87e5254500d7fc24476b/merge-base.c  (mode:100644 sha1:ee979c7532cbdf823e9930993b0dd8f97aadb21f)
@@ -0,0 +1,95 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "revision.h"
+
+static struct revision *process_list(struct parent **list_p, int this_mark,
+				     int other_mark)
+{
+	struct parent *parent, *temp;
+	struct parent *posn = *list_p;
+	*list_p = NULL;
+	while (posn) {
+		parse_commit_object(posn->parent);
+		if (posn->parent->flags & this_mark) {
+			/*
+			  printf("%d already seen %s %x\n",
+			  this_mark
+			  sha1_to_hex(posn->parent->sha1),
+			  posn->parent->flags);
+			*/
+			/* do nothing; this indicates that this side
+			 * split and reformed, and we only need to
+			 * mark it once.
+			 */
+		} else if (posn->parent->flags & other_mark) {
+			return posn->parent;
+		} else {
+			/*
+			  printf("%d based on %s\n",
+			  this_mark,
+			  sha1_to_hex(posn->parent->sha1));
+			*/
+			posn->parent->flags |= this_mark;
+			
+			parent = posn->parent->parent;
+			while (parent) {
+				temp = malloc(sizeof(struct parent));
+				temp->next = *list_p;
+				temp->parent = parent->parent;
+				*list_p = temp;
+				parent = parent->next;
+			}
+		}
+		posn = posn->next;
+	}
+	return NULL;
+}
+
+struct revision *common_ancestor(struct revision *rev1, struct revision *rev2)
+{
+	struct parent *rev1list = malloc(sizeof(struct parent));
+	struct parent *rev2list = malloc(sizeof(struct parent));
+
+	rev1list->parent = rev1;
+	rev1list->next = NULL;
+
+	rev2list->parent = rev2;
+	rev2list->next = NULL;
+
+	while (rev1list || rev2list) {
+		struct revision *ret;
+		ret = process_list(&rev1list, 0x1, 0x2);
+		if (ret) {
+			/* XXXX free lists */
+			return ret;
+		}
+		ret = process_list(&rev2list, 0x2, 0x1);
+		if (ret) {
+			/* XXXX free lists */
+			return ret;
+		}
+	}
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	struct revision *rev1, *rev2, *ret;
+	unsigned char rev1key[20], rev2key[20];
+
+	if (argc != 3 ||
+	    get_sha1_hex(argv[1], rev1key) ||
+	    get_sha1_hex(argv[2], rev2key)) {
+		usage("merge-base <commit-id> <commit-id>");
+	}
+	rev1 = lookup_rev(rev1key);
+	rev2 = lookup_rev(rev2key);
+	ret = common_ancestor(rev1, rev2);
+	if (ret) {
+		printf("%s\n", sha1_to_hex(ret->sha1));
+		return 0;
+	} else {
+		return 1;
+	}
+	
+}

