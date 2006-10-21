From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] make cg-commit --review restore original tree state afterwards
Date: Sat, 21 Oct 2006 14:11:18 +1300
Message-ID: <20061021014723.B8E9C13810D@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 03:47:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb5xS-0000pI-LQ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 03:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992772AbWJUBr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWJUBr1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 21:47:27 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:25026 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1030377AbWJUBr0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 21:47:26 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id B8E9C13810D; Sat, 21 Oct 2006 14:47:23 +1300 (NZDT)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29573>

If you delete hunks from the patch that 'cg-commit -p' shows you, then
they are lost 'forever'.  Let's put back everything how it was
beforehand instead.
---
 cg-commit |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/cg-commit b/cg-commit
index 01a4eb7..81b3619 100755
--- a/cg-commit
+++ b/cg-commit
@@ -568,18 +568,16 @@ else
 fi
 rm "$LOGMSG2"
 
+pine_for_darcs() {
+	die "unable to revert the new patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in ten minutes, have a nice day"
+}
+
 if [ "$review" ]; then
 	if ! cmp -s "$PATCH" "$PATCH2"; then
 		echo "Reverting the original patch..."
-		if ! cg-patch -R < "$PATCH"; then
-			die "unable to revert the original patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in ten minutes, have a nice day"
-		fi
+		cg-patch -R < "$PATCH" || pine_for_darcs
 		echo "Applying the edited patch..."
-		if ! cg-patch < "$PATCH2"; then
-			# FIXME: Do something better to alleviate this situation.
-			# At least restore the tree to the original state.
-			die "unable to apply the edited patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in five minutes, have a nice day"
-		fi
+		cg-patch < "$PATCH2" || pine_for_darcs
 	fi
 fi
 
@@ -625,6 +623,17 @@ if [ "$amend" ]; then
 fi
 
 treeid="$(git-write-tree ${missingok})"
+
+if [ "$review" ]; then
+        if ! cmp -s "$PATCH" "$PATCH2"; then
+                echo "Reverting the new patch..."
+                cg-patch -R < "$PATCH2" || pine_for_darcs
+                echo "Applying the old patch..."
+                cg-patch < "$PATCH" || pine_for_darcs
+        fi
+fi
+
+
 [ "$treeid" ] || die "git-write-tree failed"
 if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
    [ "$treeid" = "$(cg-object-id -t)" ]; then
-- 
1.4.2.g0ea2
