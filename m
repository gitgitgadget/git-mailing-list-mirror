From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/2] git-submodule: clone during update, not during init
Date: Tue,  5 Jun 2007 11:29:12 +0200
Message-ID: <11810357523233-git-send-email-hjemli@gmail.com>
References: <11810357523435-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvVJi-0000zW-Pc
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXFEJ0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbXFEJ0w
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:26:52 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46958 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763262AbXFEJ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:26:49 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l559QjKZ004735;
	Tue, 5 Jun 2007 11:26:46 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.846.gb8de
In-Reply-To: <11810357523435-git-send-email-hjemli@gmail.com>
Message-Id: <c14730acf8a52a57250303c033ebec09bf960007.1181034736.git.hjemli@gmail.com>
In-Reply-To: <863f2ca67857bc2d09f46f1a5ef6f653d16d5256.1181034736.git.hjemli@gmail.com>
References: <863f2ca67857bc2d09f46f1a5ef6f653d16d5256.1181034736.git.hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This teaches 'git-submodule init' to register submodule paths and urls in
.git/config instead of actually cloning them. The cloning is now handled
as part of 'git-submodule update'.

With this change it is possible to specify preferred/alternate urls for
the submodules in .git/config before the submodules are cloned.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-submodule.txt |   16 +++++++-------
 git-submodule.sh                |   41 ++++++++++++++++----------------------
 t/t7400-submodule-basic.sh      |   38 ++++++++++++++++++++++++-----------
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cb0424f..f8fb80f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -23,15 +23,15 @@ status::
 	repository. This command is the default command for git-submodule.
 
 init::
-	Initialize the submodules, i.e. clone the git repositories specified
-	in the .gitmodules file and checkout the submodule commits specified
-	in the index of the containing repository. This will make the
-	submodules HEAD be detached.
+	Initialize the submodules, i.e. register in .git/config each submodule
+	path and url found in .gitmodules. The key used in git/config is
+	`submodule.$path.url`. This command does not alter existing information
+	in .git/config.
 
 update::
-	Update the initialized submodules, i.e. checkout the submodule commits
-	specified in the index of the containing repository. This will make
-	the submodules HEAD be detached.
+	Update the registered submodules, i.e. clone missing submodules and
+	checkout the commit specified in the index of the containing repository.
+	This will make the submodules HEAD be detached.
 
 
 OPTIONS
@@ -50,7 +50,7 @@ OPTIONS
 
 FILES
 -----
-When cloning submodules, a .gitmodules file in the top-level directory
+When initializing submodules, a .gitmodules file in the top-level directory
 of the containing repository is used to find the url of each submodule.
 This file should be formatted in the same way as $GIR_DIR/config. The key
 to each submodule url is "module.$path.url".
diff --git a/git-submodule.sh b/git-submodule.sh
index a89ea88..e7b6978 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -53,7 +53,7 @@ module_clone()
 }
 
 #
-# Run clone + checkout on missing submodules
+# Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
 #
@@ -62,37 +62,23 @@ modules_init()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		# Skip submodule paths that already contain a .git directory.
-		# This will also trigger if $path is a symlink to a git
-		# repository
-		test -d "$path"/.git && continue
+		# Skip already registered paths
+		url=$(git-config submodule."$path".url)
+		test -z "$url" || continue
 
 		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
 		test -z "$url" &&
 		die "No url found for submodule '$path' in .gitmodules"
 
-		# MAYBE FIXME: this would be the place to check GIT_CONFIG
-		# for a preferred url for this submodule, possibly like this:
-		#
-		# modname=$(GIT_CONFIG=.gitmodules git-config module."$path".name)
-		# alturl=$(git-config module."$modname".url)
-		#
-		# This would let the versioned .gitmodules file use the submodule
-		# path as key, while the unversioned GIT_CONFIG would use the
-		# logical modulename (if present) as key. But this would need
-		# another fallback mechanism if the module wasn't named.
+		git-config submodule."$path".url "$url" ||
+		die "Failed to register url for submodule '$path'"
 
-		module_clone "$path" "$url" || exit $?
-
-		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
-		die "Checkout of submodule '$path' failed"
-
-		say "Submodule '$path' initialized"
+		say "Submodule '$path' registered with url '$url'"
 	done
 }
 
 #
-# Checkout correct revision of each initialized submodule
+# Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
 #
@@ -101,14 +87,21 @@ modules_update()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		if ! test -d "$path"/.git
+		url=$(git-config submodule."$path".url)
+		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
 			say "Submodule '$path' not initialized"
-			continue;
+			continue
 		fi
+
+		if ! test -d "$path"/.git
+		then
+			module_clone "$path" "$url" || exit $?
+		fi
+
 		subsha1=$(unset GIT_DIR && cd "$path" &&
 			git-rev-parse --verify HEAD) ||
 		die "Unable to find current revision of submodule '$path'"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6274729..3940433 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -40,7 +40,7 @@ test_expect_success 'Prepare submodule testing' '
 	git-add a lib z &&
 	git-commit -m "super commit 1" &&
 	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+	GIT_CONFIG=.gitmodules git-config module.lib.url git://example.com/lib.git
 '
 
 test_expect_success 'status should only print one line' '
@@ -52,41 +52,55 @@ test_expect_success 'status should initially be "missing"' '
 	git-submodule status | grep "^-$rev1"
 '
 
-test_expect_success 'init should fail when path is used by a file' '
+test_expect_success 'init should register submodule url in .git/config' '
+	git-submodule init &&
+	url=$(git-config submodule.lib.url) &&
+	if test "$url" != "git://example.com/lib.git"
+	then
+		echo "[OOPS] init succeeded but submodule url is wrong"
+		false
+	elif ! git-config submodule.lib.url ./.subrepo
+	then
+		echo "[OOPS] init succeeded but update of url failed"
+		false
+	fi
+'
+
+test_expect_success 'update should fail when path is used by a file' '
 	echo "hello" >lib &&
-	if git-submodule init
+	if git-submodule update
 	then
-		echo "[OOPS] init should have failed"
+		echo "[OOPS] update should have failed"
 		false
 	elif test -f lib && test "$(cat lib)" != "hello"
 	then
-		echo "[OOPS] init failed but lib file was molested"
+		echo "[OOPS] update failed but lib file was molested"
 		false
 	else
 		rm lib
 	fi
 '
 
-test_expect_success 'init should fail when path is used by a nonempty directory' '
+test_expect_success 'update should fail when path is used by a nonempty directory' '
 	mkdir lib &&
 	echo "hello" >lib/a &&
-	if git-submodule init
+	if git-submodule update
 	then
-		echo "[OOPS] init should have failed"
+		echo "[OOPS] update should have failed"
 		false
 	elif test "$(cat lib/a)" != "hello"
 	then
-		echo "[OOPS] init failed but lib/a was molested"
+		echo "[OOPS] update failed but lib/a was molested"
 		false
 	else
 		rm lib/a
 	fi
 '
 
-test_expect_success 'init should work when path is an empty dir' '
+test_expect_success 'update should work when path is an empty dir' '
 	rm -rf lib &&
 	mkdir lib &&
-	git-submodule init &&
+	git-submodule update &&
 	head=$(cd lib && git-rev-parse HEAD) &&
 	if test -z "$head"
 	then
@@ -99,7 +113,7 @@ test_expect_success 'init should work when path is an empty dir' '
 	fi
 '
 
-test_expect_success 'status should be "up-to-date" after init' '
+test_expect_success 'status should be "up-to-date" after update' '
 	git-submodule status | grep "^ $rev1"
 '
 
-- 
1.5.2.841.gc9eafb
