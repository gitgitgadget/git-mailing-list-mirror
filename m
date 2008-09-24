From: pasky@suse.cz
Subject: [PATCH 3/3] [FYI]git-gui: repo.or.cz-ish fork integration
Date: Thu, 25 Sep 2008 01:57:37 +0200
Message-ID: <20080925000157.506352696@suse.cz>
References: <20080924235734.697978308@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 02:03:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KieKO-0003We-SN
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 02:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYIYACQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 20:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYIYACO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 20:02:14 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50392 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbYIYACJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 20:02:09 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 2A1372AC954; Thu, 25 Sep 2008 02:01:57 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/remote-publish.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96720>

During my internship at Novartis, I have deployed a local instance of the
repo.or.cz software and for our Git deployment, some kind of integration with
git-gui was very desirable - if someone makes local changes in his repository,
he can easily publish them on the local repo.or.cz instance as a fork of the
original project. They can use the extra 'Register on repo.or.cz' item in the
'Remote' menu, which will enforce the default locator and aside of initializing
the remote repository and pushing will also open the web browser with the
project registration form of repo.or.cz.

I'm not sure if something like this would be desirable for upstream, even as an
optional feature, and to what degree should it be configurable - but I imagine
that something like this could be very useful for corporate Git deployments
especially among less technical users and in scenarios using some kind of
central place to store all the repositories. Perhaps people deploying Git
in these cases will find the patch useful to apply locally even if it won't
end up merged.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh         |    4 ++++
 git-gui/lib/remote_add.tcl |   42 +++++++++++++++++++++++++++++++++++++-----
 git-gui/lib/transport.tcl  |    7 +++++++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index aef9d66..a79d734 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2305,6 +2305,10 @@ if {[is_enabled transport]} {
 	menu .mbar.remote
 
 	.mbar.remote add command \
+		-label [mc "Register on repo.or.cz"] \
+		-command remote_add::dialog_reg \
+		-accelerator $M1T-L
+	.mbar.remote add command \
 		-label [mc "Add..."] \
 		-command remote_add::dialog \
 		-accelerator $M1T-A
diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
index 94662fb..fb43abd 100644
--- a/git-gui/lib/remote_add.tcl
+++ b/git-gui/lib/remote_add.tcl
@@ -6,22 +6,36 @@ class remote_add {
 field w              ; # widget path
 field w_name         ; # new remote name widget
 field w_loc          ; # new remote location widget
+field is_reg        0; # are we the REGistering dialog, or normal add remote?
+field base_name      ; # name of base project if is_reg
 
 field name         {}; # name of the remote the user has chosen
 field location     {}; # location of the remote the user has chosen
 
-field opt_action fetch; # action to do after registering the remote locally
+field opt_action   {}; # action to do after registering the remote locally
 
-constructor dialog {} {
+proc dialog {} {
+	dialog_create "" 0 "fetch" "Add New Remote"
+}
+
+proc dialog_reg {} {
+	dialog_create "public" 1 "push" "Register On repo.or.cz"
+}
+
+constructor dialog_create {name_ is_reg_ opt_action_ title} {
 	global repo_config
 
+	set name $name_
+	set is_reg $is_reg_
+	set opt_action $opt_action_
+
 	make_toplevel top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Add Remote"]]
+	wm title $top [append "[appname] ([reponame]): " [mc $title]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Add New Remote"] -font font_uibold
+	label $w.header -text [mc $title] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
@@ -49,7 +63,9 @@ constructor dialog {} {
 
 	label $w.desc.loc_l -text [mc "Location:"]
 	set w_loc $w.desc.loc_t
-	location_input $w_loc @location remote
+	set location_op "remote"
+	if {$is_reg} { set location_op "reg" }
+	location_input $w_loc @location $location_op
 	grid $w.desc.loc_l $w_loc -sticky we -padx {0 5}
 
 	grid columnconfigure $w.desc 1 -weight 1
@@ -78,6 +94,18 @@ constructor dialog {} {
 	grid columnconfigure $w.action 1 -weight 1
 	pack $w.action -anchor nw -fill x -pady 5 -padx 5
 
+	if {$is_reg} {
+		focus $w_loc
+		set matcher [regsub -all %s "$repo_config(locator.repo.template)" "(.*)"]
+		set origin willnevermatch
+		catch { set origin $repo_config(remote.origin.url) }
+		if {![regexp $matcher $origin xx base_name]} {
+			error_popup "This repository is not based on a repo.or.cz project; you need to register your project manually."
+			destroy $w
+			return
+		}
+	}
+
 	bind $w <Visibility> [cb _visible]
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _add]\;break
@@ -160,6 +188,10 @@ method _add {} {
 			[mc "Setting up the %s (at %s)" $name $location]]
 
 		lappend cmds [list exec git push -v --all $name]
+		if {$is_reg} {
+			global _locator_input
+			start_browser "http://repo.or.cz/m/regproj.cgi?fork=$base_name;LOC_i1=$_locator_input"
+		}
 		console::chain $c $cmds
 	}
 	none {
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 277e6b8..b80d526 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -62,6 +62,12 @@ proc location_input {widget urlvar op} {
 		return 0
 	}
 
+	set state "normal"
+	if {$op == "reg"} {
+		set state "disabled"
+		set op "remote"
+	}
+
 	if {[catch {set default_locator $repo_config(gui.${op}locator)}]} {
 		set default_locator [lindex $all_locators 0]
 	}
@@ -75,6 +81,7 @@ proc location_input {widget urlvar op} {
 
 	frame $widget
 	eval tk_optionMenu $widget.l _locator_template $all_locators
+	$widget.l configure -state $state
 	entry $widget.s \
 		-borderwidth 1 \
 		-relief sunken \
-- 
tg: (2735999..) t/git-gui/remote-publish (depends on: git-gui/remotes git-gui/locators git-gui/web-browse t/git-gui/remote-fetch)
