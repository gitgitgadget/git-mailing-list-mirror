From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base)
Date: Thu, 30 Jun 2005 09:45:33 +1000
Message-ID: <20050629234533.28709.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 01:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnm8w-00024a-66
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 01:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVF2XqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 19:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVF2XqK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 19:46:10 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:1153 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262733AbVF2Xpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 19:45:35 -0400
Received: (qmail 28719 invoked by uid 500); 29 Jun 2005 23:45:33 -0000
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

The unit test changes in this patch remove use of the --show-breaks 
flags from certain unit tests. The changed --merge-order behaviour 
changed the annotation that --show-breaks prints for certain test cases. 
The new behaviour is reasonable and irrelevant to the intent of the tests
so that tests have been changed to eliminate the spurious behaviour.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c                         |    8 +++-----
 t/t6001-rev-list-merge-order.sh |   36 ++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

26783f6660e58cc2e988b92050707a6a417cc6ae
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
@@ -366,34 +366,34 @@ test_output_expect_success "three nodes 
 = root
 EOF
 
-test_output_expect_success "linear prune l2 ^root" 'git-rev-list --merge-order --show-breaks l2 ^root' <<EOF
-= l2
-| l1
-| l0
+test_output_expect_success "linear prune l2 ^root" 'git-rev-list --merge-order l2 ^root' <<EOF
+l2
+l1
+l0
 EOF
 
-test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --merge-order --show-breaks l2 ^l0' <<EOF
-= l2
-| l1
+test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --merge-order l2 ^l0' <<EOF
+l2
+l1
 EOF
 
-test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --merge-order --show-breaks l2 ^l1' <<EOF
-= l2
+test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --merge-order l2 ^l1' <<EOF
+l2
 EOF
 
-test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --merge-order --show-breaks l5 ^a4' <<EOF
-= l5
-| l4
-| l3
+test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --merge-order l5 ^a4' <<EOF
+l5
+l4
+l3
 EOF
 
-test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --merge-order --show-breaks l5 ^l3' <<EOF
-= l5
-| l4
+test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --merge-order l5 ^l3' <<EOF
+l5
+l4
 EOF
 
-test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --merge-order --show-breaks l5 ^l4' <<EOF
-= l5
+test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --merge-order l5 ^l4' <<EOF
+l5
 EOF
 
 test_output_expect_success "max-count 10 - merge order" 'git-rev-list --merge-order --show-breaks --max-count=10 l5' <<EOF
------------
