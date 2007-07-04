From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Allow rebase to run if upstream is completely merged
Date: Wed, 4 Jul 2007 22:09:10 +0200
Message-ID: <200707042209.10877.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:09:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6BA4-0007iD-TR
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008AbXGDUJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756950AbXGDUJP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 16:09:15 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:43490 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbXGDUJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 16:09:14 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id F38EF13A82A
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 22:09:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id AD0862E118
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 22:09:11 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51637>

Consider this history:

  o--o-...-B          <- origin
      \     \
       x--x--M--x--x  <- master

In this situation, rebase considers master fully up-to-date and would
not do anything. However, if there were additional commits on origin,
the rebase would run and move the commits x on top of origin.

Here we change rebase to short-circuit out only if the history since origin
is strictly linear. Consequently, the above as well as a history like this
would be linearized:

  o--o               <- origin
      \
       x--x
        \  \
         x--M--x--x  <- master


Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-rebase.sh     |    8 +++++---
 t/t3400-rebase.sh |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index c590661..7a02f29 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -305,10 +305,12 @@ branch=$(git rev-parse --verify "${branch_name}^0") || exit
 
 # Now we are rebasing commits $upstream..$branch on top of $onto
 
-# Check if we are already based on $onto, but this should be
-# done only when upstream and onto are the same.
+# Check if we are already based on $onto with linear history,
+# but this should be done only when upstream and onto are the same.
 mb=$(git merge-base "$onto" "$branch")
-if test "$upstream" = "$onto" && test "$mb" = "$onto"
+if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
+	# linear history?
+	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
 then
 	echo >&2 "Current branch $branch_name is up to date."
 	exit 0
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 95f3a2a..62205b2 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -12,7 +12,7 @@ This test runs git rebase and checks that the author information is not lost.
 export GIT_AUTHOR_EMAIL=bogus_email_address
 
 test_expect_success \
-    'prepare repository with topic branch, then rebase against master' \
+    'prepare repository with topic branches' \
     'echo First > A &&
      git update-index --add A &&
      git-commit -m "Add A." &&
@@ -24,11 +24,48 @@ test_expect_success \
      echo Third >> A &&
      git update-index A &&
      git-commit -m "Modify A." &&
+     git checkout -b side my-topic-branch &&
+     echo Side >> C &&
+     git add C &&
+     git commit -m "Add C" &&
+     git checkout -b nonlinear my-topic-branch &&
+     echo Edit >> B &&
+     git add B &&
+     git commit -m "Modify B" &&
+     git merge side &&
+     git checkout -b upstream-merged-nonlinear &&
+     git merge master &&
      git checkout -f my-topic-branch &&
+     git tag topic
+'
+
+test_expect_success 'rebase against master' '
      git rebase master'
 
 test_expect_failure \
     'the rebase operation should not have destroyed author information' \
     'git log | grep "Author:" | grep "<>"'
 
+test_expect_success 'rebase after merge master' '
+     git reset --hard topic &&
+     git merge master &&
+     git rebase master &&
+     ! git show | grep "^Merge:"
+'
+
+test_expect_success 'rebase of history with merges is linearized' '
+     git checkout nonlinear &&
+     test 4 = $(git rev-list master.. | wc -l) &&
+     git rebase master &&
+     test 3 = $(git rev-list master.. | wc -l)
+'
+
+test_expect_success \
+    'rebase of history with merges after upstream merge is linearized' '
+     git checkout upstream-merged-nonlinear &&
+     test 5 = $(git rev-list master.. | wc -l) &&
+     git rebase master &&
+     test 3 = $(git rev-list master.. | wc -l)
+'
+
 test_done
-- 
1.5.3.rc0
