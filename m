From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] git-gui: run post-checkout hook on checkout
Date: Mon, 30 Mar 2009 21:46:17 +0200
Message-ID: <49D12189.5070409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 21:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoNSk-0005h3-UP
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 21:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbZC3Tq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 15:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756476AbZC3Tq3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 15:46:29 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46945 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbZC3Tq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 15:46:28 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id E2B48F9C0F9A;
	Mon, 30 Mar 2009 21:46:25 +0200 (CEST)
Received: from [80.128.74.92] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LoNRB-0003sj-00; Mon, 30 Mar 2009 21:46:25 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+0JiY14O+bkp+Vf+xY5s1uwX5pc0zC48E2SSjr
	mdfPngz42QamptyhX3QKcEQ4/onCPxMlVgoqy9iaW+HZCFQtF7
	P0Yq2o2KRKy2NVuykqVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115189>

git-gui is using "git-read-tree -u" for checkout which doesn't
invoke the post-checkout hook as a plain git-checkout would.
So git-gui must call the hook itself.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Thanks to Shawn for the review of the first version, this one
tries to address all the issues raised.


 git-gui/lib/checkout_op.tcl |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/checkout_op.tcl b/git-gui/lib/checkout_op.tcl
index caca888..9e7412c 100644
--- a/git-gui/lib/checkout_op.tcl
+++ b/git-gui/lib/checkout_op.tcl
@@ -9,6 +9,7 @@ field w_cons   {}; # embedded console window object
 field new_expr   ; # expression the user saw/thinks this is
 field new_hash   ; # commit SHA-1 we are switching to
 field new_ref    ; # ref we are updating/creating
+field old_hash   ; # commit SHA-1 that was checked out when we started
 
 field parent_w      .; # window that started us
 field merge_type none; # type of merge to apply to existing branch
@@ -280,11 +281,11 @@ method _start_checkout {} {
 
 	# -- Our in memory state should match the repository.
 	#
-	repository_state curType curHEAD curMERGE_HEAD
+	repository_state curType old_hash curMERGE_HEAD
 	if {[string match amend* $commit_type]
 		&& $curType eq {normal}
-		&& $curHEAD eq $HEAD} {
-	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
+		&& $old_hash eq $HEAD} {
+	} elseif {$commit_type ne $curType || $HEAD ne $old_hash} {
 		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before the current branch can be changed.
@@ -297,7 +298,7 @@ The rescan will be automatically started now.
 		return
 	}
 
-	if {$curHEAD eq $new_hash} {
+	if {$old_hash eq $new_hash} {
 		_after_readtree $this
 	} elseif {[is_config_true gui.trustmtime]} {
 		_readtree $this
@@ -453,13 +454,47 @@ method _after_readtree {} {
 If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."]
 	}
 
+	# -- Run the post-checkout hook.
+	#
+	set fd_ph [githook_read post-checkout $old_hash $new_hash 1]
+	if {$fd_ph ne {}} {
+		global pch_error
+		set pch_error {}
+		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
+		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
+	} else {
+		_update_repo_state $this
+	}
+}
+
+method _postcheckout_wait {fd_ph} {
+	global pch_error
+
+	append pch_error [read $fd_ph]
+	fconfigure $fd_ph -blocking 1
+	if {[eof $fd_ph]} {
+		if {[catch {close $fd_ph}]} {
+			hook_failed_popup post-checkout $pch_error 0
+		}
+		unset pch_error
+		_update_repo_state $this
+		return
+	}
+	fconfigure $fd_ph -blocking 0
+}
+
+method _update_repo_state {} {
 	# -- Update our repository state.  If we were previously in
 	#    amend mode we need to toss the current buffer and do a
 	#    full rescan to update our file lists.  If we weren't in
 	#    amend mode our file lists are accurate and we can avoid
 	#    the rescan.
 	#
+	global selected_commit_type commit_type HEAD MERGE_HEAD PARENT
+	global ui_comm
+
 	unlock_index
+	set name [_name $this]
 	set selected_commit_type new
 	if {[string match amend* $commit_type]} {
 		$ui_comm delete 0.0 end
-- 
1.6.2.1.414.g2daa3
