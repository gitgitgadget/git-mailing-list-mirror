From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-submodule - allow a relative path as the subproject url
Date: Sat, 22 Sep 2007 16:40:04 -0400
Message-ID: <11904936042891-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 23:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZCiB-0007CG-4C
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXIVVkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 17:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbXIVVkS
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 17:40:18 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:44798 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXIVVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 17:40:17 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2007 17:40:17 EDT
Received: from fal-l07294-lp.us.ray.com ([71.246.202.205])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JOS007S3EQSXX99@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Sep 2007 15:40:05 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.1.36.gf01e8
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58942>

This allows a subproject's location to be specified and stored as relative
to the parent project's location (e.g., ./foo, or ../foo). This url is
stored in .gitmodules as given. It is resolved into an absolute url be
appending it to the parent project's url when the information is written
to .git/config (i.e., during submodule add for the originator, and
submodule init for a downstream recipient). This allows cloning of the
project to work "as expected" if the project is hosted on a different
server than when the subprojects were added.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/git-submodule.txt |    3 +++
 git-submodule.sh                |   34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

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
index 3320998..c553e14 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -39,6 +39,19 @@ get_repo_base() {
 	) 2>/dev/null
 }
 
+# Get parent project's url
+get_parent_url ()
+{
+	# need to append this on parent project's url
+	branch="$(git branch --no-color | sed -ne 's/^\* //p')"
+	test -n "$branch" || die "I do not know what branch you are on: $branch"
+	upstream="$(git config branch.$branch.remote)"
+	test -n "$upstream" || die "Cannot find upstream repo for branch $branch"
+	uprepo="$(git config remote.$upstream.url)"
+	test -n "$upstream" || die "Cannot find url for repo $uprepo"
+	echo "$uprepo"
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -105,9 +118,16 @@ module_add()
 
 	# Turn the source into an absolute path if
 	# it is local
-	if base=$(get_repo_base "$repo"); then
-		repo="$base"
-	fi
+	case $repo in
+	.*)
+		realrepo="$(get_parent_url)/$repo" ;;
+	*)
+		if base=$(get_repo_base "$repo"); then
+			repo="$base"
+			realrepo=$repo
+		fi
+		;;
+	esac
 
 	# Guess path from repo if not specified or strip trailing slashes
 	if test -z "$path"; then
@@ -122,7 +142,7 @@ module_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$repo" || exit
+	module_clone "$path" "$realrepo" || exit
 	(unset GIT_DIR && cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
@@ -153,6 +173,12 @@ modules_init()
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
 
+		# Possibly a url relative to parent
+		case $url in
+		.*)
+			url="$(get_parent_url)/$url";;
+		esac
+
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
-- 
1.5.3.1.36.gf01e8
