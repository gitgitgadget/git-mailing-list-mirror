From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 2/3] git-gui: Add a Tools menu for arbitrary commands.
Date: Thu, 13 Nov 2008 22:35:49 +0300
Message-ID: <1226604950-18667-3-git-send-email-angavrilov@gmail.com>
References: <1226604950-18667-1-git-send-email-angavrilov@gmail.com>
 <1226604950-18667-2-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0i2N-00079I-2c
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbYKMTiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbYKMTiN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:38:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:29585 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYKMTiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:38:05 -0500
Received: by fg-out-1718.google.com with SMTP id 19so860538fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 11:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EjTIN3rix+tWbgPUokPRC4Zpjnap35aJg7vGEBtVmLQ=;
        b=gsi4AQykrnsfPCMBLV5p4B3xZtn1AheJt2GZMJwk6gH3aoXxiHuXJaOokyI//putaA
         xqs5yx/BosFoA6Z2lh0wk6Vgw49b+6Ow3fOxjs7j67nmsCejxUj+yUGXsTnj1Zme6itq
         pE7dxPOFE3opNXl8mIMfPva7BCym70Tnm46qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qjZegvyRMZyDQuHs2EtjfXFAxRBuph7rddvB4ogoa0I0TsShChpAoH0250LOWPXEsT
         yOB3vShb51Ks5VMp5XvBP5MRIUNwe5QYCouPm5Q/RO1Jtg/X+PrwpQNHVl89gMggXYsR
         Xn2Bmfap5DRGsbCwUDaQfBBT65eHK39eGsx48=
Received: by 10.180.224.13 with SMTP id w13mr22936bkg.160.1226605081809;
        Thu, 13 Nov 2008 11:38:01 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm5268685fkh.11.2008.11.13.11.37.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 11:38:00 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226604950-18667-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100902>

Due to the emphasis on scriptability in the git
design, it is impossible to provide 100% complete
GUI. Currently unaccounted areas include git-svn
and other source control system interfaces, TopGit,
all custom scripts.

This problem can be mitigated by providing basic
customization capabilities in Git Gui. This commit
adds a new Tools menu, which can be configured
to contain items invoking arbitrary shell commands.

The interface is powerful enough to allow calling
both batch text programs like git-svn, and GUI editors.
To support the latter use, the commands have access
to the name of the currently selected file through
the environment.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |   17 ++++
 lib/tools.tcl     |  107 ++++++++++++++++++++++++
 lib/tools_dlg.tcl |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+), 0 deletions(-)
 create mode 100644 lib/tools.tcl
 create mode 100644 lib/tools_dlg.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 34214b6..2efbe73 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2252,6 +2252,9 @@ if {[is_enabled transport]} {
 	.mbar add cascade -label [mc Merge] -menu .mbar.merge
 	.mbar add cascade -label [mc Remote] -menu .mbar.remote
 }
+if {[is_enabled multicommit] || [is_enabled singlecommit]} {
+	.mbar add cascade -label [mc Tools] -menu .mbar.tools
+}
 . configure -menu .mbar
 
 # -- Repository Menu
@@ -2526,6 +2529,20 @@ if {[is_MacOSX]} {
 		-command do_options
 }
 
+# -- Tools Menu
+#
+if {[is_enabled multicommit] || [is_enabled singlecommit]} {
+	set tools_menubar .mbar.tools
+	menu $tools_menubar
+	$tools_menubar add separator
+	$tools_menubar add command -label [mc "Add..."] -command tools_add::dialog
+	$tools_menubar add command -label [mc "Remove..."] -command tools_remove::dialog
+	set tools_tailcnt 3
+	if {[array names repo_config guitool.*.cmd] ne {}} {
+		tools_populate_all
+	}
+}
+
 # -- Help Menu
 #
 .mbar add cascade -label [mc Help] -menu .mbar.help
