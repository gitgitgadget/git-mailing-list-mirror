From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: run post-checkout hook on checkout
Date: Wed, 25 Mar 2009 23:48:33 +0100
Message-ID: <49CAB4C1.6070004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 23:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmbvH-0005MY-Ky
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZCYWsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZCYWsl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:48:41 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46758 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZCYWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 18:48:40 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id A6A86FC13F9B;
	Wed, 25 Mar 2009 23:48:37 +0100 (CET)
Received: from [80.128.84.164] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277)
	id 1Lmbtl-0000Wb-00; Wed, 25 Mar 2009 23:48:37 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19fzbWGB+nGF9gqq5YWAAeMfa5K1yk36HO/Wjil
	Xdm3joev8PpRNNYMqU28CZUYdfG7dzLaHtgeSxS8hU+PY44tVa
	0cqHOVqyZ5kvtW0DnY8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114687>

git-gui is using "git-read-tree -u" for checkout which doesn't
invoke the post-checkout hook as a plain git-checkout would.
So git-gui must call the hook itself.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

It's been a while since i deeply touched tcl/tk code ... i basically
adapted the code for calling the post-commit hook here.

I renamed the former local variable "curHEAD" from the method
_start_checkout to a field named "old_hash" to be able to remember
the hash of the tree *before* the checkout started. This hash has
to be given as first argument to the post-checkout hook *after* the
checkout, where it is not the *current* HEAD anymore.


 git-gui/lib/checkout_op.tcl |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/git-gui/lib/checkout_op.tcl b/git-gui/lib/checkout_op.tcl
index caca888..31863a5 100644
--- a/git-gui/lib/checkout_op.tcl
+++ b/git-gui/lib/checkout_op.tcl
@@ -9,6 +9,7 @@ field w_cons   {}; # embedded console window object
 field new_expr   ; # expression the user saw/thinks this is
 field new_hash   ; # commit SHA-1 we are switching to
 field new_ref    ; # ref we are updating/creating
+field old_hash   ; # commit SHA-1 that was checked when we started
 
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
@@ -471,7 +472,19 @@ If you wanted to be on a branch, create one now starting from 'This Detached Che
 		set PARENT $HEAD
 		ui_status [mc "Checked out '%s'." $name]
 	}
-	delete_this
+
+	# -- Run the post-checkout hook.
+	#
+	set fd_ph [githook_read post-checkout $old_hash $new_hash 1]
+	if {$fd_ph ne {}} {
+		upvar #0 pch_error pc_err
+		set pc_err {}
+		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
+		fileevent $fd_ph readable \
+			[list checkout_postcheckout_wait $fd_ph $this]
+	} else {
+		delete_this
+	}
 }
 
 git-version proc _detach_HEAD {log new} {
@@ -608,3 +621,19 @@ $err"]
 }
 
 }
+
+proc checkout_postcheckout_wait {fd_ph t} {
+	upvar #0 pch_error pch_error
+
+	append pch_error [read $fd_ph]
+	fconfigure $fd_ph -blocking 1
+	if {[eof $fd_ph]} {
+		if {[catch {close $fd_ph}]} {
+			hook_failed_popup post-checkout $pch_error 0
+		}
+		unset pch_error
+		delete_this $t
+		return
+	}
+	fconfigure $fd_ph -blocking 0
+}
-- 
1.6.2.1.307.g91408
