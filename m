From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Clean up "git-branch.sh" and add remove recursive dir
 test cases.
Date: Sun, 1 Oct 2006 14:38:18 +0200
Message-ID: <20061001143818.c9f95ab5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 14:31:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU0U7-0005ZZ-BV
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 14:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWJAMbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 08:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWJAMbw
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 08:31:52 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:20414 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932113AbWJAMbv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 08:31:51 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 4AE4554954;
	Sun,  1 Oct 2006 14:31:50 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28179>

Now that directory recursive remove works in the core C code, we
don't need to do it in "git-branch.sh".

Also add test cases to check that directory recursive remove will
continue to work.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-branch.sh        |   10 ----------
 t/t3210-pack-refs.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index bf84b30..4379a07 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -111,16 +111,6 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
-if [ -d "$GIT_DIR/refs/heads/$branchname" ]
-then
-	for refdir in `cd "$GIT_DIR" && \
-		find "refs/heads/$branchname" -type d | sort -r`
-	do
-		rmdir "$GIT_DIR/$refdir" || \
-		    die "Could not delete '$refdir', there may still be a ref there."
-	done
-fi
-
 prev=''
 if git-show-ref --verify --quiet -- "refs/heads/$branchname"
 then
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 193fe1f..f31e79c 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -67,4 +67,31 @@ test_expect_success \
      git-pack-refs &&
      git-branch -d g'
 
+test_expect_failure \
+    'git branch i/j/k should barf if branch i exists' \
+    'git-branch i &&
+     git-pack-refs --prune &&
+     git-branch i/j/k'
+
+test_expect_success \
+    'test git branch k after branch k/l/m and k/lm have been deleted' \
+    'git-branch k/l &&
+     git-branch k/lm &&
+     git-branch -d k/l &&
+     git-branch k/l/m &&
+     git-branch -d k/l/m &&
+     git-branch -d k/lm &&
+     git-branch k'
+
+test_expect_success \
+    'test git branch n after some branch deletion and pruning' \
+    'git-branch n/o &&
+     git-branch n/op &&
+     git-branch -d n/o &&
+     git-branch n/o/p &&
+     git-branch -d n/op &&
+     git-pack-refs --prune &&
+     git-branch -d n/o/p &&
+     git-branch n'
+
 test_done
-- 
1.4.2.1.g7bc701-dirty
