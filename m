From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/4] Tidy up git mergetool's backup file behaviour
Date: Thu, 21 Feb 2008 23:30:02 +0000
Message-ID: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:31:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKsf-0006pK-OU
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbYBUXaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbYBUXaS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:30:18 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:48724 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYBUXaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:30:16 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JSKrl-0006eQ-N5; Thu, 21 Feb 2008 23:30:13 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1LNU2re011515;
	Thu, 21 Feb 2008 23:30:02 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1LNU2qd011514;
	Thu, 21 Feb 2008 23:30:02 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 616d5cf5ba2d9e71f0837cfe26768749
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74678>

Currently a backup pre-merge file with conflict markers is sometimes
kept with a .orig extenstion and sometimes removed depending on the
particular merge tool used.

This patch makes the handling consistent across all merge tools and
configurable via a new mergetool.keepBackup config variable

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

I'm resending this series with result of all the previous contents
integrated. This is, though, still the 'eval' version of the patch
simply because it is significantly easier to implement and is not
significantly worse than any of the other suggested implementations in
any particular way.

 Documentation/config.txt |    6 ++++++
 git-mergetool.sh         |   25 +++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7b67671..4e17fd2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,6 +769,12 @@ mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
+mergetool.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.  Defaults to
+	`true` (i.e. keep the backup files).
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..e27bb7b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -201,7 +201,6 @@ merge_file () {
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
-	    remove_backup
 	    ;;
 	tkdiff)
 	    if base_present ; then
@@ -210,20 +209,17 @@ merge_file () {
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
-		touch "$BACKUP"
-		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
-		check_unchanged
-		save_backup
-		;;
+	    touch "$BACKUP"
+	    "$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
+	    check_unchanged
+	    ;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
@@ -240,7 +236,6 @@ merge_file () {
 		    --merged-file "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	opendiff)
 	    touch "$BACKUP"
@@ -250,7 +245,6 @@ merge_file () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	ecmerge)
 	    touch "$BACKUP"
@@ -260,7 +254,6 @@ merge_file () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$path"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
@@ -269,7 +262,6 @@ merge_file () {
 		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
 	    fi
 	    status=$?
-	    save_backup
 	    ;;
     esac
     if test "$status" -ne 0; then
@@ -277,6 +269,13 @@ merge_file () {
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
@@ -380,6 +379,8 @@ else
 
     init_merge_tool_path "$merge_tool"
 
+    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+
     if ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
         exit 1
-- 
1.5.4.2.133.g3d51e


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
