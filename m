From: Brad King <brad.king@kitware.com>
Subject: [PATCH] submodule: Demonstrate known breakage during recursive merge
Date: Wed, 24 Aug 2011 09:59:50 -0400
Message-ID: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 24 16:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwE50-0005io-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 16:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab1HXOFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 10:05:14 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:36911 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767Ab1HXOFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 10:05:12 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Aug 2011 10:05:12 EDT
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id F1E9935CBC;
	Wed, 24 Aug 2011 09:59:50 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id CFFF16098; Wed, 24 Aug 2011 09:59:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180002>

Since commit 68d03e4a (Implement automatic fast-forward merge for
submodules, 2010-07-07) we try to suggest submodule commits that resolve
a conflict.  Consider a true recursive merge case

    b---bc
   / \ /
  o   X
   \ / \
    c---cb

in which the two heads themselves (bc,cb) had resolved a submodule
conflict (i.e. reference different commits than their parents).  The
submodule merge search runs during the temporary merge of the two merge
bases (b,c) and prints out a suggestion that is not meaningful to the
user.  Then during the main merge the submodule merge search runs again
but dies with the message

  fatal: --ancestry-path given but there are no bottom commits

while trying to enumerate candidates.  Demonstrate this known breakage
with a new test in t7405-submodule-merge covering the case.

Signed-off-by: Brad King <brad.king@kitware.com>
---
Hi folks,

A co-worker encountered this problem last week in a real project.
The merge dies and does not leave the submodule conflict in the index.
We were able to work around it by moving the submodule out of the way
and resolving the conflict by hand.  Then I ran the merge again to
debug the problem and narrowed it down to this case.

BTW, if one adds the line

  rm -rf sub && mkdir sub &&

just above the line

  test_must_fail git merge top-bc

then the test passes because no submodule merge search runs.  Therefore
this test can be switched to expect success when the problem is fixed.

Brad

 t/t7405-submodule-merge.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index a8fb30b..8f6f2d6 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -228,4 +228,55 @@ test_expect_success 'merging with a modify/modify conflict between merge bases'
 	git merge d
 '
 
+# canonical criss-cross history in top and submodule
+test_expect_success 'setup for recursive merge with submodule' '
+	mkdir merge-recursive &&
+	(cd merge-recursive &&
+	 git init &&
+	 mkdir sub &&
+	 (cd sub &&
+	  git init &&
+	  test_commit a &&
+	  git checkout -b sub-b master &&
+	  test_commit b &&
+	  git checkout -b sub-c master &&
+	  test_commit c &&
+	  git checkout -b sub-bc sub-b &&
+	  git merge sub-c &&
+	  git checkout -b sub-cb sub-c &&
+	  git merge sub-b &&
+	  git checkout master) &&
+	 git add sub &&
+	 git commit -m a &&
+	 git checkout -b top-b master &&
+	 (cd sub && git checkout sub-b) &&
+	 git add sub &&
+	 git commit -m b &&
+	 git checkout -b top-c master &&
+	 (cd sub && git checkout sub-c) &&
+	 git add sub &&
+	 git commit -m c &&
+	 git checkout -b top-bc top-b &&
+	 git merge -s ours -n top-c &&
+	 (cd sub && git checkout sub-bc) &&
+	 git add sub &&
+	 git commit -m bc &&
+	 git checkout -b top-cb top-c &&
+	 git merge -s ours -n top-b &&
+	 (cd sub && git checkout sub-cb) &&
+	 git add sub &&
+	 git commit -m cb)
+'
+
+# merge should leave submodule unmerged in index
+test_expect_failure 'recursive merge with submodule' '
+	(cd merge-recursive &&
+	 test_must_fail git merge top-bc &&
+	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
+	 echo "160000 $(git rev-parse top-bc:sub) 3	sub" > expect3 &&
+	 git ls-files -u > actual &&
+	 grep "$(cat expect2)" actual > /dev/null &&
+	 grep "$(cat expect3)" actual > /dev/null)
+'
+
 test_done
-- 
1.7.4.4
