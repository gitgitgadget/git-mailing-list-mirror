From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 4/4] git-push: add tests for git push --porcelain
Date: Fri, 26 Feb 2010 22:59:51 -0500
Message-ID: <c75ea98d8b208cb3eb81c1526c428cfa0af40185.1267243044.git.larry@elder-gods.org>
References: <cover.1267242789.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDqS-0003UZ-KX
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967785Ab0B0D7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:59:55 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59106 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967772Ab0B0D7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:59:53 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 2EED1822022; Fri, 26 Feb 2010 22:59:53 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267242789.git.larry@elder-gods.org>
In-Reply-To: <cover.1267243044.git.larry@elder-gods.org>
References: <cover.1267243044.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141171>

Verify that the output format is correct for successful, rejected, and
flagrantly erroneous pushes.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 t/t5516-fetch-push.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0f04b2e..f3f113f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -660,4 +660,39 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push --porcelain' '
+	mk_empty &&
+	echo >.git/foo  "To testrepo" &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "Done" &&
+	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	) &&
+	diff -q .git/foo .git/bar
+'
+
+test_expect_success 'push --porcelain bad url' '
+	mk_empty &&
+	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/master:refs/remotes/origin/master &&
+	test_must_fail grep -q Done .git/bar
+'
+
+test_expect_success 'push --porcelain rejected' '
+	mk_empty &&
+	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+	(cd testrepo &&
+		git reset --hard origin/master^
+		git config receive.denyCurrentBranch true) &&
+
+	echo >.git/foo  "To testrepo"  &&
+	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
+
+	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/master:refs/heads/master &&
+	diff -q .git/foo .git/bar
+'
+
 test_done
-- 
1.7.0.rc2.40.g7d8aa
