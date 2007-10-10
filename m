From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 08:58:59 +0200
Message-ID: <11919995392881-git-send-email-prohaska@zib.de>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
 <11919995392158-git-send-email-prohaska@zib.de>
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 10 08:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfVXR-0002OL-Je
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXJJG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbXJJG7H
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:59:07 -0400
Received: from mailer.zib.de ([130.73.108.11]:34343 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbXJJG7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:59:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9A6wxs1012435;
	Wed, 10 Oct 2007 08:58:59 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9A6wxWp006293;
	Wed, 10 Oct 2007 08:58:59 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11919995392158-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60470>

The wrapper adds the directory it is installed in to PATH.
This is required for the git commands implemented in shell.
git-gui fails to launch them if PATH is not modified.

The wrapper script also accepts an optional command line
switch '--working-dir <dir>' and changes to <dir> before
launching the actual git-gui. This is required to implement
the "Git Gui Here" Explorer shell extension.

As a last step the original git-gui script is launched,
which is expected to be located in the same directory
under the name git-gui.tcl.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/Makefile           |   20 ++++++++++++++++++++
 git-gui/windows/git-gui.sh |   16 ++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 git-gui/windows/git-gui.sh

diff --git a/git-gui/Makefile b/git-gui/Makefile
index c805450..2ad8846 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -128,6 +128,7 @@ ifeq ($(uname_S),Darwin)
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MSGFMT=1
+	GITGUI_WINDOWS_WRAPPER := YesPlease
 endif
 
 ifdef GITGUI_MACOSXAPP
@@ -168,6 +169,13 @@ Git\ Gui.app: GIT-VERSION-FILE GIT-GUI-VARS \
 	mv '$@'+ '$@'
 endif
 
+ifdef GITGUI_WINDOWS_WRAPPER
+GITGUI_MAIN := git-gui.tcl
+
+git-gui: windows/git-gui.sh
+	cp $< $@
+endif
+
 $(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-VARS
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -233,12 +241,18 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 ifdef GITGUI_MACOSXAPP
 all:: git-gui Git\ Gui.app
 endif
+ifdef GITGUI_WINDOWS_WRAPPER
+all:: git-gui
+endif
 all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
 
 install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
+ifdef GITGUI_WINDOWS_WRAPPER
+	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+endif
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(QUIET)$(INSTALL_R0)lib/git-gui.ico $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
@@ -254,6 +268,9 @@ uninstall:
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
+ifdef GITGUI_WINDOWS_WRAPPER
+	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)
+endif
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)'/tclIndex $(REMOVE_F1)
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)'/git-gui.ico $(REMOVE_F1)
@@ -279,6 +296,9 @@ clean::
 ifdef GITGUI_MACOSXAPP
 	$(RM_RF) 'Git Gui.app'* git-gui
 endif
+ifdef GITGUI_WINDOWS_WRAPPER
+	$(RM_RF) git-gui
+endif
 
 .PHONY: all install uninstall dist-version clean
 .PHONY: .FORCE-GIT-VERSION-FILE
diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
new file mode 100644
index 0000000..98f32c0
--- /dev/null
+++ b/git-gui/windows/git-gui.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec wish "$0" -- "$@"
+
+if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
+	cd [lindex $argv 1]
+	set argv [lrange $argv 2 end]
+	incr argc -2
+}
+
+set gitguidir [file dirname [info script]]
+regsub -all ";" $gitguidir "\\;" gitguidir
+set env(PATH) "$gitguidir;$env(PATH)"
+unset gitguidir
+
+source [file join [file dirname [info script]] git-gui.tcl]
-- 
1.5.3.mingw.1.105.gf0c04
