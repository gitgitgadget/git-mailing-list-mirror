From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [PATCH 1/2] Automatically create unannotated tags for top, bottom, and base of the stack
Date: Fri,  9 Mar 2007 23:46:22 -0500
Message-ID: <11735019831879-git-send-email-jsipek@cs.sunysb.edu>
References: <11735019831915-git-send-email-jsipek@cs.sunysb.edu>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 05:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPtTe-0000DQ-Gz
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 05:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767816AbXCJEqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 23:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767821AbXCJEqb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 23:46:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54230 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767816AbXCJEq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 23:46:29 -0500
Received: from thor.fsl.cs.sunysb.edu (thor.fsl.cs.sunysb.edu [130.245.126.40])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l2A4kL4c028990;
	Fri, 9 Mar 2007 23:46:21 -0500
Received: from jsipek by thor.fsl.cs.sunysb.edu with local (Exim 4.63)
	(envelope-from <jsipek@dhcp42.fsl.cs.sunysb.edu>)
	id 1HPtTL-0007Vz-8m; Fri, 09 Mar 2007 23:46:23 -0500
X-Mailer: git-send-email 1.5.0.3.268.g3dda
In-Reply-To: <11735019831915-git-send-email-jsipek@cs.sunysb.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41846>

On every push or pop operation (refresh is a pop followed by a push), update
the stack top (${branch}_top), stack bottom (${branch}_bottom), and stack
base (${branch}_base) tags.

Top:	Topmost applied patch/commit
Bottom:	Bottommost applied patch/commit
Base:	Commit on top of which the bottom most patch is applied

Having these three tags, one can easily get the log/diff/other information
only for commits that are (or are not!) part of the patch stack.

Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 guilt |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index 43e7842..3dbe4b6 100755
--- a/guilt
+++ b/guilt
@@ -277,6 +277,33 @@ function pop_many_patches
 	mv "$applied.tmp" "$applied"
 
 	cd - 2>&1 >/dev/null
+
+	# update references to top, bottom, and base
+	update_stack_tags
+}
+
+# usage: update_stack_tags
+function update_stack_tags
+{
+	if [ `wc -l < $applied` -gt 0 ]; then
+		# there are patches applied, therefore we must get the top,
+		# bottom and base hashes, and update the tags
+
+		local top_hash=`git-rev-parse HEAD`
+		local bottom_hash=`head -1 < $applied | cut -d: -f1`
+		local base_hash=`git-rev-parse $bottom_hash^`
+
+		echo $top_hash > "$GIT_DIR/refs/tags/${branch}_top"
+		echo $bottom_hash > "$GIT_DIR/refs/tags/${branch}_bottom"
+		echo $base_hash > "$GIT_DIR/refs/tags/${branch}_base"
+	else
+		# there are no patches applied, therefore we must remove the
+		# tags to old top, bottom, and base
+
+		rm -f "$GIT_DIR/refs/tags/${branch}_top"
+		rm -f "$GIT_DIR/refs/tags/${branch}_bottom"
+		rm -f "$GIT_DIR/refs/tags/${branch}_base"
+	fi
 }
 
 # usage: push_patch patchname [bail_action]
@@ -349,6 +376,11 @@ function push_patch
 	# mark patch as applied
 	echo "$commitish:$pname" >> $applied
 
+	cd - 2>&1 >/dev/null
+
+	# update references to top, bottom, and base of the stack
+	update_stack_tags
+
 	# restore original GIT_AUTHOR_{NAME,EMAIL}
 	if [ ! -z "$author_str" ]; then
 		if [ ! -z "$backup_author_name" ]; then
@@ -376,8 +408,6 @@ function push_patch
 
 	rm -f /tmp/guilt.msg.$$ /tmp/guilt.log.$$
 
-	cd - 2>&1 >/dev/null
-
 	return $bail
 }
 
-- 
1.5.0.3.268.g3dda
