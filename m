From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] rebase -i continue: Don't skip submodule only commits
Date: Sat,  7 Apr 2012 11:20:53 +0100
Message-ID: <1333794053-22226-1-git-send-email-john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 12:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGSwQ-0001mU-K1
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 12:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab2DGKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 06:32:18 -0400
Received: from honeysuckle.london.02.net ([87.194.255.144]:44106 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab2DGKcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 06:32:17 -0400
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Apr 2012 06:32:17 EDT
Received: from river.lan (78.86.105.148) by honeysuckle.london.02.net (8.5.140)
        id 4F58EC1A00D094E2; Sat, 7 Apr 2012 11:21:09 +0100
X-Mailer: git-send-email 1.7.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194945>

When git-rebase--interactive stops due to a conflict and the only change
to be committed is in a submodule, the test for whether there is
anything to be committed ignores the staged submodule change.  This
leads rebase to skip creating the commit for the change.

While unstaged submodule changes should be ignored to avoid needing to
update submodules during a rebase, it is safe to remove the
--ignore-submodules option to diff-index because --cached ensures that
it is only checking the index.  This was discussed in [1] and a test is
included to ensure that unstaged changes are still ignored correctly.

[1] http://thread.gmane.org/gmane.comp.version-control.git/188713

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..4546749 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -672,7 +672,7 @@ rearrange_squash () {
 case "$action" in
 continue)
 	# do we have anything to commit?
-	if git diff-index --cached --quiet --ignore-submodules HEAD --
+	if git diff-index --cached --quiet HEAD --
 	then
 		: Nothing to commit -- skip this
 	else
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b981572..7fd2127 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -624,8 +624,38 @@ test_expect_success 'submodule rebase -i' '
 	FAKE_LINES="1 squash 2 3" git rebase -i A
 '
 
+test_expect_success 'submodule conflict setup' '
+	git tag submodule-base &&
+	git checkout HEAD^ &&
+	(
+		cd sub && git checkout HEAD^ && echo 4 >elif &&
+		git add elif && git commit -m "submodule conflict"
+	) &&
+	git add sub &&
+	test_tick &&
+	git commit -m "Conflict in submodule" &&
+	git tag submodule-topic
+'
+
+test_expect_success 'rebase -i continue with only submodule staged' '
+	test_must_fail git rebase -i submodule-base &&
+	git add sub &&
+	git rebase --continue &&
+	test $(git rev-parse submodule-base) != $(git rev-parse HEAD)
+'
+
+test_expect_success 'rebase -i continue with unstaged submodule' '
+	git checkout submodule-topic &&
+	git reset --hard &&
+	test_must_fail git rebase -i submodule-base &&
+	git reset &&
+	git rebase --continue &&
+	test $(git rev-parse submodule-base) = $(git rev-parse HEAD)
+'
+
 test_expect_success 'avoid unnecessary reset' '
 	git checkout master &&
+	git reset --hard &&
 	test-chmtime =123456789 file3 &&
 	git update-index --refresh &&
 	HEAD=$(git rev-parse HEAD) &&
-- 
1.7.8.5
