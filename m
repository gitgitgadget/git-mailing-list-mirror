From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 6/8] git gui: add "review topic" menuitem which supports feature branch workflow
Date: Mon, 21 Sep 2009 15:06:53 +0200
Message-ID: <48c17b5cc7f2e143187a11c4e146649721bb2b0f.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
 <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
 <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
 <0f2d6dac74105f84defebf23dd74c40846d304a3.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicG-0002uk-9c
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZIUNHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZIUNHF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:05 -0400
Received: from darksea.de ([83.133.111.250]:35697 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756087AbZIUNGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:55 -0400
Received: (qmail 28833 invoked from network); 21 Sep 2009 15:06:57 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:57 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <0f2d6dac74105f84defebf23dd74c40846d304a3.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128883>

We have a setup where each developer publishes feature branches on a
central server. These branches then become merged into the upstream
branch (master in most times) by another developer designated as the
reviewer.

The review process usually involves several steps (fetch remote branches,
update local upstream branch to server branch, review in gitk, merge).
To combine this operation into one step we add a new menu item "Review
Topic" under the merge menu which guides the user through all the steps.

After "Review Topic" has finished the only thing left to do is to push
the current branch (which is the upstream branch) and delete the feature
branch. Support for which has been implemented in an ealier patch in
this series.
---
 git-gui/git-gui.sh    |    4 ++
 git-gui/lib/merge.tcl |   83 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 2a2bd38..3e3c7cd 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2557,6 +2557,10 @@ if {[is_enabled branch]} {
 		-accelerator $M1T-M
 	lappend disable_on_lock \
 		[list .mbar.merge entryconf [.mbar.merge index last] -state]
+	.mbar.merge add command -label [mc "Review Topic..."] \
+		-command {merge::dialog review}
+	lappend disable_on_lock \
+		[list .mbar.merge entryconf [.mbar.merge index last] -state]
 	.mbar.merge add command -label [mc "Abort Merge..."] \
 		-command merge::reset_hard
 	lappend disable_on_lock \
diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
index 283e491..3716cf3 100644
--- a/git-gui/lib/merge.tcl
+++ b/git-gui/lib/merge.tcl
@@ -81,14 +81,70 @@ method _visualize {} {
 	}
 }
 
+method _update_upstream {} {
+	global repo_config index_lock_type
+
+	set upstream_branch $repo_config(gui.upstreambranch)
+	set remote $repo_config(gui.defaultremote)
+
+	if {$upstream_branch eq {} || $remote eq {}} {
+		info_popup [mc "You need to set the configuration \
+			variables gui.upstreambranch and gui.defaultremote so \
+			review topic can work"]
+		return 0
+	}
+
+	#TODO: find out why this does not return on failure
+	if {![fetch_from $remote {close_on_success}]} {
+		return 0
+	}
+
+	set co [::checkout_op::new \
+		$remote/$upstream_branch \
+		{} \
+		refs/heads/$upstream_branch]
+
+	#TODO:
+	#$co parent $w
+	$co enable_create   1
+	$co enable_merge    ff
+	$co enable_checkout 1
+
+	set spec [list refs/remotes/$remote/$upstream_branch \
+	                       $remote \
+			       refs/heads/$upstream_branch]
+
+	$co enable_fetch $spec
+	$co remote_source $spec
+
+	if {[$co run]} {
+		while {$index_lock_type ne {none}} {
+			vwait index_lock_type
+		}
+		return 1
+	} else {
+		while {$index_lock_type ne {none}} {
+			vwait index_lock_type
+		}
+		return 0
+	}
+}
+
 method _start {} {
-	global HEAD current_branch remote_url
+	global HEAD current_branch remote_url merge_type
 
 	set name [_rev $this]
 	if {$name eq {}} {
 		return
 	}
 
+	if {$merge_type eq "review"} {
+		_visualize $this
+		$w.buttons.merge configure -text [mc Merge]
+		set merge_type normal
+		return
+	}
+
 	set spec [$w_rev get_tracking_branch]
 	set cmit [$w_rev get_commit]
 
@@ -137,17 +193,34 @@ method _finish {cons ok} {
 	delete_this
 }
 
-constructor dialog {} {
+constructor dialog {{dialog_type normal}} {
 	global current_branch
 	global M1B
+	global merge_type
+
+	set merge_type $dialog_type
+	set start_button [mc Merge]
+	set action_name "Merge Into"
+	set dialog_title [mc "Merge"]
+
+	if { $merge_type eq "review" } {
+		if {![_update_upstream $this]} {
+			delete_this
+			return
+		}
+		set start_button [mc Review]
+		set action_name [mc "Review for Merge Into"]
+		set dialog_title [mc Review]
+	}
 
 	if {![_can_merge $this]} {
+		info_popup failed_can_merge
 		delete_this
 		return
 	}
 
 	make_toplevel top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
+	wm title $top [append "[appname] ([reponame]): " $dialog_title]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
@@ -155,7 +228,7 @@ constructor dialog {} {
 	set _start [cb _start]
 
 	label $w.header \
-		-text [mc "Merge Into %s" $current_branch] \
+		-text [mc "$action_name %s" $current_branch] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
@@ -165,7 +238,7 @@ constructor dialog {} {
 		-command [cb _visualize]
 	pack $w.buttons.visualize -side left
 	button $w.buttons.merge \
-		-text [mc Merge] \
+		-text $start_button \
 		-command $_start
 	pack $w.buttons.merge -side right
 	button $w.buttons.cancel \
-- 
1.6.5.rc1.12.gc72fe
