From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] three --merge-order bug fixes
Date: Thu, 09 Jun 2005 00:37:41 +1000
Message-ID: <20050608143741.30382.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 08 16:39:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg1e2-0002Rc-Mo
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 16:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFHOiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFHOiy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 10:38:54 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:62338 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261251AbVFHOho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 10:37:44 -0400
Received: (qmail 30390 invoked by uid 500); 8 Jun 2005 14:37:41 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] three --merge-order bug fixes

This patch fixes three bugs in --merge-order support
    * mark_ancestors_uninteresting was unnecessarily exponential which 
      caused a problem when a commit with no parents was merged near the 
      head of something like the linux kernel
    * removed a spurious statement from find_base which wasn't
      apparently causing problems now, but wasn't correct either.
    * removed an unnecessarily strict check from find_base_for_list
      that causes a problem if git-rev-list commit ^parent-of-commit 
      is specified.
    * added some unit tests which were accidentally omitted from
      original merge-order patch

The fix to mark_ancestors_uninteresting isn't an optimal fix - a full
graph scan will still be performed in this case even though it is
not strictly required. However, a full graph scan is linear 
and still no worse than git-rev-list HEAD which runs in less than 2
seconds on a warm cache.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Diverged from fcbfd5a6b2c87dc5ecd1d6c4e94c56eebf44c8ac by Linus Torvalds <torvalds@ppc970.osdl.org>
---
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -229,7 +229,7 @@ static int find_base_for_list(struct com
 
 		struct commit *item = list->item;
 
-		if (item->object.util || (item->object.flags & UNINTERESTING)) {
+		if (item->object.util) {
 			die("%s:%d:%s: logic error: this should not have happened - commit %s\n",
 			    __FILE__, __LINE__, __FUNCTION__, sha1_to_hex(item->object.sha1));
 		}
@@ -323,7 +323,6 @@ static int find_base(struct commit *head
 	struct commit_list *pending = NULL;
 	struct commit_list *next;
 
-	commit_list_insert(head, &pending);
 	for (next = head->parents; next; next = next->next) {
 		commit_list_insert(next->item, &pending);
 	}
@@ -418,8 +417,8 @@ static void mark_ancestors_uninteresting
 	int boundary = flags & BOUNDARY;
 	int uninteresting = flags & UNINTERESTING;
 
+	commit->object.flags |= UNINTERESTING;
 	if (uninteresting || boundary || !visited) {
-		commit->object.flags |= UNINTERESTING;
 		return;
 
 		// we only need to recurse if
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
new file mode 100644
--- /dev/null
+++ b/t/t6001-rev-list-merge-order.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+
+test_description='Test rev-list --merge-order
+'
+. ./test-lib.sh
+
+function do_commit
+{
+    git-commit-tree "$@" </dev/null
+}
+
+function check_adjacency
+{
+    read previous
+    echo "= $previous"
+    while read next
+    do
+        if ! (git-cat-file commit $previous | grep "^parent $next" >/dev/null)
+        then
+            echo "^ $next"
+        else
+            echo "| $next"
+        fi
+        previous=$next
+    done
+}
+
+function sed_script
+{
+   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
+   do
+       echo -n "s/${!c}/$c/;"
+   done
+}
+
+date >path0
+git-update-cache --add path0
+tree=$(git-write-tree)
+root=$(do_commit $tree 2>/dev/null)
+export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
+l0=$(do_commit $tree -p $root)
+l1=$(do_commit $tree -p $l0)
+l2=$(do_commit $tree -p $l1)
+a0=$(do_commit $tree -p $l2)
+a1=$(do_commit $tree -p $a0)
+export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
+b1=$(do_commit $tree -p $a0)
+c1=$(do_commit $tree -p $b1)
+export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
+b2=$(do_commit $tree -p $b1)
+b3=$(do_commit $tree -p $b2)
+c2=$(do_commit $tree -p $c1 -p $b2)
+c3=$(do_commit $tree -p $c2)
+a2=$(do_commit $tree -p $a1)
+a3=$(do_commit $tree -p $a2)
+b4=$(do_commit $tree -p $b3 -p $a3)
+a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
+l3=$(do_commit $tree -p $a4)
+l4=$(do_commit $tree -p $l3)
+l5=$(do_commit $tree -p $l4)
+echo $l5 > .git/HEAD
+
+git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
+cat > expected-merge-order <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| b3
+| b2
+| b1
+^ a3
+| a2
+| a1
+= a0
+| l2
+| l1
+| l0
+= root
+EOF
+
+git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+
+test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 19 ]'
+test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
+test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+
+cat > expected-merge-order-1 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+l1
+l0
+root
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 | sed "$(sed_script)" > actual-merge-order-1
+test_expect_success 'Testing multiple heads' 'diff expected-merge-order-1 actual-merge-order-1'
+
+cat > expected-merge-order-2 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 ^$a1 | sed "$(sed_script)" > actual-merge-order-2
+test_expect_success 'Testing stop' 'diff expected-merge-order-2 actual-merge-order-2'
+
+cat > expected-merge-order-3 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 ^$l1 | sed "$(sed_script)" > actual-merge-order-3
+test_expect_success 'Testing stop in linear epoch' 'diff expected-merge-order-3 actual-merge-order-3'
+
+cat > expected-merge-order-4 <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
+
+git-rev-list --merge-order $l5 ^$l1 | sed "$(sed_script)" > actual-merge-order-4
+test_expect_success 'Testing start in linear epoch, stop after non-linear epoch' 'diff expected-merge-order-4 actual-merge-order-4'
+
+git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
+test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
+
+test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
+
+test_done
