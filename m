From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/3] git-gui: use the actual worktree
Date: Mon,  9 Feb 2009 03:00:49 +0100
Message-ID: <1234144850-2903-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 03:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLTn-0004WI-Gr
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbZBICBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 21:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbZBICBJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:01:09 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:35615 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZBICBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:01:04 -0500
Received: by fxm13 with SMTP id 13so2320155fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FdchAzVgjhXLntdIaxpTDsW2sIk7afzXWmn2y0z0UaM=;
        b=mvCJ2ii4asYINRV0BNSeIQd+Cye/p4QpCrPw/6M142Ea30kr1YaTOZ/qxylWn1gs5Q
         xBIfktKK30RT0EDGOZ1Ot/s9aD9KP+Ye3Up7vm8bMoKIXNoXadfkeyscAqgWiBlDrVS5
         tNoAbzaL1cL09GF3PvPnRewH89XZbLO1CNqeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UgxiR0NHBFoBG5gw85z2froKueEumHZmSUiM4yesxduD+GfaIY/DpYoD8lBxmOZ7s9
         etkxc4e+lEkvb3KlzJFbs0URovrFYUzdpj0lmenEHxq3HOekw3gz+jlHd+WTRIelLzT0
         P8BtMPgNMBiM1P7SDqha/fUtKqS8zG2ukvR+A=
Received: by 10.103.92.10 with SMTP id u10mr335147mul.22.1234144862152;
        Sun, 08 Feb 2009 18:01:02 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id e10sm35961muf.11.2009.02.08.18.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 18:01:01 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
In-Reply-To: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109036>

Don't rely on the git worktree being the updir of the gitdir, since it
might not be. Instead, define (and use) a new _gitworktree global
variable, setting it to $GIT_WORK_TREE if present, or to whatever we
guess the correct worktree is.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 658a728..94317c7 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -121,6 +121,7 @@ unset oguimsg
 
 set _appname {Git Gui}
 set _gitdir {}
+set _gitworktree {}
 set _gitexec {}
 set _reponame {}
 set _iscygwin {}
@@ -1062,13 +1063,19 @@ if {![file isdirectory $_gitdir]} {
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
 	exit 1
 }
+set _gitworktree $env(GIT_WORK_TREE)
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
 	if {[is_config_true core.bare]} {
@@ -1076,11 +1083,15 @@ if {$_prefix ne {}} {
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
@@ -1878,6 +1889,7 @@ proc incr_font_size {font {amt 1}} {
 set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
+	global _gitworktree
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
@@ -1895,7 +1907,7 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		cd [file dirname [gitdir]]
+		cd $_gitworktree
 		set env(GIT_DIR) [file tail [gitdir]]
 
 		eval exec $cmd $revs &
@@ -1915,6 +1927,7 @@ proc do_gitk {revs} {
 }
 
 proc do_explore {} {
+	global _gitworktree
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
@@ -1924,7 +1937,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer [file dirname [gitdir]] &
+	eval exec $explorer $_gitworktree &
 }
 
 set is_quitting 0
@@ -3302,7 +3315,7 @@ unset i
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
 # -- Warn the user about environmental problems.  Cygwin's Tcl
-- 
1.6.2.rc0.173.g5e148
