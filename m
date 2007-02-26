From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Make "guilt push" match "quilt push" when the patch doesn't apply
Date: Sun, 25 Feb 2007 22:58:09 -0500
Message-ID: <E1HLX7O-0004bu-Qx@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Feb 26 05:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLX7b-0004e1-6r
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 05:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933752AbXBZEFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 23:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbXBZEFs
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 23:05:48 -0500
Received: from THUNK.ORG ([69.25.196.29]:36185 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933752AbXBZEFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 23:05:48 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HLXCr-0003aQ-0Y; Sun, 25 Feb 2007 23:11:21 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HLX7O-0004bu-Qx; Sun, 25 Feb 2007 23:05:42 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40609>

Sometimes the reason why the patch doesn't apply is because it has
already been applied in mainline when rebasing a patch series.  It is
therefore more convenient if "guilt push" leaves the working tree
untouched if the patch fails to apply unless explicitly asked to force
apply a failing patch using the -f option.

This behavior matches how "quilt push" and "hg qpush" works, so it
also avoids unpleasant surprises for developers used to other patch
series tools.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt      |   14 ++++++++++++--
 guilt-push |   16 +++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/guilt b/guilt
index 284f9fb..f5a55ff 100755
--- a/guilt
+++ b/guilt
@@ -259,8 +259,10 @@ function push_patch
 {
 	local p="$GUILT_DIR/$branch/$1"
 	local pname="$1"
+	local bail_action="$2"
 
 	local bail=0
+	local reject="--reject"
 
 	assert_head_check
 
@@ -268,11 +270,19 @@ function push_patch
 
 	# apply the patch if and only if there is something to apply
 	if [ `git-apply --numstat $p | wc -l` -gt 0 ]; then
+		if [ "$bail_action" = abort ]; then
+		    reject=""
+		fi
 		git-apply -C$guilt_push_diff_context \
-			--reject $p > /dev/null 2> /tmp/guilt.log.$$
+			$reject $p > /dev/null 2> /tmp/guilt.log.$$
 		bail=$?
 
-		[ $bail -ne 0 ] && cat /tmp/guilt.log.$$ >&2
+		if [ $bail -ne 0 ]; then
+			cat /tmp/guilt.log.$$ >&2
+			if [ "$bail_action" = abort ]; then
+				return $bail
+			fi
+		fi
 
 		# FIXME: Path munging is being done, we need to convince
 		# git-apply to just give us list of files with \0 as a
diff --git a/guilt-push b/guilt-push
index 4fb89e2..85b4122 100755
--- a/guilt-push
+++ b/guilt-push
@@ -5,7 +5,14 @@
 
 source "`dirname $0`/guilt"
 
-USAGE="$USAGE [-a | --all | <patchname>]"
+abort_flag="abort"
+
+USAGE="$USAGE [ -f ] [-a | --all | <patchname>]"
+
+if [ "$1" == "-f" ]; then
+	abort_flag=""
+	shift
+fi
 
 if [ $# -gt 1 ]; then
 	print_usage
@@ -61,14 +68,17 @@ for p in `get_series`; do
 		exit 1
 	fi
 
-	push_patch $p
+	push_patch $p $abort_flag
 
 	# bail if necessary
 	if [ $? -eq 0 ]; then
 		echo "Patch applied."
-	else
+	elif [ -z "$abort_flag" ]; then
 		echo "Patch applied with rejects. Fix it up, and refresh." >&2
 		exit 1
+	else
+		echo "To force apply this patch, use 'guilt push -f'" >&2
+		exit 1
 	fi
 done
 
-- 
1.5.0.1.74.g2470
