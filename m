From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cogito: make tutorial-script a testsuite
Date: Wed, 02 Nov 2005 20:16:22 -0500
Message-ID: <1130980582.20017.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Nov 03 02:16:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXTiP-0007Dr-Jk
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 02:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVKCBQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 20:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVKCBQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 20:16:26 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55466 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030241AbVKCBQ0
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 20:16:26 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EXTiK-0005Mv-MW
	for git@vger.kernel.org; Wed, 02 Nov 2005 20:16:24 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EXTiI-0007Sz-LE; Wed, 02 Nov 2005 20:16:22 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11061>

Documentation/tutorial-script/script.sh can be used as a testsuite.
Errors should cause the script to exit.  Unexpected success should be
treated like an error.  Successful completion should be reported.

Signed-off-by: Pavel Roskin <proski@gnu.org>

---

Currently, the last cg-merge invocation doesn't fail as it should, and
the subsequent ed scripts fail for Makefile and rpn.c.  I don't have a
fix for that.  Most likely, the script in cogito differs from the
original version.  Horst, could you please have a look?

diff --git a/Documentation/tutorial-script/script.sh
b/Documentation/tutorial-script/script.sh
index 26adec0..fe43e65 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -1,10 +1,16 @@
-#!/bin/sh
+#!/bin/sh -e
 #
 # FIXME: This script has many GITisms. Some of them are unnecessary, while
 # some stem from missing Cogito features (especially no support for pushing
 # tags, and consequently no support for remotes/).
 
 
+should_fail () {
+	echo "Expected failure, got success - aborting" >&2
+	exit 1
+}
+
+
 ### Set up playground
 sh 0000-playground.sh
 TOP=$(pwd)
@@ -98,7 +104,7 @@ git branch
 # Alice needs to register his remote branch
 cg-branch-add bobswork $BOB/rpn
 # Now try to merge Bob's work to the bob branch
-cg-update bobswork
+cg-update bobswork && should_fail
 
 # There are conflicts in rpn.c. Looking at the file, Alice sees the
 # difference between her version and Bob's:
@@ -190,11 +196,12 @@ cd $ALICE/rpn
 git checkout master
 # Alice tries "git merge" instead of "cg-merge" since she wanted to
 # merge both branches at once, which "cg-merge" cannot do.
-git merge "Integrate changes from Bob and Charlie" master bob charlie
+git merge "Integrate changes from Bob and Charlie" master bob charlie \
+	&& should_fail
 
 # Automatic 3-way merge fails! Have to do it step by step
 
-cg-merge bob
+cg-merge bob && should_fail
 
 # Merge fails:
 
@@ -213,7 +220,7 @@ ed Makefile < $TOP/0017-alice-bob-fixup.
 
 cg-commit -m "Integrate Bob's changes"
 
-cg-merge charlie
+cg-merge charlie && should_fail
 
 # Merge conflicts!
 
@@ -282,10 +289,10 @@ cg-fetch
 # (Note that originally, rpn-0.4 was signed, but that would require you
 # to set up a GPG key before running the script... verify-tag on unsigned
 # scripts does not make much sense.)
-git verify-tag rpn-0.4
+git verify-tag rpn-0.4 && should_fail
 
 # Everything's OK, integrate the changes
-echo "Merge with 0.4" | cg-merge
+echo "Merge with 0.4" | cg-merge && should_fail
 
 # Merge conflicts in Makefile, rpn.c
 # Mishandled stack.h
@@ -296,3 +303,6 @@ cg-add stack.h
 
 # Now commit the whole
 cg-commit -m "Merge with 0.4"
+
+# Great, we are done.
+echo "Script completed successfully!"


-- 
Regards,
Pavel Roskin
