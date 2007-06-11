From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/5] git-submodule: give submodules proper names
Date: Mon, 11 Jun 2007 21:12:24 +0200
Message-ID: <1181589146188-git-send-email-hjemli@gmail.com>
References: <11815891453464-git-send-email-hjemli@gmail.com>
 <11815891451258-git-send-email-hjemli@gmail.com>
 <1181589146478-git-send-email-hjemli@gmail.com>
 <1181589146685-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHL-0007ab-8G
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXFKTKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXFKTKJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:10:09 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:40968 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbXFKTKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:10:07 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJ9pBT025419;
	Mon, 11 Jun 2007 21:09:52 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <1181589146685-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49873>

This changes the way git-submodule uses .gitmodules: Subsections no longer
specify the submodule path, they now specify the submodule name. The
submodule path is found under the new key "submodule.<name>.path", which is
a required key.

With this change a submodule can be moved between different 'checkout paths'
without upsetting git-submodule.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh           |   45 ++++++++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh |   20 +++++++++++++++---
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6c83c52..89a3885 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -25,6 +25,19 @@ say()
 	fi
 }
 
+#
+# Map submodule path to submodule name
+#
+# $1 = path
+#
+module_name()
+{
+       name=$(GIT_CONFIG=.gitmodules git-config --get-regexp '^submodule\..*\.path$' "$1" |
+       sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
+       test -z "$name" &&
+       die "No submodule mapping found in .gitmodules for path '$path'"
+       echo "$name"
+}
 
 #
 # Clone a submodule
@@ -49,7 +62,7 @@ module_clone()
 	die "A file already exist at path '$path'"
 
 	git-clone -n "$url" "$path" ||
-	die "Clone of submodule '$path' failed"
+	die "Clone of '$url' into submodule path '$path' failed"
 }
 
 #
@@ -63,17 +76,18 @@ modules_init()
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
-		url=$(git-config submodule."$path".url)
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
 		test -z "$url" || continue
 
-		url=$(GIT_CONFIG=.gitmodules git-config submodule."$path".url)
+		url=$(GIT_CONFIG=.gitmodules git-config submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule '$path' in .gitmodules"
+		die "No url found for submodule path '$path' in .gitmodules"
 
-		git-config submodule."$path".url "$url" ||
-		die "Failed to register url for submodule '$path'"
+		git-config submodule."$name".url "$url" ||
+		die "Failed to register url for submodule path '$path'"
 
-		say "Submodule '$path' registered with url '$url'"
+		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
 
@@ -87,13 +101,14 @@ modules_update()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		url=$(git-config submodule."$path".url)
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "Submodule '$path' not initialized"
+			say "Submodule path '$path' not initialized"
 			continue
 		fi
 
@@ -104,22 +119,22 @@ modules_update()
 		else
 			subsha1=$(unset GIT_DIR && cd "$path" &&
 				git-rev-parse --verify HEAD) ||
-			die "Unable to find current revision of submodule '$path'"
+			die "Unable to find current revision in submodule path '$path'"
 		fi
 
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR && cd "$path" && git-fetch &&
 				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule '$path'"
+			die "Unable to checkout '$sha1' in submodule path '$path'"
 
-			say "Submodule '$path': checked out '$sha1'"
+			say "Submodule path '$path': checked out '$sha1'"
 		fi
 	done
 }
 
 #
-# List all registered submodules, prefixed with:
+# List all submodules, prefixed with:
 #  - submodule not initialized
 #  + different revision checked out
 #
@@ -133,7 +148,9 @@ modules_list()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		if ! test -d "$path"/.git
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
+		if test -z "url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
 			continue;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9f2d4f9..7a9b505 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -18,7 +18,7 @@ subcommands of git-submodule.
 #  -add directory lib to 'superproject', this creates a DIRLINK entry
 #  -add a couple of regular files to enable testing of submodule filtering
 #  -mv lib subrepo
-#  -add an entry to .gitmodules for path 'lib'
+#  -add an entry to .gitmodules for submodule 'example'
 #
 test_expect_success 'Prepare submodule testing' '
 	mkdir lib &&
@@ -40,7 +40,19 @@ test_expect_success 'Prepare submodule testing' '
 	git-add a lib z &&
 	git-commit -m "super commit 1" &&
 	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config submodule.lib.url git://example.com/lib.git
+	GIT_CONFIG=.gitmodules git-config submodule.example.url git://example.com/lib.git
+'
+
+test_expect_success 'status should fail for unmapped paths' '
+	if git-submodule status
+	then
+		echo "[OOPS] submodule status succeeded"
+		false
+	elif ! GIT_CONFIG=.gitmodules git-config submodule.example.path lib
+	then
+		echo "[OOPS] git-config failed to update .gitmodules"
+		false
+	fi
 '
 
 test_expect_success 'status should only print one line' '
@@ -54,12 +66,12 @@ test_expect_success 'status should initially be "missing"' '
 
 test_expect_success 'init should register submodule url in .git/config' '
 	git-submodule init &&
-	url=$(git-config submodule.lib.url) &&
+	url=$(git-config submodule.example.url) &&
 	if test "$url" != "git://example.com/lib.git"
 	then
 		echo "[OOPS] init succeeded but submodule url is wrong"
 		false
-	elif ! git-config submodule.lib.url ./.subrepo
+	elif ! git-config submodule.example.url ./.subrepo
 	then
 		echo "[OOPS] init succeeded but update of url failed"
 		false
-- 
1.5.2.1.914.gbd3a7
