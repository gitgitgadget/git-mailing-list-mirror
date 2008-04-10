From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC 6/7] git-submodule: Don't die when command fails for one submodule
Date: Thu, 10 Apr 2008 23:50:24 +0800
Message-ID: <1207842625-9210-10-git-send-email-pkufranky@gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-8-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-9-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz4a-0005Y2-B7
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbYDJPun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757370AbYDJPul
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:41 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37793 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756704AbYDJPub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:31 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 0683D470B9; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207842625-9210-9-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79229>

When handling multiple modules, init/update/status/add subcommand will
exit when it fails for one submodule. This patch makes the subcommand
continue bypassing the failure and keep right exit status.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   87 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f1c164c..b4db676 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -193,15 +193,19 @@ module_clone()
 	# succeed but the rmdir will fail. We might want to fix this.
 	if test -d "$path"
 	then
-		rmdir "$path" 2>/dev/null ||
-		die "Directory '$path' exist, but is neither empty nor a git repository"
+		! rmdir "$path" 2>/dev/null &&
+		say "Directory '$path' exist, but is neither empty nor a git repository" &&
+		return 1
 	fi
 
 	test -e "$path" &&
-	die "A file already exist at path '$path'"
+	say "A file already exist at path '$path'" &&
+	return 1
 
-	git-clone -n "$url" "$path" ||
-	die "Clone of '$url' into submodule path '$path' failed"
+	! git-clone -n "$url" "$path" &&
+	say "Clone of '$url' into submodule path '$path' failed" &&
+	return 1
+	:
 }
 
 #
@@ -227,7 +231,8 @@ module_add() {
 	fi
 
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "'$path' already exists in the index"
+	say "'$path' already exists in the index" &&
+	return 1
 
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$path"
@@ -237,21 +242,26 @@ module_add() {
 		then
 			echo "Adding existing repo at '$path' to the index"
 		else
-			die "'$path' already exists and is not a valid git repo"
+			say "'$path' already exists and is not a valid git repo"
+			return 1
 		fi
 	else
-		module_clone "$path" "$repo" || exit
-		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
-		die "Unable to checkout submodule '$path'"
+		module_clone "$path" "$repo" || return 1
+		! (unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) &&
+		say "Unable to checkout submodule '$path'" &&
+		return 1
 	fi
 
-	git add "$path" ||
-	die "Failed to add submodule '$path'"
+	! git add "$path" &&
+	say "Failed to add submodule '$path'" &&
+	return 1
 
 	GIT_CONFIG=.gitmodules git config submodule."$path".path "$path" &&
 	GIT_CONFIG=.gitmodules git config submodule."$path".url "$repo" &&
-	git add .gitmodules ||
-	die "Failed to register submodule '$path'"
+	! git add .gitmodules &&
+	say "Failed to register submodule '$path'" &&
+	return 1
+	:
 }
 
 #
@@ -292,14 +302,17 @@ cmd_add()
 	if test -n "$use_module_name"
 	then
 		module_info "$@" |
+		{
+		exit_status=0
 		while read sha1 path name url
 		do
-			module_add "$url" "$path"
+			module_add "$url" "$path" || exit_status=1
 		done
+		test $exit_status = 0
+		}
 	else
 		module_add "$1" "$2"
 	fi
-
 }
 
 #
@@ -331,20 +344,30 @@ cmd_init()
 	done
 
 	module_info "$@" |
+	{
+	exit_status=0
 	while read sha1 path name url
 	do
-		test -n "$name" || exit
+		test -z "$name" && exit_status=1 && continue
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		say "No url found for submodule path '$path' in .gitmodules" &&
+		exit_status=1 &&
+		continue
 		# Skip already registered paths
 		git config submodule.$name.url && continue
 
 		url=$(absolute_url "$url")
 		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
+		{
+		say "Failed to register url for submodule path '$path'"
+		exit_status=1
+		continue
+		}
 
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
+	exit $exit_status
+	}
 }
 
 #
@@ -376,9 +399,11 @@ cmd_update()
 	done
 
 	module_info "$@" |
+	{
+	exit_status=0
 	while read sha1 path name url
 	do
-		test -n "$name" || exit
+		test -z "$name" && exit_status=1 && continue
 		if test $sha1 = 0000000000000000000000000000000000000000
 		then
 			say "Not a submodule: $name @ $path"
@@ -394,23 +419,33 @@ cmd_update()
 
 		if ! test -d "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			! module_clone "$path" "$url" && exit_status=1 && continue
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
 				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			{
+				say "Unable to find current revision in submodule path '$path'"
+				exit_status=1
+				continue
+			}
 		fi
 
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR; cd "$path" && git-fetch &&
 				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			{
+				say "Unable to checkout '$sha1' in submodule path '$path'"
+				exit_status=1
+				continue
+			}
 
 			say "Submodule path '$path': checked out '$sha1'"
 		fi
 	done
+	exit $exit_status
+	}
 }
 
 set_name_rev () {
@@ -629,9 +664,11 @@ cmd_status()
 		shift
 	done
 	module_info "$@" |
+	{
+	exit_status=0
 	while read sha1 path name url
 	do
-		test -n "$name" || exit
+		test -z "$name" && exit_status=1 && continue
 		if test $sha1 = 0000000000000000000000000000000000000000
 		then
 			say "*$sha1 $path"
@@ -654,6 +691,8 @@ cmd_status()
 			say "+$sha1 $path$revname"
 		fi
 	done
+	exit $exit_status
+	}
 }
 
 # This loop parses the command line arguments to find the
-- 
1.5.5.23.g2a5f
