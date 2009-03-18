From: Heiko Voigt <git-list@hvoigt.net>
Subject: [PATCH v3 1/2] cvsimport: add test illustrating a bug in cvsps
Date: Wed, 18 Mar 2009 18:33:34 +0100
Message-ID: <49C1306E.6060201@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljzg7-00079I-2F
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZCRRdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZCRRdj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:33:39 -0400
Received: from darksea.de ([83.133.111.250]:55575 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753631AbZCRRdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:33:38 -0400
Received: (qmail 20247 invoked from network); 18 Mar 2009 18:33:24 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 18 Mar 2009 18:33:24 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49B52F74.1090006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113633>

Some cvs repositories may have time deviations in their recorded commits.
This is a test for one of such cases. These kind of repositories can happen
if the system time of cvs clients is not fully synchronised.

Consider the following sequence of events:

 * client A commits file a r1.1
 * client A commits file a r1.2, b r1.1
 * client B commits file b r1.2 using the same timestamp as a r1.1

This can be resolved but due to cvsps ordering its patchsets solely based
on the timestamp. It only takes revision odering into account if there
is no difference in the timestamp.

I hit this bug when importing from a real repository which was originally
converted from another rcs based scm. Other import tools can handle this
correctly, e.g. parsecvs.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

 t/t9603-cvsimport-patchsets.sh     |   33 +++++++++++++++++++++++++++++
 t/t9603/cvsroot/CVSROOT/.gitignore |    2 +
 t/t9603/cvsroot/module/a,v         |   40 ++++++++++++++++++++++++++++++++++++
 t/t9603/cvsroot/module/b,v         |   40 ++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100755 t/t9603-cvsimport-patchsets.sh
 create mode 100644 t/t9603/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9603/cvsroot/module/a,v
 create mode 100644 t/t9603/cvsroot/module/b,v

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
new file mode 100755
index 0000000..15a971f
--- /dev/null
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+# Structure of the test cvs repository
+#
+# Message   File:Content         Commit Time
+# Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
+# Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
+# Rev 3               b: 1.2     2009-02-21 19:11:43 +0100
+#
+# As you can see the commit of Rev 3 has the same time as
+# Rev 1 this leads to a broken import because of a cvsps
+# bug.
+
+test_description='git cvsimport testing for correct patchset estimation'
+. ./lib-cvs.sh
+
+CVSROOT="$TEST_DIRECTORY"/t9603/cvsroot
+export CVSROOT
+
+test_expect_failure 'import with criss cross times on revisions' '
+
+    git cvsimport -p"-x" -C module-git module &&
+    cd module-git &&
+        git log --pretty=format:%s > ../actual &&
+        echo "" >> ../actual &&
+    cd .. &&
+    echo "Rev 3
+Rev 2
+Rev 1" > expect &&
+    test_cmp actual expect
+'
+
+test_done
diff --git a/t/t9603/cvsroot/CVSROOT/.gitignore b/t/t9603/cvsroot/CVSROOT/.gitignore
new file mode 100644
index 0000000..3bb9b34
--- /dev/null
+++ b/t/t9603/cvsroot/CVSROOT/.gitignore
@@ -0,0 +1,2 @@
+history
+val-tags
diff --git a/t/t9603/cvsroot/module/a,v b/t/t9603/cvsroot/module/a,v
new file mode 100644
index 0000000..e86adfc
--- /dev/null
+++ b/t/t9603/cvsroot/module/a,v
@@ -0,0 +1,40 @@
+head	1.2;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2009.02.21.18.11.14;	author tester;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2009.02.21.18.11.43;	author tester;	state Exp;
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
+@Rev 2
+@
+text
+@1.2
+@
+
+
+1.1
+log
+@Rev 1
+@
+text
+@d1 1
+a1 1
+1.1
+@
diff --git a/t/t9603/cvsroot/module/b,v b/t/t9603/cvsroot/module/b,v
new file mode 100644
index 0000000..ab3089f
--- /dev/null
+++ b/t/t9603/cvsroot/module/b,v
@@ -0,0 +1,40 @@
+head	1.2;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2009.02.21.18.11.43;	author tester;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2009.02.21.18.11.14;	author tester;	state Exp;
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
+@Rev 3
+@
+text
+@1.2
+@
+
+
+1.1
+log
+@Rev 2
+@
+text
+@d1 1
+a1 1
+1.1
+@
-- 
1.6.1.2.390.gba743
