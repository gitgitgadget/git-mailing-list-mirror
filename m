From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/RFC 1/2] Revert "git-gui: Don't allow staging files with conflicts."
Date: Wed, 17 Sep 2008 13:40:51 +0200
Message-ID: <1221651652-3712-2-git-send-email-johannes.sixt@telecom.at>
References: <200808310052.21595.angavrilov@gmail.com>
 <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfvQD-0004PZ-HY
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYIQLlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYIQLlE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:41:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21884 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYIQLlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:41:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KfvOw-0002wd-2p; Wed, 17 Sep 2008 13:40:58 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 58A27F533; Wed, 17 Sep 2008 13:40:53 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 05AB3FA43; Wed, 17 Sep 2008 13:40:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.203.g117c
In-Reply-To: <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96097>

This reverts commits 617ceee653bd7377f662bfc6d3085f321efab7e4 (Don't allow
staging files with conflicts) and 2fe5b2ee42897a3acc78e5ddaace3775eb2713ca
(Restore ability to Stage Working Copy for conflicts).

The inability to use the icon in front of the file name to stage a file,
even a conflicted one, is too disruptive for the workflow. It was intended
as a safety valve against accidentally staging the conflicted file, which
would remove the conflict stages from the index and inhibit the use of
the merge tool. The new menu item "Stage Working Copy" that the second
reverted commit introduced helped a bit, but it clearly was just a
workaround.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-gui.sh        |   10 ----------
 lib/mergetool.tcl |    6 ------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 1044ab9..3b1532c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1954,17 +1954,12 @@ proc toggle_or_diff {w x y} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
-	# Do not stage files with conflicts
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
 	} else {
 		set state {__}
 	}
 
-	if {[string first {U} $state] >= 0} {
-		set col 1
-	}
-
 	# Restage the file, or simply show the diff
 	if {$col == 0 && $y > 1} {
 		if {[string index $state 1] eq {O}} {
@@ -2902,11 +2897,6 @@ $ctxmmg add command \
 	-command {merge_resolve_one 1}
 lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
 $ctxmmg add separator
-$ctxmmg add command \
-	-label [mc "Stage Working Copy"] \
-	-command {merge_resolve_one 0}
-lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
-$ctxmmg add separator
 create_common_diff_popup $ctxmmg
 
 proc popup_diff_menu {ctxm ctxmmg x y X Y} {
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index a44a725..965cfe4 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -5,12 +5,6 @@ proc merge_resolve_one {stage} {
 	global current_diff_path
 
 	switch -- $stage {
-		0 {	# Stage without confirmation, to minimize
-			# disruption of the rerere workflow
-			merge_add_resolution $current_diff_path
-			return
-		}
-
 		1 { set targetquestion [mc "Force resolution to the base version?"] }
 		2 { set targetquestion [mc "Force resolution to this branch?"] }
 		3 { set targetquestion [mc "Force resolution to the other branch?"] }
-- 
1.6.0.1.1210.gb7ffe
