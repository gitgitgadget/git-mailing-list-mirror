From: Heiko Voigt <git-list@hvoigt.net>
Subject: [PATCH v3 2/2] cvsimport: extend testcase about patchset order to
 contain branches
Date: Wed, 18 Mar 2009 18:33:41 +0100
Message-ID: <49C13075.7060307@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljzg8-00079I-FD
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbZCRRdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbZCRRdq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:33:46 -0400
Received: from darksea.de ([83.133.111.250]:55580 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755249AbZCRRdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:33:44 -0400
Received: (qmail 20257 invoked from network); 18 Mar 2009 18:33:31 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 18 Mar 2009 18:33:31 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49B52F74.1090006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113635>

This makes sure that timestamps and ordering on branches is not influenced
by a fix for cvsps.

The test extension does not deal which patchset correction on branches it
only verifes that branches are basically handled as before.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t9603-cvsimport-patchsets.sh |   19 +++++++++----
 t/t9603/cvsroot/.gitattributes |    1 +
 t/t9603/cvsroot/module/a,v     |   38 ++++++++++++++++++++++++-
 t/t9603/cvsroot/module/b,v     |   58 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 104 insertions(+), 12 deletions(-)
 create mode 100644 t/t9603/cvsroot/.gitattributes

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 15a971f..2511b69 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -17,17 +17,24 @@ test_description='git cvsimport testing for correct patchset estimation'
 CVSROOT="$TEST_DIRECTORY"/t9603/cvsroot
 export CVSROOT
 
-test_expect_failure 'import with criss cross times on revisions' '
+test_expect_success 'import with criss cross times on revisions' '
 
     git cvsimport -p"-x" -C module-git module &&
     cd module-git &&
-        git log --pretty=format:%s > ../actual &&
-        echo "" >> ../actual &&
+        git log --pretty=format:%s > ../actual-master &&
+        git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
+        echo "" >> ../actual-master &&
+        echo "" >> ../actual-A &&
     cd .. &&
-    echo "Rev 3
+    echo "Rev 4
+Rev 3
 Rev 2
-Rev 1" > expect &&
-    test_cmp actual expect
+Rev 1" > expect-master &&
+    test_cmp actual-master expect-master &&
+
+    echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
+Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
+    test_cmp actual-A expect-A
 '
 
 test_done
diff --git a/t/t9603/cvsroot/.gitattributes b/t/t9603/cvsroot/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9603/cvsroot/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t9603/cvsroot/module/a,v b/t/t9603/cvsroot/module/a,v
index e86adfc..ba8fd5a 100644
--- a/t/t9603/cvsroot/module/a,v
+++ b/t/t9603/cvsroot/module/a,v
@@ -1,13 +1,15 @@
 head	1.2;
 access;
-symbols;
+symbols
+	A:1.2.0.2;
 locks; strict;
 comment	@# @;
 
 
 1.2
 date	2009.02.21.18.11.14;	author tester;	state Exp;
-branches;
+branches
+	1.2.2.1;
 next	1.1;
 
 1.1
@@ -15,6 +17,16 @@ date	2009.02.21.18.11.43;	author tester;	state Exp;
 branches;
 next	;
 
+1.2.2.1
+date	2009.03.11.19.03.52;	author tester;	state Exp;
+branches;
+next	1.2.2.2;
+
+1.2.2.2
+date	2009.03.11.19.09.10;	author tester;	state Exp;
+branches;
+next	;
+
 
 desc
 @@
@@ -29,6 +41,28 @@ text
 @
 
 
+1.2.2.1
+log
+@Rev 4 Branch A
+@
+text
+@d1 1
+a1 1
+1.2.2.1
+@
+
+
+1.2.2.2
+log
+@Rev 5 Branch A
+@
+text
+@d1 1
+a1 1
+1.2.2.2
+@
+
+
 1.1
 log
 @Rev 1
diff --git a/t/t9603/cvsroot/module/b,v b/t/t9603/cvsroot/module/b,v
index ab3089f..d268855 100644
--- a/t/t9603/cvsroot/module/b,v
+++ b/t/t9603/cvsroot/module/b,v
@@ -1,13 +1,20 @@
-head	1.2;
+head	1.3;
 access;
-symbols;
+symbols
+	A:1.2.0.2;
 locks; strict;
 comment	@# @;
 
 
+1.3
+date	2009.03.11.19.05.08;	author tester;	state Exp;
+branches;
+next	1.2;
+
 1.2
 date	2009.02.21.18.11.43;	author tester;	state Exp;
-branches;
+branches
+	1.2.2.1;
 next	1.1;
 
 1.1
@@ -15,17 +22,60 @@ date	2009.02.21.18.11.14;	author tester;	state Exp;
 branches;
 next	;
 
+1.2.2.1
+date	2009.03.11.19.03.52;	author tester;	state Exp;
+branches;
+next	1.2.2.2;
+
+1.2.2.2
+date	2009.03.11.19.09.10;	author tester;	state Exp;
+branches;
+next	;
+
 
 desc
 @@
 
 
+1.3
+log
+@Rev 4
+@
+text
+@1.3
+@
+
+
 1.2
 log
 @Rev 3
 @
 text
-@1.2
+@d1 1
+a1 1
+1.2
+@
+
+
+1.2.2.1
+log
+@Rev 4 Branch A
+@
+text
+@d1 1
+a1 1
+1.2.2.1
+@
+
+
+1.2.2.2
+log
+@Rev 5 Branch A
+@
+text
+@d1 1
+a1 1
+1.2
 @
 
 
-- 
1.6.1.2.390.gba743
