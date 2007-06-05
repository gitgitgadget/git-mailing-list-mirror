From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Tue,  5 Jun 2007 11:29:11 +0200
Message-ID: <11810357522478-git-send-email-hjemli@gmail.com>
References: <11810357523435-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvVJi-0000zW-7w
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763229AbXFEJ0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763281AbXFEJ0v
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:26:51 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46957 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763229AbXFEJ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:26:49 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l559QjKY004735;
	Tue, 5 Jun 2007 11:26:46 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.846.gb8de
In-Reply-To: <11810357523435-git-send-email-hjemli@gmail.com>
Message-Id: <863f2ca67857bc2d09f46f1a5ef6f653d16d5256.1181034736.git.hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is just a simple refactoring of modules_init() with no change in
functionality.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6ed5a6c..a89ea88 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -25,6 +25,33 @@ say()
 	fi
 }
 
+
+#
+# Clone a submodule
+#
+module_clone()
+{
+	path=$1
+	url=$2
+
+	# If there already is a directory at the submodule path,
+	# expect it to be empty (since that is the default checkout
+	# action) and try to remove it.
+	# Note: if $path is a symlink to a directory the test will
+	# succeed but the rmdir will fail. We might want to fix this.
+	if test -d "$path"
+	then
+		rmdir "$path" 2>/dev/null ||
+		die "Directory '$path' exist, but is neither empty nor a git repository"
+	fi
+
+	test -e "$path" &&
+	die "A file already exist at path '$path'"
+
+	git-clone -n "$url" "$path" ||
+	die "Clone of submodule '$path' failed"
+}
+
 #
 # Run clone + checkout on missing submodules
 #
@@ -40,20 +67,6 @@ modules_init()
 		# repository
 		test -d "$path"/.git && continue
 
-		# If there already is a directory at the submodule path,
-		# expect it to be empty (since that is the default checkout
-		# action) and try to remove it.
-		# Note: if $path is a symlink to a directory the test will
-		# succeed but the rmdir will fail. We might want to fix this.
-		if test -d "$path"
-		then
-			rmdir "$path" 2>/dev/null ||
-			die "Directory '$path' exist, but is neither empty nor a git repository"
-		fi
-
-		test -e "$path" &&
-		die "A file already exist at path '$path'"
-
 		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
 		test -z "$url" &&
 		die "No url found for submodule '$path' in .gitmodules"
@@ -69,8 +82,7 @@ modules_init()
 		# logical modulename (if present) as key. But this would need
 		# another fallback mechanism if the module wasn't named.
 
-		git-clone -n "$url" "$path" ||
-		die "Clone of submodule '$path' failed"
+		module_clone "$path" "$url" || exit $?
 
 		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
 		die "Checkout of submodule '$path' failed"
-- 
1.5.2.841.gc9eafb
