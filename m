From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-submodule - allow a relative path as the subproject url
Date: Sun, 23 Sep 2007 22:19:42 -0400
Message-ID: <1190600382-1648-1-git-send-email-mdl123@verizon.net>
References: <11904936042891-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 04:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZdY8-0006HB-8G
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 04:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbXIXCTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbXIXCTq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 22:19:46 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:53346 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXIXCTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 22:19:45 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.132.29])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JOU00GRVP4WX4Y6@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 23 Sep 2007 21:19:45 -0500 (CDT)
In-reply-to: <11904936042891-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.3.2.9.g69b29
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59012>

This allows a subproject's location to be specified and stored as relative
to the parent project's location (e.g., ./foo, or ../foo). This url is
stored in .gitmodules as given. It is resolved into an absolute url by
appending it to the parent project's url when the information is written
to .git/config (i.e., during submodule add for the originator, and
submodule init for a downstream recipient). This allows cloning of the
project to work "as expected" if the project is hosted on a different
server than when the subprojects were added.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
This patch is slightly improved as it removes embedded ./ and ../ sequences
from the url constructed from a base and relative part. It also avoids use
of git-branch in favor of git-symbolic-ref.

 Documentation/git-submodule.txt |    3 ++
 git-submodule.sh                |   53 ++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c48936..d421677 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -21,6 +21,9 @@ add::
 	repository is cloned at the specified path, added to the
 	changeset and registered in .gitmodules.   If no path is
 	specified, the path is deduced from the repository specification.
+        If the repository url begins with ./ or ../, it is stored as
+        given but resolved as a relative path from the main project's
+        url when cloning.

 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 3320998..5bf4551 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -39,6 +39,32 @@ get_repo_base() {
 	) 2>/dev/null
 }

+# Resolve relative url by appending to parent's url
+resolve_relative_url ()
+{
+	branch="$(git symbolic-ref HEAD 2>/dev/null)"
+	remote="$(git config branch.${branch#refs/heads/}.remote)"
+	remote="${remote:-origin}"
+	remoteurl="$(git config remote.$remote.url)" ||
+		die "remote ($remote) does not have a url in .git/config"
+	url="$1"
+	while test -n "$url"
+	do
+		case "$url" in
+		../*)
+			url="${url#../}"
+			remoteurl="${remoteurl%/*}"
+			;;
+		./*)
+			url="${url#./}"
+			;;
+		*)
+			break;;
+		esac
+	done
+	echo "$remoteurl/$url"
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -103,11 +129,19 @@ module_add()
 		usage
 	fi

-	# Turn the source into an absolute path if
-	# it is local
-	if base=$(get_repo_base "$repo"); then
-		repo="$base"
-	fi
+	case $repo in
+	./*|../*)
+		# dereference source url relative to parent's url
+		realrepo="$(resolve_relative_url $repo)" ;;
+	*)
+		# Turn the source into an absolute path if
+		# it is local
+		if base=$(get_repo_base "$repo"); then
+			repo="$base"
+			realrepo=$repo
+		fi
+		;;
+	esac

 	# Guess path from repo if not specified or strip trailing slashes
 	if test -z "$path"; then
@@ -122,7 +156,7 @@ module_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"

-	module_clone "$path" "$repo" || exit
+	module_clone "$path" "$realrepo" || exit
 	(unset GIT_DIR && cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
@@ -153,6 +187,13 @@ modules_init()
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"

+		# Possibly a url relative to parent
+		case $url in
+		./*|../*)
+			url="$(resolve_relative_url $url)"
+			;;
+		esac
+
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"

--
1.5.3.2.9.g69b29