diff --git a/lib/tools.tcl b/lib/tools.tcl
new file mode 100644
index 0000000..0bef503
--- /dev/null
+++ b/lib/tools.tcl
@@ -0,0 +1,107 @@
+# git-gui Tools menu implementation
+
+proc tools_list {} {
+	global repo_config
+
+	set names {}
+	foreach item [array names repo_config guitool.*.cmd] {
+		lappend names [string range $item 8 end-4]
+	}
+	return [lsort $names]
+}
+
+proc tools_populate_all {} {
+	global tools_menubar tools_menutbl
+	global tools_tailcnt
+
+	set mbar_end [$tools_menubar index end]
+	set mbar_base [expr {$mbar_end - $tools_tailcnt}]
+	if {$mbar_base >= 0} {
+		$tools_menubar delete 0 $mbar_base
+	}
+
+	array unset tools_menutbl
+
+	foreach fullname [tools_list] {
+		tools_populate_one $fullname
+	}
+}
+
+proc tools_create_item {parent args} {
+	global tools_menubar tools_tailcnt
+	if {$parent eq $tools_menubar} {
+		set pos [expr {[$parent index end]-$tools_tailcnt+1}]
+		eval [list $parent insert $pos] $args
+	} else {
+		eval [list $parent add] $args
+	}
+}
+
+proc tools_populate_one {fullname} {
+	global tools_menubar tools_menutbl tools_id
+
+	if {![info exists tools_id]} {
+		set tools_id 0
+	}
+
+	set names [split $fullname '/']
+	set parent $tools_menubar
+	for {set i 0} {$i < [llength $names]-1} {incr i} {
+		set subname [join [lrange $names 0 $i] '/']
+		if {[info exists tools_menutbl($subname)]} {
+			set parent $tools_menutbl($subname)
+		} else {
+			set subid $parent.t$tools_id
+			tools_create_item $parent cascade \
+					-label [lindex $names $i] -menu $subid
+			menu $subid
+			set tools_menutbl($subname) $subid
+			set parent $subid
+			incr tools_id
+		}
+	}
+
+	tools_create_item $parent command \
+		-label [lindex $names end] \
+		-command [list tools_exec $fullname]
+}
+
+proc tools_exec {fullname} {
+	global repo_config env current_diff_path
+	global current_branch is_detached
+
+	if {[is_config_true "guitool.$fullname.needsfile"]} {
+		if {$current_diff_path eq {}} {
+			error_popup [mc "Running %s requires a selected file." $fullname]
+			return
+		}
+	}
+
+	if {[is_config_true "guitool.$fullname.confirm"]} {
+		if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
+			return
+		}
+	}
+
+	set env(GIT_GUITOOL) $fullname
+	set env(FILENAME) $current_diff_path
+	if {$is_detached} {
+		set env(CUR_BRANCH) ""
+	} else {
+		set env(CUR_BRANCH) $current_branch
+	}
+
+	set cmdline $repo_config(guitool.$fullname.cmd)
+	if {[is_config_true "guitool.$fullname.noconsole"]} {
+		exec sh -c $cmdline &
+	} else {
+		set w [console::new \
+			[mc "Tool %s" $fullname] \
+			[mc "Running %s" $cmdline]]
+		console::exec $w [list sh -c $cmdline]
+	}
+
+	unset env(GIT_GUITOOL)
+	unset env(FILENAME)
+	unset env(CUR_BRANCH)
+}
diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
new file mode 100644
index 0000000..c221ba9
--- /dev/null
+++ b/lib/tools_dlg.tcl
@@ -0,0 +1,234 @@
+# git-gui Tools menu dialogs
+
+class tools_add {
+
+field w              ; # widget path
+field w_name         ; # new remote name widget
+field w_cmd          ; # new remote location widget
+
+field name         {}; # name of the tool
+field command      {}; # command to execute
+field add_global    0; # add to the --global config
+field no_console    0; # disable using the console
+field needs_file    0; # ensure filename is set
+field confirm       0; # ask for confirmation
+
+constructor dialog {} {
+	global repo_config
+
+	make_toplevel top w
+	wm title $top [append "[appname] ([reponame]): " [mc "Add Tool"]]
+	if {$top ne {.}} {
+		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+		wm transient $top .
+	}
+
+	label $w.header -text [mc "Add New Tool Command"] -font font_uibold
+	pack $w.header -side top -fill x
+
+	frame $w.buttons
+	checkbutton $w.buttons.global \
+		-text [mc "Add globally"] \
+		-variable @add_global
+	pack $w.buttons.global -side left -padx 5
+	button $w.buttons.create -text [mc Add] \
+		-default active \
+		-command [cb _add]
+	pack $w.buttons.create -side right
+	button $w.buttons.cancel -text [mc Cancel] \
+		-command [list destroy $w]
+	pack $w.buttons.cancel -side right -padx 5
+	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+
+	labelframe $w.desc -text [mc "Tool Details"]
+
+	label $w.desc.name_cmnt -anchor w\
+		-text [mc "Use '/' separators to create a submenu tree:"]
+	grid x $w.desc.name_cmnt -sticky we -padx {0 5} -pady {0 2}
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
+	label $w.desc.cmd_l -text [mc "Command:"]
+	set w_cmd $w.desc.cmd_t
+	entry $w_cmd \
+		-borderwidth 1 \
+		-relief sunken \
+		-width 40 \
+		-textvariable @command
+	grid $w.desc.cmd_l $w_cmd -sticky we -padx {0 5} -pady {0 3}
+
+	grid columnconfigure $w.desc 1 -weight 1
+	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
+
+	checkbutton $w.confirm \
+		-text [mc "Ask for confirmation before running"] \
+		-variable @confirm
+	pack $w.confirm -anchor w -pady {5 0} -padx 5
+
+	checkbutton $w.noconsole \
+		-text [mc "Don't show the command output window"] \
+		-variable @no_console
+	pack $w.noconsole -anchor w -padx 5
+
+	checkbutton $w.needsfile \
+		-text [mc "Run only if a diff is selected (\$FILENAME not empty)"] \
+		-variable @needs_file
+	pack $w.needsfile -anchor w -padx 5
+
+	bind $w <Visibility> [cb _visible]
+	bind $w <Key-Escape> [list destroy $w]
+	bind $w <Key-Return> [cb _add]\;break
+	tkwait window $w
+}
+
+method _add {} {
+	global repo_config
+
+	if {$name eq {}} {
+		error_popup [mc "Please supply a name for the tool."]
+		focus $w_name
+		return
+	}
+
+	set item "guitool.$name.cmd"
+
+	if {[info exists repo_config($item)]} {
+		error_popup [mc "Tool '%s' already exists." $name]
+		focus $w_name
+		return
+	}
+
+	set cmd [list git config]
+	if {$add_global} { lappend cmd --global }
+	set items {}
+	if {$no_console} { lappend items "guitool.$name.noconsole" }
+	if {$confirm}    { lappend items "guitool.$name.confirm" }
+	if {$needs_file} { lappend items "guitool.$name.needsfile" }
+
+	if {[catch {
+		eval $cmd [list $item $command]
+		foreach citem $items { eval $cmd [list $citem yes] }
+	    } err]} {
+		error_popup [mc "Could not add tool:\n%s" $err]
+	} else {
+		set repo_config($item) $command
+		foreach citem $items { set repo_config($citem) yes }
+
+		tools_populate_all
+	}
+
+	destroy $w
+}
+
+method _validate_name {d S} {
+	if {$d == 1} {
+		if {[regexp {[~?*&\[\0\"\\\{]} $S]} {
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
+
+class tools_remove {
+
+field w              ; # widget path
+field w_names        ; # name list
+
+constructor dialog {} {
+	global repo_config global_config system_config
+
+	load_config 1
+
+	make_toplevel top w
+	wm title $top [append "[appname] ([reponame]): " [mc "Remove Tool"]]
+	if {$top ne {.}} {
+		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+		wm transient $top .
+	}
+
+	label $w.header -text [mc "Remove Tool Commands"] -font font_uibold
+	pack $w.header -side top -fill x
+
+	frame $w.buttons
+	button $w.buttons.create -text [mc Remove] \
+		-default active \
+		-command [cb _remove]
+	pack $w.buttons.create -side right
+	button $w.buttons.cancel -text [mc Cancel] \
+		-command [list destroy $w]
+	pack $w.buttons.cancel -side right -padx 5
+	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+
+	frame $w.list
+	set w_names $w.list.l
+	listbox $w_names \
+		-height 10 \
+		-width 30 \
+		-selectmode extended \
+		-exportselection false \
+		-yscrollcommand [list $w.list.sby set]
+	scrollbar $w.list.sby -command [list $w.list.l yview]
+	pack $w.list.sby -side right -fill y
+	pack $w.list.l -side left -fill both -expand 1
+	pack $w.list -fill both -expand 1 -pady 5 -padx 5
+
+	set local_cnt 0
+	foreach fullname [tools_list] {
+		# Cannot delete system tools
+		if {[info exists system_config(guitool.$fullname.cmd)]} continue
+
+		$w_names insert end $fullname
+		if {![info exists global_config(guitool.$fullname.cmd)]} {
+			$w_names itemconfigure end -foreground blue
+			incr local_cnt
+		}
+	}
+
+	if {$local_cnt > 0} {
+		label $w.colorlbl -foreground blue \
+			-text [mc "(Blue denotes repository-local tools)"]
+		pack $w.colorlbl -fill x -pady 5 -padx 5
+	}
+
+	bind $w <Visibility> [cb _visible]
+	bind $w <Key-Escape> [list destroy $w]
+	bind $w <Key-Return> [cb _remove]\;break
+	tkwait window $w
+}
+
+method _remove {} {
+	foreach i [$w_names curselection] {
+		set name [$w_names get $i]
+
+		catch { git config --remove-section guitool.$name }
+		catch { git config --global --remove-section guitool.$name }
+	}
+
+	load_config 0
+	tools_populate_all
+
+	destroy $w
+}
+
+method _visible {} {
+	grab $w
+	focus $w_names
+}
+
+}
-- 
1.6.0.3.15.gb8d36
