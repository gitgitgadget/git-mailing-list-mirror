From: Max Kirillov <max@max630.net>
Subject: [PATCH v2] reachable.c: add HEAD to reachability starting commits
Date: Mon,  1 Sep 2014 00:16:44 +0300
Message-ID: <1409519804-15960-1-git-send-email-max@max630.net>
References: <20140831152806.GC17449@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 23:18:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOCVe-0000cc-SG
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 23:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaHaVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 17:17:24 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:53197
	"EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751235AbaHaVRY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2014 17:17:24 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-04.prod.phx3.secureserver.net with 
	id lZHF1o00D3gsSd601ZHJ3Z; Sun, 31 Aug 2014 14:17:20 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <20140831152806.GC17449@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256299>

HEAD is not explicitly used as a starting commit for
calculating reachability, so if it's detached and reflogs
are disabled it may be pruned.

Add tests which demonstrate it. Test 'prune: prune former HEAD after checking
out branch' also reverts changes to repository.

Signed-off-by: Max Kirillov <max@max630.net>
---
Inserted test into existing script.
 reachable.c      |  3 +++
 t/t5304-prune.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/reachable.c b/reachable.c
index 654a8c5..6f6835b 100644
--- a/reachable.c
+++ b/reachable.c
@@ -229,6 +229,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
 
+	/* detached HEAD is not included in the list above */
+	head_ref(add_one_ref, revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		for_each_reflog(add_one_reflog, revs);
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 377d3d3..77cf064 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -104,6 +104,27 @@ test_expect_success 'prune: prune unreachable heads' '
 
 '
 
+test_expect_success 'prune: do not prune detached HEAD with no reflog' '
+
+	git config core.logAllRefUpdates false &&
+	test ! -e .git/logs &&
+	git checkout --detach --quiet &&
+	git commit --allow-empty -m "detached commit" &&
+	git prune -n >prune_actual &&
+	: >prune_expected &&
+	test_cmp prune_actual prune_expected
+
+'
+
+test_expect_success 'prune: prune former HEAD after checking out branch' '
+
+	head_sha1=`git rev-parse HEAD` &&
+	git checkout --quiet master &&
+	git prune -v >prune_actual &&
+	grep -q "$head_sha1" prune_actual
+
+'
+
 test_expect_success 'prune: do not prune heads listed as an argument' '
 
 	: > file2 &&
-- 
2.0.1.1697.g73c6810
