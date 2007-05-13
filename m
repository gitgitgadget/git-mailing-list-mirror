From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH/RFC] cvsserver: Add test cases for config file handling
Date: Sun, 13 May 2007 02:17:50 +0200
Message-ID: <11790154701376-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 02:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1me-0001n6-B8
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbXEMARw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 20:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbXEMARw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:17:52 -0400
Received: from mail.lenk.info ([217.160.134.107]:3417 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569AbXEMARv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:17:51 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hn1lK-0002w2-Tz; Sun, 13 May 2007 02:16:35 +0200
Received: from p3ee3e222.dip.t-dialin.net ([62.227.226.34] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hn1mW-0005MH-F7; Sun, 13 May 2007 02:17:48 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hn1mY-0003W7-GI; Sun, 13 May 2007 02:17:50 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47115>

Add a few test cases for the config file parsing
done by git-cvsserver.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9420-git-cvsserver-config.sh |  108 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100755 t/t9420-git-cvsserver-config.sh

 The RFC part is test 4 (gitcvs.ext.enabled = false).
 With the current code it fails, with my GITCVS::config
 patch it succeeds. I think the documentation currently
 states ('method specific options "override" general options')
 it should succeed and I guess that would be the more
 intuitive behaviour. Anyone disagree?

diff --git a/t/t9420-git-cvsserver-config.sh b/t/t9420-git-cvsserver-config.sh
new file mode 100755
index 0000000..53550e8
--- /dev/null
+++ b/t/t9420-git-cvsserver-config.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Frank Lichtenheld
+#
+
+test_description='git-cvsserver configuration handling
+
+tests the parsing and handling of the git configuration
+by git-cvsserver'
+
+. ./test-lib.sh
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    test_done
+    exit
+fi
+perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    test_done
+    exit
+}
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
+CVSROOT=":fork:$SERVERDIR"
+CVSWORK=$(pwd)/cvswork
+CVS_SERVER=git-cvsserver
+export CVSROOT CVS_SERVER
+
+rm -rf "$CVSWORK" "$SERVERDIR"
+echo >empty &&
+  git add empty &&
+  git commit -q -m "First Commit" &&
+  git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+  GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+  GIT_DIR="$SERVERDIR" git config --bool gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+  exit 1
+
+# note that cvs doesn't accept absolute pathnames
+# as argument to co -d
+test_expect_success 'basic checkout' \
+  'cvs -Q co -d cvswork master &&
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
+
+test_expect_success 'gitcvs.enabled = false' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
+   if cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   test ! -d cvswork2'
+
+rm -fr cvswork2
+
+test_expect_success 'gitcvs.ext.enabled = true' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
+   cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -q cvswork cvswork2'
+
+rm -fr cvswork2
+
+test_expect_success 'gitcvs.ext.enabled = false' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
+   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+   if cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   test ! -d cvswork2'
+
+rm -fr cvswork2
+
+test_expect_success 'gitcvs.dbname' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
+   cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -q cvswork cvswork2 &&
+   test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
+   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
+
+rm -fr cvswork2
+
+# currently fails due to a git-config bug
+#test_expect_success 'gitcvs.ext.dbname' \
+#  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+#   GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
+#   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
+#   cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+#   diff -q cvswork cvswork2 &&
+#   test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
+#   test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
+#   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
+
+
+test_done
-- 
1.5.1.4
