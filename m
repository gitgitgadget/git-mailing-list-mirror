From: Alec Berryman <alec@thened.net>
Subject: [PATCH] git-svn: factor out svnserve test code for later use
Date: Sun, 14 Sep 2008 17:14:15 -0400
Message-ID: <1221426856-2652-2-git-send-email-alec@thened.net>
References: <1221426856-2652-1-git-send-email-alec@thened.net>
Cc: Alec Berryman <alec@thened.net>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kez76-0008WG-GU
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbYINVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbYINVZT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:25:19 -0400
Received: from 129.210.68.208.dnsptr.net ([208.68.210.129]:59867 "EHLO
	ives.vdov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbYINVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:25:18 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Sep 2008 17:25:18 EDT
Received: from localhost (localhost [127.0.0.1])
	by ives.vdov.net (Postfix) with ESMTP id 7486524EDCB;
	Sun, 14 Sep 2008 16:15:04 -0500 (CDT)
Received: from ives.vdov.net ([127.0.0.1])
	by localhost (ives.vdov.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPIHik7gec+e; Sun, 14 Sep 2008 16:15:03 -0500 (CDT)
Received: from localhost (pool-96-237-12-178.bstnma.east.verizon.net [96.237.12.178])
	by ives.vdov.net (Postfix) with ESMTPSA id 34F9424EDBD;
	Sun, 14 Sep 2008 16:15:03 -0500 (CDT)
X-Mailer: git-send-email 1.6.0.2.231.gfc858
In-Reply-To: <1221426856-2652-1-git-send-email-alec@thened.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95866>

Signed-off-by: Alec Berryman <alec@thened.net>
---
 t/lib-git-svn.sh                    |   17 +++++++++++++++++
 t/t9113-git-svn-dcommit-new-file.sh |   14 +-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c526eed..67c431d 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -138,3 +138,20 @@ close $wr or die $!;
 close $rd or die $!;
 EOF
 }
+
+require_svnserve () {
+    if test -z "$SVNSERVE_PORT"
+    then
+        say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
+        test_done
+        exit
+    fi
+}
+
+start_svnserve () {
+    svnserve --listen-port $SVNSERVE_PORT \
+             --root "$rawsvnrepo" \
+             --listen-once \
+             --listen-host 127.0.0.1 &
+}
+
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 250c530..e9b6128 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -12,19 +12,7 @@ test_description='git svn dcommit new files over svn:// test'
 
 . ./lib-git-svn.sh
 
-if test -z "$SVNSERVE_PORT"
-then
-	say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
-	test_done
-	exit
-fi
-
-start_svnserve () {
-	svnserve --listen-port $SVNSERVE_PORT \
-	         --root "$rawsvnrepo" \
-	         --listen-once \
-	         --listen-host 127.0.0.1 &
-}
+require_svnserve
 
 test_expect_success 'start tracking an empty repo' '
 	svn mkdir -m "empty dir" "$svnrepo"/empty-dir &&
-- 
1.6.0.2.231.gfc858
