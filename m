From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Wed, 16 Apr 2008 22:19:32 +0800
Message-ID: <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:30:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8VM-00050Q-Dl
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbYDPOUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbYDPOTq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:19:46 -0400
Received: from mail.qikoo.org ([60.28.205.235]:52424 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754548AbYDPOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:19:42 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 182E3470AF; Wed, 16 Apr 2008 22:19:37 +0800 (CST)
X-Mailer: git-send-email 1.5.5.70.gd68a
In-Reply-To: <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79704>

Extract function absolute_url to remove code redundance and inconsistence in
cmd_init and cmd_add when resolving relative url/path to absolute one.

Also move resolving absolute url logic from cmd_add to module_clone which
results in a litte behaviour change: cmd_update originally doesn't
resolve absolute url but now it will.

This behaviour change breaks t7400 which uses relative url './.subrepo'.
However, this test originally doesn't mean to test relative url with './',
so fix the url as '.subrepo'.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh           |   41 ++++++++++++++++++-----------------------
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0d82ec1..d3ae1e4 100755
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
1.5.5.70.gd68a
