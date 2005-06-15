From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] Fix to bug introduced into rev-list.c by [PATCH 5/7] Move...
Date: Wed, 15 Jun 2005 20:34:38 +1000
Message-ID: <20050615103438.16891.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 12:29:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiV9V-0002aN-Gk
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 12:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFOKeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 06:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFOKeq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 06:34:46 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:28801 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261331AbVFOKel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 06:34:41 -0400
Received: (qmail 16901 invoked by uid 500); 15 Jun 2005 10:34:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This fixes a problem introduced in the following patch:
	[PATCH 5/7] Move knowledge of UNINTERESTING flag into rev-list.c

I have also included a unit test that would detect this kind of error
in future.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

---

Note: as of the time of writing, this patch had not yet been
merged with Linus' head.

For ease of reference, the set of pending changes still to be
applied (in application orderevese order of app;lication) 

[PATCH] Fix to bug introduced into rev-list.c by [PATCH 5/7] Move...
[PATCH 7/7] Move traversal parts of epoch.[ch] into traversal.[ch]
[PATCH 6/7] Remove DUPCHECK, UNINTERESTING flags from epoch.h
[PATCH 5/7] Move knowledge of UNINTERESTING flag into rev-list.c
[PATCH 4/7] Move two general purpose commit-related functions into commit.[ch]
[PATCH 3/7] Rename epoch.c entry points as traverse_* methods/stuctures
[PATCH 2/7] Introduce new methods into the epoch_methods structure.
[PATCH 1/7] Additional --merge-order tests and general cleanup of t/t6001-rev-list-merge-order.sh
[PATCH 2/2] Add support for author-oriented git-rev-list switches [rev 11]
[PATCH 1/2] Changes to non-epoch.c code required for author-oriented git-rev-list changes
---

 rev-list.c                      |    2 +-
 t/t6001-rev-list-merge-order.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -91,7 +91,7 @@ static int process_commit(struct commit 
 	if (commit->object.flags & UNINTERESTING)
 		stop_traversal = 1;
 
-	if (action & STOP) {
+	if (action == STOP) {
 		return STOP;
 	}
 
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -464,6 +464,32 @@ test_output_expect_success "linear prune
 = l5
 EOF
 
+test_output_expect_success "max-count 10 - merge order" 'git-rev-list --show-breaks --max-count=10 l5' <<EOF
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
+EOF
+
+test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | sort' <<EOF
+a4
+b2
+b3
+b4
+c1
+c2
+c3
+l3
+l4
+l5
+EOF
+
 test_expect_failure "all heads uninteresting" 'git-rev-list --show-breaks a3 ^a3'
 #
 #
------------
