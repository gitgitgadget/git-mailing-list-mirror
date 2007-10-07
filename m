From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Sun,  7 Oct 2007 23:28:21 +0200
Message-ID: <11917925011987-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Steffen Prohaska <prohaska@zib.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Oct 07 23:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iedfx-0004uE-F4
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXJGV22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbXJGV22
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:28:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:39985 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbXJGV21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:28:27 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l97LSM1d022486;
	Sun, 7 Oct 2007 23:28:22 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l97LSL5G027580;
	Sun, 7 Oct 2007 23:28:21 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60220>

If git-gui is started outside a work tree the repository
chooser will offer a list of recently opend repositories.
Clicking on an entry directly opens the repository.

The list of recently opened repositories is stored in the
config as gui.recentrepos. If the list grows beyond 10
entries it will be truncated.

Note, only repositories that are opened through the
repository chooser will get added to the recent list.
Repositories opened from the shell will not yet be added.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/lib/choose_repository.tcl |   47 +++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)


The commit is also available on branch
steffen/git-gui-openrecent in 4msysgit.


Shawn,
I'd suggest to reduce the number of clicks needed to open or
clone an existing directory that is not in the list of
recent repositories. First choosing from the radiobuttons
and then clicking next is one click to much. There are no
options to combine. Choosing from the list should
immediately trigger the action.

We could either put 'Create/Clone/Open New Repository' into
the Repository menu and only present the recent repository
list. Or we could offer push buttons for the other actions.

	Steffen


diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 16bf67c..bfc8780 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -116,9 +116,26 @@ constructor pick {} {
 		-text [mc "Open Existing Repository"] \
 		-variable @action \
 		-value open
+	label $w_body.space
+	label $w_body.recentlabel \
+		-anchor w \
+		-text "Select Recent Repository:"
+	listbox $w_body.recentlist \
+		-relief flat \
+		-width 50 \
+		-height 10 \
+		-exportselection false \
+		-selectmode select
+	foreach p [_get_recentrepos] {
+		$w_body.recentlist insert end $p
+	}
+	bind $w_body.recentlist <<ListboxSelect>> [cb _open_recent]
 	pack $w_body.new -anchor w -fill x
 	pack $w_body.clone -anchor w -fill x
 	pack $w_body.open -anchor w -fill x
+	pack $w_body.space -anchor w -fill x
+	pack $w_body.recentlabel -anchor w -fill x
+	pack $w_body.recentlist -anchor w -fill x
 	pack $w_body -fill x -padx 10 -pady 10
 
 	frame $w.buttons
@@ -171,6 +188,34 @@ method _invoke_next {} {
 	}
 }
 
+proc _get_recentrepos {} {
+	set recent [list]
+	foreach p [get_config gui.recentrepos] {
+		if {[file isdirectory [file join $p .git]]} {
+			lappend recent $p
+		}
+	}
+	return [lsort $recent]
+}
+
+proc _append_recentrepos {path} {
+	set recent [get_config gui.recentrepos]
+	if {[lsearch $recent $path] < 0} {
+		lappend recent $path
+	}
+	if {[llength $recent] > 10} {
+		set recent [lrange $recent 1 end]
+	}
+	regsub -all "\[{}\]" $recent {"} recent
+	git config --global gui.recentrepos $recent
+}
+
+method _open_recent {} {
+	set id [$w_body.recentlist curselection]
+	set local_path [$w_body.recentlist get $id]
+	_do_open2 $this
+}
+
 method _next {} {
 	destroy $w_body
 	_do_$action $this
@@ -893,6 +938,8 @@ method _do_open2 {} {
 		return
 	}
 
+	_append_recentrepos $local_path
+
 	set ::_gitdir .git
 	set ::_prefix {}
 	set done 1
-- 
1.5.3.mingw.1.110.gef4c8
