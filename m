From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] rebase -i: Fix left-behind =?UTF-8?Q?CHERRY=5FPICK?=
 =?UTF-8?Q?=5FHEAD?=
Date: Thu, 18 Jun 2015 13:44:29 +0200
Organization: gmx
Message-ID: <cover.1434627492.git.johannes.schindelin@gmx.de>
References: <cover.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 13:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5YFW-0004AZ-3q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbbFRLoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:44:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:65027 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbbFRLop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:44:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LxcbX-1Z2ynN16OR-017Abg; Thu, 18 Jun 2015 13:44:30
 +0200
In-Reply-To: <cover.1434528725.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Ps+eJ55plk04gdiguY3zatFHuEpuhAXjIG9jPme4m+yRPI7gWGt
 geGRL0NFrz/FRvoO+8tgSz8h9sOXrBf77nuDG1RcjgljBTZJXQvQnB3APbCIRmbwvagCLCX
 PyW4cPoZc8luM7X6Vfxj9mkwoKjbelrArRV8+eWSg+Fejz+osmyPTsHrceWSlOBTcJCeex2
 kFfSjtx0egT12Nzhzh8sA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271999>

These patches fix a bug that bites me often enough when rebasing Git for
Windows.

The symptom is that .git/CHERRY_PICK_HEAD is left behind after skipping
an already-merged patch with `git rebase --continue` instead of `git
rebase --skip`. I always prefer the former invocation because the latter
would also skip legitimate patches if there were merge conflicts, while
the former would not allow that.

Changes since v1:

- no longer uses ':' to make the comment a no-op statement

- sets the fake editor correctly in the test (I verified that by
  rebasing onto v2.2.2 and running the test with and without setting the
  fake editor)

Interdiff below the diffstat.

Johannes Schindelin (2):
  t3404: demonstrate CHERRY_PICK_HEAD bug
  rebase -i: do not leave a CHERRY_PICK_HEAD file behind

 git-rebase--interactive.sh    |  6 +++++-
 t/t3404-rebase-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 16e0a82..5ff0f1c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,7 @@ continue)
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
-		: Nothing to commit -- skip this commit
+		# Nothing to commit -- skip this commit
 
 		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
 		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 241d4d1..f3337ad 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1114,7 +1114,8 @@ test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 	git tag seq-onto &&
 	git reset --hard HEAD~2 &&
 	git cherry-pick seq-onto &&
-	test_must_fail git rebase -i seq-onto &&
+	set_fake_editor &&
+	FAKE_LINES= test_must_fail git rebase -i seq-onto &&
 	test -d .git/rebase-merge &&
 	git rebase --continue &&
 	git diff seq-onto &&

-- 
2.3.1.windows.1.9.g8c01ab4
