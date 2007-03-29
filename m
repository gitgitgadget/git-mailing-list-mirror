From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Add support for Apple Mac OS X's opendiff command
Date: Thu, 29 Mar 2007 11:44:23 -0400
Message-ID: <11751830651076-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu> <11751830651361-git-send-email-tytso@mit.edu> <11751830654112-git-send-email-tytso@mit.edu> <11751830652803-git-send-email-tytso@mit.edu> <11751830653835-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Arjen Laarhoven <arjen@yaph.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoL-0004BP-DE
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbXC2Pom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXC2Pom
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:42 -0400
Received: from thunk.org ([69.25.196.29]:36603 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030259AbXC2Pob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwte-0007J6-Ho; Thu, 29 Mar 2007 11:50:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xy-Jr; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830653835-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43445>

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index f73072a..b0d28fd 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -232,6 +232,16 @@ merge_file () {
 	    check_unchanged
 	    save_backup
 	    ;;
+	opendiff)
+	    touch "$BACKUP"
+	    if base_present; then
+		opendiff "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+	    else
+		opendiff "$LOCAL" "$REMOTE" -merge "$path" | cat
+	    fi
+	    check_unchanged
+	    save_backup
+	    ;;
 	emerge)
 	    if base_present ; then
 		emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"
@@ -282,7 +292,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | emerge | vimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -301,6 +311,8 @@ if test -z "$merge_tool" ; then
 	merge_tool=xxdiff
     elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
 	merge_tool=meld
+    elif type opendiff >/dev/null 2>&1; then
+	merge_tool=opendiff
     elif type emacs >/dev/null 2>&1; then
 	merge_tool=emerge
     elif type vimdiff >/dev/null 2>&1; then
@@ -312,7 +324,7 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.1.rc2.1.g8afe-dirty
