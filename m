From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/14] git p4: test sync/clone --branch behavior
Date: Mon, 14 Jan 2013 19:46:55 -0500
Message-ID: <1358210828-2369-2-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuugy-0000ME-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756987Ab3AOArc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:47:32 -0500
Received: from honk.padd.com ([74.3.171.149]:52458 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971Ab3AOArc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:47:32 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 81FA32F3F;
	Mon, 14 Jan 2013 16:47:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0170E28EC2; Mon, 14 Jan 2013 19:47:28 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213552>

Add failing tests to document behavior when there are multiple p4
branches, as created using the --branch option.  In particular:

Using clone --branch populates the specified branch correctly, but
dies with an error when trying to checkout master.

Calling sync without a master branch dies with an error looking for
master.  When there are two or more branches, a sync does
nothing due to branch detection code, but that is expected.

Using sync --branch to try to update just a particular branch
updates no branch, but appears to succeed.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9806-git-p4-options.sh | 53 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index fa40cc8..844aae0 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -27,14 +27,59 @@ test_expect_success 'clone no --git-dir' '
 	test_must_fail git p4 clone --git-dir=xx //depot
 '
 
-test_expect_success 'clone --branch' '
+test_expect_failure 'clone --branch should checkout master' '
 	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git ls-files >files &&
-		test_line_count = 0 files &&
-		test_path_is_file .git/refs/remotes/p4/sb
+		git rev-parse refs/remotes/p4/sb >sb &&
+		git rev-parse refs/heads/master >master &&
+		test_cmp sb master &&
+		git rev-parse HEAD >head &&
+		test_cmp sb head
+	)
+'
+
+test_expect_failure 'sync when branch is not called master should work' '
+	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot@2 &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git p4 sync &&
+		git show -s --format=%s refs/remotes/p4/sb >show &&
+		grep "change 3" show
+	)
+'
+
+# engages --detect-branches code, which will do filename filtering so
+# no sync to either b1 or b2
+test_expect_success 'sync when two branches but no master should noop' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init &&
+		git p4 sync --branch=refs/remotes/p4/b1 //depot@2 &&
+		git p4 sync --branch=refs/remotes/p4/b2 //depot@2 &&
+		git p4 sync &&
+		git show -s --format=%s refs/remotes/p4/b1 >show &&
+		grep "Initial import" show &&
+		git show -s --format=%s refs/remotes/p4/b2 >show &&
+		grep "Initial import" show
+	)
+'
+
+test_expect_failure 'sync --branch updates specified branch' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init &&
+		git p4 sync --branch=refs/remotes/p4/b1 //depot@2 &&
+		git p4 sync --branch=refs/remotes/p4/b2 //depot@2 &&
+		git p4 sync --branch=refs/remotes/p4/b2 &&
+		git show -s --format=%s refs/remotes/p4/b1 >show &&
+		grep "Initial import" show &&
+		git show -s --format=%s refs/remotes/p4/b2 >show &&
+		grep "change 3" show
 	)
 '
 
-- 
1.8.1.350.gdbf6fd0
