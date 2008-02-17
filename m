From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 4/4] Tidy up git mergetool's handling of backup files
Date: Sun, 17 Feb 2008 10:24:33 +0000
Message-ID: <695bf8507497f15cefb1ca93feb02d632de3f854.1203242325.git.charles@hashpling.org>
References: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 11:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQghy-0004xp-0U
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbYBQKYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbYBQKYn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:24:43 -0500
Received: from ptb-relay01.plus.net ([212.159.14.212]:33718 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbYBQKYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:24:42 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1JQghM-0005MJ-Rt
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:24:41 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HAOXQo023735
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:24:33 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HAOXdw023734
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:24:33 GMT
Content-Disposition: inline
In-Reply-To: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: e458ea4def40f29fe8b87037e4968884
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74114>

Currently a backup pre-merge file with conflict markers is sometimes
kept with a .orig extenstion and sometimes removed depending on the
particular merge tool used.

This patch makes the handling consistent across all merge tools and
configurable via a new mergetool.keepBackup config variable

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt |    5 +++++
 git-mergetool.sh         |   31 ++++++++++---------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06a93e0..d9f62f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -744,6 +744,11 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2437c37..4397f47 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -127,18 +127,6 @@ check_unchanged () {
     fi
 }
 
-save_backup () {
-    if test "$status" -eq 0; then
-	mv -- "$BACKUP" "$path.orig"
-    fi
-}
-
-remove_backup () {
-    if test "$status" -eq 0; then
-	rm "$BACKUP"
-    fi
-}
-
 merge_file () {
     path="$1"
 
@@ -201,7 +189,6 @@ merge_file () {
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
-	    remove_backup
 	    ;;
 	tkdiff)
 	    if base_present ; then
@@ -210,19 +197,16 @@ merge_file () {
 		"$merge_tool_path" -o "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
-	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
 	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
 	    check_unchanged
-	    save_backup
 	    ;;
 	gvimdiff)
 		touch "$BACKUP"
 		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
 		check_unchanged
-		save_backup
 		;;
 	xxdiff)
 	    touch "$BACKUP"
@@ -240,7 +224,6 @@ merge_file () {
 		    --merged-file "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	opendiff)
 	    touch "$BACKUP"
@@ -250,7 +233,6 @@ merge_file () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	ecmerge)
 	    touch "$BACKUP"
@@ -260,7 +242,6 @@ merge_file () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$path"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
@@ -269,7 +250,6 @@ merge_file () {
 		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
 	    fi
 	    status=$?
-	    save_backup
 	    ;;
 	*)
 	    if test -n "$merge_tool_cmd"; then
@@ -286,15 +266,22 @@ merge_file () {
 		    ( MERGED="$path" eval $tool )
 		    status=$?
 		fi
-		save_backup
 	    fi
 	    ;;
     esac
+
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
 	mv -- "$BACKUP" "$path"
 	exit 1
     fi
+
+    if test "$merge_keep_backup" = "true"; then
+	mv -- "$BACKUP" "$path.orig"
+    else
+	rm -- "$BACKUP"
+    fi
+
     git add -- "$path"
     cleanup_temp_files
 }
@@ -406,6 +393,8 @@ else
 
     init_merge_tool_path "$merge_tool"
 
+    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+
     if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
         exit 1
-- 
1.5.4.1.34.g94bf
