From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 3/3] git-gui: Allow Tools to request arguments from the user.
Date: Thu, 13 Nov 2008 22:35:50 +0300
Message-ID: <1226604950-18667-4-git-send-email-angavrilov@gmail.com>
References: <1226604950-18667-1-git-send-email-angavrilov@gmail.com>
 <1226604950-18667-2-git-send-email-angavrilov@gmail.com>
 <1226604950-18667-3-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0i2M-00079I-8V
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbYKMTiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYKMTiK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:38:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:40616 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbYKMTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:38:07 -0500
Received: by fg-out-1718.google.com with SMTP id 19so860553fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nyzqXy27BDkDly2H48rAuIaNzBuvdgzhMy8WnHw7Mio=;
        b=Gfb8AYdsc0SlBkty/PwCO0RPVIpDv2cNu6W5AkojdLY3U3FpmtqzAJL50zvVOVCR48
         lHtG55CK+drGqGNiGhSLowm8j1LuoFRsDdG66ZZv7h1CU6zqT25L4rPYIS1D8JstyM4e
         xoXjL40kJVQqbf8SRC3DCSmHSPQ2/TCLD+CuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rAAsmEEXt6cSQgd47JSpnoFAOM1saLMJMcK/UBYTu2Sdjk6p8ppd7yL7eY8TWRSYNk
         E90lQX8dRmW6Ziichl9htS/tMwrqB+fWwgCAyPM+BoVIliueQoZ6at0ocsmq0C19uhJJ
         yE9lBxshhj+LiPGetsSO4zSKe2Hd+0iOB0uWc=
Received: by 10.181.159.17 with SMTP id l17mr32969bko.14.1226605085242;
        Thu, 13 Nov 2008 11:38:05 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm5268685fkh.11.2008.11.13.11.38.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 11:38:03 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226604950-18667-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100901>

While static commands are already useful, some tools need
additional parameters to reach maximum usability. This
commit adds support for passing them one revision name
parameter, and one arbitrary string. With this addition,
the tools menu becomes flexible enough to implement basic
rebase support:

[core]
        editor = kwrite
[guitool "Rebase/Abort"]
        cmd = git rebase --abort
        confirm = yes
[guitool "Rebase/Continue"]
        cmd = git rebase --continue
[guitool "Rebase/Skip Commit"]
        cmd = git rebase --skip
        confirm = yes
[guitool "Rebase/Start..."]
        cmd = git rebase $ARGS $REVISION $CUR_BRANCH
        title = Start Rebase
        prompt = Rebase Current Branch
        argprompt = Flags
        revprompt = New Base
        revunmerged = yes

Some of the options, like title or prompt, are intentionally
not included in the Add dialog to avoid clutter. Also, the
dialog handles argprompt and revprompt as boolean vars.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/tools.tcl     |   13 +++-
 lib/tools_dlg.tcl |  194 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 0bef503..9cb2dbc 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -77,7 +77,16 @@ proc tools_exec {fullname} {
 		}
 	}
 
