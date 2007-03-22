From: arjen@yaph.org (Arjen Laarhoven)
Subject: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Thu, 22 Mar 2007 22:37:28 +0100
Message-ID: <20070322213728.GD3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 23:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUVT4-0008LU-M0
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 23:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbXCVWJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXCVWJH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 18:09:07 -0400
Received: from regex.yaph.org ([193.202.115.201]:38810 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161139AbXCVWJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 18:09:06 -0400
X-Greylist: delayed 1896 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2007 18:09:06 EDT
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 43CAA5B7C8; Thu, 22 Mar 2007 22:37:28 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42885>


Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 git-mergetool.sh |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7942fd0..58ae201 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -248,6 +248,30 @@ merge_file () {
 		mv -- "$BACKUP" "$path.orig"
 	    fi
 	    ;;
+	opendiff)
+	    touch "$BACKUP"
+	    if base_present; then
+		opendiff $LOCAL $REMOTE -ancestor $BASE -merge $path | cat
+            else
+                opendiff $LOCAL $REMOTE -merge $path | cat
+            fi
+	    if test "$path" -nt "$BACKUP" ; then
+		status=0;
+	    else
+		while true; do
+		    echo "$path seems unchanged."
+		    echo -n "Was the merge successful? [y/n] "
+		    read answer < /dev/tty
+		    case "$answer" in
+			y*|Y*) status=0; break ;;
+			n*|N*) status=1; break ;;
+		    esac
+		done
+	    fi
+	    if test "$status" -eq 0; then
+		mv -- "$BACKUP" "$path.orig"
+	    fi
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -289,7 +313,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | emerge | vimdiff)
+	kdiff3 | tkdiff | xxdiff | meld | emerge | vimdiff | opendiff)
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -312,6 +336,8 @@ if test -z "$merge_tool" ; then
 	merge_tool=emerge
     elif type vimdiff >/dev/null 2>&1; then
 	merge_tool=vimdiff
+    elif type opendiff >/dev/null 2>&1; then
+	merge_tool=opendiff
     else
 	echo "No available merge resolution programs available."
 	exit 1
@@ -319,7 +345,7 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.1.rc1.13.g0872
