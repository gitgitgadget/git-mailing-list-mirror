From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 2/5] git-gui: handle bare repos correctly
Date: Sat, 23 Jan 2010 11:03:35 +0100
Message-ID: <1264241018-6616-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcrA-0000WZ-NA
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab0AWKEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733Ab0AWKEL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:11 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52722 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab0AWKEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:09 -0500
Received: by bwz27 with SMTP id 27so1657541bwz.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m7hsrnkO3gru3zZiv9+krNhUnDreHxfw3ruw4u7ej4M=;
        b=PHpmDwV0vAfHieF9U966hRwPzMSVivbn7oVCkmkaer8+Qjz4apU0UXF8zOjzvELy8j
         EIymvcNoqa1CGxBb6Eo1zxD5pbdiqBaajy2sQxy7BT7MsttPBx2LK3TL83O5nuaSckR4
         TPV4zhQgpolwrrrVVufG+BhTJRXUVTGyKe8EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ePuVCbNgtTKSgHPJzDG8dJIaS5AXH8vKsz5y0UjCLsoPZVPYqV8gQDYiQkKKkKPfHI
         GqppO8/OGwzdEcgumESWEpGxPokh0gzVjXUV7evecJsaeRqHWGHssoY12Ii3p6EYtYsr
         mZzXjfpBBIgn11SIIWfbR4OTUa4QxJROwTD/M=
Received: by 10.204.48.132 with SMTP id r4mr2232362bkf.158.1264241046501;
        Sat, 23 Jan 2010 02:04:06 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 14sm1361871bwz.1.2010.01.23.02.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:05 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137832>

Refactor checking for a bare repository into its own proc, that relies
on git rev-parse --is-bare-repository if possible. For older versions of
git we fall back to a logic such that the repository is considered bare
if:
 * either the core.bare setting is true
 * or the worktree is not set and the directory name ends with .git
The error message for the case of an unhandled bare repository is also
updated to reflect the fact that the problem is not the funny name but
the bareness.

The new refactored proc is also used to disable the menu entry to
explore the working copy, and to skip changing to the worktree before
the gitk invocation.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7e633f4..d0dff40 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -122,6 +122,7 @@ unset oguimsg
 set _appname {Git Gui}
 set _gitdir {}
 set _gitworktree {}
+set _isbare {}
 set _gitexec {}
 set _githtmldir {}
 set _reponame {}
@@ -277,6 +278,32 @@ proc get_config {name} {
 	}
 }
 
+proc is_bare {} {
+	global _isbare
+	global _gitdir
+	global _gitworktree
+
+	if {$_isbare eq {}} {
+		if {[catch {
+			set _bare [git rev-parse --is-bare-repository]
+			switch  -- $_bare {
+			true { set _isbare 1 }
+			false { set _isbare 0}
+			default { throw }
+			}
+		}]} {
+			if {[is_config_true core.bare]
+				|| ($_gitworktree eq {}
+					&& [lindex [file split $_gitdir] end] ne {.git})} {
+				set _isbare 1
+			} else {
+				set _isbare 0
+			}
+		}
+	}
+	return $_isbare
+}
+
 ######################################################################
 ##
 ## handy utils
@@ -1112,9 +1139,9 @@ if {$_prefix ne {}} {
 	set _gitworktree [pwd]
 	unset cdup
 } elseif {![is_enabled bare]} {
-	if {[lindex [file split $_gitdir] end] ne {.git}} {
+	if {[is_bare]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
+		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
 		exit 1
 	}
 	if {$_gitworktree eq {}} {
@@ -1956,7 +1983,7 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		if { $_gitworktree ne {} } {
+		if { ![is_bare] } {
 			cd $_gitworktree
 		}
 		set env(GIT_DIR) [file normalize [gitdir]]
@@ -2383,10 +2410,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 #
 menu .mbar.repository
 
-.mbar.repository add command \
-	-label [mc "Explore Working Copy"] \
-	-command {do_explore}
-.mbar.repository add separator
+if {![is_bare]} {
+	.mbar.repository add command \
+		-label [mc "Explore Working Copy"] \
+		-command {do_explore}
+	.mbar.repository add separator
+}
 
 .mbar.repository add command \
 	-label [mc "Browse Current Branch's Files"] \
-- 
1.6.6.rc1.295.g3a4e71