-	if {[is_config_true "guitool.$fullname.confirm"]} {
+	catch { unset env(ARGS) }
+	catch { unset env(REVISION) }
+
+	if {[get_config "guitool.$fullname.revprompt"] ne {} ||
+	    [get_config "guitool.$fullname.argprompt"] ne {}} {
+		set dlg [tools_askdlg::dialog $fullname]
+		if {![tools_askdlg::execute $dlg]} {
+			return
+		}
+	} elseif {[is_config_true "guitool.$fullname.confirm"]} {
 		if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
 			return
 		}
@@ -104,4 +113,6 @@ proc tools_exec {fullname} {
 	unset env(GIT_GUITOOL)
 	unset env(FILENAME)
 	unset env(CUR_BRANCH)
+	catch { unset env(ARGS) }
+	catch { unset env(REVISION) }
 }
diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
index c221ba9..ca9a95f 100644
--- a/lib/tools_dlg.tcl
+++ b/lib/tools_dlg.tcl
@@ -12,6 +12,8 @@ field add_global    0; # add to the --global config
 field no_console    0; # disable using the console
 field needs_file    0; # ensure filename is set
 field confirm       0; # ask for confirmation
+field ask_branch    0; # ask for a revision
+field ask_args      0; # ask for additional args
 
 constructor dialog {} {
 	global repo_config
@@ -69,9 +71,22 @@ constructor dialog {} {
 	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
 
 	checkbutton $w.confirm \
-		-text [mc "Ask for confirmation before running"] \
-		-variable @confirm
-	pack $w.confirm -anchor w -pady {5 0} -padx 5
+		-text [mc "Show a dialog before running"] \
+		-variable @confirm -command [cb _check_enable_dlg]
+
+	labelframe $w.dlg -labelwidget $w.confirm
+
+	checkbutton $w.dlg.askbranch \
+		-text [mc "Ask the user to select a revision (sets \$REVISION)"] \
+		-variable @ask_branch -state disabled
+	pack $w.dlg.askbranch -anchor w -padx 15
+
+	checkbutton $w.dlg.askargs \
+		-text [mc "Ask the user for additional arguments (sets \$ARGS)"] \
+		-variable @ask_args -state disabled
+	pack $w.dlg.askargs -anchor w -padx 15
+
+	pack $w.dlg -anchor nw -fill x -pady {0 8} -padx 5
 
 	checkbutton $w.noconsole \
 		-text [mc "Don't show the command output window"] \
@@ -89,6 +104,16 @@ constructor dialog {} {
 	tkwait window $w
 }
 
+method _check_enable_dlg {} {
+	if {$confirm} {
+		$w.dlg.askbranch configure -state normal
+		$w.dlg.askargs configure -state normal
+	} else {
+		$w.dlg.askbranch configure -state disabled
+		$w.dlg.askargs configure -state disabled
+	}
+}
+
 method _add {} {
 	global repo_config
 
@@ -110,8 +135,14 @@ method _add {} {
 	if {$add_global} { lappend cmd --global }
 	set items {}
 	if {$no_console} { lappend items "guitool.$name.noconsole" }
-	if {$confirm}    { lappend items "guitool.$name.confirm" }
 	if {$needs_file} { lappend items "guitool.$name.needsfile" }
+	if {$confirm} {
+		if {$ask_args}   { lappend items "guitool.$name.argprompt" }
+		if {$ask_branch} { lappend items "guitool.$name.revprompt" }
+		if {!$ask_args && !$ask_branch} {
+			lappend items "guitool.$name.confirm"
+		}
+	}
 
 	if {[catch {
 		eval $cmd [list $item $command]
@@ -232,3 +263,158 @@ method _visible {} {
 }
 
 }
+
+class tools_askdlg {
+
+field w              ; # widget path
+field w_rev        {}; # revision browser
+field w_args       {}; # arguments
+
+field is_ask_args   0; # has arguments field
+field is_ask_revs   0; # has revision browser
+
+field is_ok         0; # ok to start
+field argstr       {}; # arguments
+
+constructor dialog {fullname} {
+	global M1B
+
+	set title [get_config "guitool.$fullname.title"]
+	if {$title eq {}} {
+		set title [mc "Run Tool %s" $fullname]
+	}
+
+	make_toplevel top w -autodelete 0
+	wm title $top [append "[appname] ([reponame]): " $title]
+	if {$top ne {.}} {
+		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+		wm transient $top .
+	}
+
+	set prompt [get_config "guitool.$fullname.prompt"]
+	if {$prompt eq {}} {
+		set prompt [mc "Run Tool Command %s" $fullname]
+	}
+
+	label $w.header -text $prompt -font font_uibold
+	pack $w.header -side top -fill x
+
+	set argprompt [get_config "guitool.$fullname.argprompt"]
+	set revprompt [get_config "guitool.$fullname.revprompt"]
+
+	set is_ask_args [expr {$argprompt ne {}}]
+	set is_ask_revs [expr {$revprompt ne {}}]
+
+	if {$is_ask_args} {
+		if {$argprompt eq {yes} || $argprompt eq {true} || $argprompt eq {1}} {
+			set argprompt [mc "Arguments"]
+		}
+
+		labelframe $w.arg -text $argprompt
+
+		set w_args $w.arg.txt
+		entry $w_args \
+			-borderwidth 1 \
+			-relief sunken \
+			-width 40 \
+			-textvariable @argstr
+		pack $w_args -padx 5 -pady 5 -fill both
+		pack $w.arg -anchor nw -fill both -pady 5 -padx 5
+	}
+
+	if {$is_ask_revs} {
+		if {$revprompt eq {yes} || $revprompt eq {true} || $revprompt eq {1}} {
+			set revprompt [mc "Revision"]
+		}
+
+		if {[is_config_true "guitool.$fullname.revunmerged"]} {
+			set w_rev [::choose_rev::new_unmerged $w.rev $revprompt]
+		} else {
+			set w_rev [::choose_rev::new $w.rev $revprompt]
+		}
+
+		pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
+	}
+
+	frame $w.buttons
+	if {$is_ask_revs} {
+		button $w.buttons.visualize \
+			-text [mc Visualize] \
+			-command [cb _visualize]
+		pack $w.buttons.visualize -side left
+	}
+	button $w.buttons.ok \
+		-text [mc OK] \
+		-command [cb _start]
+	pack $w.buttons.ok -side right
+	button $w.buttons.cancel \
+		-text [mc "Cancel"] \
+		-command [cb _cancel]
+	pack $w.buttons.cancel -side right -padx 5
+	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+
+	bind $w <$M1B-Key-Return> [cb _start]
+	bind $w <Key-Return> [cb _start]
+	bind $w <Key-Escape> [cb _cancel]
+	wm protocol $w WM_DELETE_WINDOW [cb _cancel]
+
+	bind $w <Visibility> [cb _visible]
+	return $this
+}
+
+method execute {} {
+	tkwait window $w
+	set rv $is_ok
+	delete_this
+	return $rv
+}
+
+method _visible {} {
+	grab $w
+	if {$is_ask_args} {
+		focus $w_args
+	} elseif {$is_ask_revs} {
+		$w_rev focus_filter
+	}
+}
+
+method _cancel {} {
+	wm protocol $w WM_DELETE_WINDOW {}
+	destroy $w
+}
+
+method _rev {} {
+	if {[catch {$w_rev commit_or_die}]} {
+		return {}
+	}
+	return [$w_rev get]
+}
+
+method _visualize {} {
+	global current_branch
+	set rev [_rev $this]
+	if {$rev ne {}} {
+		do_gitk [list --left-right "$current_branch...$rev"]
+	}
+}
+
+method _start {} {
+	global env
+
+	if {$is_ask_revs} {
+		set name [_rev $this]
+		if {$name eq {}} {
+			return
+		}
+		set env(REVISION) $name
+	}
+
+	if {$is_ask_args} {
+		set env(ARGS) $argstr
+	}
+
+	set is_ok 1
+	_cancel $this
+}
+
+}
-- 
1.6.0.3.15.gb8d36
