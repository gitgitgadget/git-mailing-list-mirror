From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 1/8] git gui: add a "compose review email" checkbox to push dialog
Date: Mon, 21 Sep 2009 15:06:48 +0200
Message-ID: <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicE-0002uk-2o
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104AbZIUNHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbZIUNHA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:00 -0400
Received: from darksea.de ([83.133.111.250]:35690 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756033AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28813 invoked from network); 21 Sep 2009 15:06:56 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:56 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128881>

This is useful when working with a central server. If a developer wants
to send his changes to a reviewer we can help him fill out the necessary
information about the branch he has pushed and launch his default email
composer.

Composition of such an email is currently only allowed for pushing one
branch because the subject line size is limited.
---
 git-gui/git-gui.sh        |    2 +
 git-gui/lib/option.tcl    |    2 +
 git-gui/lib/transport.tcl |   75 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3c0ce26..dfc1652 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -737,6 +737,8 @@ set default_config(gui.matchtrackingbranch) false
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.fastcopyblame) false
+set default_config(gui.emailafterpush) false
+set default_config(gui.upstreambranch) {master}
 set default_config(gui.copyblamethreshold) 40
 set default_config(gui.blamehistoryctx) 7
 set default_config(gui.diffcontext) 5
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 1d55b49..55ecfe6 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -147,6 +147,8 @@ proc do_options {} {
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
+		{b gui.emailafterpush {mc "Open Email Composer after Push of Feature Branch"}}
+		{t gui.upstreambranch {mc "Upstream branch"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index b18d9c7..77a2f46 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -30,10 +30,63 @@ proc push_to {remote} {
 	console::exec $w $cmd
 }
 
+proc compose_email {to subject} {
+	set mail_link mailto:
+	append mail_link $to "?subject=" $subject
+	start_browser $mail_link
+}
+
+proc after_push_anywhere_action {cons ok} {
+	global push_email r_url branches
+
+	console::done $cons $ok
+
+	if {$ok} {
+		if {$push_email} {
+			set rconfig_var "remote.$r_url.url"
+			set remote_url [exec git config $rconfig_var]
+			set remote_short_name [lindex [split $remote_url / ] end ]
+			set remote_short_name [lindex [split $remote_short_name . ] 0 ]
+			# TODO: create a configuration variable for the
+			# subject
+			set email_subject "Review%20request:%20$remote_short_name:$branches"
+			compose_email {} $email_subject
+		}
+	}
+}
+
+proc do_push_on_change_branch {w} {
+	global upstream_branch
+
+	$w.options.email select
+
+	set cnt 0
+	set b {}
+	foreach i [$w.source.l curselection] {
+		set b [$w.source.l get $i]
+		incr cnt
+	}
+
+	if {$cnt != 1} {
+		$w.options.email deselect
+		$w.options.email configure -state disabled
+		return
+	}
+
+	$w.options.email configure -state normal
+
+	if { $b eq $upstream_branch } {
+		if {[is_config_true gui.emailafterpush]} {
+			$w.options.email deselect
+		}
+	}
+}
+
 proc start_push_anywhere_action {w} {
 	global push_urltype push_remote push_url push_thin push_tags
 	global push_force
 	global repo_config
+	global r_url branches
 
 	set is_mirror 0
 	set r_url {}
@@ -64,9 +117,11 @@ proc start_push_anywhere_action {w} {
 			[mc "Mirroring to %s" $r_url]]
 	} else {
 		set cnt 0
+		set branches {}
 		foreach i [$w.source.l curselection] {
 			set b [$w.source.l get $i]
 			lappend cmd "refs/heads/$b:refs/heads/$b"
+			lappend branches $b
 			incr cnt
 		}
 		if {$cnt == 0} {
@@ -81,7 +136,7 @@ proc start_push_anywhere_action {w} {
 			[mc "push %s" $r_url] \
 			[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
 	}
-	console::exec $cons $cmd
+	console::exec $cons $cmd "after_push_anywhere_action $cons"
 	destroy $w
 }
 
@@ -91,7 +146,8 @@ trace add variable push_remote write \
 proc do_push_anywhere {} {
 	global all_remotes current_branch
 	global push_urltype push_remote push_url push_thin push_tags
-	global push_force
+	global push_force push_email upstream_branch
+	global repo_config
 
 	set w .push_setup
 	toplevel $w
@@ -117,6 +173,9 @@ proc do_push_anywhere {} {
 		-width 70 \
 		-selectmode extended \
 		-yscrollcommand [list $w.source.sby set]
+	if {[is_config_true gui.emailafterpush]} {
+		bind $w.source.l <ButtonRelease-1> [list do_push_on_change_branch $w]
+	}
 	foreach h [load_all_heads] {
 		$w.source.l insert end $h
 		if {$h eq $current_branch} {
@@ -179,6 +238,11 @@ proc do_push_anywhere {} {
 		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
+	checkbutton $w.options.email \
+		-text [mc "Compose email with review request"] \
+		-variable push_email
+	grid $w.options.email -columnspan 2 -sticky w
+	$w.options.email deselect
 	grid columnconfigure $w.options 1 -weight 1
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
 
@@ -186,6 +250,13 @@ proc do_push_anywhere {} {
 	set push_force 0
 	set push_thin 0
 	set push_tags 0
+	set push_email 0
+
+	set upstream_branch $repo_config(gui.upstreambranch)
+
+	if {[is_config_true gui.emailafterpush]} {
+		do_push_on_change_branch $w
+	}
 
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
-- 
1.6.5.rc1.12.gc72fe
