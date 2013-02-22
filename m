From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] t7502: perform commits using alternate editor in a subshell
Date: Fri, 22 Feb 2013 15:13:00 -0800
Message-ID: <1361574780-30067-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <ralf.thielow@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91o5-00061y-Kk
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053Ab3BVXNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:13:09 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:11873 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab3BVXNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:13:07 -0500
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B5127fb770002>; Fri, 22 Feb 2013 15:12:55 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2013 15:12:19 -0800
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Fri, 22 Feb 2013 15:12:19 -0800
Received: from sc-xterm-14.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 22 Feb 2013
 15:13:02 -0800
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216879>

From: Brandon Casey <drafnel@gmail.com>

These tests call test_set_editor to set an alternate editor script, but
they appear to presume that the assignment is of a temporary nature and
will not have any effect outside of each individual test.  That is not
the case.  All of the test functions within a test script share a single
environment, so any variables modified in one, are visible in the ones
that follow.

So, let's protect the test functions that follow these, which set an
alternate editor, by performing the test_set_editor and 'git commit'
in a subshell.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Before "git-commit: populate the edit buffer with 2 blank lines before s-o-b"
is merged, this is needed on top of rt/commit-cleanup-config 51fb3a3d so that
the default EDITOR remains in effect for the new test.

-Brandon


 t/t7502-commit.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b1c7648..520a5cd 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -255,32 +255,40 @@ test_expect_success 'cleanup commit message (fail on invalid cleanup mode config
 test_expect_success 'cleanup commit message (no config and no option uses default)' '
 	echo content >>file &&
 	git add file &&
-	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
-	git commit --no-status &&
+	(
+	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	  git commit --no-status
+	) &&
 	commit_msg_is "commit message"
 '
 
 test_expect_success 'cleanup commit message (option overrides default)' '
 	echo content >>file &&
 	git add file &&
-	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
-	git commit --cleanup=whitespace --no-status &&
+	(
+	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	  git commit --cleanup=whitespace --no-status
+	) &&
 	commit_msg_is "commit message # comment"
 '
 
 test_expect_success 'cleanup commit message (config overrides default)' '
 	echo content >>file &&
 	git add file &&
-	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
-	git -c commit.cleanup=whitespace commit --no-status &&
+	(
+	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	  git -c commit.cleanup=whitespace commit --no-status
+	) &&
 	commit_msg_is "commit message # comment"
 '
 
 test_expect_success 'cleanup commit message (option overrides config)' '
 	echo content >>file &&
 	git add file &&
-	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
-	git -c commit.cleanup=whitespace commit --cleanup=default &&
+	(
+	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	  git -c commit.cleanup=whitespace commit --cleanup=default
+	) &&
 	commit_msg_is "commit message"
 '
 
-- 
1.8.1.3.566.gaa39828
