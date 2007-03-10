From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [PATCH 2/2] Autotag: Read guilt.autotag config var and tag commits only if this feature is enabled
Date: Fri,  9 Mar 2007 23:46:23 -0500
Message-ID: <11735019832141-git-send-email-jsipek@cs.sunysb.edu>
References: <11735019831915-git-send-email-jsipek@cs.sunysb.edu>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 05:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPtTf-0000DQ-11
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 05:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767819AbXCJEqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 23:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767820AbXCJEqb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 23:46:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54232 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767819AbXCJEq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 23:46:29 -0500
Received: from thor.fsl.cs.sunysb.edu (thor.fsl.cs.sunysb.edu [130.245.126.40])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l2A4kLe6028995;
	Fri, 9 Mar 2007 23:46:21 -0500
Received: from jsipek by thor.fsl.cs.sunysb.edu with local (Exim 4.63)
	(envelope-from <jsipek@dhcp42.fsl.cs.sunysb.edu>)
	id 1HPtTL-0007W5-FK; Fri, 09 Mar 2007 23:46:23 -0500
X-Mailer: git-send-email 1.5.0.3.268.g3dda
In-Reply-To: <11735019831915-git-send-email-jsipek@cs.sunysb.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41845>

Some users may not want to have guilt automatically tag the top, bottom, and
base of the stack. Allow them to disable such functionality by setting
guilt.autotag=0 in their git config file.

guilt-init now accepts a new parameter '-n' to automatically set
guilt.autotag=0 in the current repository.

Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 Documentation/guilt-init.txt |    8 +++++++-
 guilt                        |   15 +++++++++++++++
 guilt-init                   |   15 ++++++++++++---
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/guilt-init.txt b/Documentation/guilt-init.txt
index e643668..a245c6e 100644
--- a/Documentation/guilt-init.txt
+++ b/Documentation/guilt-init.txt
@@ -8,12 +8,18 @@ guilt-init - Initialize guilt for use in a git repository
 
 SYNOPSIS
 --------
-'guilt-init' 
+'guilt-init [-n]' 
 
 DESCRIPTION
 -----------
 Initialize a git repository for use with guilt
 
+OPTIONS
+-------
+-n::
+	Do not automatically create stack top, bottom, and base tags (sets
+	guilt.autotag config variable to 0).
+
 EXAMPLES
 --------
 First, get a repository to work on. Here's one that we'll use as an example:
diff --git a/guilt b/guilt
index 3dbe4b6..e7c22d2 100755
--- a/guilt
+++ b/guilt
@@ -285,6 +285,11 @@ function pop_many_patches
 # usage: update_stack_tags
 function update_stack_tags
 {
+	# bail if autotagging is not enabled
+	if [ $autotag -eq 0 ]; then
+		return 0
+	fi
+
 	if [ `wc -l < $applied` -gt 0 ]; then
 		# there are patches applied, therefore we must get the top,
 		# bottom and base hashes, and update the tags
@@ -480,12 +485,22 @@ function munge_hash_range
 	fi
 }
 
+#
 # Some constants
+#
 
 # used for: git-apply -C <val>
 guilt_push_diff_context=1
 
 #
+# Parse any part of .git/config that belongs to us
+#
+
+# autotag?
+autotag=`git-config guilt.autotag`
+[ -z "$autotag" ] && autotag=1
+
+#
 # The following gets run every time this file is source'd
 #
 
diff --git a/guilt-init b/guilt-init
index 1277998..feacf95 100755
--- a/guilt-init
+++ b/guilt-init
@@ -5,11 +5,19 @@
 
 DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
+USAGE="[-n]"
 . guilt
 
-if [ $# -ne 0 ]; then
-	usage
-fi
+autotag=1
+
+while case $# in 0) break ;; esac; do
+	if [ "$1" = "-n" ]; then
+		autotag=0
+		shift
+	else
+		usage
+	fi
+done
 
 if [ -d "$GUILT_DIR/$branch" ]; then
 	die "Branch $branch appears to be already initialized (GIT_DIR=$GIT_DIR)"
@@ -20,3 +28,4 @@ mkdir $GUILT_DIR/$branch
 touch $GUILT_DIR/$branch/series
 touch $GUILT_DIR/$branch/status
 
+git-config --int --replace-all guilt.autotag $autotag
-- 
1.5.0.3.268.g3dda
