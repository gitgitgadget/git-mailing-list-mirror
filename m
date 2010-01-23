From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 1/5] git-gui: handle non-standard worktree locations
Date: Sat, 23 Jan 2010 11:03:34 +0100
Message-ID: <1264241018-6616-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcqk-0000LD-Vl
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0AWKEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590Ab0AWKEI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:9955 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab0AWKEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:05 -0500
Received: by fg-out-1718.google.com with SMTP id 16so255212fgg.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3Kq7pfvEnlGni0im2XBI07oGLz/dHg+eBiwXBZ9crwg=;
        b=LCDhDfbh58Dv9wqcsPXgm5GnuItVzIYHNi4V6bHBw3HIPuTBGSMxjZkHdxQyb8o9v7
         M6oguRdnEXppCHRTmA1z1NvMOJMpQMeR983Xgf8PEOgUAyTczOr+P9cquCzddeRFNTeg
         b9q46LKy/tSEzM5lwrt/jc+CEjN8rgRJBt01Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dl0GuhP3u9G1IlW9w/8dCVpOfs6wIHdB8XXyKrQ8utJzKF6dCt7rYeUnPmGR3p1Fu6
         K391JqsChsQ4HRVnne97GhWYnDLUwD1njFhz5WmUonDkXxVP9tirGN8/yKaR/x19y3Pk
         7/YRdhlF4suHAy0uxI+rxZwg4OfJBtW56O7HM=
Received: by 10.86.233.18 with SMTP id f18mr2114205fgh.68.1264241043887;
        Sat, 23 Jan 2010 02:04:03 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 14sm1724810fxm.7.2010.01.23.02.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:03 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137827>

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
index 718277a..7e633f4 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -121,6 +121,7 @@ unset oguimsg
 
 set _appname {Git Gui}
 set _gitdir {}
+set _gitworktree {}
 set _gitexec {}
 set _githtmldir {}
 set _reponame {}
@@ -1090,13 +1091,25 @@ if {![file isdirectory $_gitdir]} {
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
@@ -1104,11 +1117,15 @@ if {$_prefix ne {}} {
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
@@ -1921,6 +1938,7 @@ proc incr_font_size {font {amt 1}} {
 set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
+	global _gitworktree
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
@@ -1938,8 +1956,10 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		cd [file dirname [gitdir]]
-		set env(GIT_DIR) [file tail [gitdir]]
+		if { $_gitworktree ne {} } {
+			cd $_gitworktree
+		}
+		set env(GIT_DIR) [file normalize [gitdir]]
 
 		eval exec $cmd $revs &
 
@@ -1958,6 +1978,7 @@ proc do_gitk {revs} {
 }
 
 proc do_explore {} {
+	global _gitworktree
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
@@ -1967,7 +1988,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer [list [file nativename [file dirname [gitdir]]]] &
+	eval exec $explorer $_gitworktree &
 }
 
 set is_quitting 0
@@ -2331,8 +2352,6 @@ proc show_less_context {} {
 ##
 ## ui construction
 
-load_config 0
-apply_config
 set ui_comm {}
 
 # -- Menu Bar
@@ -3370,7 +3389,7 @@ unset i
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
 # -- Warn the user about environmental problems.  Cygwin's Tcl
-- 
1.6.6.rc1.295.g3a4e71
