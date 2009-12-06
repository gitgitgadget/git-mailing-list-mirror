From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 1/3] git-gui: handle non-standard worktree locations
Date: Sun,  6 Dec 2009 09:06:39 +0100
Message-ID: <1260086801-4331-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 09:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHC9t-0002wZ-1O
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbZLFIHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 03:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbZLFIHi
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:07:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:38657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbZLFIHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 03:07:37 -0500
Received: by fg-out-1718.google.com with SMTP id 16so413598fgg.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 00:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NTePlhlmxphiKf8KFordiY8nUgcw66XgQFyt5bL3BYg=;
        b=OR3YkL6CAV0WjVJcQeTDnpTUINQV0zYN3WtJ1MVlmCt6eP27UB/fl7NT11T+gf69LG
         tbd4JlmLadg7zKKXnAEhn/SyZAffLxpEKSZIU7t9zYENHpabWuC/rU3TKAb47Cj6N7NP
         t7QW96Ger92sl/KsFyP6/V9SGcpHA3EV1aXS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W4IaWHJHLjlPcyT2lbLBfjvObpIp+Xz/kN6YXbd4ct5m0eg4dWb/wKxsFJ18t41WKk
         8DC6cJRiHh1fOutoSPd9G56STtKGcp7VQVK12I8KvKnZEhqH2Iq1odFlOTTV+kj3OfMl
         wFWJqE9tRVwe72YR6o/E4Ne/tqr8u5wBodTE0=
Received: by 10.86.159.37 with SMTP id h37mr4265480fge.79.1260086862255;
        Sun, 06 Dec 2009 00:07:42 -0800 (PST)
Received: from localhost (host-78-13-51-245.cust-adsl.tiscali.it [78.13.51.245])
        by mx.google.com with ESMTPS id e11sm14089542fga.29.2009.12.06.00.07.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 00:07:41 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134654>

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
index 037a1f2..fc766ca 100755
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
@@ -2326,8 +2347,6 @@ proc show_less_context {} {
 ##
 ## ui construction
 
-load_config 0
-apply_config
 set ui_comm {}
 
 # -- Menu Bar
@@ -3365,7 +3384,7 @@ unset i
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
 # -- Warn the user about environmental problems.  Cygwin's Tcl
-- 
1.6.5.4
