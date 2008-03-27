From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 6/7] cvsserver: Add test for update -p
Date: Thu, 27 Mar 2008 23:18:23 +0100
Message-ID: <c1b10ec91d678b58e0c5e65b3fbc77a4ed19453a.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:19:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0RB-000666-AQ
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844AbYC0WS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759817AbYC0WS0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:18:26 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:41803 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759777AbYC0WSZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:18:25 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 733A6209444;
	Thu, 27 Mar 2008 23:18:24 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 5D613100C1;
	Thu, 27 Mar 2008 23:18:24 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A646C67E05;
	Thu, 27 Mar 2008 23:18:23 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: c1b10ec91d678b58e0c5e65b3fbc77a4ed19453a Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78375>

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
1.5.5.rc1.19.gfe7681
