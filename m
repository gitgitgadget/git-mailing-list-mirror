From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Test that git-branch -l works.
Date: Wed, 24 May 2006 23:34:04 -0400
Message-ID: <20060525033404.GC4403@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 05:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj6c9-0004fq-Mh
	for gcvg-git@gmane.org; Thu, 25 May 2006 05:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWEYDeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 23:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWEYDeN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 23:34:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23191 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964854AbWEYDeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 23:34:11 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fj6bj-000589-OW; Wed, 24 May 2006 23:33:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 805A120FB0C; Wed, 24 May 2006 23:34:04 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20721>

If the user supplies -l to git-branch when creating a new branch
then the new branch's log should be created automatically and the
branch creation should be logged in that log.

Further if a branch is being deleted and it had a log then also
verify that the log was deleted.

Test git-checkout -b foo -l for creating a new branch foo with a
log and checking out that branch.

Fixed git-checkout -b foo -l as the branch variable name was
incorrect in the script.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-checkout.sh   |    4 ++--
 t/t3200-branch.sh |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 360aabf..564117f 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -197,8 +197,8 @@ #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
 		if [ "$newbranch_log" ]; then
-			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
-			touch "$GIT_DIR/logs/refs/heads/$branchname"
+			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$newbranch")
+			touch "$GIT_DIR/logs/refs/heads/$newbranch"
 		fi
 		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
 		branch="$newbranch"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c3de151..5b04efc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -14,7 +14,8 @@ test_expect_success \
     'prepare an trivial repository' \
     'echo Hello > A &&
      git-update-index --add A &&
-     git-commit -m "Initial commit."'
+     git-commit -m "Initial commit." &&
+     HEAD=$(git-rev-parse --verify HEAD)'
 
 test_expect_success \
     'git branch --help should return success now.' \
@@ -32,4 +33,32 @@ test_expect_success \
     'git branch a/b/c should create a branch' \
     'git-branch a/b/c && test -f .git/refs/heads/a/b/c'
 
+cat >expect <<EOF
+0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from HEAD
+EOF
+test_expect_success \
+    'git branch -l d/e/f should create a branch and a log' \
+	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     git-branch -l d/e/f &&
+	 test -f .git/refs/heads/d/e/f &&
+	 test -f .git/logs/refs/heads/d/e/f &&
+	 diff expect .git/logs/refs/heads/d/e/f'
+
+test_expect_success \
+    'git branch -d d/e/f should delete a branch and a log' \
+	'git-branch -d d/e/f &&
+	 test ! -f .git/refs/heads/d/e/f &&
+	 test ! -f .git/logs/refs/heads/d/e/f'
+
+cat >expect <<EOF
+0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	checkout: Created from master^0
+EOF
+test_expect_success \
+    'git checkout -b g/h/i -l should create a branch and a log' \
+	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     git-checkout -b g/h/i -l master &&
+	 test -f .git/refs/heads/g/h/i &&
+	 test -f .git/logs/refs/heads/g/h/i &&
+	 diff expect .git/logs/refs/heads/g/h/i'
+
 test_done
-- 
1.3.3.g45d8
