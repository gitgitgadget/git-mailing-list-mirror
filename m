From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2] git-gui: add menu item to select a branch to visualize with gitk
Date: Sat,  2 May 2009 11:20:54 +0200
Message-ID: <1241256054-14117-2-git-send-email-markus.heidelberg@web.de>
References: <1241256054-14117-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 11:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0BRY-0006Dm-Jn
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 11:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZEBJWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 05:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbZEBJWo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 05:22:44 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53953 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZEBJWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 05:22:42 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 994671012E1F6;
	Sat,  2 May 2009 11:21:39 +0200 (CEST)
Received: from [89.59.107.122] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0BPf-0002rf-01; Sat, 02 May 2009 11:21:39 +0200
X-Mailer: git-send-email 1.6.3.rc3.79.g777c
In-Reply-To: <1241256054-14117-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18xo0q59KI6GHxFqHkcC0+kctCV2U1kIPpBvX1v
	AoL6NQeuMNra3R25JdUZ9d0Z7UuxTW7rKirEba6WEzWuJFdbPY
	KkWzQYnub6mViRbm+mmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118128>

Previously it was only possible to either visualize the history of the
current branch or of all branches. This new menu item "Visualize Branch
History..." is similar to the existing "Browse Branch Files..." item.

The gitk_open class was straight copied from the browser_open class with
merely adjusting the UI text and the command to execute.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-gui.sh   |    3 +++
 lib/gitk.tcl |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 6ff04c4..9ceaf6f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2310,6 +2310,9 @@ set ui_browse_current [.mbar.repository index last]
 	-command {do_gitk $current_branch}
 set ui_visualize_current [.mbar.repository index last]
 .mbar.repository add command \
+	-label [mc "Visualize Branch History..."] \
+	-command gitk_open::dialog
+.mbar.repository add command \
 	-label [mc "Visualize All Branch History"] \
 	-command {do_gitk --all}
 .mbar.repository add separator
diff --git a/lib/gitk.tcl b/lib/gitk.tcl
index fcbb73d..251ab45 100644
--- a/lib/gitk.tcl
+++ b/lib/gitk.tcl
@@ -39,3 +39,56 @@ proc do_gitk {revs} {
 		}
 	}
 }
+
+class gitk_open {
+
+field w              ; # widget path
+field w_rev          ; # mega-widget to pick the initial revision
+
+constructor dialog {} {
+	make_toplevel top w
+	wm title $top [append "[appname] ([reponame]): " [mc "Visualize Branch History"]]
+	if {$top ne {.}} {
+		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+	}
+
+	label $w.header \
+		-text [mc "Visualize Branch History"] \
+		-font font_uibold
+	pack $w.header -side top -fill x
+
+	frame $w.buttons
+	button $w.buttons.browse -text [mc Visualize] \
+		-default active \
+		-command [cb _open]
+	pack $w.buttons.browse -side right
+	button $w.buttons.cancel -text [mc Cancel] \
+		-command [list destroy $w]
+	pack $w.buttons.cancel -side right -padx 5
+	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+
+	set w_rev [::choose_rev::new $w.rev [mc Revision]]
+	$w_rev bind_listbox <Double-Button-1> [cb _open]
+	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
+
+	bind $w <Visibility> [cb _visible]
+	bind $w <Key-Escape> [list destroy $w]
+	bind $w <Key-Return> [cb _open]\;break
+	tkwait window $w
+}
+
+method _open {} {
+	if {[catch {$w_rev commit_or_die} err]} {
+		return
+	}
+	set name [$w_rev get]
+	destroy $w
+	do_gitk $name
+}
+
+method _visible {} {
+	grab $w
+	$w_rev focus_filter
+}
+
+}
-- 
1.6.3.rc3.79.g777c
