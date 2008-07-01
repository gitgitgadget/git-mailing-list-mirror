From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Tue, 1 Jul 2008 17:00:25 +0200
Message-ID: <20080701150025.GD5852@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 17:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDhT2-0000bZ-AX
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 17:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075AbYGAPHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758908AbYGAPHY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 11:07:24 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:35846 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758843AbYGAPHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 11:07:22 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay05.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KDhLF-0005jT-1L
	for git@vger.kernel.org; Tue, 01 Jul 2008 17:00:25 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87043>

The 'master' version of git-submodule.sh fails to see that
a/b/c/repository is an already existing repository and messes up the
whole thing. The following patch fixes that.
-- 
Sylvain

>From 2bca2e17a01cd81ce30f81750583ab943ab57ff0 Mon Sep 17 00:00:00 2001
From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Date: Tue, 1 Jul 2008 16:45:04 +0200
Subject: [PATCH] fix submodule add for non-toplevel in-project directories

This patch fixes git-submodule add for submodules that
already exist in the current package tree, in a folder
which is not at toplevel, i.e.:

  git submodule add a/b/c/repository

Signed-off-by: Sylvain Joyeux <sylvain.joyeux@dfki.de>
---
 git-submodule.sh           |    6 +++++-
 t/t7400-submodule-basic.sh |    9 +++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e2b91f6..3fa8ff3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -156,7 +156,11 @@ cmd_add()
 
 	# Guess path from repo if not specified or strip trailing slashes
 	if test -z "$path"; then
-		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+                if echo "$repo" | grep -q "^\(\.\.\|\/\)"; then
+                        path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+                else
+                        path=$(echo "$repo" | sed -e 's|/*$||')
+                fi
 	else
 		path=$(echo "$path" | sed -e 's|/*$||')
 	fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ffaa932..84ea6e9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -215,4 +215,13 @@ test_expect_success 'update --init' '
 
 '
 
+test_expect_success 'adding an already-existing repository deep in the directory hierarchy' '
+
+        mkdir dir0 &&
+        mkdir dir0/dir1 &&
+        git clone init dir0/dir1/init &&
+        git-submodule add dir0/dir1/init &&
+        git-submodule status | grep "dir0/dir1/init"
+'
+
 test_done
-- 
1.5.6
