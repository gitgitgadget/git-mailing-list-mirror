From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] cvsimport: test case for severe branch import problem
Date: Sat, 23 Jun 2007 14:51:47 +0200
Message-ID: <11826031071213-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 14:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I255j-0002bq-Qp
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 14:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXFWMvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbXFWMvu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 08:51:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:54396 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbXFWMvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 08:51:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5NCpmnq026551
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 14:51:48 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5NCplfn007994;
	Sat, 23 Jun 2007 14:51:47 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50736>

The result of importing branches using git-cvsimport depends
on the time of the first commit to the cvs branch. If the first
commit is done after other commits to the cvs trunk the result
of cvsimport may be wrong. git-cvsimport creates a wrong history.

The problem is quite severe because merging such a wrongly imported
branch by git may be successful without reporting any problem but the
results are wrong. The result may differ from what a simple cvs merge
(cvs up -j) yields.

This test script creates two cvs repositories and imports both to
git. The first cvs repository has the 'wrong' order of commits and
yields an error. The result of a merge in cvs and a merge in git
differs. The second cvs repository has the 'right' order and the
import to git runs as expected and merging yields the same results
in cvs and git.

The conclusion is you must not rely on the existing cvsimport for
tracking cvs branches. The history of such branches may be plain wrong.
Git may display different patches than cvs would do. Merging cvs
topic branches may yield completely wrong results. One obvious thing
that may happen is that a merge reverts changes commited to the cvs
trunk before the first commit to the cvs branch. And this would happen
without any indication by git. Everything would seem to run smoothely.

This conclusion should be stated in bold at appropriate places in
the documentation.

It's a pity because merging is what git is especially good at. But
as long as git-cvsimport may create the wrong history you can't use
git to merge cvs topic branches without double checking every detail,
which makes this approach unfeasable.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t9600-cvsimport.sh |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100755 t/t9600-cvsimport.sh

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
new file mode 100755
index 0000000..180cd8a
--- /dev/null
+++ b/t/t9600-cvsimport.sh
@@ -0,0 +1,184 @@
+
+test_description='CVS import'
+
+. ./test-lib.sh
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsimport tests, cvs not found' :
+    test_done
+    exit
+fi
+
+CVSROOT=$(pwd)/cvsrootwrong
+CVSWORK=$(pwd)/cvsworkwrong
+CVSIMPORTED=$(pwd)/cvsimportedwrong
+export CVSROOT CVSWORK
+
+cvspscache="$HOME/.cvsps/$(echo $CVSROOT | sed -e 's%/%#%g')#src"
+rm -f $cvspscache
+
+rm -rf "$CVSROOT" "$CVSWORK"
+mkdir "$CVSROOT" &&
+cvs init &&
+mkdir "$CVSROOT/src"
+cvs -Q co -d "$CVSWORK" src &&
+rm -rf .git || 
+exit 1
+
+# sleeps are needed to fight cvsps' fuzz
+test_expect_success \
+	'initial cvs commits, tag, and branch' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 1" >>a.txt &&
+	   cvs add a.txt &&
+	   cvs commit -m "cvs commit 1" &&
+	   sleep 2 &&
+	   echo "a: line 2" >>a.txt &&
+	   echo "a: line 3" >>a.txt &&
+	   echo "a: line 4" >>a.txt &&
+	   echo "a: line 5" >>a.txt &&
+	   cvs commit -m "cvs commit 2" &&
+	   cvs tag split &&
+	   cvs tag -b branch &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 6" >>a.txt &&
+	   cvs commit -m "cvs commit 2" &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 7" >>a.txt &&
+	   cvs commit -m "cvs commit 3" &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   cvs up -r branch &&
+	   sed -e 's/2/B/' a.txt >t &&
+	   mv t a.txt &&
+	   cvs commit -m "cvs commit on branch" &&
+	   cvs up -A &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'merging' \
+    '( cd "$CVSWORK" &&
+	   cvs up -j branch
+	 ) &&
+	 (
+	   cd "$CVSIMPORTED" &&
+	   git-checkout cvshead &&
+	   git-merge branch
+	 ) &&
+	 diff -q "$CVSWORK/a.txt" "$CVSIMPORTED/a.txt"'
+
+CVSROOT=$(pwd)/cvsrootright
+CVSWORK=$(pwd)/cvsworkright
+CVSIMPORTED=$(pwd)/cvsimportedright
+export CVSROOT CVSWORK
+
+cvspscache="$HOME/.cvsps/$(echo $CVSROOT | sed -e 's%/%#%g')#src"
+rm -f $cvspscache
+
+rm -rf "$CVSROOT" "$CVSWORK"
+mkdir "$CVSROOT" &&
+cvs init &&
+mkdir "$CVSROOT/src"
+cvs -Q co -d "$CVSWORK" src &&
+rm -rf .git || 
+exit 1
+
+# sleeps are needed to fight cvsps' fuzz
+test_expect_success \
+	'initial cvs commits, tag, and branch' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 1" >>a.txt &&
+	   cvs add a.txt &&
+	   cvs commit -m "cvs commit 1" &&
+	   sleep 2 &&
+	   echo "a: line 2" >>a.txt &&
+	   echo "a: line 3" >>a.txt &&
+	   echo "a: line 4" >>a.txt &&
+	   echo "a: line 5" >>a.txt &&
+	   cvs commit -m "cvs commit 2" &&
+	   cvs tag split &&
+	   cvs tag -b branch &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   cvs up -r branch &&
+	   sed -e 's/2/B/' a.txt >t &&
+	   mv t a.txt &&
+	   cvs commit -m "cvs commit on branch" &&
+	   cvs up -A &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 6" >>a.txt &&
+	   cvs commit -m "cvs commit 2" &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'cvs commit' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 7" >>a.txt &&
+	   cvs commit -m "cvs commit 3" &&
+	   sleep 2
+	)'
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C $CVSIMPORTED -o cvshead src'
+
+test_expect_success \
+	'merging' \
+    '( cd "$CVSWORK" &&
+	   cvs up -j branch
+	 ) &&
+	 (
+	   cd "$CVSIMPORTED" &&
+	   git-checkout cvshead &&
+	   git-merge branch
+	 ) &&
+	 diff -q "$CVSWORK/a.txt" "$CVSIMPORTED/a.txt"'
+
+test_done
-- 
1.5.2.2.315.gc649a
