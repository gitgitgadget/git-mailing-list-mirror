From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Use Cogito when possible in the "tutorial" test.
Date: Fri, 03 Mar 2006 20:23:34 -0500
Message-ID: <20060304012333.10494.35600.stgit@dv.roinet.com>
X-From: git-owner@vger.kernel.org Sat Mar 04 02:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFLUs-0007W9-OQ
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 02:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWCDBXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 20:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWCDBXp
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 20:23:45 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:4490 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932147AbWCDBXp
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 20:23:45 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FFLUj-0002rJ-B1
	for git@vger.kernel.org; Fri, 03 Mar 2006 20:23:41 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FFLUc-0002jR-8i; Fri, 03 Mar 2006 20:23:34 -0500
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17164>

In particular, use Cogito branch support.  Document why git has to be
used in some places.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/tutorial-script/script.sh |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index edcebda..4d6b732 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -1,8 +1,9 @@
 #!/bin/bash
 #
-# FIXME: This script has many GITisms. Some of them are unnecessary, while
-# some stem from missing Cogito features (especially no support for pushing
-# tags, and consequently no support for remotes/).
+# FIXME: This script has some GITisms. They stem from missing Cogito
+# features, such as exporting patches to mbox format, applying patches
+# from e-mail, merging multiple tags at once, verifying signed tags and
+# repacking the repository.
 
 
 # This function is appended as "&& should_fail" to commands which should
@@ -34,7 +35,7 @@ cd $ALICE
 tar xf $TOP/0001-alice.tar
 cd rpn
 
-# Being a tidy girl, she places it under git
+# Being a tidy girl, she places it under Cogito
 echo "Alice's first version" | cg-init
 cg-tag -d "First ever version of RPN" rpn-0.1
  
@@ -108,8 +109,8 @@ cg-export ../rpn-0.3.tar.bz2
 ### Bob tells Alice of his changes, Alice prepares to get them.
 cd $ALICE/rpn
 
-git checkout -b bob
-git branch
+cg-switch -r master bob
+cg-status -g
 
 # Alice needs to register his remote branch
 cg-branch-add bobswork $BOB/rpn
@@ -163,14 +164,16 @@ cg-commit -m "Add proper header file for
           -m "Update dependencies in Makefile"
 
 # Charlie emails the patch to Alice:
+# cg-mkpatch -d .. -r rpn-0.3..master
 git format-patch -o .. --mbox --signoff -r rpn-0.3
-      # Result is in $TOP/0014-charlie-email
+# Only git can create mbox formatted output
+# Compare the result to 0014-charlie-email
 
 
 ### Alice is busy meanwhile...
 cd $ALICE/rpn
 
-git checkout master
+cg-switch master
 
 patch -p1 -i $TOP/0015-alice-mod.patch
 
@@ -189,21 +192,23 @@ cg-push public
 ### Alice gets Charlie's fix, creates a new branch for his changes
 cd $ALICE/rpn
 
-git checkout master
-git checkout -b charlie rpn-0.3
-git branch
+cg-switch -r rpn-0.3 charlie
+cg-status -g
 
+# Check what's inside the patch.  There is no Cogito equivalent yet.
 git apply --stat $TOP/0014-charlie-email
 git apply --summary $TOP/0014-charlie-email
 git apply --check $TOP/0014-charlie-email
 
 # Everything looks OK
 git applymbox $TOP/0014-charlie-email
+# This doesn't work well yet
+# cg-patch < $TOP/0014-charlie-email
 
 ### Alice integrates the changes in the branches for the next release
 cd $ALICE/rpn
 
-git checkout master
+cg-switch master
 # Alice tries "git merge" instead of "cg-merge" since she wanted to
 # merge both branches at once, which "cg-merge" cannot do.
 git merge "Integrate changes from Bob and Charlie" master bob charlie \
