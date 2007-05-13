From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Add some basic pserver tests
Date: Sun, 13 May 2007 19:49:26 +0200
Message-ID: <11790785662928-git-send-email-frank@lichtenheld.de>
References: <1179078566806-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 19:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnICM-00017B-Ll
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbXEMRtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758347AbXEMRta
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:49:30 -0400
Received: from mail.lenk.info ([217.160.134.107]:2767 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbXEMRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:49:29 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HnIB0-0006pv-Cs; Sun, 13 May 2007 19:48:10 +0200
Received: from p54b0dc82.dip.t-dialin.net ([84.176.220.130] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnICE-00030t-As; Sun, 13 May 2007 19:49:26 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnICE-00020A-F6; Sun, 13 May 2007 19:49:26 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1179078566806-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47155>

While we can easily test the cvs <-> git-cvsserver
communication with :fork: and git-cvsserver server
there are some pserver specifics we should test, too.

Currently this are two tests of the pserver authentication.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9410-git-cvsserver-pserver.sh |   53 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 t/t9410-git-cvsserver-pserver.sh

diff --git a/t/t9410-git-cvsserver-pserver.sh b/t/t9410-git-cvsserver-pserver.sh
new file mode 100644
index 0000000..1cf9bc7
--- /dev/null
+++ b/t/t9410-git-cvsserver-pserver.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# 
+# Copyright (c) 2007 Frank Lichtenheld
+#
+
+test_description='git-cvsserver pserver access
+
+tests some pserver specific features (like
+authentication).'
+
+. ./test-lib.sh
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
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
+test_expect_success 'authentication' \
+  'cat <<EOF | git-cvsserver pserver >log 2>&1 &&
+BEGIN AUTH REQUEST
+$SERVERDIR
+anonymous
+
+END AUTH REQUEST
+EOF
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_success 'authentication failure (non-anonymous user)' \
+  'if cat <<EOF | git-cvsserver pserver >log 2>&1
+BEGIN AUTH REQUEST
+$SERVERDIR
+git
+
+END AUTH REQUEST
+EOF
+   then
+       false
+   else
+       true
+   fi &&
+   tail -n1 log | grep -q "^I HATE YOU$"'
+
+
+test_done
-- 
1.5.1.4
