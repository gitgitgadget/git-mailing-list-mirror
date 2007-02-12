From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] Fix cg-commit -p to not touch the working tree
Date: Mon, 12 Feb 2007 16:14:31 +1300
Message-ID: <20070212031923.D20B913A382@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 12 04:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGRiz-0003tM-RV
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 04:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbXBLDT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 22:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbXBLDT0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 22:19:26 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:41658 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881AbXBLDT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 22:19:26 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id D20B913A382; Mon, 12 Feb 2007 16:19:23 +1300 (NZDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39353>

Previously, the working tree state was modified with `patch', which
was a fragile operation.  Do everything with `git-apply --cached
--index' instead.
---
 cg-commit |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/cg-commit b/cg-commit
index 360d5e6..f676e1f 100755
--- a/cg-commit
+++ b/cg-commit
@@ -575,22 +575,6 @@ else
 fi
 rm "$LOGMSG2"
 
-if [ "$review" ]; then
-	if ! cmp -s "$PATCH" "$PATCH2"; then
-		echo "Reverting the original patch..."
-		if ! cg-patch -R < "$PATCH"; then
-			die "unable to revert the original patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in ten minutes, have a nice day"
-		fi
-		echo "Applying the edited patch..."
-		if ! cg-patch < "$PATCH2"; then
-			# FIXME: Do something better to alleviate this situation.
-			# At least restore the tree to the original state.
-			die "unable to apply the edited patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in five minutes, have a nice day"
-		fi
-	fi
-fi
-
-
 precommit_update()
 {
 	queueN=(); queueD=(); queueM=();
@@ -620,6 +604,23 @@ if [ ! "$ignorecache" ]; then
 	precommit_update "${commitfiles[@]}" || die "update-cache failed"
 fi
 
+if [ "$review" ]; then
+	if ! cmp -s "$PATCH" "$PATCH2"; then
+		git-read-tree HEAD
+		while ! git-apply --check --cached --index "$PATCH2"
+		do
+			echo "patch tried was:"
+			cat $PATCH2
+			echo "your patch does not apply cleanly, re-edit it!"
+			echo -n "sleeping 5s..."
+			sleep 4
+			echo "get it right this time OK?"
+			sleep 1
+			${EDITOR:-vi} "$PATCH2"
+		done
+		git-apply --cached --index "$PATCH2"
+	fi
+fi
 
 oldhead=
 oldheadname="$(git-symbolic-ref HEAD)"
-- 
1.5.0.rc2.g84cf66-dirty
