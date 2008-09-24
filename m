From: pasky@suse.cz
Subject: [PATCH 3/5] git-gui: Add support for adding remotes
Date: Wed, 24 Sep 2008 22:44:01 +0200
Message-ID: <20080924204615.625864882@suse.cz>
References: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:48:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibHO-0002ti-UM
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYIXUqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYIXUqc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:32 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46830 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752547AbYIXUq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:27 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 309FB2AC954; Wed, 24 Sep 2008 22:46:16 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/remote-add.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96692>

When a remote is being added, it can also be automatically either fetched
or initialized and pushed; this patch adds capability for initializing
of local and ssh repositories. This also of course leaves a lot of space
for further customization features, like individually turning the
initialization phase on/off or tuning attributes of the remote
repository; I consider that out of scope of this patch, however.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh         |    4 +
 git-gui/lib/remote.tcl     |   15 ++++
 git-gui/lib/remote_add.tcl |  190 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 75bd460..79d7597 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2305,6 +2305,10 @@ if {[is_enabled transport]} {
 	menu .mbar.remote
 
 	.mbar.remote add command \
+		-label [mc "Add..."] \
+		-command remote_add::dialog \
+		-accelerator $M1T-A
+	.mbar.remote add command \
 		-label [mc "Push..."] \
 		-command do_push_anywhere \
 		-accelerator $M1T-P
diff --git a/git-gui/lib/remote.tcl b/git-gui/lib/remote.tcl
index d97c851..643f0bc 100644
--- a/git-gui/lib/remote.tcl
+++ b/git-gui/lib/remote.tcl
@@ -221,3 +221,18 @@ proc populate_remotes_menu {} {
 		add_push_entry $r
 	}
 }
