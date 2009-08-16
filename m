From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/3] git-gui: handle bare repos correctly
Date: Mon, 17 Aug 2009 01:58:47 +0200
Message-ID: <1250467128-29839-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 01:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McpdJ-0006yb-0N
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 01:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbZHPX7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 19:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbZHPX7F
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 19:59:05 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:39915 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958AbZHPX7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 19:59:00 -0400
Received: by mail-fx0-f215.google.com with SMTP id 11so2023084fxm.39
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DxH1ucj1JUX6gnr9U59ZvYE8RyHf2y4Fbla+Nx4zbpg=;
        b=sIQa4cNKBJ7Lm3m8m04aJroAWeYOfAFGcjdi39iSd4pT0R+9rpoZQR535bwBe5V6BZ
         yuxewbciCLlBAWHneKxiYJI4TJta8alApDm8LUiwhaQdGGeNEbqwXRWXMFUkuRiysD6h
         CrK6hIMHBnPaHDUGFx/WMHAz5WFlbddUgL7os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iJxgpkkLl3Au5Bv1qw8zhfOgF/hfl5zlcsHy65oNZLedrATmInFGUchHc3AmYfpbHX
         SsAaIoNF6Cbl99++9lwuFC09TqnJyRiIu/GXrnDeUbeWKPj19eY3sCIGwzGr8MqPEuXE
         qfFNw5qRZQGCttiiRCD4ohKLZHitn1v0TNk5c=
Received: by 10.103.8.17 with SMTP id l17mr1124400mui.2.1250467141779;
        Sun, 16 Aug 2009 16:59:01 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-24-143.clienti.tiscali.it [94.37.24.143])
        by mx.google.com with ESMTPS id t10sm14873682muh.0.2009.08.16.16.59.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 16:59:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.177.g695987
In-Reply-To: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126099>

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
index 229e94a..38b11c1 100755
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
@@ -1110,9 +1137,9 @@ if {$_prefix ne {}} {
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
@@ -1940,7 +1967,7 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		if { $_gitworktree ne {} } {
+		if { ![is_bare] } {
 			cd $_gitworktree
 		}
 		set env(GIT_DIR) [file normalize [gitdir]]
@@ -2349,10 +2376,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
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
1.6.4.177.g695987
