From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/2] git-gui: handle non-standard worktree locations
Date: Thu, 19 Feb 2009 02:15:44 +0100
Message-ID: <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 02:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxXU-0002WS-Sp
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZBSBPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZBSBPy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:15:54 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:12884 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZBSBPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:15:52 -0500
Received: by fk-out-0910.google.com with SMTP id f33so155872fkf.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 17:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qKe5onaRo0wNzPP2TXSLhYfsovNA6URonTfDlvtO7wU=;
        b=YGeQdF2g9t4t+BWcYJIRor4Wu6qPquqkLo7IgG7l6tFuUwae89k37pZgDsAhVeM6BA
         OOrykEzvcO31tivzhOkbdoUAPBmqt/XLuHSOtpef2nSyTN+2j0icjOX9fNVx7LGIxYSc
         adMIHppwbp36Ur43SOtTGiDPLoYGWj2E6QGSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oUeLKNzqnkkqdMTXUOqrnJIT1BvzxVmvvuzaeOlff/Hh0EU+ZEscZ/vR30i0c9LiY1
         lY+gbJUAtqM46NIETA6WhX/TQqeOHHZ+90HHoR3VOhNTJvaAtR6WURmXr7NL8evIl7DI
         LrBFRRdMR2+CCYazrg3/OLo/qUv99koBPYx9w=
Received: by 10.103.92.8 with SMTP id u8mr30921mul.12.1235006151577;
        Wed, 18 Feb 2009 17:15:51 -0800 (PST)
Received: from localhost ([94.37.6.213])
        by mx.google.com with ESMTPS id n10sm786378mue.9.2009.02.18.17.15.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 17:15:50 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.179.g17e82
In-Reply-To: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110606>

Don't rely on the git worktree being the updir of the gitdir, since it
might not be. Instead, define (and use) a new _gitworktree global
variable, setting it to $GIT_WORK_TREE if present, falling back to
core.worktree if defined, and finally to whatever we guess the correct
worktree is. Getting core.worktree requires the config from the alleged
git dir _gitdir to be loaded early.

Supporting non-standard worktree locations also breaks the git-gui
assumption (made when calling gitk) that the worktree was the dirname of
$_gitdir and that, by consequence, the git dir could be set to the tail
of $_gitdir once we changed to the worktree root directory. Therefore,
we need to export a GIT_DIR environment variable set to the full,
normalized path of $_gitdir instead. We also skip changing to the worktree
directory if it's empty (i.e. if we're working on a bare repository).
---
 git-gui/git-gui.sh |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e018e07..12c7ff3 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -121,6 +121,7 @@ unset oguimsg
 
 set _appname {Git Gui}
 set _gitdir {}
+set _gitworktree {}
 set _gitexec {}
 set _reponame {}
 set _iscygwin {}
@@ -1062,13 +1063,25 @@ if {![file isdirectory $_gitdir]} {
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
 	exit 1
 }
+# _gitdir exists, so try loading the config
+load_config 0
+apply_config
+# try to set work tree from environment, falling back to core.worktree
+if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
+	set _gitworktree [get_config core.worktree]
+}
 if {$_prefix ne {}} {
-	regsub -all {[^/]+/} $_prefix ../ cdup
+	if {$_gitworktree eq {}} {
+		regsub -all {[^/]+/} $_prefix ../ cdup
+	} else {
+		set cdup $_gitworktree
+	}
 	if {[catch {cd $cdup} err]} {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
 		exit 1
 	}
+	set _gitworktree [pwd]
 	unset cdup
 } elseif {![is_enabled bare]} {
 	if {[lindex [file split $_gitdir] end] ne {.git}} {
@@ -1076,11 +1089,15 @@ if {$_prefix ne {}} {
 		error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
 		exit 1
 	}
-	if {[catch {cd [file dirname $_gitdir]} err]} {
+	if {$_gitworktree eq {}} {
+		set _gitworktree [file dirname $_gitdir]
+	}
+	if {[catch {cd $_gitworktree} err]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "No working directory"] " [file dirname $_gitdir]:\n\n$err"]
+		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
 		exit 1
 	}
+	set _gitworktree [pwd]
 }
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
@@ -1878,6 +1895,7 @@ proc incr_font_size {font {amt 1}} {
 set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
+	global _gitworktree
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
@@ -1895,8 +1913,10 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		cd [file dirname [gitdir]]
-		set env(GIT_DIR) [file tail [gitdir]]
+		if { $_gitworktree ne {} } {
+			cd $_gitworktree
+		}
+		set env(GIT_DIR) [file normalize [gitdir]]
 
 		eval exec $cmd $revs &
 
@@ -1915,6 +1935,7 @@ proc do_gitk {revs} {
 }
 
 proc do_explore {} {
+	global _gitworktree
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
@@ -1924,7 +1945,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer [file dirname [gitdir]] &
+	eval exec $explorer $_gitworktree &
 }
 
 set is_quitting 0
@@ -2270,8 +2291,6 @@ proc show_less_context {} {
 ##
 ## ui construction
 
-load_config 0
-apply_config
 set ui_comm {}
 
 # -- Menu Bar
@@ -3302,7 +3321,7 @@ unset i
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
 # -- Warn the user about environmental problems.  Cygwin's Tcl
-- 
1.6.2.rc1.179.g17e82
