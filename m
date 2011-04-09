From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH] mergetool: Teach about submodules
Date: Fri,  8 Apr 2011 20:59:30 -0700
Message-ID: <1302321570-85987-1-git-send-email-me@JonathonMah.com>
Cc: Jonathon Mah <me@JonathonMah.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 05:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8PL4-0001MS-NA
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 05:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab1DID7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 23:59:41 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:11923 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753774Ab1DID7l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 23:59:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApSDAG/Wn01i6vJRIWdsb2JhbACJE50HCwEBAQEgFzLCPYVtBIVV
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO Adamantium.local.net) ([98.234.242.81])
  by ipmail06.adl2.internode.on.net with ESMTP; 09 Apr 2011 13:29:36 +0930
X-Mailer: git-send-email 1.7.5.rc1.1.g64431
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171179>

Mergetool mildly clobbered submodules, attempting to move and copy their
directories. It now recognizes submodules and offers a resolution:

Submodule merge conflict for 'Shared':
  {local}: commit ad9f12e3e6205381bf2163a793d1e596a9e211d0
  {remote}: commit f5893fb70ec5646efcd9aa643c5136753ac89253
Use (l)ocal or (r)emote, or (a)bort?

Selecting a commit will stage it, but not update the submodule (as it
would had there been no conflict). Type changes are also supported,
should the path be a submodule on one side, and a file on the other.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 git-mergetool.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index bacbda2..83351d6 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -21,6 +21,10 @@ is_symlink () {
     test "$1" = 120000
 }
 
+is_submodule () {
+    test "$1" = 160000
+}
+
 local_present () {
     test -n "$local_mode"
 }
@@ -52,6 +56,8 @@ describe_file () {
 	echo "deleted"
     elif is_symlink "$mode" ; then
 	echo "a symbolic link -> '$(cat "$file")'"
+    elif is_submodule "$mode" ; then
+	echo "commit $file"
     else
 	if base_present; then
 	    echo "modified"
@@ -112,6 +118,51 @@ resolve_deleted_merge () {
 	done
 }
 
+resolve_submodule_merge () {
+    while true; do
+	printf "Use (l)ocal or (r)emote, or (a)bort? "
+	read ans
+	case "$ans" in
+	    [lL]*)
+		local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
+		if is_submodule "$local_mode"; then
+		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
+		else
+		    git checkout-index -f --stage=2 -- "$MERGED"
+		    git add -- "$MERGED"
+		fi
+		return 0
+		;;
+	    [rR]*)
+		remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
+		if is_submodule "$remote_mode"; then
+		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
+		else
+		    git checkout-index -f --stage=2 -- "$MERGED"
+		    git add -- "$MERGED"
+		fi
+		return 0
+		;;
+	    [aA]*)
+		return 1
+		;;
+	    esac
+	done
+}
+
+stage_submodule () {
+    path="$1"
+    submodule_sha1="$2"
+
+    submodule_basename=$(basename "$path")
+    tree_with_module=$(echo "160000 commit $submodule_sha1	\"$submodule_basename\"" | git mktree --missing 2>/dev/null)
+    if test -z "$tree_with_module" ; then
+	echo "$path: unable to stage commit $sha1"
+	return 1
+    fi
+    git checkout $tree_with_module -- "$path"
+}
+
 checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
@@ -139,13 +190,23 @@ merge_file () {
     REMOTE="./$MERGED.REMOTE.$ext"
     BASE="./$MERGED.BASE.$ext"
 
-    mv -- "$MERGED" "$BACKUP"
-    cp -- "$BACKUP" "$MERGED"
-
     base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
     local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
     remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
 
+    if is_submodule "$local_mode" || is_submodule "$remote_mode"; then
+	echo "Submodule merge conflict for '$MERGED':"
+	local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
+	remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
+	describe_file "$local_mode" "local" "$local_sha1"
+	describe_file "$remote_mode" "remote" "$remote_sha1"
+	resolve_submodule_merge
+	return
+    fi
+
+    mv -- "$MERGED" "$BACKUP"
+    cp -- "$BACKUP" "$MERGED"
+
     base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
     local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
     remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
-- 
1.7.5.rc1.1.g64431
