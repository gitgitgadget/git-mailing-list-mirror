From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: provide question helper for retry fallback on
	Windows
Date: Wed, 23 Mar 2011 21:31:19 +0100
Message-ID: <20110323203119.GA23905@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 21:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2UiG-0006Vt-VK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 21:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283Ab1CWUbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 16:31:23 -0400
Received: from darksea.de ([83.133.111.250]:41173 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933145Ab1CWUbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 16:31:22 -0400
Received: (qmail 19296 invoked from network); 23 Mar 2011 21:31:19 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2011 21:31:19 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169871>

Make use of the new environment variable GIT_ASK_YESNO to support the
recently implemented fallback in case unlink, rename or rmdir fail for
files in use on Windows. The added dialog will present a yes/no question
to the the user which will currently be used by the windows compat layer
to let the user retry a failed file operation.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Since the infrastructure for this is now in Junio's master lets also add
it to git-gui. This patch contains a fix of the question helper which
correctly wraps long lines in questions. I also disabled the
resizeability of the dialog because the text would not be rewrapped
anyway.

Cheers Heiko

 Makefile                  |    2 +
 git-gui.sh                |    3 ++
 git-gui/git-gui--askyesno |   52 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 git-gui/git-gui--askyesno

diff --git a/Makefile b/Makefile
index e22ba5c..d50b455 100644
--- a/Makefile
+++ b/Makefile
@@ -290,6 +290,7 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL_X0)git-gui--askyesno $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
@@ -308,6 +309,7 @@ uninstall:
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askpass $(REMOVE_F1)
+	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askyesno $(REMOVE_F1)
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)
diff --git a/git-gui.sh b/git-gui.sh
index d96df63..049bc70 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1158,6 +1158,9 @@ set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 if {![info exists env(SSH_ASKPASS)]} {
 	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
 }
+if {![info exists env(GIT_ASK_YESNO)]} {
+	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
+}
 
 ######################################################################
 ##
diff --git a/git-gui/git-gui--askyesno b/git-gui/git-gui--askyesno
new file mode 100755
index 0000000..7604610
--- /dev/null
+++ b/git-gui/git-gui--askyesno
@@ -0,0 +1,52 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec wish "$0" -- "$@"
+
+# This is an implementation of a simple yes no dialog
+# which is injected into the git commandline by git gui
+# in case a yesno question needs to be answered.
+
+set NS {}
+set use_ttk [package vsatisfies [package provide Tk] 8.5]
+if {$use_ttk} {
+	set NS ttk
+}
+
+if {$argc < 1} {
+	puts stderr "Usage: $argv0 <question>"
+	exit 1
+} else {
+	set prompt [join $argv " "]
+}
+
+${NS}::frame .t
+${NS}::label .t.m -text $prompt -justify left -width 40
+pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
+pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
+bind .t.m <Map> {.t.m configure -wraplength [winfo width .t.m]}
+
+${NS}::frame .b
+${NS}::frame .b.left -width 200
+${NS}::button .b.yes -text Yes -command yes
+${NS}::button .b.no  -text No  -command no
+
+
+pack .b.left -side left -expand 1 -fill x
+pack .b.yes -side left -expand 1
+pack .b.no -side right -expand 1 -ipadx 5
+pack .b -side bottom -fill x -ipadx 20 -ipady 15
+
+bind . <Key-Return> {exit 0}
+bind . <Key-Escape> {exit 1}
+
+proc no {} {
+	exit 1
+}
+
+proc yes {} {
+	exit 0
+}
+
+wm title . "Question?"
+wm resizable . 0 0
+tk::PlaceWindow .
-- 
1.7.4.rc3.9.gbf3bd
