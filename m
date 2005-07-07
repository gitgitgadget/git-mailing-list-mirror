From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add t/t6003 with some --topo-order tests
Date: Thu, 07 Jul 2005 10:50:04 +1000
Message-ID: <20050707005004.9205.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 02:54:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqKeZ-0004g0-Ob
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 02:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVGGAxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 20:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGGAvO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 20:51:14 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:11651 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262331AbVGGAuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 20:50:07 -0400
Received: (qmail 9215 invoked by uid 500); 7 Jul 2005 00:50:04 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Linus: the last test fails with --topo-order at the moment. I haven't
seen your most recent changes, so it may still fail for trivial 
reasons even then. If so, I'll post an update.

 t/t6003-rev-list-topo-order.sh |  417 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 417 insertions(+), 0 deletions(-)
 create mode 100755 t/t6003-rev-list-topo-order.sh

4adac54d3b1503168c54c8eb03e78ab09762c7f7
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
new file mode 100755
--- /dev/null
+++ b/t/t6003-rev-list-topo-order.sh
@@ -0,0 +1,417 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+
+test_description='Tests git-rev-list --topo-order functionality'
+
+. ./test-lib.sh
+. ../t6000-lib.sh # t6xxx specific functions
+
+list_duplicates()
+{
+    "$@" | sort | uniq -d
+}
+
+date >path0
+git-update-cache --add path0
+save_tag tree git-write-tree
+on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "1971-08-16 00:00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "1971-08-16 00:00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "1971-08-16 00:00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "1971-08-16 00:00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "1971-08-16 00:00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "1971-08-16 00:00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "1971-08-16 00:00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "1971-08-16 00:00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
+on_committer_date "1971-08-16 00:00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
+on_committer_date "1971-08-16 00:00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
+on_committer_date "1971-08-16 00:00:21" hide_error save_tag alt_root unique_commit alt_root tree
+on_committer_date "1971-08-16 00:00:22" save_tag r0 unique_commit r0 tree -p alt_root
+on_committer_date "1971-08-16 00:00:23" save_tag r1 unique_commit r1 tree -p r0
+on_committer_date "1971-08-16 00:00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
+on_committer_date "1971-08-16 00:00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
+
+
+#
+# note: as of 20/6, it isn't possible to create duplicate parents, so this
+# can't be tested.
+#
+#on_committer_date "1971-08-16 00:00:20" save_tag m3 unique_commit m3 tree -p c3 -p a4 -p c3
+hide_error save_tag e1 as_author e@example.com unique_commit e1 tree
+save_tag e2 as_author e@example.com unique_commit e2 tree -p e1
+save_tag f1 as_author f@example.com unique_commit f1 tree -p e1
+save_tag e3 as_author e@example.com unique_commit e3 tree -p e2
+save_tag f2 as_author f@example.com unique_commit f2 tree -p f1
+save_tag e4 as_author e@example.com unique_commit e4 tree -p e3 -p f2
+save_tag e5 as_author e@example.com unique_commit e5 tree -p e4
+save_tag f3 as_author f@example.com unique_commit f3 tree -p f2
+save_tag f4 as_author f@example.com unique_commit f4 tree -p f3
+save_tag e6 as_author e@example.com unique_commit e6 tree -p e5 -p f4
+save_tag f5 as_author f@example.com unique_commit f5 tree -p f4
+save_tag f6 as_author f@example.com unique_commit f6 tree -p f5 -p e6
+save_tag e7 as_author e@example.com unique_commit e7 tree -p e6
+save_tag e8 as_author e@example.com unique_commit e8 tree -p e7
+save_tag e9 as_author e@example.com unique_commit e9 tree -p e8
+save_tag f7 as_author f@example.com unique_commit f7 tree -p f6
+save_tag f8 as_author f@example.com unique_commit f8 tree -p f7
+save_tag f9 as_author f@example.com unique_commit f9 tree -p f8
+save_tag e10 as_author e@example.com unique_commit e1 tree -p e9 -p f8
+
+hide_error save_tag g0 unique_commit g0 tree
+save_tag g1 unique_commit g1 tree -p g0
+save_tag h1 unique_commit g2 tree -p g0
+save_tag g2 unique_commit g3 tree -p g1 -p h1
+save_tag h2 unique_commit g4 tree -p g2
+save_tag g3 unique_commit g5 tree -p g2
+save_tag g4 unique_commit g6 tree -p g3 -p h2
+
+tag l5 > .git/HEAD
+
+#
+# cd to t/trash and use 
+#
+#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
+#
+# if you ever want to manually debug the operation of git-rev-list
+#
+echo "$sed_script" | tr ' ' \\012 > sed.script
+
+test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+19
+EOF
+
+test_output_expect_success 'simple topo order' 'git-rev-list --topo-order  HEAD' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+l1
+l0
+root
+EOF
+
+test_output_expect_success 'two diamonds topo order (g6)' 'git-rev-list --topo-order  g4' <<EOF
+g4
+h2
+g3
+g2
+h1
+g1
+g0
+EOF
+
+test_output_expect_success 'multiple heads' 'git-rev-list --topo-order a3 b3 c3' <<EOF
+b3
+c3
+c2
+b2
+c1
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
+test_output_expect_success 'multiple heads, prune at a1' 'git-rev-list --topo-order a3 b3 c3 ^a1' <<EOF
+b3
+c3
+c2
+b2
+c1
+b1
+a3
+a2
+EOF
+
+test_output_expect_success 'multiple heads, prune at l1' 'git-rev-list --topo-order a3 b3 c3 ^l1' <<EOF
+b3
+c3
+c2
+b2
+c1
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
+
+test_output_expect_success 'cross-epoch, head at l5, prune at l1' 'git-rev-list --topo-order l5 ^l1' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+EOF
+
+test_output_expect_success 'duplicated head arguments' 'git-rev-list --topo-order l5 l5 ^l1' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+EOF
+
+test_output_expect_success 'prune near topo' 'git-rev-list --topo-order a4 ^c3' <<EOF
+a4
+b4
+a3
+a2
+a1
+b3
+EOF
+
+test_output_expect_success "head has no parent" 'git-rev-list --topo-order  root' <<EOF
+root
+EOF
+
+test_output_expect_success "two nodes - one head, one base" 'git-rev-list --topo-order  l0' <<EOF
+l0
+root
+EOF
+
+test_output_expect_success "three nodes one head, one internal, one base" 'git-rev-list --topo-order  l1' <<EOF
+l1
+l0
+root
+EOF
+
+test_output_expect_success "linear prune l2 ^root" 'git-rev-list --topo-order  l2 ^root' <<EOF
+l2
+l1
+l0
+EOF
+
+test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --topo-order  l2 ^l0' <<EOF
+l2
+l1
+EOF
+
+test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --topo-order  l2 ^l1' <<EOF
+l2
+EOF
+
+test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --topo-order  l5 ^a4' <<EOF
+l5
+l4
+l3
+EOF
+
+test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --topo-order  l5 ^l3' <<EOF
+l5
+l4
+EOF
+
+test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --topo-order  l5 ^l4' <<EOF
+l5
+EOF
+
+test_output_expect_success "max-count 10 - topo order" 'git-rev-list --topo-order  --max-count=10 l5' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+EOF
+
+test_output_expect_success "max-count 10 - non topo order" 'git-rev-list --max-count=10 l5' <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+c2
+b3
+EOF
+
+test_output_expect_success '--max-age=c3, no --topo-order' "git-rev-list --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+EOF
+
+#
+# this test fails on --topo-order - a fix is required
+#
+#test_output_expect_success '--max-age=c3, --topo-order' "git-rev-list --topo-order --max-age=$(commit_date c3) l5" <<EOF
+#l5
+#l4
+#l3
+#a4
+#c3
+#b4
+#a3
+#a2
+#EOF
+
+test_output_expect_success 'one specified head reachable from another a4, c3, --topo-order' "list_duplicates git-rev-list --topo-order a4 c3" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another c3, a4, --topo-order' "list_duplicates git-rev-list --topo-order c3 a4" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another a4, c3, no --topo-order' "list_duplicates git-rev-list a4 c3" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another c3, a4, no --topo-order' "list_duplicates git-rev-list c3 a4" <<EOF
+EOF
+
+test_output_expect_success 'graph with c3 and a4 parents of head' "list_duplicates git-rev-list m1" <<EOF
+EOF
+
+test_output_expect_success 'graph with a4 and c3 parents of head' "list_duplicates git-rev-list m2" <<EOF
+EOF
+
+test_expect_success "head ^head --topo-order" 'git-rev-list --topo-order  a3 ^a3' <<EOF
+EOF
+
+test_expect_success "head ^head no --topo-order" 'git-rev-list a3 ^a3' <<EOF
+EOF
+
+test_output_expect_success 'simple topo order (l5r1)' 'git-rev-list --topo-order  l5r1' <<EOF
+l5r1
+r1
+r0
+alt_root
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+l1
+l0
+root
+EOF
+
+test_output_expect_success 'simple topo order (r1l5)' 'git-rev-list --topo-order  r1l5' <<EOF
+r1l5
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+l1
+l0
+root
+r1
+r0
+alt_root
+EOF
+
+test_output_expect_success "don't print things unreachable from one branch" "git-rev-list a3 ^b3 --topo-order" <<EOF
+a3
+a2
+a1
+EOF
+
+test_output_expect_success "--topo-order a4 l3" "git-rev-list --topo-order a4 l3" <<EOF
+l3
+a4
+c3
+c2
+c1
+b4
+a3
+a2
+a1
+b3
+b2
+b1
+a0
+l2
+l1
+l0
+root
+EOF
+
+#
+#
+
+test_done
------------
