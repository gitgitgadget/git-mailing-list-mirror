From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] A test case that demonstrates a problem with merges with two roots.
Date: Thu, 23 Jun 2005 12:01:09 +1000
Message-ID: <20050623020109.16402.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jun 23 04:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlH7J-0006XQ-D8
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVFWCJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVFWCFB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:05:01 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:54144 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262003AbVFWCBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 22:01:16 -0400
Received: (qmail 16413 invoked by uid 500); 23 Jun 2005 02:01:09 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


git-rev-list --merge-order is omitting one of the roots when
displaying a merge containing two distinct roots.

A subsequent patch will fix the problem.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |   61 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -172,6 +172,13 @@ on_committer_date "1971-08-16 00:00:17" 
 on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
 on_committer_date "1971-08-16 00:00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
 on_committer_date "1971-08-16 00:00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
+on_committer_date "1971-08-16 00:00:21" hide_error save_tag alt_root unique_commit alt_root tree
+on_committer_date "1971-08-16 00:00:22" save_tag r0 unique_commit r0 tree -p alt_root
+on_committer_date "1971-08-16 00:00:23" save_tag r1 unique_commit r1 tree -p r0
+on_committer_date "1971-08-16 00:00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
+on_committer_date "1971-08-16 00:00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
+
+
 #
 # note: as of 20/6, it isn't possible to create duplicate parents, so this
 # can't be tested.
@@ -483,6 +490,60 @@ EOF
 
 test_expect_success "head ^head no --merge-order" 'git-rev-list a3 ^a3' <<EOF
 EOF
+
+test_output_expect_success 'simple merge order (l5r1)' 'git-rev-list --merge-order --show-breaks l5r1' <<EOF
+= l5r1
+| r1
+| r0
+| alt_root
+^ l5
+| l4
+| l3
+| a4
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
+| a0
+| l2
+| l1
+| l0
+= root
+EOF
+
+test_output_expect_success 'simple merge order (r1l5)' 'git-rev-list --merge-order --show-breaks r1l5' <<EOF
+= r1l5
+| l5
+| l4
+| l3
+| a4
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
+| a0
+| l2
+| l1
+| l0
+| root
+^ r1
+| r0
+= alt_root
+EOF
+
+
 #
 #
 
------------
