From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH/RFC] git-cvsserver: Add a basic test file for cvsserver
Date: Sun, 29 Apr 2007 22:10:27 +0200
Message-ID: <11778774271937-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 22:11:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiFji-0004qn-9R
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031335AbXD2UKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031347AbXD2UKf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 16:10:35 -0400
Received: from mail.lenk.info ([217.160.134.107]:1806 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031335AbXD2UKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 16:10:33 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HiFiK-0005wn-H5; Sun, 29 Apr 2007 22:09:44 +0200
Received: from p54b0dd98.dip.t-dialin.net ([84.176.221.152] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HiFj3-0002Sf-5h; Sun, 29 Apr 2007 22:10:29 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HiFj1-0001jM-Ju; Sun, 29 Apr 2007 22:10:27 +0200
X-Mailer: git-send-email 1.5.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45834>

Contains only one test (checkout) at this point and is
mostly indented to be used as a RFC to discuss
how to properly implement tests for git-cvsserver.

Currently the test uses netcat to run git-cvsserver
pserver on a unprivilegded port.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-read.sh |   56 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 t/t9400-git-cvsserver-read.sh

 Since this is my first test script for git I would welcome comments
 and suggestions. Especially if someone has a simpler method of
 testing it than the somewhat fragile netcat hack I used.

diff --git a/t/t9400-git-cvsserver-read.sh b/t/t9400-git-cvsserver-read.sh
new file mode 100644
index 0000000..311d6c5
--- /dev/null
+++ b/t/t9400-git-cvsserver-read.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# 
+# Copyright (c) 2007 Frank Lichtenheld
+#
+
+test_description='git-cvsserver read access
+
+tests read access to a git repository with the
+cvs CLI client via git-cvsserver pserver'
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
+netcat -h >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsserver tests, netcat not found' :
+    test_done
+    exit
+fi
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
+CVSROOT=":pserver:anonymous@localhost:12345$SERVERDIR"
+CVSWORK=$(pwd)/cvswork
+export CVSROOT CVSWORK
+
+rm -rf "$CVSWORK" "$SERVERDIR"
+echo >empty &&
+  git add empty &&
+  git commit -q -m "First Commit" &&
+  git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+  GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true ||
+  exit 1
+
+start_pserver () {
+   netcat -l -p 12345 -c "git-cvsserver pserver" localhost &
+   echo $! >nc.pid
+}
+start_pserver
+
+# note that cvs doesn't accept absolute pathnames
+# as argument to co -d
+test_expect_success 'basic checkout' \
+  "cvs -Q co -d cvswork master"
+
+kill $(cat nc.pid) 2>/dev/null
+
+test_done
-- 
1.5.1.2
