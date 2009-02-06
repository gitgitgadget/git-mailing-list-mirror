From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH] Offer to print changes while running git-mergetool
Date: Fri,  6 Feb 2009 14:32:25 +0000
Message-ID: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 15:41:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRtd-0001F6-Eh
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbZBFOkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbZBFOkH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:40:07 -0500
Received: from cumberland.bestbefore.tv ([82.165.41.205]:40315 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZBFOkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:40:06 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2009 09:40:05 EST
Received: (qmail 29423 invoked from network); 6 Feb 2009 14:33:23 +0000
Received: from gir.mp.bestbefore.tv (HELO localhost.localdomain) (89.105.122.147)
  by cumberland.bestbefore.tv with SMTP; 6 Feb 2009 14:33:23 +0000
X-Mailer: git-send-email 1.6.1.2.390.gba743.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108717>

Add a "Show changes" option to each prompt in mergetool. This prints the conflicted changes on the current file, using 'git log -p --merge <file>'

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

I frequently find myself running git-mergetool, then finding halfway through that I need to review the changes that produced that conflict.
How about something like this, for showing the changes from within mergetool?

 git-mergetool.sh |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..9df91d8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -62,7 +62,7 @@ describe_file () {
 
 resolve_symlink_merge () {
     while true; do
-	printf "Use (l)ocal or (r)emote, or (a)bort? "
+	printf "Use (l)ocal or (r)emote, (s)how changes, or (a)bort? "
 	read ans
 	case "$ans" in
 	    [lL]*)
@@ -77,6 +77,12 @@ resolve_symlink_merge () {
 		cleanup_temp_files --save-backup
 		return 0
 		;;
+		[sS]*)
+		git log -p --merge "$MERGED"
+		printf "\n"
+		resolve_symlink_merge
+		return
+		;;
 	    [aA]*)
 		return 1
 		;;
@@ -87,9 +93,9 @@ resolve_symlink_merge () {
 resolve_deleted_merge () {
     while true; do
 	if base_present; then
-	    printf "Use (m)odified or (d)eleted file, or (a)bort? "
+	    printf "Use (m)odified or (d)eleted file, (s)how changes, or (a)bort? "
 	else
-	    printf "Use (c)reated or (d)eleted file, or (a)bort? "
+	    printf "Use (c)reated or (d)eleted file, (s)how changes, or (a)bort? "
 	fi
 	read ans
 	case "$ans" in
@@ -103,6 +109,12 @@ resolve_deleted_merge () {
 		cleanup_temp_files
 		return 0
 		;;
+		[sS]*)
+		git log -p --merge "$MERGED"
+		printf "\n"
+		resolve_deleted_merge
+		return
+		;;
 	    [aA]*)
 		return 1
 		;;
@@ -183,10 +195,21 @@ merge_file () {
     echo "Normal merge conflict for '$MERGED':"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
-    if "$prompt" = true; then
-	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-	read ans
-    fi
+	if "$prompt" = true; then
+		while true; do
+			printf "(S)how changes, or hit return to start merge resolution tool (%s): " "$merge_tool"
+			read ans
+			case "$ans" in
+				[sS]*)
+				git log -p --merge "$MERGED"
+				printf "\n"
+				;;
+				*)
+				break
+				;;
+			esac
+		done
+	fi
 
     case "$merge_tool" in
 	kdiff3)
-- 
1.6.1.2.390.gba743.dirty
