From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH (GIT-GUI)] git-gui: Add more integration options to
	citool.
Date: Wed, 24 Sep 2008 09:52:01 -0700
Message-ID: <20080924165201.GV3669@spearce.org>
References: <200809122243.50007.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:53:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXcg-0004TQ-3l
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYIXQwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYIXQwE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:52:04 -0400
Received: from george.spearce.org ([209.20.77.23]:59551 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbYIXQwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:52:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 684973835F; Wed, 24 Sep 2008 16:52:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809122243.50007.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96663>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> - Make citool return nonzero exit code if it did not commit.
> - Add a mode where it does not actually commit and simply
>   exits with zero code. Commit message is either disabled,
>   or simply dumped to GITGUI_EDITMSG before exiting.
> - Add an option to immediately start it in amend mode.
...
> 	I think this functionality might be useful, in particular for some of
> 	my own scripts. But I'm not sure if this is the best way to do it.

This looks good to me, but I think we may want to add this as a
follow-up patch.  Thoughts?

--8<--
git-gui: Hide commit related UI during citool --nocommit

If the user started git-gui as "git citool --nocommit" then they
don't need the new commit / amend commit radio buttons, or the sign
off button in the UI.  Rather than use up space with options the
user cannot activate they are simply not installed into the UI.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |  104 ++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c4ccc66..1939001 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2271,23 +2271,25 @@ proc commit_btn_caption {} {
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
-	.mbar.commit add radiobutton \
-		-label [mc "New Commit"] \
-		-command do_select_commit_type \
-		-variable selected_commit_type \
-		-value new
-	lappend disable_on_lock \
-		[list .mbar.commit entryconf [.mbar.commit index last] -state]
-
-	.mbar.commit add radiobutton \
-		-label [mc "Amend Last Commit"] \
-		-command do_select_commit_type \
-		-variable selected_commit_type \
-		-value amend
-	lappend disable_on_lock \
-		[list .mbar.commit entryconf [.mbar.commit index last] -state]
-
-	.mbar.commit add separator
+	if {![is_enabled nocommit]} {
+		.mbar.commit add radiobutton \
+			-label [mc "New Commit"] \
+			-command do_select_commit_type \
+			-variable selected_commit_type \
+			-value new
+		lappend disable_on_lock \
+			[list .mbar.commit entryconf [.mbar.commit index last] -state]
+
+		.mbar.commit add radiobutton \
+			-label [mc "Amend Last Commit"] \
+			-command do_select_commit_type \
+			-variable selected_commit_type \
+			-value amend
+		lappend disable_on_lock \
+			[list .mbar.commit entryconf [.mbar.commit index last] -state]
+
+		.mbar.commit add separator
+	}
 
 	.mbar.commit add command -label [mc Rescan] \
 		-command ui_do_rescan \
@@ -2329,9 +2331,11 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 	.mbar.commit add separator
 
-	.mbar.commit add command -label [mc "Sign Off"] \
-		-command do_signoff \
-		-accelerator $M1T-S
+	if {![is_enabled nocommit]} {
+		.mbar.commit add command -label [mc "Sign Off"] \
+			-command do_signoff \
+			-accelerator $M1T-S
+	}
 
 	.mbar.commit add command -label [commit_btn_caption] \
 		-command do_commit \
@@ -2657,9 +2661,11 @@ pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.incall conf -state}
 
-button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
-	-command do_signoff
-pack .vpane.lower.commarea.buttons.signoff -side top -fill x
+if {![is_enabled nocommit]} {
+	button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
+		-command do_signoff
+	pack .vpane.lower.commarea.buttons.signoff -side top -fill x
+}
 
 button .vpane.lower.commarea.buttons.commit -text [commit_btn_caption] \
 	-command do_commit
@@ -2667,15 +2673,10 @@ pack .vpane.lower.commarea.buttons.commit -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.commit conf -state}
 
-button .vpane.lower.commarea.buttons.push -text [mc Push] \
-	-command do_push_anywhere
-pack .vpane.lower.commarea.buttons.push -side top -fill x
-
-if {[is_enabled nocommitmsg]} {
-	.vpane.lower.commarea.buttons.signoff configure -state disabled
-}
-if {[is_enabled nocommit]} {
-	.vpane.lower.commarea.buttons.push configure -state disabled
+if {![is_enabled nocommit]} {
+	button .vpane.lower.commarea.buttons.push -text [mc Push] \
+		-command do_push_anywhere
+	pack .vpane.lower.commarea.buttons.push -side top -fill x
 }
 
 # -- Commit Message Buffer
@@ -2684,20 +2685,24 @@ frame .vpane.lower.commarea.buffer
 frame .vpane.lower.commarea.buffer.header
 set ui_comm .vpane.lower.commarea.buffer.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
-radiobutton .vpane.lower.commarea.buffer.header.new \
-	-text [mc "New Commit"] \
-	-command do_select_commit_type \
-	-variable selected_commit_type \
-	-value new
-lappend disable_on_lock \
-	[list .vpane.lower.commarea.buffer.header.new conf -state]
-radiobutton .vpane.lower.commarea.buffer.header.amend \
-	-text [mc "Amend Last Commit"] \
-	-command do_select_commit_type \
-	-variable selected_commit_type \
-	-value amend
-lappend disable_on_lock \
-	[list .vpane.lower.commarea.buffer.header.amend conf -state]
+
+if {![is_enabled nocommit]} {
+	radiobutton .vpane.lower.commarea.buffer.header.new \
+		-text [mc "New Commit"] \
+		-command do_select_commit_type \
+		-variable selected_commit_type \
+		-value new
+	lappend disable_on_lock \
+		[list .vpane.lower.commarea.buffer.header.new conf -state]
+	radiobutton .vpane.lower.commarea.buffer.header.amend \
+		-text [mc "Amend Last Commit"] \
+		-command do_select_commit_type \
+		-variable selected_commit_type \
+		-value amend
+	lappend disable_on_lock \
+		[list .vpane.lower.commarea.buffer.header.amend conf -state]
+}
+
 label $ui_coml \
 	-anchor w \
 	-justify left
@@ -2715,8 +2720,11 @@ proc trace_commit_type {varname args} {
 }
 trace add variable commit_type write trace_commit_type
 pack $ui_coml -side left -fill x
-pack .vpane.lower.commarea.buffer.header.amend -side right
-pack .vpane.lower.commarea.buffer.header.new -side right
+
+if {![is_enabled nocommit]} {
+	pack .vpane.lower.commarea.buffer.header.amend -side right
+	pack .vpane.lower.commarea.buffer.header.new -side right
+}
 
 text $ui_comm -background white -foreground black \
 	-borderwidth 1 \
-- 
1.6.0.2.471.g47a76



-- 
Shawn.