+
+proc add_single_remote {name location} {
+	global all_remotes repo_config
+	lappend all_remotes $name
+
+	git remote add $name $location
+
+	# XXX: Better re-read the config so that we will never get out
+	# of sync with git remote implementation?
+	set repo_config(remote.$name.url) $location
+	set repo_config(remote.$name.fetch) "+refs/heads/*:refs/remotes/$name/*"
+
+	add_fetch_entry $name
+	add_push_entry $name
+}
diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
new file mode 100644
index 0000000..89e88ee
--- /dev/null
+++ b/git-gui/lib/remote_add.tcl
@@ -0,0 +1,190 @@
+# git-gui remote adding support
+# Copyright (C) 2008 Petr Baudis
+
+class remote_add {
+
+field w              ; # widget path
+field w_name         ; # new remote name widget
+field w_loc          ; # new remote location widget
+
+field name         {}; # name of the remote the user has chosen
+field location     {}; # location of the remote the user has chosen
+
+field opt_action fetch; # action to do after registering the remote locally
+
+constructor dialog {} {
+	global repo_config
+
+	make_toplevel top w
+	wm title $top [append "[appname] ([reponame]): " [mc "Add Remote"]]
+	if {$top ne {.}} {
+		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+	}
+
+	label $w.header -text [mc "Add New Remote"] -font font_uibold
+	pack $w.header -side top -fill x
+
+	frame $w.buttons
+	button $w.buttons.create -text [mc Add] \
+		-default active \
+		-command [cb _add]
+	pack $w.buttons.create -side right
+	button $w.buttons.cancel -text [mc Cancel] \
+		-command [list destroy $w]
+	pack $w.buttons.cancel -side right -padx 5
+	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+
+	labelframe $w.desc -text [mc "Remote Details"]
+
+	label $w.desc.name_l -text [mc "Name:"]
+	set w_name $w.desc.name_t
+	entry $w_name \
+		-borderwidth 1 \
+		-relief sunken \
+		-width 40 \
+		-textvariable @name \
+		-validate key \
+		-validatecommand [cb _validate_name %d %S]
+	grid $w.desc.name_l $w_name -sticky we -padx {0 5}
+
+	label $w.desc.loc_l -text [mc "Location:"]
+	set w_loc $w.desc.loc_t
+	entry $w_loc \
+		-borderwidth 1 \
+		-relief sunken \
+		-width 40 \
+		-textvariable @location
+	grid $w.desc.loc_l $w_loc -sticky we -padx {0 5}
+
+	grid columnconfigure $w.desc 1 -weight 1
+	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
+
+	labelframe $w.action -text [mc "Further Action"]
+
+	radiobutton $w.action.fetch \
+		-text [mc "Fetch Immediately"] \
+		-value fetch \
+		-variable @opt_action
+	pack $w.action.fetch -anchor nw
+
+	radiobutton $w.action.push \
+		-text [mc "Initialize Remote Repository and Push"] \
+		-value push \
+		-variable @opt_action
+	pack $w.action.push -anchor nw
+
+	radiobutton $w.action.none \
+		-text [mc "Do Nothing Else Now"] \
+		-value none \
+		-variable @opt_action
+	pack $w.action.none -anchor nw
+
+	grid columnconfigure $w.action 1 -weight 1
+	pack $w.action -anchor nw -fill x -pady 5 -padx 5
+
+	bind $w <Visibility> [cb _visible]
+	bind $w <Key-Escape> [list destroy $w]
+	bind $w <Key-Return> [cb _add]\;break
+	tkwait window $w
+}
+
+method _add {} {
+	global repo_config env
+	global M1B
+
+	if {$name eq {}} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title [wm title $w] \
+			-parent $w \
+			-message [mc "Please supply a remote name."]
+		focus $w_name
+		return
+	}
+
+	# XXX: We abuse check-ref-format here, but
+	# that should be ok.
+	if {[catch {git check-ref-format "remotes/$name"}]} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title [wm title $w] \
+			-parent $w \
+			-message [mc "'%s' is not an acceptable remote name." $name]
+		focus $w_name
+		return
+	}
+
+	if {[catch {add_single_remote $name $location}]} {
+		tk_messageBox \
+			-icon error \
+			-type ok \
+			-title [wm title $w] \
+			-parent $w \
+			-message [mc "Failed to add remote '%s' of location '%s'." $name $location]
+		focus $w_name
+		return
+	}
+
+	switch -- $opt_action {
+	fetch {
+		set c [console::new \
+			[mc "fetch %s" $remote] \
+			[mc "Fetching the %s" $remote]]
+		console::exec $c [list git fetch --all $name]
+	}
+	push {
+		set cmds [list]
+
+		# Parse the location
+		if { [regexp {(?:git\+)?ssh://([^/]+)(/.+)} $location xx host path]
+		     || [regexp {([^:][^:]+):(.+)} $location xx host path]} {
+			set ssh ssh
+			if {[info exists env(GIT_SSH)]} {
+				set ssh $env(GIT_SSH)
+			}
+			lappend cmds [list exec $ssh $host git --git-dir=$path init --bare]
+		} elseif { ! [regexp {://} $location xx] } {
+			lappend cmds [list exec git --git-dir=$location init --bare]
+		} else {
+			tk_messageBox \
+				-icon error \
+				-type ok \
+				-title [wm title $w] \
+				-parent $w \
+				-message [mc "Do not know how to initialize repository at location '%s'." $location]
+			destroy $w
+			return
+		}
+
+		set c [console::new \
+			[mc "push %s" $name] \
+			[mc "Setting up the %s (at %s)" $name $location]]
+
+		lappend cmds [list exec git push -v --all $name]
+		console::chain $c $cmds
+	}
+	none {
+	}
+	}
+
+	destroy $w
+}
+
+method _validate_name {d S} {
+	if {$d == 1} {
+		if {[regexp {[~^:?*\[\0- ]} $S]} {
+			return 0
+		}
+	}
+	return 1
+}
+
+method _visible {} {
+	grab $w
+	$w_name icursor end
+	focus $w_name
+}
+
+}
-- 
tg: (fd699bc..) t/git-gui/remote-add (depends on: t/git-gui/populate-refactor)
