From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Tue, 06 Sep 2005 13:03:28 -0700
Message-ID: <7vbr36j75b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
	<7virxeycod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509061228090.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 22:05:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECjfp-0004jG-K7
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 22:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVIFUDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVIFUDj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 16:03:39 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29639 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750857AbVIFUDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 16:03:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906200330.DHYN3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 16:03:30 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8142>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Do you know if there's anything like case #16 in there? I'd be interested 
> to know if there's anything that gets handled automatically in different 
> ways depending on which single base is used, and doesn't require manual 
> intervention with multiple bases, because that's probably wrong.

Re-running the tests with the attached patch shows there weren't any.

> I didn't want to break the assumption of only one entry per stage in the 
> initial version. I'm also not sure that listing the ancestors is 
> particularly useful in this case. They have to be exactly the contents of 
> stages 2 and 3, plus possibly more stuff that's not been kept by either 
> side.

Ah, I see, that's true.

> Great. Want me to send the patches with better organization, or are you 
> set with what I've sent?

That's up to you.  If you are content with what I have in the pu
branch, there is no need to bother resending.  OTOH if you have
further clean-ups in mind, i.e. "better organization" above, I
do not mind dropping the current ones from "pu" and replace them
with another set from you.

------------
[PATCH] Add debugging help for case #16 to read-tree.c

This will help us detect if real-world example merges have multiple
merge-base candidates and one of them matches one head while another
matches the other head.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 read-tree.c                 |   36 ++++++++++++++++++++++++++++--------
 t/t1000-read-tree-m-3way.sh |   16 ++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

6405d0aa729f4b060123e1235b3ddc074fdd01b7
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define DBRT_DEBUG 1
+
 #include "cache.h"
 
 #include "object.h"
@@ -47,8 +49,6 @@ static int entcmp(char *name1, int dir1,
 	return ret;
 }
 
-#define DBRT_DEBUG 0
-
 static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			    const char *base, merge_fn_t fn, int *indpos)
 {
@@ -101,14 +101,14 @@ static int unpack_trees_rec(struct tree_
 			}
 		}
 
-#if DBRT_DEBUG
+#if DBRT_DEBUG > 1
 		if (first)
 			printf("index %s\n", first);
 #endif
 		for (i = 0; i < len; i++) {
 			if (!posns[i] || posns[i] == &df_conflict_list)
 				continue;
-#if DBRT_DEBUG
+#if DBRT_DEBUG > 1
 			printf("%d %s\n", i + 1, posns[i]->name);
 #endif
 			if (!first || entcmp(first, firstdir,
@@ -188,7 +188,7 @@ static int unpack_trees_rec(struct tree_
 			if (merge) {
 				int ret;
 
-#if DBRT_DEBUG
+#if DBRT_DEBUG > 1
 				printf("%s:\n", first);
 				for (i = 0; i < src_size; i++) {
 					printf(" %d ", i);
@@ -200,7 +200,7 @@ static int unpack_trees_rec(struct tree_
 #endif
 				ret = fn(src);
 				
-#if DBRT_DEBUG
+#if DBRT_DEBUG > 1
 				printf("Added %d entries\n", ret);
 #endif
 				*indpos += ret;
@@ -353,6 +353,19 @@ static int keep_entry(struct cache_entry
 	return 1;
 }
 
+#if DBRT_DEBUG
+static void show_stage_entry(FILE *o,
+			     const char *label, const struct cache_entry *ce)
+{
+	fprintf(stderr, "%s%06o %s %d\t%s\n",
+		label,
+		ntohl(ce->ce_mode),
+		sha1_to_hex(ce->sha1),
+		ce_stage(ce),
+		ce->name);
+}
+#endif
+
 static int threeway_merge(struct cache_entry **stages)
 {
 	struct cache_entry *index;
@@ -392,10 +405,10 @@ static int threeway_merge(struct cache_e
 	if (!same(remote, head)) {
 		for (i = 1; i < head_idx; i++) {
 			if (same(stages[i], head)) {
-				head_match = 1;
+				head_match = i;
 			}
 			if (same(stages[i], remote)) {
-				remote_match = 1;
+				remote_match = i;
 			}
 		}
 	}
@@ -450,6 +463,13 @@ static int threeway_merge(struct cache_e
 			}
 		}
 	}
+#if DBRT_DEBUG
+	else {
+		fprintf(stderr, "read-tree: warning #16 detected\n");
+		show_stage_entry(stderr, "head   ", stages[head_match]);
+		show_stage_entry(stderr, "remote ", stages[remote_match]);
+	}
+#endif
 	if (head) { count += keep_entry(head); }
 	if (remote) { count += keep_entry(remote); }
 	return count;
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -218,6 +218,9 @@ currently implemented.
                                            or (2) match B.
  ------------------------------------------------------------------
  15  exists  O==A    O==B      take B      must match A if exists.
+ ------------------------------------------------------------------
+ 16  exists  O==A    O==B      barf        must match A if exists.
+     *multi* in one  in another
 -------------------------------------------------------------------
 
 Note: if we want to implement 2ALT and 3ALT we need to be careful.
@@ -514,4 +517,17 @@ test_expect_failure \
      git-update-cache --add NN &&
      git-read-tree -m $tree_O $tree_A $tree_B"
 
+# #16
+test_expect_success \
+    '16 - A matches in one and B matches in another.' \
+    'rm -f .git/index F16 &&
+    echo F16 >F16 &&
+    git-update-cache --add F16 &&
+    tree0=`git-write-tree` &&
+    echo E16 >F16 &&
+    git-update-cache F16 &&
+    tree1=`git-write-tree` &&
+    git-read-tree -m $tree0 $tree1 $tree1 $tree0 &&
+    git-ls-files --stage'
+
 test_done
