From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 3/8] git gui: add checkbox to launch remote branch delete after push
Date: Mon, 21 Sep 2009 15:06:50 +0200
Message-ID: <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicD-0002uk-IH
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbZIUNG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbZIUNG5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:06:57 -0400
Received: from darksea.de ([83.133.111.250]:35687 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756029AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28821 invoked from network); 21 Sep 2009 15:06:56 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:56 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128876>

This is useful when working with a central server and feature branches.
After a reviewer merged a feature branch into the upstream branch he
usually wants to delete this branch on the server after pushing the
upstream branch.

Save some clicks and open the delete dialog after pushing the upstream
branch.
---
 git-gui/git-gui.sh        |    1 +
 git-gui/lib/option.tcl    |    1 +
 git-gui/lib/transport.tcl |   28 ++++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index dfc1652..b32b8e7 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -738,6 +738,7 @@ set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.fastcopyblame) false
 set default_config(gui.emailafterpush) false
+set default_config(gui.deleteafterpush) false
 set default_config(gui.upstreambranch) {master}
 set default_config(gui.copyblamethreshold) 40
 set default_config(gui.blamehistoryctx) 7
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 55ecfe6..6bfe343 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -148,6 +148,7 @@ proc do_options {} {
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{b gui.emailafterpush {mc "Open Email Composer after Push of Feature Branch"}}
+		{b gui.deleteafterpush {mc "Open Remote Delete Dialog On Push of Upstream Branch"}}
 		{t gui.upstreambranch {mc "Upstream branch"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 77a2f46..d717468 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -37,7 +37,7 @@ proc compose_email {to subject} {
 }
 
 proc after_push_anywhere_action {cons ok} {
-	global push_email r_url branches
+	global push_email delete_after_push r_url branches
 
 	console::done $cons $ok
 
@@ -52,13 +52,21 @@ proc after_push_anywhere_action {cons ok} {
 			set email_subject "Review%20request:%20$remote_short_name:$branches"
 			compose_email {} $email_subject
 		}
+		if {$delete_after_push} {
+			remote_branch_delete::dialog $r_url
+		}
 	}
 }
 
 proc do_push_on_change_branch {w} {
 	global upstream_branch
 
-	$w.options.email select
+	if {[is_config_true gui.emailafterpush]} {
+		$w.options.email select
+	}
+	if {[is_config_true gui.deleteafterpush]} {
+		$w.options.delete_after_push deselect
+	}
 
 	set cnt 0
 	set b {}
@@ -70,6 +78,7 @@ proc do_push_on_change_branch {w} {
 	if {$cnt != 1} {
 		$w.options.email deselect
 		$w.options.email configure -state disabled
+		$w.options.delete_after_push deselect
 		return
 	}
 
@@ -79,6 +88,9 @@ proc do_push_on_change_branch {w} {
 		if {[is_config_true gui.emailafterpush]} {
 			$w.options.email deselect
 		}
+		if {[is_config_true gui.deleteafterpush]} {
+			$w.options.delete_after_push select
+		}
 	}
 }
 
@@ -173,7 +185,8 @@ proc do_push_anywhere {} {
 		-width 70 \
 		-selectmode extended \
 		-yscrollcommand [list $w.source.sby set]
-	if {[is_config_true gui.emailafterpush]} {
+	if {[is_config_true gui.emailafterpush] \
+	    || [is_config_true gui.deleteafterpush]} {
 		bind $w.source.l <ButtonRelease-1> [list do_push_on_change_branch $w]
 	}
 	foreach h [load_all_heads] {
@@ -243,6 +256,11 @@ proc do_push_anywhere {} {
 		-variable push_email
 	grid $w.options.email -columnspan 2 -sticky w
 	$w.options.email deselect
+	checkbutton $w.options.delete_after_push \
+		-text [mc "Launch delete dialog after push"] \
+		-variable delete_after_push
+	grid $w.options.delete_after_push -columnspan 2 -sticky w
+	$w.options.delete_after_push deselect
 	grid columnconfigure $w.options 1 -weight 1
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
 
@@ -251,10 +269,12 @@ proc do_push_anywhere {} {
 	set push_thin 0
 	set push_tags 0
 	set push_email 0
+	set delete_after_push 0
 
 	set upstream_branch $repo_config(gui.upstreambranch)
 
-	if {[is_config_true gui.emailafterpush]} {
+	if {[is_config_true gui.emailafterpush] \
+	    || [is_config_true gui.deleteafterpush]} {
 		do_push_on_change_branch $w
 	}
 
-- 
1.6.5.rc1.12.gc72fe
