From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: Don't die when command fails for one submodule
Date: Tue,  4 Mar 2008 22:35:14 +0800
Message-ID: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 04 15:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYFO-0005Gt-UY
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYCDOfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbYCDOfU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:35:20 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43926 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751824AbYCDOfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:35:19 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 956F8470AE; Tue,  4 Mar 2008 22:35:14 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76090>

When handling multiple modules, init/update/status command will exit
when it fails for one submodule. This patch makes the command continue
bypassing the failure.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   51 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 67d3224..2d1639c 100755
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
@@ -224,13 +227,14 @@ cmd_init()
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
-		name=$(module_name "$path") || exit
+		name=$(module_name "$path") || continue
 		url=$(git config submodule."$name".url)
 		test -z "$url" || continue
 
 		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		say "No url found for submodule path '$path' in .gitmodules" &&
+		continue
 
 		# Possibly a url relative to parent
 		case "$url" in
@@ -239,10 +243,13 @@ cmd_init()
 			;;
 		esac
 
-		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
+		if git config submodule."$name".url "$url"
+		then
+			say "Submodule '$name' ($url) registered for path '$path'"
+		else
+			say "Failed to register url for submodule path '$path'"
+		fi
 
-		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
 
@@ -277,7 +284,7 @@ cmd_update()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		name=$(module_name "$path") || exit
+		name=$(module_name "$path") || continue
 		url=$(git config submodule."$name".url)
 		if test -z "$url"
 		then
@@ -290,21 +297,25 @@ cmd_update()
 
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
+			if (unset GIT_DIR; cd "$path" && git-fetch &&
+				git-checkout -q "$sha1")
+			then
+				say "Submodule path '$path': checked out '$sha1'"
+			else
+				say "Unable to checkout '$sha1' in submodule path '$path'"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
 		fi
 	done
 }
@@ -360,7 +371,7 @@ cmd_status()
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
-		name=$(module_name "$path") || exit
+		name=$(module_name "$path") || continue
 		url=$(git config submodule."$name".url)
 		if test -z "$url" || ! test -d "$path"/.git
 		then
-- 
1.5.4.3.347.g5314c

