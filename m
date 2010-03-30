From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/2] git-gui: Introduce is_unmerged global variable to encapsulate its derivation.
Date: Wed, 31 Mar 2010 02:34:48 +1100
Message-ID: <1269963289-480-1-git-send-email-jon.seymour@gmail.com>
Cc: git@vger.kernel.org, spearce@spearce.org, j.sixt@viscovery.net
To: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 30 17:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwdc6-00049m-E5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 17:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab0C3PoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 11:44:14 -0400
Received: from outbound.icp-qv1-irony-out5.iinet.net.au ([203.59.1.105]:38094
	"EHLO outbound.icp-qv1-irony-out5.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab0C3PoN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 11:44:13 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 11:44:13 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYFAHu3sUt8qoyc/2dsb2JhbACPP4FOiiJxr3mCK4R9LYhRhQAE
X-IronPort-AV: E=Sophos;i="4.51,334,1267372800"; 
   d="scan'208";a="122256063"
Received: from unknown (HELO localhost.localdomain) ([124.170.140.156])
  by outbound.icp-qv1-irony-out5.iinet.net.au with ESMTP; 30 Mar 2010 23:34:51 +0800
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143571>

Defined is_unmerged to be [expr {[string first {U} $m] >= 0}]
and then replaced uses of {[string first {U} $m] >= 0} with {$is_unmerged}.

This change is made because the subsequent patch will introduce a 3rd use of this expression.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-gui/lib/diff.tcl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ec8c11e..e7b1986 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -80,6 +80,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
 	global current_diff_queue
+	global is_unmerged
 
 	if {$diff_active || ![lock_index read]} return
 
@@ -98,6 +99,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 	set s $file_states($path)
 	set m [lindex $s 0]
 	set is_conflict_diff 0
+	set is_unmerged [expr {[string first {U} $m] >= 0}]
 	set current_diff_path $path
 	set current_diff_side $w
 	set current_diff_queue {}
@@ -105,7 +107,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 
 	set cont_info [list $scroll_pos $callback]
 
-	if {[string first {U} $m] >= 0} {
+	if {$is_unmerged} {
 		merge_load_stages $path [list show_unmerged_diff $cont_info]
 	} elseif {$m eq {_O}} {
 		show_other_diff $path $w $m $cont_info
@@ -258,6 +260,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	global is_3way_diff is_submodule_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
+	global is_unmerged
 
 	set path $current_diff_path
 	set w $current_diff_side
@@ -274,7 +277,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		lappend cmd diff-index
 		lappend cmd --cached
 	} elseif {$w eq $ui_workdir} {
-		if {[string first {U} $m] >= 0} {
+	        if {$is_unmerged} {
 			lappend cmd diff
 		} else {
 			lappend cmd diff-files
-- 
1.6.6.1
