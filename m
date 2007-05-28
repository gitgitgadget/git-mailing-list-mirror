From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Let .git/config specify the url for submodules
Date: Mon, 28 May 2007 22:51:23 +0200
Message-ID: <1180385483418-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 22:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsm9Y-0006jA-Oh
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXE1UtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXE1UtN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:49:13 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:62326 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbXE1UtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:49:12 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id l4SKn8Jp020586;
	Mon, 28 May 2007 22:49:08 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.74.g6b2d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48643>

This changes git-submodule in a few ways:
a. Section names in .gitmodules are now called 'path', not 'module'.
b. Each 'path' section is required to have a 'submodule' key, used to
   give the submodule a name.
c. During 'git-submodule init', the submodule name and url is found in
   .gitmodules and stored in .git/config under the key 'submodule.$name.url'.
   The 'init' command does not clone the submodule.
d. A new git-submodule command, 'clone', will map submodule path to submodule
   name in .gitmodules and use the name to find a url for the submodule in
   .git/config. This url is then used to clone the submodule before checking
   out the commit named in the index of the containing repository.

The main reason for these changes is to make it easier to specify alternate
urls for a submodule without touching .gitmodules, i.e. like this:

  $ git submodule init
  $ git config submodule.foobar.url /pub/git/foobar.git
  $ git submodule clone

It also might turn out to be nice to have submodules identified by a 'logical
name' instead of by path when a single path is used for different submodules
in different versions of a 'superproject', and if/when the submodules gets
cloned somewhere below .git of the containing repository.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This is on top of my previous 'submodule test-script' patch (which was on top
of 'next', sorry for not mentioning this in the mail).


 Documentation/git-submodule.txt |   36 ++++++++-----
 git-submodule.sh                |  109 ++++++++++++++++++++++++++++-----------
 t/t7400-submodule-basic.sh      |   69 ++++++++++++++++--------
 3 files changed, 148 insertions(+), 66 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cb0424f..c93e40f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -8,7 +8,7 @@ git-submodule - Initialize, update or inspect submodules
 
 SYNOPSIS
 --------
-'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
+'git-submodule' [--quiet] [--cached] [status|init|clone|update] [--] [<path>...]
 
 
 COMMANDS
