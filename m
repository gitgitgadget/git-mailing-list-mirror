From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 4/7] cvsserver: Add a few tests for 'status' command
Date: Mon, 24 Mar 2008 23:50:05 +0100
Message-ID: <96f67c3e4ad8f5fe0c179b97b9f1ae1a7943b106.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvVC-0002kt-Ob
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbYCXWuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYCXWuI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:50:08 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:42976 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834AbYCXWuH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:50:07 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5118A2090EC;
	Mon, 24 Mar 2008 23:50:06 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 3F58D5BFA2;
	Mon, 24 Mar 2008 23:50:06 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id BA22D8C466;
	Mon, 24 Mar 2008 23:50:05 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 96f67c3e4ad8f5fe0c179b97b9f1ae1a7943b106 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78118>


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
1.5.5.rc1.6.gd183
