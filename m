From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 1/3] git-gui: handle non-standard worktree locations
Date: Mon, 17 Aug 2009 01:58:46 +0200
Message-ID: <1250467128-29839-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 01:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcpcx-0006us-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 01:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbZHPX7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbZHPX7A
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 19:59:00 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34823 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZHPX67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 19:58:59 -0400
Received: by bwz22 with SMTP id 22so2030748bwz.18
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UCUftmlyfFpO5sbOiCNHziPIWDqbEQ1PdQ5lyoSAJLc=;
        b=wSzUuGfyySfnBKal9UAD/KqGw9s/+GLqk8LbrTYbEYaYdEnZxq/hAFENgKR2Crd6CU
         GJMYQwJxfaUuGJ/4DuDJmzpqwq60U473QCOG9YAq4xcHT5HUS0rykqwlL7CKrRjgiYHR
         4+I/Oca0/f56LPu5NP1dv6/yulnObg3BKqcrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Lg7qk1eCP27LuKUVJag+iE9Hr53DLYO6DvQYOZ7H7fMnRbQmLj9XlVWX1o/Qi4fMIK
         z2gOUcfmPvNjYkcOrh97qh9b54aDDvLg73gBQ36qMqhlGCeAlCosPr4VvMkz88mKz4wI
         TjRsmMSmPuzvkZyGm/QEwWsQwQDMvOunLLq5I=
Received: by 10.103.86.9 with SMTP id o9mr1108125mul.4.1250467139642;
        Sun, 16 Aug 2009 16:58:59 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-24-143.clienti.tiscali.it [94.37.24.143])
        by mx.google.com with ESMTPS id j2sm16271262mue.50.2009.08.16.16.58.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 16:58:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.177.g695987
In-Reply-To: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126097>

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

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b92ba..229e94a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -121,6 +121,7 @@ unset oguimsg
 
 set _appname {Git Gui}
 set _gitdir {}
+set _gitworktree {}
 set _gitexec {}
 set _githtmldir {}
 set _reponame {}
@@ -1088,13 +1089,25 @@ if {![file isdirectory $_gitdir]} {
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
@@ -1102,11 +1115,15 @@ if {$_prefix ne {}} {
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
@@ -1905,6 +1922,7 @@ proc incr_font_size {font {amt 1}} {
 set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
+	global _gitworktree
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
@@ -1922,8 +1940,10 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		cd [file dirname [gitdir]]
-		set env(GIT_DIR) [file tail [gitdir]]
+		if { $_gitworktree ne {} } {
+			cd $_gitworktree
+		}
+		set env(GIT_DIR) [file normalize [gitdir]]
 
 		eval exec $cmd $revs &
 
@@ -1942,6 +1962,7 @@ proc do_gitk {revs} {
 }
 
 proc do_explore {} {
+	global _gitworktree
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
@@ -1951,7 +1972,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer [list [file nativename [file dirname [gitdir]]]] &
+	eval exec $explorer $_gitworktree &
 }
 
 set is_quitting 0
@@ -2297,8 +2318,6 @@ proc show_less_context {} {
 ##
 ## ui construction
 
-load_config 0
-apply_config
 set ui_comm {}
 
 # -- Menu Bar
@@ -3328,7 +3347,7 @@ unset i
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
 # -- Warn the user about environmental problems.  Cygwin's Tcl
-- 
1.6.4.177.g695987
