From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] stg-gitk: allow passing args to gitk; add --help.
Date: Thu, 22 Nov 2007 22:23:34 +0100
Message-ID: <20071122212334.3351.4777.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJWx-0007nZ-NL
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbXKVVX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbXKVVX6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:23:58 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44315 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbXKVVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:23:57 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D385217B53C;
	Thu, 22 Nov 2007 22:23:55 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A8BF217B535;
	Thu, 22 Nov 2007 22:23:55 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3FFAA1F036;
	Thu, 22 Nov 2007 22:23:35 +0100 (CET)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65847>

Quite handy to further limit the commits to be shown.
---

 contrib/stg-gitk |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
index 6ddcfb1..cb264e5 100755
--- a/contrib/stg-gitk
+++ b/contrib/stg-gitk
@@ -12,25 +12,31 @@ set -e
 # Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
 
+helptext="Usage: $(basename $0) [--refs] [<branches>|--all] [-- <gitk args>]"
+
 usage()
 {
-    echo "Usage: $(basename $0) [<branches>|--all]"
+    echo >&2 "$helptext"
     exit 1
 }
 
 allbranches=0
 refsonly=0
+branches=''
 while [ "$#" -gt 0 ]; do
     case "$1" in
 	--refs) refsonly=1 ;;
 	--all) allbranches=1 ;;
+	--help) echo "$helptext"; exit 0 ;;
+	--) shift; break ;;
 	--*) usage ;;
-	*) break ;;
+	*) branches="$branches $1" ;;
     esac
     shift
 done
+# Now any remaining stuff in $@ are additional options for gitk
 
-if [ $allbranches = 1 ] && [ "$#" -gt 0 ]; then
+if [ $allbranches = 1 ] && [ "$branches" != "" ]; then
     usage
 fi
 
@@ -41,11 +47,17 @@ refdirs=''
 if [ $allbranches = 1 ]; then
     refdirs="$GIT_DIR/refs"
 else
-    if [ "$#" = 0 ]; then
-	set -- "$(stg branch)"
+    # default to current branch
+    if [ "$branches" == "" ]; then
+	branches="$(stg branch)"
+    fi
+    if [ "$branches" == "" ]; then
+	echo >&2 "ERROR: cannot find current branch."
+	exit 1
     fi
 
-    for b in "$@"; do
+    # expand patches for each named branch
+    for b in $branches; do
 	if [ -e "$GIT_DIR/refs/patches/$b" ]; then
 	    # StGIT branch: show all patches
 	    refdirs="$refdirs $GIT_DIR/refs/heads/$b $GIT_DIR/refs/patches/$b"
@@ -73,11 +85,11 @@ elif grep -q -- --argscmd $(which gitk); then
     # This gitk supports --argscmd.
     # Let's use a hack to pass --all, which was consumed during command-line parsing
     if [ $allbranches = 1 ]; then
-	gitk --argscmd="$0 --refs --all"
+	gitk --argscmd="$0 --refs --all" "$@"
     else
-	gitk --argscmd="$0 --refs $*"
+	gitk --argscmd="$0 --refs $branches" "$@"
     fi
 else
     # This gitk does not support --argscmd, just compute refs onces
-    gitk $(printrefs)
+    gitk $(printrefs) "$@"
 fi
