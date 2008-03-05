From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2] git-submodule: Don't die when command fails for one submodule
Date: Wed,  5 Mar 2008 23:21:18 +0800
Message-ID: <1204730478-22027-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 16:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvRU-00018C-IH
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYCEPV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYCEPV0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:21:26 -0500
Received: from mail.qikoo.org ([60.28.205.235]:46233 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752789AbYCEPVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 10:21:25 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 45F1E470AE; Wed,  5 Mar 2008 23:21:18 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76228>

When handling multiple modules, init/update/status command will exit
when it fails for one submodule. This patch makes the command continue
bypassing the failure and keep right exit status.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |  110 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 67d3224..3ad7214 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -100,15 +100,18 @@ module_clone()
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
 }
 
 #
@@ -156,7 +159,7 @@ cmd_add()
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
-		realrepo="$(resolve_relative_url $repo)" ;;
+		realrepo="$(resolve_relative_url $repo)" || return 1 ;;
 	*)
 		# Turn the source into an absolute path if
 		# it is local
@@ -175,21 +178,26 @@ cmd_add()
 	fi
 
 	test -e "$path" &&
-	die "'$path' already exists"
+	say "'$path' already exists" &&
+	return 1
 
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "'$path' already exists in the index"
+	say "'$path' already exists in the index" &&
+	return 1
 
-	module_clone "$path" "$realrepo" || exit
-	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
-	die "Unable to checkout submodule '$path'"
-	git add "$path" ||
-	die "Failed to add submodule '$path'"
+	module_clone "$path" "$realrepo" || return 1
+	! (unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) &&
+	say "Unable to checkout submodule '$path'" &&
+	return 1
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
 }
 
 #
@@ -221,29 +229,40 @@ cmd_init()
 	done
 
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	{
+	total=0
+	success=0
 	while read mode sha1 stage path
 	do
+		total=$(( $total + 1 ))
 		# Skip already registered paths
-		name=$(module_name "$path") || exit
+		name=$(module_name "$path") || continue
 		url=$(git config submodule."$name".url)
-		test -z "$url" || continue
+		test -n "$url" && success=$(( $success + 1 )) && continue
 
 		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		say "No url found for submodule path '$path' in .gitmodules" &&
+		continue
 
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url="$(resolve_relative_url "$url")"
+			url="$(resolve_relative_url "$url")" || continue
 			;;
 		esac
 
-		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
-
-		say "Submodule '$name' ($url) registered for path '$path'"
+		if git config submodule."$name".url "$url"
+		then
+			say "Submodule '$name' ($url) registered for path '$path'"
+		else
+			say "Failed to register url for submodule path '$path'"
+			continue
+		fi
+		success=$(( $success + 1 ))
 	done
+	test $success = $total
+	}
 }
 
 #
@@ -275,38 +294,53 @@ cmd_update()
 	done
 
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	{
+	total=0
+	success=0
 	while read mode sha1 stage path
 	do
-		name=$(module_name "$path") || exit
+		total=$(( $total + 1 ))
+		name=$(module_name "$path") || continue
 		url=$(git config submodule."$name".url)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
-			test "$#" != "0" &&
-			say "Submodule path '$path' not initialized"
+			if test "$#" != "0"
+			then
+				say "Submodule path '$path' not initialized"
+			else
+				success=$(( $success + 1 ))
+			fi
 			continue
 		fi
 
 		if ! test -d "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" || continue
 			subsha1=
 		else
-			subsha1=$(unset GIT_DIR; cd "$path" &&
-				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			! subsha1=$(unset GIT_DIR; cd "$path" &&
+				git rev-parse --verify HEAD 2>/dev/null) &&
+			say "Unable to find current revision in submodule path '$path'" &&
+			continue
 		fi
 
 		if test "$subsha1" != "$sha1"
 		then
-			(unset GIT_DIR; cd "$path" && git-fetch &&
-				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
-
-			say "Submodule path '$path': checked out '$sha1'"
+			if (unset GIT_DIR; cd "$path" && git-fetch &&
+				git-checkout -q "$sha1")
+			then
+				say "Submodule path '$path': checked out '$sha1'"
+			else
+				say "Unable to checkout '$sha1' in submodule path '$path'"
+				continue
+			fi
 		fi
+		success=$(( $success + 1 ))
 	done
+	test $success = $total
+	}
 }
 
 set_name_rev () {
@@ -358,9 +392,11 @@ cmd_status()
 	done
 
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	{
+	exit_status=0
 	while read mode sha1 stage path
 	do
-		name=$(module_name "$path") || exit
+		! name=$(module_name "$path") && exit_status=1 && continue
 		url=$(git config submodule."$name".url)
 		if test -z "$url" || ! test -d "$path"/.git
 		then
@@ -380,6 +416,8 @@ cmd_status()
 			say "+$sha1 $path$revname"
 		fi
 	done
+	exit $exit_status
+	}
 }
 
 # This loop parses the command line arguments to find the
-- 
1.5.4.3.347.g5314c

