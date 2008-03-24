From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 6/7] cvsserver: Added test for update -p
Date: Mon, 24 Mar 2008 23:50:44 +0100
Message-ID: <d183368d7796cc28e600a6984954a836dc78d8be.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvVr-000319-4S
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbYCXWus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYCXWus
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:50:48 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:36230 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753894AbYCXWur (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:50:47 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id B2ACE30280C;
	Mon, 24 Mar 2008 23:50:45 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id A1AF02D3C7F;
	Mon, 24 Mar 2008 23:50:45 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id EAF398C468;
	Mon, 24 Mar 2008 23:50:44 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: d183368d7796cc28e600a6984954a836dc78d8be Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78120>


Signed-off-by: Damien Diederen <dash@foobox.net>
---
 t/t9400-git-cvsserver-server.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6168324..166b43f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -420,6 +420,24 @@ test_expect_success 'cvs update (merge no-op)' \
     GIT_CONFIG="$git_config" cvs -Q update &&
     diff -q merge ../merge'
 
+cd "$WORKDIR"
+test_expect_success 'cvs update (-p)' '
+    touch really-empty &&
+    echo Line 1 > no-lf &&
+    echo -n Line 2 >> no-lf &&
+    git add really-empty no-lf &&
+    git commit -q -m "Update -p test" &&
+    git push gitcvs.git >/dev/null &&
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs update &&
+    rm -f failures &&
+    for i in merge no-lf empty really-empty; do
+        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
+        diff $i.out ../$i >>failures 2>&1
+    done &&
+    test -z "$(cat failures)"
+'
+
 #------------
 # CVS STATUS
 #------------
-- 
1.5.5.rc1.6.gd183
