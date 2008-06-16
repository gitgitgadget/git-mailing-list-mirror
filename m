From: Patrick Higgins <patrick.higgins@cexp.com>
Subject: [PATCH v3/RFC] Remove the use of '--' in merge program invocation
Date: Mon, 16 Jun 2008 17:33:41 -0600
Message-ID: <1213659221-27519-1-git-send-email-patrick.higgins@cexp.com>
Cc: Patrick Higgins <patrick.higgins@cexp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 01:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8OFT-0001LJ-C3
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 01:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbYFPXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754859AbYFPXfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 19:35:25 -0400
Received: from mx02.cexp.com ([170.131.136.83]:18929 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbYFPXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 19:35:24 -0400
Received: from uscobrmfa-se-05 (uscobrmfa-se-05.cexp.com [170.131.144.36])
	by mx02.cexp.com (Postfix) with ESMTP id 02E4B1E406C
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 17:33:43 -0600 (MDT)
Received: from localhost.localdomain ([10.128.5.63]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 16 Jun 2008 17:33:42 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id m5GNXfWH027542;
	Mon, 16 Jun 2008 17:33:41 -0600
Received: (from phiggins@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id m5GNXfiJ027541;
	Mon, 16 Jun 2008 17:33:41 -0600
X-Mailer: git-send-email 1.5.6.rc3.8.gce12
X-OriginalArrivalTime: 16 Jun 2008 23:33:42.0404 (UTC) FILETIME=[698AB440:01C8D009]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85247>

Put a "./" at the beginning of all paths given to the merge program so
that filenames beginning with a '-' character don't get interpreted as
options.

This deals with a problem where kdiff3 can be compiled with or without
support for the '--' separator between options and filenames.

Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
---

This is applying Junio's idea because my earlier attempts would fail on files
that started with a dash. This should work for those files with kdiff3
compiled with or without '--' support, does not require any additional
overhead to determine if kdiff3 has that support, and the technique should
work for all merge programs in case any others have the problem kdiff3 has.

My only concern is if 'git ls-files -u' ever returns absolute paths, then this
will not work.

 git-mergetool.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index fcdec4a..94187c3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -141,10 +141,10 @@ merge_file () {
     fi
 
     ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-    BACKUP="$MERGED.BACKUP.$ext"
-    LOCAL="$MERGED.LOCAL.$ext"
-    REMOTE="$MERGED.REMOTE.$ext"
-    BASE="$MERGED.BASE.$ext"
+    BACKUP="./$MERGED.BACKUP.$ext"
+    LOCAL="./$MERGED.LOCAL.$ext"
+    REMOTE="./$MERGED.REMOTE.$ext"
+    BASE="./$MERGED.BASE.$ext"
 
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
@@ -183,29 +183,29 @@ merge_file () {
 	kdiff3)
 	    if base_present ; then
 		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
-		    -o "$MERGED" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
 		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
-		    -o "$MERGED" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
 	    ;;
 	tkdiff)
 	    if base_present ; then
-		"$merge_tool_path" -a "$BASE" -o "$MERGED" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
 	    else
-		"$merge_tool_path" -o "$MERGED" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -- "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	gvimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -f -- "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	xxdiff)
@@ -215,13 +215,13 @@ merge_file () {
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" -- "$LOCAL" "$BASE" "$REMOTE"
+		    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
 	    else
 		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" -- "$LOCAL" "$REMOTE"
+		    --merged-file "$MERGED" "$LOCAL" "$REMOTE"
 	    fi
 	    check_unchanged
 	    ;;
-- 
1.5.6.rc2
