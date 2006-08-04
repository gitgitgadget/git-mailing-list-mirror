From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Fri,  4 Aug 2006 15:34:07 +1200
Message-ID: <11546624471356-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Aug 04 05:32:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qPn-00047U-ND
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 05:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWHDDbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 23:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHDDbz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 23:31:55 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:8616 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1030224AbWHDDby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 23:31:54 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1G8qPg-0003Lq-7a; Fri, 04 Aug 2006 15:31:52 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1G8qRr-0000Xe-00; Fri, 04 Aug 2006 15:34:07 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.ge1f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24766>

This is a bit of a crude but really useful shortcut for conflict resolution.
The name is bad, but matches git-xxdiff which has been around for like... ages

As Cogito doesn't make use of the index during merges/applies, cg-xxdiff
is somewhat more brittle and cannot not help during conflict resolution when
using cg-patch.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 Makefile  |    3 ++-
 cg-xxdiff |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ba9bf9a..dc21702 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,8 @@ SCRIPT=	cg-object-id cg-add cg-admin-lso
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-fetch cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
 	cg cg-admin-ls cg-push cg-branch-chg cg-admin-cat cg-clean \
-	cg-admin-setuprepo cg-switch cg-mv cg-admin-rewritehist cg-tag-show
+	cg-admin-setuprepo cg-switch cg-mv cg-admin-rewritehist cg-tag-show \
+	cg-xxdiff
 
 LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xfetchprogress cg-Xfollowrenames
 
diff --git a/cg-xxdiff b/cg-xxdiff
new file mode 100755
index 0000000..7a1a863
--- /dev/null
+++ b/cg-xxdiff
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+USAGE='<path-with-conflict>'
+SUBDIRECTORY_OK=No
+. git-sh-setup
+
+FILE=$1
+
+# Sanity checks
+if test ! -n "$FILE"
+then
+	echo Need a path
+	exit 1
+fi
+
+git cat-file blob `git rev-parse HEAD`:$FILE > $FILE~ours
+if test $? -gt 0
+then 
+	echo "Error - $FILE is not tracked by git or does not have a conflict"
+	exit 1
+fi
+echo Written $FILE~ours
+
+git cat-file blob `git rev-parse FETCH_HEAD`:$FILE > $FILE~branch
+if  test $? -gt 0
+then 
+	echo "Error - $FILE is not tracked by git or does not have a conflict"
+	exit 1
+fi
+echo Written $FILE~branch
+echo Resolved file will be saved as $FILE~merged
+
+xxdiff -wbB --show-merged-pane --merged-filename $FILE~merged $FILE~ours $FILE~branch
-- 
1.4.2.rc2.ge1f7
