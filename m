From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Sun, 17 Jun 2007 17:59:01 +0200
Message-ID: <11820959413590-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 17:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzx9k-0004XF-TT
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 17:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXFQP7H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbXFQP7G
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 11:59:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:39210 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbXFQP7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 11:59:05 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5HFx2iA021024
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 17:59:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5HFx1Z7013816;
	Sun, 17 Jun 2007 17:59:01 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50356>

Apple's developer tools include the application FileMerge,
which supports graphical three way merges with ancestor.
This patch makes the tool available through git-mergetool.

FileMerge is assumed to be installed at its default location.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-mergetool.txt |    3 ++-
 git-mergetool.sh                |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6c32c6d..ff4cdf2 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,8 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, opendiff,
+	and FileMerge
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7b66309..abe2a97 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -258,6 +258,16 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+	*FileMerge)
+	    touch "$BACKUP"
+	    if base_present; then
+		$merge_tool -left "$LOCAL" -right "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+	    else
+		$merge_tool -left "$LOCAL" -right "$REMOTE" -merge "$path" | cat
+	    fi
+	    check_unchanged
+	    save_backup
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -326,6 +336,9 @@ if test -z "$merge_tool" ; then
         merge_tool_candidates="$merge_tool_candidates vimdiff"
     fi
     merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
+    if test $(uname) = "Darwin" ; then
+    	merge_tool_candidates="/Developer/Applications/Utilities/FileMerge.app/Contents/MacOS/FileMerge $merge_tool_candidates"
+    fi
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
         if test $i = emerge ; then
@@ -357,6 +370,13 @@ case "$merge_tool" in
 	    exit 1
 	fi
 	;;
+    *FileMerge)
+	merge_tool=/Developer/Applications/Utilities/FileMerge.app/Contents/MacOS/FileMerge
+	if ! test -x $merge_tool ; then
+	    echo "FileMerge is not available"
+	    exit 1
+	fi
+	;;
     *)
 	echo "Unknown merge tool: $merge_tool"
 	exit 1
-- 
1.5.2.2.252.gbc777-dirty