@@ -16,22 +16,25 @@ COMMANDS
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
-	submodule path and the output of gitlink:git-describe[1] for the
-	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized and `+` if the currently checked out submodule commit
+	submodule name, path and the output of gitlink:git-describe[1] for
+	the SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is
+	not initialized and `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
 	repository. This command is the default command for git-submodule.
 
 init::
-	Initialize the submodules, i.e. clone the git repositories specified
-	in the .gitmodules file and checkout the submodule commits specified
-	in the index of the containing repository. This will make the
-	submodules HEAD be detached.
+	Initialize the submodules, i.e. register the submodules and their
+	suggested urls in $GIT_DIR/config of the containing repository.
+
+clone::
+	Clone the initialized git repositories and checkout the submodule
+	commits specified in the index of the containing repository. This
+	will make the submodule HEADs be detached.
 
 update::
 	Update the initialized submodules, i.e. checkout the submodule commits
 	specified in the index of the containing repository. This will make
-	the submodules HEAD be detached.
+	the submodule HEADs be detached.
 
 
 OPTIONS
@@ -48,18 +51,25 @@ OPTIONS
 	Path to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
 
+
 FILES
 -----
-When cloning submodules, a .gitmodules file in the top-level directory
-of the containing repository is used to find the url of each submodule.
-This file should be formatted in the same way as $GIR_DIR/config. The key
-to each submodule url is "module.$path.url".
+git-submodule uses a file named .gitmodules in the top-level directory of the
+containing repository. This file should be formatted in the same way as
+$GIR_DIR/config.
+
+The .gitmodules file is used to find the name and suggested url for each
+submodule path, using the keys `path.$path.submodule` and 'path.$path.url'.
+The submodule name and url is stored in $GIT_DIR/config by
+`git-submodule init`, using the key `submodule.$name.url`, and this key is
+then used during `git-submodule clone` to lookup the preferred submodule url.
 
 
 AUTHOR
 ------
 Written by Lars Hjemli <hjemli@gmail.com>
 
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/git-submodule.sh b/git-submodule.sh
index 6ed5a6c..31de80e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,11 +4,12 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [status|init|clone|update] [--] [<path>...]'
 . git-sh-setup
 require_work_tree
 
 init=
+clone=
 update=
 status=
 quiet=
@@ -26,7 +27,7 @@ say()
 }
 
 #
-# Run clone + checkout on missing submodules
+# Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
 #
@@ -35,9 +36,56 @@ modules_init()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
+		# Get the submodule name for this path
+		name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
+		test -z "$name" && die "Unnamed submodule at path '$path'"
+
+		# Skip registered submodules
+		url=$(git-config submodule."$name".url)
+		test -z "$url" || continue
+
+		# find suggested url in .gitmodules
+		url=$(GIT_CONFIG=.gitmodules git-config path."$path".url)
+		test -z "$url" &&
+		die "No url found for submodule '$name' (path '$path') in .gitmodules"
+
+		# Save the url in local config, indicating that this
+		# submodule is now registered (and enabling the user to
+		# override the url before running 'git submodule clone'
+		git-config submodule."$name".url "$url" ||
+		die "Failed to register url '$url' for submodule '$name'"
+
+		say "Submodule '$name' registered for path '$path', using url '$url'"
+	done
+}
+
+#
+# Run clone + checkout on missing submodules
+#
+# $@ = requested paths (default to all)
+#
+modules_clone()
+{
+	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		# Get the submodule name for this path
+		name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
+		test -z "$name" && die "Unnamed submodule at path '$path'"
+
+		# Get the url for the module from local config
+		url=$(git-config submodule."$name".url)
+		if test -z "$url"
+		then
+			# If this path was specified on the command line,
+			# make sure the user gets a proper errormessage.
+			test "$#" != "$0" &&
+			die "Submodule '$name' (path '$path') not initialized"
+
+			continue
+		fi
+
 		# Skip submodule paths that already contain a .git directory.
-		# This will also trigger if $path is a symlink to a git
-		# repository
 		test -d "$path"/.git && continue
 
 		# If there already is a directory at the submodule path,
@@ -54,28 +102,17 @@ modules_init()
 		test -e "$path" &&
 		die "A file already exist at path '$path'"
 
-		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
-		test -z "$url" &&
-		die "No url found for submodule '$path' in .gitmodules"
-
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
+		# Use the submodule name to find the preferred url in local config
+		url=$(git-config submodule."$name".url)
+		test -z "$url" && die "No url found for submodule '$name' (path '$path')"
 
 		git-clone -n "$url" "$path" ||
-		die "Clone of submodule '$path' failed"
+		die "Clone of submodule '$name' (path '$path') failed"
 
 		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
-		die "Checkout of submodule '$path' failed"
+		die "Checkout of '$sha1' in submodule '$name' (path '$path') failed"
 
-		say "Submodule '$path' initialized"
+		say "Submodule '$name' (path '$path') cloned and checked out"
 	done
 }
 
@@ -94,27 +131,33 @@ modules_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "Submodule '$path' not initialized"
+			say "Submodule in directory '$path' not initialized"
 			continue;
 		fi
+
+		# Get the module name for this path
+		name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
+		test -z "$name" && die "Unnamed submodule at path '$path'"
+
+		# Get the SHA-1 of the submodule HEAD
 		subsha1=$(unset GIT_DIR && cd "$path" &&
 			git-rev-parse --verify HEAD) ||
-		die "Unable to find current revision of submodule '$path'"
+		die "Unable to find current revision of submodule '$module' (path '$path')"
 
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR && cd "$path" && git-fetch &&
 				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule '$path'"
+			die "Unable to checkout '$sha1' for submodule '$name' (path '$path')"
 
-			say "Submodule '$path': checked out '$sha1'"
+			say "Submodule '$name' (path '$path'): checked out '$sha1'"
 		fi
 	done
 }
 
 #
 # List all registered submodules, prefixed with:
-#  - submodule not initialized
+#  - submodule not initialized or cloned
 #  + different revision checked out
 #
 # If --cached was specified the revision in the index will be printed
@@ -153,6 +196,9 @@ do
 	init)
 		init=1
 		;;
+	clone)
+		clone=1
+		;;
 	update)
 		update=1
 		;;
@@ -178,14 +224,17 @@ do
 	shift
 done
 
-case "$init,$update,$status,$cached" in
-1,,,)
+case "$init,$clone,$update,$status,$cached" in
+1,,,,)
 	modules_init "$@"
 	;;
-,1,,)
+,1,,,)
+	modules_clone "$@"
+	;;
+,,1,,)
 	modules_update "$@"
 	;;
-,,*,*)
+,,,*,*)
 	modules_list "$@"
 	;;
 *)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a023c87..234f940 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -5,8 +5,8 @@
 
 test_description='Basic submodule support in porcelain
 
-This test tries to run the init, update and status commands of git-submodule
-with a known good setup (and two known bad)
+This test tries to verify basic sanity of the init, clone, update and
+status commands of git-submodule.
 '
 
 . ./test-lib.sh
@@ -24,32 +24,57 @@ cd ..
 echo a >a && echo z >z
 git-add a lib z && git-commit -q -m "super commit 1"
 
-# move submodule to another location, register repo url in .gitmodules
+# move submodule to another location
 mv lib .subrepo
-GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+
+# register a broken url in .gitmodules
+GIT_CONFIG=.gitmodules git-config path.lib.url ./broken
 
 test_expect_success 'status is "missing"' \
 	'git-submodule status | grep "^-$rev1"'
 
-# make sure 'init' will not overwrite a regular file
-touch lib
-test_expect_failure 'init fails when path is used by a file' \
+# 'init' should fail, since the submodule is unnamed in .gitmodules
+test_expect_failure 'do not initialize unnamed submodules' \
 	'git-submodule init'
 
-# make sure 'init' will not overwrite a nonempty directory
+# give the submodule a logical name
+GIT_CONFIG=.gitmodules git-config path.lib.submodule thelib
+test_expect_success 'init should register the submodule in .git/config' '
+	git-submodule init &&
+	url=$(git-config submodule.thelib.url) &&
+	test "$url" = "./broken"
+'
+
+# specify correct url in local config
+git-config submodule.thelib.url ./.subrepo
+
+# make sure 'clone' will not overwrite a regular file
+touch lib
+test_expect_failure 'clone fails when path is used by a file' \
+	'git-submodule clone'
+
+test_expect_success 'the annoying file is preserved' \
+	'test -f lib'
+
+# make sure 'clone' will not overwrite a nonempty directory
 rm lib
 mkdir -p lib/foo
-test_expect_failure 'init fails when path is used by a nonempty directory' \
-	'git-submodule init'
+test_expect_failure 'clone fails when path is used by a nonempty directory' \
+	'git-submodule clone'
 
-# turn lib into an empty directory, just like git-checkout would do
+test_expect_success 'the annoying directory is preserved' \
+	'test -d lib/foo'
+
+# make lib be an empty directory, just like git-checkout would have done
 rmdir lib/foo
-test_expect_success 'init works when path is an empty dir' \
-	'git-submodule init && test -d lib/.git && git-diff --exit-code'
 
-head=$(cd lib && git-rev-parse HEAD)
-test_expect_success 'submodule HEAD should match rev1' \
-	'test "$head" = "$rev1"'
+test_expect_success 'clone into empty directory should work' \
+	'git-submodule clone'
+
+test_expect_success 'submodule HEAD should match rev1' '
+	head=$(cd lib && git-rev-parse HEAD) &&
+	test "$head" = "$rev1"
+'
 
 test_expect_success 'status is "up-to-date" after init' \
 	'git-submodule status | grep "^ $rev1"'
@@ -66,15 +91,13 @@ test_expect_success 'status is "modified" after submodule commit' \
 test_expect_success 'the --cached sha1 should be rev1' \
 	'git-submodule --cached status | grep "^\+$rev1"'
 
-test_expect_failure 'git-diff --exit-code reports local modifications' \
-	'git-diff --exit-code'
-
-test_expect_success 'update should checkout the correct commit' \
+test_expect_success 'after update, there should be no local modifications' \
 	'git-submodule update && git-diff --exit-code'
 
-head=$(cd lib && git-rev-parse HEAD)
-test_expect_success 'submodule HEAD should match rev1' \
-	'test "$head" = "$rev1"'
+test_expect_success 'submodule HEAD should match rev1' '
+	head=$(cd lib && git-rev-parse HEAD) &&
+	test "$head" = "$rev1"
+'
 
 test_expect_success 'status is "up-to-date" after update' \
 	'git-submodule status | grep "^ $rev1"'
-- 
1.5.2.74.g6b2d
