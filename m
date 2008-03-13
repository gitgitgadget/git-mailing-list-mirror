From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 3/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Fri, 14 Mar 2008 01:56:37 +0800
Message-ID: <1205431001-18590-4-git-send-email-pkufranky@gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhB-0002de-GY
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYCMR4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbYCMR4s
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:48 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43768 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757097AbYCMR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:44 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 4B950470B0; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77114>

Extract function absolute_url to remove code redundant and inconsistence in
cmd_init and cmd_add when resolving relative url/path to absolute one.

Also move resolving absolute url logic from cmd_add to module_clone which
results in a litte behaviour change: cmd_update originally doesn't
resolve absolute url but now it will.

This behaviour change breaks t7400 which uses relative url './.subrepo'.
However, this test originally doesn't mean to test relative url, so fix
the url as '.subrepo'.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh           |   41 ++++++++++++++++++-----------------------
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7545d1a..0e14078 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -65,6 +65,21 @@ resolve_relative_url ()
 	echo "$remoteurl/$url"
 }
 
+# Resolve relative url/path to absolute one
+absolute_url () {
+	case "$1" in
+	./*|../*)
+		# dereference source url relative to parent's url
+		url="$(resolve_relative_url $1)" ;;
+	*)
+		# Turn the source into an absolute path if it is local
+		url=$(get_repo_base "$1") ||
+		url=$1
+		;;
+	esac
+	echo "$url"
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -112,7 +127,7 @@ module_info() {
 module_clone()
 {
 	path=$1
-	url=$2
+	url=$(absolute_url "$2")
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -195,21 +210,7 @@ cmd_add()
 			die "'$path' already exists and is not a valid git repo"
 		fi
 	else
-		case "$repo" in
-		./*|../*)
-			# dereference source url relative to parent's url
-			realrepo="$(resolve_relative_url $repo)" ;;
-		*)
-			# Turn the source into an absolute path if
-			# it is local
-			if base=$(get_repo_base "$repo"); then
-				repo="$base"
-			fi
-			realrepo=$repo
-			;;
-		esac
-
-		module_clone "$path" "$realrepo" || exit
+		module_clone "$path" "$repo" || exit
 		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 		die "Unable to checkout submodule '$path'"
 	fi
@@ -262,13 +263,7 @@ cmd_init()
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
 
-		# Possibly a url relative to parent
-		case "$url" in
-		./*|../*)
-			url="$(resolve_relative_url "$url")"
-			;;
-		esac
-
+		url=$(absolute_url "$url")
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2ef85a8..e5d59b8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -75,7 +75,7 @@ test_expect_success 'init should register submodule url in .git/config' '
 	then
 		echo "[OOPS] init succeeded but submodule url is wrong"
 		false
-	elif ! git config submodule.example.url ./.subrepo
+	elif ! git config submodule.example.url .subrepo
 	then
 		echo "[OOPS] init succeeded but update of url failed"
 		false
-- 
1.5.4.4.653.g7cf1e
