From: Max Kirillov <max@max630.net>
Subject: [PATCH v3] reachable.c: add HEAD to reachability starting commits
Date: Wed,  3 Sep 2014 19:14:10 +0300
Message-ID: <1409760850-27322-1-git-send-email-max@max630.net>
References: <xmqq4mwp3oeb.fsf@gitster.dls.corp.google.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPDDF-0003hQ-7m
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 18:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbaICQOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 12:14:50 -0400
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:59687
	"EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753857AbaICQOt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 12:14:49 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-10.prod.phx3.secureserver.net with 
	id mgEg1o00D3gsSd601gEkQo; Wed, 03 Sep 2014 09:14:46 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <xmqq4mwp3oeb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256396>

HEAD is not explicitly used as a starting commit for
calculating reachability, so if it's detached and reflogs
are disabled it may be pruned.

Add tests which demonstrate it. Test 'prune: prune former HEAD after checking
out branch' also reverts changes to repository.

Signed-off-by: Max Kirillov <max@max630.net>
---
Fixed the notes.

(This filesystem stuff would not be needed if I had a separated repository
without reflogs from scratch, like in v1. Having to handle leftouts from
previous test cases does not add clarity here. Maybe it worth extracting all
cases with no reflogs into a separated script.)
 reachable.c      |  3 +++
 t/t5304-prune.sh | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 377d3d3..01c6a3f 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -104,6 +104,28 @@ test_expect_success 'prune: prune unreachable heads' '
 
 '
 
+test_expect_success 'prune: do not prune detached HEAD with no reflog' '
+
+	git checkout --detach --quiet &&
+	git commit --allow-empty -m "detached commit" &&
+	# verify that there is no reflogs
+	# (should be removed and disabled by previous test)
+	test ! -e .git/logs &&
+	git prune -n >prune_actual &&
+	: >prune_expected &&
+	test_cmp prune_actual prune_expected
+
+'
+
+test_expect_success 'prune: prune former HEAD after checking out branch' '
+
+	head_sha1=$(git rev-parse HEAD) &&
+	git checkout --quiet master &&
+	git prune -v >prune_actual &&
+	grep "$head_sha1" prune_actual
+
+'
+
 test_expect_success 'prune: do not prune heads listed as an argument' '
 
 	: > file2 &&
-- 
2.0.1.1697.g73c6810
