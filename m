From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 14:11:36 +0200
Message-ID: <11908086961933-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 26 14:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaVk5-000236-QA
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 14:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbXIZMLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbXIZMLm
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 08:11:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58344 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXIZMLl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 08:11:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IaVju-0003ls-18; Wed, 26 Sep 2007 14:11:38 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 86AB054D; Wed, 26 Sep 2007 14:11:37 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 227C0FA45; Wed, 26 Sep 2007 14:11:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.gcc9e
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59225>

This allows a poor-mans-filter-branch of the top-most commit.

Specifically, I had this history:

   --o--o--A'    <-- amended version of A
         \
          A
           \
    --o--B--M

I now wanted to "amend" M to pull in A' instead of A as its second parent.
For various reasons I didn't want to redo the merge M again, in particular,
it already contained the changes that were amended into A'. So I figured
I would just install a graft that lists B and A' as parents of M and then
do a simple git commit --amend. Alas, git commit looks at the real parents
instead of the grafted ones, so the amended M' would still have A as its
second parent. Here is the fix that picks the grafted parents instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  I know that git-commit is becoming a builtin. At the least, here is
  a test that makes sure that the behavior is remains.

  -- Hannes

 git-commit.sh     |    4 ++--
 t/t7501-commit.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 t/t7501-commit.sh

diff --git a/git-commit.sh b/git-commit.sh
index 7a7a2cb..33e7503 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -529,8 +529,8 @@ then
 		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	elif test -n "$amend"; then
 		rloga='commit (amend)'
-		PARENTS=$(git cat-file commit HEAD |
-			sed -n -e '/^$/q' -e 's/^parent /-p /p')
+		PARENTS=$(git rev-list --parents -1 HEAD |
+			sed -e 's/^[^ ]*//' -e 's/ / -p /g')
 	fi
 	current="$(git rev-parse --verify HEAD)"
 else
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
old mode 100644
new mode 100755
index b151b51..09c0d98
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -163,4 +163,13 @@ test_expect_success 'partial commit that involves removal (3)' '
 
 '
 
+test_expect_success '--amend respects grafts' '
+
+	grandparent=$(git rev-parse HEAD~2) &&
+	echo $(git rev-parse HEAD) $grandparent > .git/info/grafts &&
+	git commit --amend -C HEAD &&
+	test "parent $grandparent" = "$(git cat-file commit HEAD | grep "^parent")"
+
+'
+
 test_done
-- 
1.5.3.3.gcc9e
