From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] git-submodule: Try harder to describe the status of a submodule
Date: Wed, 27 Jun 2007 14:13:21 -0500
Message-ID: <118297160163-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 21:15:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3czZ-0001bX-Q7
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXF0TPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 15:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbXF0TPp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 15:15:45 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:38377 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXF0TPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 15:15:44 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l5RJFfZ1010510
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 12:15:42 -0700 (MST)
Received: from localhost.localdomain ([10.82.124.180])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5RJFfiS025364;
	Wed, 27 Jun 2007 14:15:41 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.2.549.gaeb59
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51062>

Some repositories might not use/have annotated tags (for example repositories created with
git-cvsimport) or might not have tags at all and could cause git-submodule status to fail because
git-describe might fail.

This change makes git-submodule status try harder in displaying the status of a module by
considering lightweight tags, subsequent tags and branches.

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 git-submodule.sh |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 89a3885..7429ce3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -134,6 +134,25 @@ modules_update()
 }
 
 #
+# Identify and display the most specific name describing an object specified by a SHA1 key
+#
+# First try to locate a tag that predates the commit. If that fails try to locate a tag that comes
+# after the commit. If that fails too (e.g. undefined), try to locate the branch of the commit. If
+# that fails too just display "undefined"
+#
+get_revname()
+{
+	_revname=$(git-describe --tags "$1" 2>/dev/null || git-describe --contains "$1" 2>/dev/null)
+	if test -z "$_revname" -o "$_revname" = "undefined"
+	then
+		_revname=$(git-describe --all "$1" 2>/dev/null | cut -d / -f2-)
+		test -z "$_revname" && _revname=undefined
+	fi
+	echo $_revname
+	unset _revname
+}
+
+#
 # List all submodules, prefixed with:
 #  - submodule not initialized
 #  + different revision checked out
@@ -155,7 +174,7 @@ modules_list()
 			say "-$sha1 $path"
 			continue;
 		fi
-		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+		revname=$(unset GIT_DIR && cd "$path" && get_revname $sha1)
 		if git diff-files --quiet -- "$path"
 		then
 			say " $sha1 $path ($revname)"
@@ -163,7 +182,7 @@ modules_list()
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD)
-				revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+				revname=$(unset GIT_DIR && cd "$path" && get_revname $sha1)
 			fi
 			say "+$sha1 $path ($revname)"
 		fi
-- 
1.5.2.2.549.gaeb59
