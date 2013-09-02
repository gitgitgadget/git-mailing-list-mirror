From: Joergen Edelbo <jed@napatech.com>
Subject: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Mon, 2 Sep 2013 10:54:19 +0200
Message-ID: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
Cc: spearce@spearce.org, hvoigt@hvoigt.net, jed@napatech.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEpA-0003tC-P9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762957Ab3IDPQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:16:48 -0400
Received: from nat.napatech.com ([188.120.77.114]:2202 "EHLO jed-dev-01.labnet"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756587Ab3IDPQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:16:47 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2013 11:16:46 EDT
Received: by jed-dev-01.labnet (Postfix, from userid 1000)
	id 52EC4121B7E; Wed,  4 Sep 2013 17:08:53 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233837>

Problem: It is not possible to push for Gerrit review
as you will always try to push to /refs/heads/... on
the remote. As you should not be forced to work on a
branch with the same name as some branch on the remote,
some more flexibility in the selection of destination
branch is also needed.

Changes done:

Remove selection of branches to push - push always HEAD.
This can be justified by the fact that this far the most
common thing to do.
Specify both the remote repository to push to as well as
the specific branch on that remote. This gives the flexibility.

Add option to specify "Gerrit review". If selected, replace
the traditional "heads" with the artificial "for" in the
destination ref spec. This is what actually solved the trigger
problem.

Limit the branches to select from to the known branches
for currently selected remote. This is motivated in better
usability. Works only when "usettk" is true - it is left for
further study how to change the values in tk_optionMenu on the
fly.

Signed-off-by: Joergen Edelbo <jed@napatech.com>
---
Hi there,

We are at Napatech A/S just about to roll out a Git/Gerrit/Jenkins
solution. It will really help the gui oriented people in pushing
commits if this can be done directly in git-gui.

BR
Joergen Edelbo
Napatech A/S

 lib/transport.tcl |  184 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 142 insertions(+), 42 deletions(-)

diff --git a/lib/transport.tcl b/lib/transport.tcl
index e5d211e..4c20ef7 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -59,20 +59,42 @@ proc push_to {remote} {
 	console::exec $w $cmd
 }
 
-proc start_push_anywhere_action {w} {
-	global push_urltype push_remote push_url push_thin push_tags
-	global push_force
-	global repo_config
-
-	set is_mirror 0
-	set r_url {}
+proc get_remote_rep {} {
+	global push_urltype push_remote push_url
+	set rep {}
 	switch -- $push_urltype {
-	remote {
-		set r_url $push_remote
-		catch {set is_mirror $repo_config(remote.$push_remote.mirror)}
+	remote { set rep $push_remote }
+	url    { set rep $push_url }
 	}
-	url {set r_url $push_url}
+	return $rep
+}
+
+proc get_remote_branch {} {
+	global push_branchtype push_branch push_new
+	set branch {}
+	switch -- $push_branchtype {
+	existing { set branch $push_branch }
+	create   { set branch $push_new }
+	}
+   return $branch
+}
+
+proc get_remote_ref_spec {} {
+	global gerrit_review
+	set push_branch [get_remote_branch]
+	if {$gerrit_review} {
+		return "refs/for/$push_branch"
+	} else {
+		return "refs/heads/$push_branch"
 	}
+}
+
+proc start_push_anywhere_action {w} {
+	global push_thin push_tags push_force
+	global repo_config current_branch is_detached
+
+	set is_mirror 0
+	set r_url [get_remote_rep]
 	if {$r_url eq {}} return
 
 	set cmd [list git push]
@@ -87,28 +109,25 @@ proc start_push_anywhere_action {w} {
 		lappend cmd --tags
 	}
 	lappend cmd $r_url
+
+	catch {set is_mirror $repo_config(remote.$r_url.mirror)}
 	if {$is_mirror} {
 		set cons [console::new \
 			[mc "push %s" $r_url] \
 			[mc "Mirroring to %s" $r_url]]
 	} else {
-		set cnt 0
-		foreach i [$w.source.l curselection] {
-			set b [$w.source.l get $i]
-			lappend cmd "refs/heads/$b:refs/heads/$b"
-			incr cnt
-		}
-		if {$cnt == 0} {
-			return
-		} elseif {$cnt == 1} {
-			set unit branch
+		if {$is_detached} {
+			set src HEAD
 		} else {
-			set unit branches
+			set src $current_branch
 		}
+		set dest [get_remote_ref_spec]
+
+		lappend cmd "$src:$dest"
 
 		set cons [console::new \
 			[mc "push %s" $r_url] \
-			[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
+			[mc "Pushing %s to %s" $src $dest]]
 	}
 	console::exec $cons $cmd
 	destroy $w
@@ -117,10 +136,58 @@ proc start_push_anywhere_action {w} {
 trace add variable push_remote write \
 	[list radio_selector push_urltype remote]
 
+proc update_branchtype {br} {
+	global current_branch push_branch push_branchtype
+	if {$br eq {}} {
+		set push_branchtype create
+		set push_branch {}
+	} else {
+		set push_branchtype existing
+		if {[lsearch -sorted -exact $br $current_branch] != -1} {
+			set push_branch $current_branch
+		} elseif {[lsearch -sorted -exact $br master] != -1} {
+			set push_branch master
+		} else {
+			set push_branch [lindex $br 0]
+		}
+	}
+}
+
+proc all_branches_combined {} {
+	set branches [list]
+	foreach spec [all_tracking_branches] {
+		set refn [lindex $spec 2]
+		regsub ^refs/heads/ $refn {} name
+		if { $name ne {HEAD} && [lsearch $branches $name] eq -1} {
+			lappend branches $name
+		}
+	}
+	update_branchtype  $branches
+	return $branches
+}
+
+proc update_branches {} {
+	global push_remote branch_combo
+	set branches [list]
+	foreach spec [all_tracking_branches] {
+		if {[lindex $spec 1] eq $push_remote} {
+			set refn [lindex $spec 0]
+			regsub ^refs/(heads|remotes)/$push_remote/ $refn {} name
+			if {$name ne {HEAD}} {
+				lappend branches $name
+			}
+		}
+	}
+	update_branchtype  $branches
+	$branch_combo configure -values $branches
+	return $branches
+}
+
 proc do_push_anywhere {} {
-	global all_remotes current_branch
-	global push_urltype push_remote push_url push_thin push_tags
-	global push_force use_ttk NS
+	global all_remotes use_ttk branch_combo
+	global push_urltype push_remote push_url
+	global push_branchtype push_branch push_new
+	global push_thin push_tags push_force NS gerrit_review
 
 	set w .push_setup
 	toplevel $w
@@ -129,7 +196,7 @@ proc do_push_anywhere {} {
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 	pave_toplevel $w
 
-	${NS}::label $w.header -text [mc "Push Branches"] \
+	${NS}::label $w.header -text [mc "Push current HEAD"] \
 		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
@@ -144,21 +211,6 @@ proc do_push_anywhere {} {
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	${NS}::labelframe $w.source -text [mc "Source Branches"]
-	slistbox $w.source.l \
-		-height 10 \
-		-width 70 \
-		-selectmode extended
-	foreach h [load_all_heads] {
-		$w.source.l insert end $h
-		if {$h eq $current_branch} {
-			$w.source.l select set end
-			$w.source.l yview end
-		}
-	}
-	pack $w.source.l -side left -fill both -expand 1
-	pack $w.source -fill both -expand 1 -pady 5 -padx 5
-
 	${NS}::labelframe $w.dest -text [mc "Destination Repository"]
 	if {$all_remotes ne {}} {
 		${NS}::radiobutton $w.dest.remote_r \
@@ -202,7 +254,51 @@ proc do_push_anywhere {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
+	${NS}::labelframe $w.destbr -text [mc "Destination Branches"]
+	set all_branches [all_branches_combined]
+	if {$all_branches ne {}} {
+		${NS}::radiobutton $w.destbr.remote_b \
+			-text [mc "Known Branch:        "] \
+			-value existing \
+			-variable push_branchtype
+		if {$use_ttk} {
+			ttk::combobox $w.destbr.remote_n -state readonly \
+				-exportselection false \
+				-textvariable push_branch
+			set branch_combo $w.destbr.remote_n
+			update_branches
+		} else {
+			eval tk_optionMenu $w.destbr.remote_n push_branch $all_branches
+		}
+		grid $w.destbr.remote_b $w.destbr.remote_n -sticky w
+	}
+
+	${NS}::radiobutton $w.destbr.branch_r \
+		-text [mc "Arbitrary Branch:"] \
+		-value create \
+		-variable push_branchtype
+	${NS}::entry $w.destbr.branch_t \
+		-width 50 \
+		-textvariable push_new \
+		-validate key \
+		-validatecommand {
+			if {%d == 1 && [regexp {\s} %S]} {return 0}
+			if {%d == 1 && [string length %S] > 0} {
+				set push_branchtype create
+			}
+			return 1
+		}
+	grid $w.destbr.branch_r $w.destbr.branch_t -sticky we -padx {0 5}
+	${NS}::checkbutton $w.destbr.gerrit \
+		-text [mc "Push for Gerrit review (refs/for/...)"] \
+		-variable gerrit_review
+	grid $w.destbr.gerrit -columnspan 2 -sticky w
+
+	grid columnconfigure $w.destbr 1 -weight 1
+	pack $w.destbr -anchor nw -fill x -pady 5 -padx 5
+
 	${NS}::labelframe $w.options -text [mc "Transfer Options"]
+
 	${NS}::checkbutton $w.options.force \
 		-text [mc "Force overwrite existing branch (may discard changes)"] \
 		-variable push_force
@@ -222,10 +318,14 @@ proc do_push_anywhere {} {
 	set push_force 0
 	set push_thin 0
 	set push_tags 0
+	set gerrit_review 0
 
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
+	if {$all_remotes ne {}} {
+		bind $w.dest.remote_m <<ComboboxSelected>> { update_branches }
+	}
 	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
 	wm deiconify $w
 	tkwait window $w
-- 
1.7.9.5
