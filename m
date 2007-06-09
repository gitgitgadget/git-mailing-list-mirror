From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/3] git-submodule: allow submodule name and path to differ
Date: Sat,  9 Jun 2007 23:38:50 +0200
Message-ID: <1181425132294-git-send-email-hjemli@gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8bz-00008j-Ln
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXFIVg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756701AbXFIVg3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:36:29 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:53427 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756362AbXFIVg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:36:28 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l59LaKTf006815;
	Sat, 9 Jun 2007 23:36:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <1181425132239-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49621>

This teaches git-submodule to check module.*.path when looking for the
config for a submodule path. If no match is found it falls back to the
current behaviour (module.$path).

With this change a submodule can be checked out at different paths in
different revisions of the superproject without changing the submodule
properties in .git/config.

While at it, add a new testscript for named submodules. This is basically
the same tests as can be found in t7400, but modified for a submodule
with name != path.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-submodule.txt                    |   16 ++++---
 git-submodule.sh                                   |   44 +++++++++++++------
 ...submodule-basic.sh => t7401-submodule-named.sh} |   27 ++++++++----
 3 files changed, 59 insertions(+), 28 deletions(-)
 copy t/{t7400-submodule-basic.sh => t7401-submodule-named.sh} (82%)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f8fb80f..176e16d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -24,8 +24,8 @@ status::
 
 init::
 	Initialize the submodules, i.e. register in .git/config each submodule
-	path and url found in .gitmodules. The key used in git/config is
-	`submodule.$path.url`. This command does not alter existing information
+	name and url found in .gitmodules. The key used in git/config is
+	`submodule.$name.url`. This command does not alter existing information
 	in .git/config.
 
 update::
@@ -50,11 +50,15 @@ OPTIONS
 
 FILES
 -----
-When initializing submodules, a .gitmodules file in the top-level directory
-of the containing repository is used to find the url of each submodule.
-This file should be formatted in the same way as $GIR_DIR/config. The key
-to each submodule url is "module.$path.url".
+The .gitmodules file in the top-level directory of the containing repository
+is used to map submodule path to submodule name. The map consist of keys
+named `module.$name.path` with a value matching the path found in the index of
+the containing repository. If no such key is found for a specific path, the
+submodule path is used as submodule name.
 
+During `git-submodule init` the url for each submodule is registered in
+.git/config of the containing repository. The url is located under the key
+`module.$name.url` in .gitmodules.
 
 AUTHOR
 ------
diff --git a/git-submodule.sh b/git-submodule.sh
index 8bdd99a..d9f0c91 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -25,6 +25,18 @@ say()
 	fi
 }
 
+#
+# Resolve submodule name from path, use path as name if no mapping exist
+#
+# $1 = path
+#
+module_name()
+{
+	name=$(GIT_CONFIG=.gitmodules git-config --get-regexp '^module\..*\.path$' "$1" |
+		sed -nre 's/^module\.(.+)\.path .+$/\1/p')
+	test -z "$name" && name="$1"
+	echo $name
+}
 
 #
 # Clone a submodule
@@ -62,18 +74,19 @@ modules_init()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		# Skip already registered paths
-		url=$(git-config submodule."$path".url)
+		# Skip already registered submodules
+		name=$(module_name "$path")
+		url=$(git-config submodule."$name".url)
 		test -z "$url" || continue
 
-		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
+		url=$(GIT_CONFIG=.gitmodules git-config module."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule '$path' in .gitmodules"
+		die "No url found for submodule '$name', path '$path' in .gitmodules"
 
-		git-config submodule."$path".url "$url" ||
-		die "Failed to register url for submodule '$path'"
+		git-config submodule."$name".url "$url" ||
+		die "Failed to register url for submodule '$name', path '$path'"
 
-		say "Submodule '$path' registered with url '$url'"
+		say "Submodule '$name', path '$path' registered with url '$url'"
 	done
 }
 
