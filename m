From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/5] Add some tests of git-cvsimport's handling of vendor branches
Date: Mon, 23 Feb 2009 06:08:13 +0100
Message-ID: <0ceb6eefc5d16857dfe4c3433a0e4339381a929f.1235364493.git.mhagger@alum.mit.edu>
References: <1235365694-28935-1-git-send-email-mhagger@alum.mit.edu>
 <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
 <7d834a5a7542df6bfa8963bb6440cc4b4531ead7.1235364493.git.mhagger@alum.mit.edu>
 <24f32b195f4dbfa0e1dda8b30097becdb3c2d3b7.1235364493.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 06:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbT5A-00014D-H8
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 06:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZBWFIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 00:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbZBWFIo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 00:08:44 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37141 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZBWFIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 00:08:38 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1N58Eg1019166;
	Mon, 23 Feb 2009 06:08:16 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <24f32b195f4dbfa0e1dda8b30097becdb3c2d3b7.1235364493.git.mhagger@alum.mit.edu>
In-Reply-To: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
References: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111085>

CVS's handling of vendor branches is tricky; add some tests to check
whether revisions added via "cvs imports" then imported to git via
"git cvsimport" are reflected correctly on master.

One of these tests fail and is therefore marked "test_expect_failure".
Cvsimport doesn't realize that subsequent changes on a vendor branch
affect master as long as the vendor branch is the default branch.

The test CVS repository used for these tests is derived from cvs2svn's
test suite.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9601-cvsimport-vendor-branch.sh                 |   86 ++++++++++++++++++++
 t/t9601/cvsroot/.gitattributes                     |    1 +
 t/t9601/cvsroot/CVSROOT/.gitignore                 |    2 +
 t/t9601/cvsroot/module/added-imported.txt,v        |   44 ++++++++++
 t/t9601/cvsroot/module/imported-anonymously.txt,v  |   42 ++++++++++
 .../module/imported-modified-imported.txt,v        |   76 +++++++++++++++++
 t/t9601/cvsroot/module/imported-modified.txt,v     |   59 +++++++++++++
 t/t9601/cvsroot/module/imported-once.txt,v         |   43 ++++++++++
 t/t9601/cvsroot/module/imported-twice.txt,v        |   60 ++++++++++++++
 9 files changed, 413 insertions(+), 0 deletions(-)
 create mode 100755 t/t9601-cvsimport-vendor-branch.sh
 create mode 100644 t/t9601/cvsroot/.gitattributes
 create mode 100644 t/t9601/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9601/cvsroot/module/added-imported.txt,v
 create mode 100644 t/t9601/cvsroot/module/imported-anonymously.txt,v
 create mode 100644 t/t9601/cvsroot/module/imported-modified-imported.txt,v
 create mode 100644 t/t9601/cvsroot/module/imported-modified.txt,v
 create mode 100644 t/t9601/cvsroot/module/imported-once.txt,v
 create mode 100644 t/t9601/cvsroot/module/imported-twice.txt,v

diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
new file mode 100755
index 0000000..3afaf56
--- /dev/null
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+# Description of the files in the repository:
+#
+#    imported-once.txt:
+#
+#       Imported once.  1.1 and 1.1.1.1 should be identical.
+#
+#    imported-twice.txt:
+#
+#       Imported twice.  HEAD should reflect the contents of the
+#       second import (i.e., have the same contents as 1.1.1.2).
+#
+#    imported-modified.txt:
+#
+#       Imported, then modified on HEAD.  HEAD should reflect the
+#       modification.
+#
+#    imported-modified-imported.txt:
+#
+#       Imported, then modified on HEAD, then imported again.
+#
+#    added-imported.txt,v:
+#
+#       Added with 'cvs add' to create 1.1, then imported with
+#       completely different contents to create 1.1.1.1, therefore the
+#       vendor branch was never the default branch.
+#
+#    imported-anonymously.txt:
+#
+#       Like imported-twice.txt, but with a vendor branch whose branch
+#       tag has been removed.
+
+test_description='git cvsimport handling of vendor branches'
+. ./lib-cvs.sh
+
+CVSROOT="$TEST_DIRECTORY"/t9601/cvsroot
+export CVSROOT
+
+test_expect_success 'import a module with a vendor branch' '
+
+	git cvsimport -C module-git module
+
+'
+
+test_expect_success 'check HEAD out of cvs repository' 'test_cvs_co master'
+
+test_expect_success 'check master out of git repository' 'test_git_co master'
+
+test_expect_success 'check a file that was imported once' '
+
+	test_cmp_branch_file master imported-once.txt
+
+'
+
+test_expect_failure 'check a file that was imported twice' '
+
+	test_cmp_branch_file master imported-twice.txt
+
+'
+
+test_expect_success 'check a file that was imported then modified on HEAD' '
+
+	test_cmp_branch_file master imported-modified.txt
+
+'
+
+test_expect_success 'check a file that was imported, modified, then imported again' '
+
+	test_cmp_branch_file master imported-modified-imported.txt
+
+'
+
+test_expect_success 'check a file that was added to HEAD then imported' '
+
+	test_cmp_branch_file master added-imported.txt
+
+'
+
+test_expect_success 'a vendor branch whose tag has been removed' '
+
+	test_cmp_branch_file master imported-anonymously.txt
+
+'
+
+test_done
diff --git a/t/t9601/cvsroot/.gitattributes b/t/t9601/cvsroot/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9601/cvsroot/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t9601/cvsroot/CVSROOT/.gitignore b/t/t9601/cvsroot/CVSROOT/.gitignore
new file mode 100644
index 0000000..3bb9b34
--- /dev/null
+++ b/t/t9601/cvsroot/CVSROOT/.gitignore
@@ -0,0 +1,2 @@
+history
+val-tags
diff --git a/t/t9601/cvsroot/module/added-imported.txt,v b/t/t9601/cvsroot/module/added-imported.txt,v
new file mode 100644
index 0000000..5f83072
--- /dev/null
+++ b/t/t9601/cvsroot/module/added-imported.txt,v
@@ -0,0 +1,44 @@
+head	1.1;
+access;
+symbols
+	vtag-4:1.1.1.1
+	vbranchA:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2004.02.09.15.43.15;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.16;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@Add a file to the working copy.
+@
+text
+@Adding this file, before importing it with different contents.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-4).
+@
+text
+@d1 1
+a1 1
+This is vtag-4 (on vbranchA) of added-then-imported.txt.
+@
+
diff --git a/t/t9601/cvsroot/module/imported-anonymously.txt,v b/t/t9601/cvsroot/module/imported-anonymously.txt,v
new file mode 100644
index 0000000..55e1b0c
--- /dev/null
+++ b/t/t9601/cvsroot/module/imported-anonymously.txt,v
@@ -0,0 +1,42 @@
+head	1.1;
+branch	1.1.1;
+access;
+symbols
+	vtag-1:1.1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@This is vtag-1 (on vbranchA) of imported-anonymously.txt.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-1).
+@
+text
+@@
+
+
diff --git a/t/t9601/cvsroot/module/imported-modified-imported.txt,v b/t/t9601/cvsroot/module/imported-modified-imported.txt,v
new file mode 100644
index 0000000..e5830ae
--- /dev/null
+++ b/t/t9601/cvsroot/module/imported-modified-imported.txt,v
@@ -0,0 +1,76 @@
+head	1.2;
+access;
+symbols
+	vtag-2:1.1.1.2
+	vtag-1:1.1.1.1
+	vbranchA:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2004.02.09.15.43.14;	author kfogel;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	1.1.1.2;
+
+1.1.1.2
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@First regular commit, to imported-modified-imported.txt, on HEAD.
+@
+text
+@This is a modification of imported-modified-imported.txt on HEAD.
+It should supersede the version from the vendor branch.
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d1 2
+a2 1
+This is vtag-1 (on vbranchA) of imported-modified-imported.txt.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-1).
+@
+text
+@@
+
+
+1.1.1.2
+log
+@Import (vbranchA, vtag-2).
+@
+text
+@d1 1
+a1 1
+This is vtag-2 (on vbranchA) of imported-modified-imported.txt.
+@
+
+
diff --git a/t/t9601/cvsroot/module/imported-modified.txt,v b/t/t9601/cvsroot/module/imported-modified.txt,v
new file mode 100644
index 0000000..bbcfe44
--- /dev/null
+++ b/t/t9601/cvsroot/module/imported-modified.txt,v
@@ -0,0 +1,59 @@
+head	1.2;
+access;
+symbols
+	vtag-1:1.1.1.1
+	vbranchA:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2004.02.09.15.43.14;	author kfogel;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Commit on HEAD.
+@
+text
+@This is a modification of imported-modified.txt on HEAD.
+It should supersede the version from the vendor branch.
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d1 2
+a2 1
+This is vtag-1 (on vbranchA) of imported-modified.txt.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-1).
+@
+text
+@@
+
+
diff --git a/t/t9601/cvsroot/module/imported-once.txt,v b/t/t9601/cvsroot/module/imported-once.txt,v
new file mode 100644
index 0000000..c5dd82b
--- /dev/null
+++ b/t/t9601/cvsroot/module/imported-once.txt,v
@@ -0,0 +1,43 @@
+head	1.1;
+branch	1.1.1;
+access;
+symbols
+	vtag-1:1.1.1.1
+	vbranchA:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@This is vtag-1 (on vbranchA) of imported-once.txt.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-1).
+@
+text
+@@
+
+
diff --git a/t/t9601/cvsroot/module/imported-twice.txt,v b/t/t9601/cvsroot/module/imported-twice.txt,v
new file mode 100644
index 0000000..d1f3f1b
--- /dev/null
+++ b/t/t9601/cvsroot/module/imported-twice.txt,v
@@ -0,0 +1,60 @@
+head	1.1;
+branch	1.1.1;
+access;
+symbols
+	vtag-2:1.1.1.2
+	vtag-1:1.1.1.1
+	vbranchA:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	1.1.1.2;
+
+1.1.1.2
+date	2004.02.09.15.43.13;	author kfogel;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@This is vtag-1 (on vbranchA) of imported-twice.txt.
+@
+
+
+1.1.1.1
+log
+@Import (vbranchA, vtag-1).
+@
+text
+@@
+
+
+1.1.1.2
+log
+@Import (vbranchA, vtag-2).
+@
+text
+@d1 1
+a1 1
+This is vtag-2 (on vbranchA) of imported-twice.txt.
+@
+
+
-- 
1.6.1.3
