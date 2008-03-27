From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 4/7] cvsserver: Add a few tests for 'status' command
Date: Thu, 27 Mar 2008 23:18:02 +0100
Message-ID: <3bc8d6b298f7111d5ddcc5bfbaf8bab557eaec61.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0Qu-0005yp-SI
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbYC0WSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759754AbYC0WSH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:18:07 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:50322 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759671AbYC0WSG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:18:06 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id A1E6A19B71E;
	Thu, 27 Mar 2008 23:18:03 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 8D5A51B8E4B;
	Thu, 27 Mar 2008 23:18:03 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id D9AD727EC6;
	Thu, 27 Mar 2008 23:18:02 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 3bc8d6b298f7111d5ddcc5bfbaf8bab557eaec61 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78373>

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 t/t9400-git-cvsserver-server.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index b91b151..6168324 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -420,4 +420,36 @@ test_expect_success 'cvs update (merge no-op)' \
     GIT_CONFIG="$git_config" cvs -Q update &&
     diff -q merge ../merge'
 
+#------------
+# CVS STATUS
+#------------
+
+cd "$WORKDIR"
+test_expect_success 'cvs status' '
+    mkdir status.dir &&
+    echo Line > status.dir/status.file &&
+    echo Line > status.file &&
+    git add status.dir status.file &&
+    git commit -q -m "Status test" &&
+    git push gitcvs.git >/dev/null &&
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs update &&
+    GIT_CONFIG="$git_config" cvs status | grep "^File: status.file" >../out &&
+    test $(wc -l <../out) = 2
+'
+
+cd "$WORKDIR"
+test_expect_success 'cvs status (nonrecursive)' '
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs status -l | grep "^File: status.file" >../out &&
+    test $(wc -l <../out) = 1
+'
+
+cd "$WORKDIR"
+test_expect_success 'cvs status (no subdirs in header)' '
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs status | grep ^File: >../out &&
+    ! grep / <../out
+'
+
 test_done
-- 
1.5.5.rc1.19.gfe7681
