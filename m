From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] filter-branch: provide the convenience functions also
 for commit filters
Date: Fri, 31 Aug 2007 20:05:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312005070.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 31 21:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRBoT-00086t-Di
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966034AbXHaTFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965988AbXHaTFo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:05:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965717AbXHaTFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:05:43 -0400
Received: (qmail invoked by alias); 31 Aug 2007 19:05:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 31 Aug 2007 21:05:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9WEQwnQy9uGu2z5AV3hXSB1I6/vJgYQJQoOugvM
	u+UXiCbRv8PAYW
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57195>


Move the convenience functions to the top of git-filter-branch.sh, and
return from the script when the environment variable SOURCE_FUNCTIONS is
set.

By sourcing git-filter-branch with that variable set automatically, all
commit filters may access the convenience functions like "map".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Evidently, this is on top of my documentation cleanup...

	Obviously, I think that these two changes are simple enough to be
	included even this late in the game for 1.5.3.  But I understand
	completely when people shout at me: "What exactly does deep
	feature freeze mean to you *knocks on Dscho's head*?"

 Documentation/git-filter-branch.txt |    3 ---
 git-filter-branch.sh                |   25 +++++++++++++++----------
 t/t7003-filter-branch.sh            |   10 ++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 4f89c04..456d52b 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -112,9 +112,6 @@ OPTIONS
 As a special extension, the commit filter may emit multiple
 commit ids; in that case, ancestors of the original commit will
 have all of them as parents.
-+
-Note that the 'map' function is not available in the commit filter yet.
-This will be changed in a future version.
 
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index c166c97..3b041d8 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,15 +8,6 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="[--env-filter <command>] [--tree-filter <command>] \
-[--index-filter <command>] [--parent-filter <command>] \
-[--msg-filter <command>] [--commit-filter <command>] \
-[--tag-name-filter <command>] [--subdirectory-filter <directory>] \
-[--original <namespace>] [-d <directory>] [-f | --force] \
-[<rev-list options>...]"
-
-. git-sh-setup
-
 warn () {
         echo "$*" >&2
 }
@@ -75,6 +66,20 @@ set_ident () {
 	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
+# This script can be sourced by the commit filter to get the functions
+test "a$SOURCE_FUNCTIONS" = a1 && return
+this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
+export this_script
+
+USAGE="[--env-filter <command>] [--tree-filter <command>] \
+[--index-filter <command>] [--parent-filter <command>] \
+[--msg-filter <command>] [--commit-filter <command>] \
+[--tag-name-filter <command>] [--subdirectory-filter <directory>] \
+[--original <namespace>] [-d <directory>] [-f | --force] \
+[<rev-list options>...]"
+
+. git-sh-setup
+
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
@@ -131,7 +136,7 @@ do
 		filter_msg="$OPTARG"
 		;;
 	--commit-filter)
-		filter_commit="$OPTARG"
+		filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"
 		;;
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index bc6e2dd..c79853d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -159,4 +159,14 @@ test_expect_success 'barf on invalid name' '
 	! git filter-branch -f HEAD^
 '
 
+test_expect_success '"map" works in commit filter' '
+	git filter-branch -f --commit-filter "\
+		parent=\$(git rev-parse \$GIT_COMMIT^) &&
+		mapped=\$(map \$parent) &&
+		actual=\$(echo \"\$@\" | sed \"s/^.*-p //\") &&
+		test \$mapped = \$actual &&
+		git commit-tree \"\$@\";" master~2..master &&
+	git rev-parse --verify master
+'
+
 test_done
-- 
1.5.3.rc7.18.gc9b59
