From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base) [rev 2]
Date: Thu, 30 Jun 2005 11:51:34 +1000
Message-ID: <20050630015134.32197.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 04:18:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnocj-0005YZ-BS
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 04:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVF3CUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 22:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVF3CTA
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 22:19:00 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:20608 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262772AbVF3CSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 22:18:21 -0400
Received: (qmail 32207 invoked by uid 500); 30 Jun 2005 01:51:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch makes --merge-order produce the same list as git-rev-list 
without --merge-order specified.

In particular, if the graph looks like this:

A
| B
|/ 
C
|
D

The both git-rev-list B ^A and git-rev-list --merge-order will produce B.

The unit tests have been changed to reflect the fact that the prune
points are now formally part of the start list that is used to perform
the --merge-order sort.

That is: git-rev-list --merge-order A ^D used to produce

= A
| C

It now produces:

^ A
| C

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c                         |    8 +++-----
 t/t6001-rev-list-merge-order.sh |   12 ++++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

d402f03f56475c30c3b62577c5a42af09f6b95b8
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -585,11 +585,9 @@ int sort_list_in_merge_order(struct comm
 	for (; list; list = list->next) {
 		struct commit *next = list->item;
 
-		if (!(next->object.flags & UNINTERESTING)) {
-			if (!(next->object.flags & DUPCHECK)) {
-				next->object.flags |= DUPCHECK;
-				commit_list_insert(list->item, &reversed);
-			}
+		if (!(next->object.flags & DUPCHECK)) {
+			next->object.flags |= DUPCHECK;
+			commit_list_insert(list->item, &reversed);
 		}
 	}
 
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -367,33 +367,33 @@ test_output_expect_success "three nodes 
 EOF
 
 test_output_expect_success "linear prune l2 ^root" 'git-rev-list --merge-order --show-breaks l2 ^root' <<EOF
-= l2
+^ l2
 | l1
 | l0
 EOF
 
 test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --merge-order --show-breaks l2 ^l0' <<EOF
-= l2
+^ l2
 | l1
 EOF
 
 test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --merge-order --show-breaks l2 ^l1' <<EOF
-= l2
+^ l2
 EOF
 
 test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --merge-order --show-breaks l5 ^a4' <<EOF
-= l5
+^ l5
 | l4
 | l3
 EOF
 
 test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --merge-order --show-breaks l5 ^l3' <<EOF
-= l5
+^ l5
 | l4
 EOF
 
 test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --merge-order --show-breaks l5 ^l4' <<EOF
-= l5
+^ l5
 EOF
 
 test_output_expect_success "max-count 10 - merge order" 'git-rev-list --merge-order --show-breaks --max-count=10 l5' <<EOF
------------
