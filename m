From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,MINGW) 2/3] git-gui: Add a simple implementation of SSH_ASKPASS.
Date: Mon, 20 Oct 2008 20:02:19 +0400
Message-ID: <1224518540-23782-3-git-send-email-angavrilov@gmail.com>
References: <1224518540-23782-1-git-send-email-angavrilov@gmail.com>
 <1224518540-23782-2-git-send-email-angavrilov@gmail.com>
Cc: msysgit@googlegroups.com, Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 21:07:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxGU-0006X3-Sg
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYJTQEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYJTQEX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:04:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:50287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYJTQEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:04:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1444234fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qe5qjyWY4yUZSuk8Oc2f8LdtjEf0hCcVAHU8BN/6y5Y=;
        b=SKYnmuLRrmjTBhkMA6L1ekjP4tKJFHfezNr0tVpcfftl6nUaGsxQCp61Js9WSlj5aZ
         IEME8SxNo3QnGVVQeFj2QFltWMM7J4YLsJ+MPP5/07Kgjmk6RrkqeW97Ox45AuNRJI+z
         JHJq5fZb1CdQ52m/4qSw8MPPhth3q/Vhnzrkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KgnWVimY9iPiuNV+ucoajFqI0hl/81fvhwBS0irr7hEIaVe7QJfFAbLBIq7bmb5TrS
         JWDkIYOF6okbHq8o2IvLrwdYIjuxwf0SEcQVNpERSLoYsHvkRzKqDoDvdNhVSMzUPJZp
         ve26n+qwqk3NrKxRWlYHiLcGZDkXN9SHWZh1Q=
Received: by 10.180.232.9 with SMTP id e9mr2669162bkh.57.1224518654381;
        Mon, 20 Oct 2008 09:04:14 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm7985073fka.14.2008.10.20.09.04.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 09:04:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1224518540-23782-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98691>

OpenSSH allows specifying an external program to use
for direct user interaction. While most Linux systems
already have such programs, some environments, for
instance, msysgit, lack it. This patch adds a simple
fallback Tcl implementation of the tool.

In msysgit it is also necessary to set a fake value of
the DISPLAY variable, because otherwise ssh won't even
try to use SSH_ASKPASS handlers.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 Makefile         |    2 ++
 git-gui.sh       |   12 ++++++++++++
 git-gui--askpass |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100755 git-gui--askpass

diff --git a/Makefile b/Makefile
index 55765c8..0ee47bf 100644
--- a/Makefile
+++ b/Makefile
@@ -285,6 +285,7 @@ all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
 install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
@@ -302,6 +303,7 @@ endif
 uninstall:
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
+	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askpass $(REMOVE_F1)
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)
diff --git a/git-gui.sh b/git-gui.sh
index e4d1f70..5e04a7c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -592,6 +592,11 @@ bind . <Visibility> {
 if {[is_Windows]} {
 	wm iconbitmap . -default $oguilib/git-gui.ico
 	set ::tk::AlwaysShowSelection 1
+
+	# Spoof an X11 display for SSH
+	if {![info exists env(DISPLAY)]} {
+		set env(DISPLAY) :native
+	}
 }
 
 ######################################################################
@@ -1071,6 +1076,13 @@ set nullid2 "0000000000000000000000000000000000000001"
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 
 ######################################################################
+
+# Suggest our implementation of askpass, if not already set
+if {![info exists env(SSH_ASKPASS)]} {
+	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
+}
+
+######################################################################
 ##
 ## task management
 
diff --git a/git-gui--askpass b/git-gui--askpass
new file mode 100755
index 0000000..12e117e
--- /dev/null
+++ b/git-gui--askpass
@@ -0,0 +1,59 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec wish "$0" -- "$@"
+
+# This is a trivial implementation of an SSH_ASKPASS handler.
+# Git-gui uses this script if none are already configured.
+
+set answer {}
+set yesno  0
+set rc     255
+
+if {$argc < 1} {
+	set prompt "Enter your OpenSSH passphrase:"
+} else {
+	set prompt [join $argv " "]
+	if {[regexp -nocase {\(yes\/no\)\?\s*$} $prompt]} {
+		set yesno 1
+	}
+}
+
+message .m -text $prompt -justify center -aspect 4000
+pack .m -side top -fill x -padx 20 -pady 20 -expand 1
+
+entry .e -textvariable answer -width 50
+pack .e -side top -fill x -padx 10 -pady 10
+
+if {!$yesno} {
+	.e configure -show "*"
+}
+
+frame .b
+button .b.ok     -text OK     -command finish
+button .b.cancel -text Cancel -command {destroy .}
+
+pack .b.ok -side left -expand 1
+pack .b.cancel -side right -expand 1
+pack .b -side bottom -fill x -padx 10 -pady 10
+
+bind . <Visibility> {focus -force .e}
+bind . <Key-Return> finish
+bind . <Key-Escape> {destroy .}
+bind . <Destroy>    {exit $rc}
+
+proc finish {} {
+	if {$::yesno} {
+		if {$::answer ne "yes" && $::answer ne "no"} {
+			tk_messageBox -icon error -title "Error" -type ok \
+				-message "Only 'yes' or 'no' input allowed."
+			return
+		}
+	}
+
+	set ::rc 0
+	puts $::answer
+	destroy .
+}
+
+wm title . "OpenSSH"
+tk::PlaceWindow .
-- 
1.6.0.20.g6148bc
