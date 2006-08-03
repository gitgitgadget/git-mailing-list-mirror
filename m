From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution
Date: Fri,  4 Aug 2006 11:53:53 +1200
Message-ID: <11546492331601-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Aug 04 01:51:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8mye-0004DM-Ng
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 01:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWHCXvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 19:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWHCXvl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 19:51:41 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:61900 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751394AbWHCXvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 19:51:41 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1G8myY-0007rc-TC; Fri, 04 Aug 2006 11:51:38 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1G8n0j-0007vd-00; Fri, 04 Aug 2006 11:53:53 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.g1869bc-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24758>

This is a bit of a crude but really useful shortcut for conflict resolution.
The name is bad, but git-merge-* is a different 'namespace', and git-resolve is
also taken.

And as different conflict resolvers take different options, it may make sense
to have git-xxdiff, git-sdiff and git-winmerge at least initially.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 Makefile      |    2 +-
 git-xxdiff.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletions(-)

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
index 0000000..d562ab2
--- /dev/null
+++ b/git-xxdiff.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+USAGE='<path>'
+SUBDIRECTORY_OK=No
+. git-sh-setup
+
+FILE=$1
+MERGE_HEAD=`git rev-parse MERGE_HEAD`
+
+# Sanity checks
+if test ! -n "$FILE"
+then
+	echo Need a path
+	exit 1
+fi
+
+if test ! -n "$MERGE_HEAD"
+then
+	echo git-xxdiff is only useful during a merge
+fi
+
+git cat-file blob HEAD:$FILE > $FILE~HEAD
+if test $? -gt 0
+then 
+	echo "Error - maybe $FILE is not tracked by git?"
+	exit
+fi
+echo Written $FILE~HEAD
+
+git cat-file blob $MERGE_HEAD:$FILE > $FILE~MERGE_HEAD
+if  test $? -gt 0
+then 
+	echo "Error - maybe $FILE is not tracked by git?"
+	exit
+fi
+echo Written $FILE~MERGE_HEAD
+
+xxdiff -wbB --show-merged-pane --merged-filename $FILE~merged $FILE~HEAD $FILE~MERGE_HEAD
\ No newline at end of file
-- 
1.4.2.rc2.g1869bc-dirty
