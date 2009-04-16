From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/1] hook/update: example of how to prevent branch creation
Date: Thu, 16 Apr 2009 22:00:44 +0200
Message-ID: <1239912044-29923-1-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 22:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuXwI-0000Aa-5v
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 22:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbZDPUK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZDPUK1
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 16:10:27 -0400
Received: from pan.madism.org ([88.191.52.104]:40179 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbZDPUK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 16:10:27 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2009 16:10:27 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9222C41FF1;
	Thu, 16 Apr 2009 22:00:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 37C9A2B4D9; Thu, 16 Apr 2009 22:00:55 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc0.201.gadb14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116716>

Since git doesn't provide a receive.denyBranchCreation or similar, here is
an example of how to be sure users cannot create branches remotely by
pushing a new reference.

This setup has been proven useful to prevent creation of spurious branches
because of users having their remote.origin.push set to HEAD, when they
use `git push` while being on a local topic branch of theirs instead of
the proper one.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 templates/hooks--update.sample |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index a3f68ae..62b9cfe 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -16,6 +16,9 @@
 # hooks.allowdeletebranch
 #   This boolean sets whether deleting branches will be allowed in the
 #   repository.  By default they won't be.
+# hooks.denycreatebranch
+#   This boolean sets wether remotely creating branches will be denied
+#   in the repository.  By default this is allowed.
 #
 
 # --- Command line
@@ -39,6 +42,7 @@ fi
 # --- Config
 allowunannotated=$(git config --bool hooks.allowunannotated)
 allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
+denycreatebranch=$(git config --bool hooks.denycreatebranch)
 allowdeletetag=$(git config --bool hooks.allowdeletetag)
 
 # check for no description
@@ -52,7 +56,8 @@ esac
 
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
-if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
+zero="0000000000000000000000000000000000000000"
+if [ "$newrev" = "$zero" ]; then
 	newrev_type=delete
 else
 	newrev_type=$(git-cat-file -t $newrev)
@@ -80,6 +85,10 @@ case "$refname","$newrev_type" in
 		;;
 	refs/heads/*,commit)
 		# branch
+		if [ "$oldrev" = "$zero" -a "$denycreatebranch" = "true" ]; then
+			echo "*** Creating a branch is not allowed in this repository" >&2
+			exit 1
+		fi
 		;;
 	refs/heads/*,delete)
 		# delete branch
-- 
1.6.3.rc0.201.gadb14
