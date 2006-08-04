From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution - take 2
Date: Fri,  4 Aug 2006 12:37:07 +1200
Message-ID: <11546518271379-git-send-email-martin@catalyst.net.nz>
References: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Aug 04 02:35:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8nea-0001wc-65
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHDAez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 20:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWHDAez
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 20:34:55 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:2482 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1030199AbWHDAez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 20:34:55 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1G8neO-00025S-Ru; Fri, 04 Aug 2006 12:34:52 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1G8ngZ-000898-00; Fri, 04 Aug 2006 12:37:07 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.g1869bc-dirty
In-Reply-To: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24763>

This is a bit of a crude but really useful shortcut for conflict resolution.
The name is bad, but git-merge-* is a different 'namespace', and git-resolve is
also taken.

And as different conflict resolvers take different options, it may make sense
to have git-xxdiff, git-sdiff and git-winmerge at least initially.

Reposting with some fixes suggested by Junio.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---

How about this one? ;-)
---
 Makefile      |    2 +-
 git-xxdiff.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8349e3d..a6f6628 100644
--- a/Makefile
+++ b/Makefile
@@ -145,7 +145,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh git-xxdiff.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-xxdiff.sh b/git-xxdiff.sh
new file mode 100755
index 0000000..3dc9876
--- /dev/null
+++ b/git-xxdiff.sh
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
+git cat-file blob :2:$FILE > $FILE~ours
+if test $? -gt 0
+then 
+	echo "Error - $FILE is not tracked by git or does not have a conflict"
+	exit 1
+fi
+echo Written $FILE~ours
+
+git cat-file blob :3:$FILE > $FILE~branch
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
1.4.2.rc2.g1869bc-dirty
