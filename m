From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Tests for core subproject support
Date: Thu, 19 Apr 2007 01:55:45 +0200
Message-ID: <20070418235545.GA14247@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 01:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeK07-0006Uw-LH
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbXDRXzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbXDRXzs
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:55:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:29547 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030302AbXDRXzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:55:47 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (mrclete mo22) (RZmta 5.5)
	with ESMTP id A000dej3INJYZf ; Thu, 19 Apr 2007 01:55:46 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2F491277BD;
	Thu, 19 Apr 2007 01:55:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id F4191BDDE; Thu, 19 Apr 2007 01:55:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44965>

The following tests available:

- create subprojects: create a directory in the superproject,
  initialize a git repo in it, and try adding it in super project.
  Make a commit in superproject

- check if fsck ignores the subprojects: it just should give no errors

- check if commit in a subproject detected: make a commit in
  subproject, git-diff-files in superproject should detect it

- check if a changed subproject HEAD can be committed: try
  "git-commit -a" in superproject. It should commit changed
  HEAD of a subproject

- check if diff-index works for subproject elements: compare the index
  (changed by previuos tests) with the initial commit (which created
  two subprojects). Should show a change for the recently changed subproject

- check if diff-tree works for subproject elements: do the same, just use
  git-diff-tree. This test is somewhat redundant, I just added it for
  completeness (diff, diff-files, and diff-index are already used)

- check if git diff works for subproject elements: try to limit
  the diff for the name of a subproject in superproject:
     git diff HEAD^ HEAD -- subproject

- check if clone works: try a clone of superproject and compare
  "git ls-files -s" output in superproject and cloned repo

- removing and adding subproject: rename test. Currently implemented
  as "git-update-index --force-remove", "mv" and "git-add".

- checkout in superproject: try to checkout the initial commit

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I should have missed something, I have that feeling...

 t/t3040-subprojects-basic.sh |   85 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100755 t/t3040-subprojects-basic.sh

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
new file mode 100755
index 0000000..79b9f23
--- /dev/null
+++ b/t/t3040-subprojects-basic.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='Basic subproject functionality'
+. ./test-lib.sh
+
+test_expect_success 'Super project creation' \
+    ': >Makefile &&
+    git add Makefile &&
+    git commit -m "Superproject created"'
+
+
+cat >expected <<EOF
+:000000 160000 00000... A	sub1
+:000000 160000 00000... A	sub2
+EOF
+test_expect_success 'create subprojects' \
+    'mkdir sub1 &&
+    ( cd sub1 && git init && : >Makefile && git add * &&
+    git commit -q -m "subproject 1" ) &&
+    mkdir sub2 &&
+    ( cd sub2 && git init && : >Makefile && git add * &&
+    git commit -q -m "subproject 2" ) &&
+    git update-index --add sub1 &&
+    git add sub2 &&
+    git commit -q -m "subprojects added" &&
+    git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+    git diff expected current'
+
+git branch save HEAD
+
+test_expect_success 'check if fsck ignores the subprojects' \
+    'git fsck --full'
+
+test_expect_success 'check if commit in a subproject detected' \
+    '( cd sub1 &&
+    echo "all:" >>Makefile &&
+    echo "	true" >>Makefile &&
+    git commit -q -a -m "make all" ) && {
+        git diff-files --exit-code
+	test $? = 1
+    }'
+
+test_expect_success 'check if a changed subproject HEAD can be committed' \
+    'git commit -q -a -m "sub1 changed" && {
+	git diff-tree --exit-code HEAD^ HEAD
+	test $? = 1
+    }'
+
+test_expect_success 'check if diff-index works for subproject elements' \
+    'git diff-index --exit-code --cached save -- sub1
+    test $? = 1'
+
+test_expect_success 'check if diff-tree works for subproject elements' \
+    'git diff-tree --exit-code HEAD^ HEAD -- sub1
+    test $? = 1'
+
+test_expect_success 'check if git diff works for subproject elements' \
+    'git diff --exit-code HEAD^ HEAD
+    test $? = 1'
+
+test_expect_success 'check if clone works' \
+    'git ls-files -s >expected &&
+    git clone -l -s . cloned &&
+    ( cd cloned && git ls-files -s ) >current &&
+    git diff expected current'
+
+test_expect_success 'removing and adding subproject' \
+    'git update-index --force-remove -- sub2 &&
+    mv sub2 sub3 &&
+    git add sub3 &&
+    git commit -q -m "renaming a subproject" && {
+	git diff -M --name-status --exit-code HEAD^ HEAD
+	test $? = 1
+    }'
+
+# the index must contain the object name the HEAD of the
+# subproject sub1 was at the point "save"
+test_expect_success 'checkout in superproject' \
+    'git checkout save &&
+    git diff-index --exit-code --raw --cached save -- sub1'
+
+# just interesting what happened...
+# git diff --name-status -M save master
+
+test_done
-- 
1.5.1.1.819.gcfdd2
