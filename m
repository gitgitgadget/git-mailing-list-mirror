From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: if todo was reordered use HEAD as the rewritten parent
Date: Wed, 15 Oct 2008 02:44:40 -0500
Message-ID: <130c9caae646675893ed17cd213c53a9734fe837.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
 <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
 <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
 <ab80b829ebfa597dc4aaac6e49f9907e505adf59.1224055978.git.stephen@exigencecorp.com>
 <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
 <3fd41e60ed27b248f15c60d5a45e543a7e32af99.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq15i-0001GN-L0
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbYJOHo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYJOHoz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:55 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49889 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYJOHot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:49 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id D51DC1E06B2;
	Wed, 15 Oct 2008 03:44:48 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 575431E0660;
	Wed, 15 Oct 2008 03:44:48 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <3fd41e60ed27b248f15c60d5a45e543a7e32af99.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98253>

This seems like the best guess we can make until git sequencer marks are
available. That being said, within the context of re-ordering a commit before
its parent in todo, I think applying it on top of the current commit seems like
a reasonable assumption of what the user intended.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh               |    9 +++++++++
 t/t3411-rebase-preserve-around-merges.sh |    4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3821692..1fc4f44 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -194,6 +194,15 @@ pick_one_preserving_merges () {
 		if test -f "$REWRITTEN"/$p
 		then
 			new_p=$(cat "$REWRITTEN"/$p)
+
+			# If the todo reordered commits, and our parent is marked for
+			# rewriting, but hasn't been gotten to yet, assume the user meant to
+			# drop it on top of the current HEAD
+			if test -z "$new_p"
+			then
+				new_p=$(git rev-parse HEAD)
+			fi
+
 			test $p != $new_p && fast_forward=f
 			case "$new_parents" in
 			*$new_p*)
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index b3973c9..dfad5dd 100644
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -80,7 +80,7 @@ test_expect_success 'setup' '
 #       \        /
 #        -- C1 --
 #
-test_expect_failure 'squash F1 into D1' '
+test_expect_success 'squash F1 into D1' '
 	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse branch)" &&
 	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
@@ -99,7 +99,7 @@ test_expect_failure 'squash F1 into D1' '
 #
 # And rebase G1..M1 onto E2
 
-test_expect_failure 'rebase two levels of merge' '
+test_expect_success 'rebase two levels of merge' '
 	git checkout -b branch2 A1 &&
 	touch g &&
 	git add g &&
-- 
1.6.0.2
