From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Clean up after failed "git merge" in the tutorial script
Date: Tue, 21 Mar 2006 23:07:33 -0500
Message-ID: <20060322040733.29189.75397.stgit@dv.roinet.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 05:07:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLudM-0004ZC-6S
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 05:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWCVEHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 23:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWCVEHk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 23:07:40 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:62437 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750737AbWCVEHj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 23:07:39 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FLudS-000780-SW
	for git@vger.kernel.org; Tue, 21 Mar 2006 23:07:51 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FLudB-0007bE-Vn; Tue, 21 Mar 2006 23:07:33 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17801>

From: Pavel Roskin <proski@gnu.org>

Failed "git merge" in the tutorial script leaves some damage to the
working directory.  Use cg-reset to clean up the mess.

This eliminates conflicts in the final merge.  Adjust code accordingly,
remove unused fixup scripts.

Adjust 0017-alice-bob-fixup.ed to deal with merge conflict from cg-merge
rather than "git merge".

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .../tutorial-script/0017-alice-bob-fixup.ed        |    4 ++--
 .../tutorial-script/0021-bob-alice-fixup1.ed       |    4 ----
 .../tutorial-script/0022-bob-alice-fixup2.ed       |    5 -----
 .../tutorial-script/0023-bob-alice-fixup3.ed       |    4 ----
 Documentation/tutorial-script/script.sh            |   18 ++++--------------
 5 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/Documentation/tutorial-script/0017-alice-bob-fixup.ed b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
index ad04eb7..1b06f4e 100644
--- a/Documentation/tutorial-script/0017-alice-bob-fixup.ed
+++ b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
@@ -1,5 +1,5 @@
-/^<<<<<<< Makefile/d
+/^<<<<<<< master/d
 /^=======/,/^=======/+1d
-/^>>>>>>> \.merge_file_/d
+/^>>>>>>> bob/d
 w
 q
diff --git a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed b/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
deleted file mode 100644
index df703d5..0000000
--- a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
+++ /dev/null
@@ -1,4 +0,0 @@
-/^<<<<<<< master/,/^=======/d
-/^>>>>>>> origin/d
-w
-q
diff --git a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed b/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
deleted file mode 100644
index d8c5746..0000000
--- a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
+++ /dev/null
@@ -1,5 +0,0 @@
-/^#include "stack\.h"/+1d
-/^#include "lexer\.h"/+1,/^#include "stack\.h"/d
-/^<<<<<<< master/-1,/^>>>>>>> origin/d
-w
-q
diff --git a/Documentation/tutorial-script/0023-bob-alice-fixup3.ed b/Documentation/tutorial-script/0023-bob-alice-fixup3.ed
deleted file mode 100644
index fea2fc7..0000000
--- a/Documentation/tutorial-script/0023-bob-alice-fixup3.ed
+++ /dev/null
@@ -1,4 +0,0 @@
-/^#endif/s;^#endif.*;#endif /* STACK_H */;
-w
-q
-
diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index 0401954..f07dfc1 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -222,12 +222,13 @@ git merge "Integrate changes from Bob an
 
 # Automatic 3-way merge fails! Have to do it step by step
 
+cg-reset
 cg-merge bob && should_fail
 
 # Merge fails:
 
 #: ...
-#: <<<<<<< Makefile
+#: <<<<<<< master
 #:	$(CC) $(CFLAGS) $^ -lm -o $@
 #: =======
 #:	$(CC) $(CFLAGS) $^ -o $@
@@ -235,7 +236,7 @@ cg-merge bob && should_fail
 #: rpn.o: stack.h
 #: stack.o: stack.h
 #: lexer.o:	
-#: >>>>>>> .merge_file_iNhznP
+#: >>>>>>> bob
 
 ed Makefile < $TOP/0017-alice-bob-fixup.ed
 
@@ -313,18 +314,7 @@ cg-fetch
 git verify-tag rpn-0.4 && should_fail
 
 # Everything's OK, integrate the changes
-echo "Merge with 0.4" | cg-merge && should_fail
-
-# Merge conflicts in Makefile, rpn.c
-ed Makefile < $TOP/0021-bob-alice-fixup1.ed
-ed rpn.c    < $TOP/0022-bob-alice-fixup2.ed
-# Resolve conflicting addition of two versions of stack.h
-rm stack.h~master
-mv stack.h~origin stack.h
-cg-add stack.h
-
-# Now commit the whole
-cg-commit -m "Merge with 0.4"
+cg-merge
 
 # Great, we are done.
 trap - exit