@@ -87,13 +100,14 @@ modules_update()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		url=$(git-config submodule."$path".url)
+		name=$(module_name "$path")
+		url=$(git-config submodule."$name".url)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "Submodule '$path' not initialized"
+			say "Submodule '$name', path '$path' not initialized"
 			continue
 		fi
 
@@ -104,15 +118,15 @@ modules_update()
 
 		subsha1=$(unset GIT_DIR && cd "$path" &&
 			git-rev-parse --verify HEAD) ||
-		die "Unable to find current revision of submodule '$path'"
+		die "Unable to find current revision of submodule '$name', path '$path'"
 
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR && cd "$path" && git-fetch &&
 				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule '$path'"
+			die "Unable to checkout '$sha1' in submodule '$name', path '$path'"
 
-			say "Submodule '$path': checked out '$sha1'"
+			say "Submodule '$name', path '$path': checked out '$sha1'"
 		fi
 	done
 }
@@ -132,10 +146,12 @@ modules_list()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		if ! test -d "$path"/.git
+		name=$(module_name "$path")
+		url=$(git-config submodule."$name".url)
+		if test -z "$url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
-			continue;
+			continue
 		fi
 		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
 		if git diff-files --quiet -- "$path"
diff --git a/t/t7400-submodule-basic.sh b/t/t7401-submodule-named.sh
similarity index 82%
copy from t/t7400-submodule-basic.sh
copy to t/t7401-submodule-named.sh
index 3940433..3c3d195 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7401-submodule-named.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2007 Lars Hjemli
 #
 
-test_description='Basic porcelain support for submodules
+test_description='Basic porcelain support for named submodules
 
 This test tries to verify basic sanity of the init, update and status
-subcommands of git-submodule.
+subcommands of git-submodule when a submodule name differs from its path.
 '
 
 . ./test-lib.sh
@@ -18,7 +18,7 @@ subcommands of git-submodule.
 #  -add directory lib to 'superproject', this creates a DIRLINK entry
 #  -add a couple of regular files to enable testing of submodule filtering
 #  -mv lib subrepo
-#  -add an entry to .gitmodules for path 'lib'
+#  -add an entry to .gitmodules for submodule 'foo'
 #
 test_expect_success 'Prepare submodule testing' '
 	mkdir lib &&
@@ -40,7 +40,7 @@ test_expect_success 'Prepare submodule testing' '
 	git-add a lib z &&
 	git-commit -m "super commit 1" &&
 	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config module.lib.url git://example.com/lib.git
+	GIT_CONFIG=.gitmodules git-config module.foo.url git://example.com/libfoo.git
 '
 
 test_expect_success 'status should only print one line' '
@@ -52,14 +52,25 @@ test_expect_success 'status should initially be "missing"' '
 	git-submodule status | grep "^-$rev1"
 '
 
+test_expect_success 'init should fail when map from path to name is missing' '
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif ! GIT_CONFIG=.gitmodules git-config module.foo.path lib
+	then
+		echo "[OOPS] init failed but so did git-config"
+	fi
+'
+
 test_expect_success 'init should register submodule url in .git/config' '
 	git-submodule init &&
-	url=$(git-config submodule.lib.url) &&
-	if test "$url" != "git://example.com/lib.git"
+	url=$(git-config submodule.foo.url) &&
+	if test "$url" != "git://example.com/libfoo.git"
 	then
 		echo "[OOPS] init succeeded but submodule url is wrong"
 		false
-	elif ! git-config submodule.lib.url ./.subrepo
+	elif ! git-config submodule.foo.url ./.subrepo
 	then
 		echo "[OOPS] init succeeded but update of url failed"
 		false
@@ -72,7 +83,7 @@ test_expect_success 'update should fail when path is used by a file' '
 	then
 		echo "[OOPS] update should have failed"
 		false
-	elif test -f lib && test "$(cat lib)" != "hello"
+	elif test "$(cat lib)" != "hello"
 	then
 		echo "[OOPS] update failed but lib file was molested"
 		false
-- 
1.5.2.1.914.gbd3a7
