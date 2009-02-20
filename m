From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2bis 2/2] git-gui: handle bare repos correctly
Date: Fri, 20 Feb 2009 02:32:29 +0100
Message-ID: <1235093549-5912-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0902191634n30f97c24t4d1840f5660c3eb3@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 02:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaKHC-0006eQ-SW
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 02:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbZBTBcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 20:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbZBTBcf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 20:32:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:32004 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZBTBce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 20:32:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1505058fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fUfxbjaa3ZUybFD2a5+5NzNwZMFuSCW4t8hmBOiJFi8=;
        b=kgSFRNa/xbLrWQOL4TmKID11qtNgEBG1hLAfGLJTVmC5yWjxFJ1WZ++HZqMCS6tnlD
         4TD3/vyPsY6NWxGeyy4dYYNHbEKPY3mEzm0Sv79368EQAVn2NtWEVcT96wMVHxCZJJ2a
         KayrBKrPvFUJVGOu+zLXOioPUT3QSzNSVohRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w1YTWDyfB1wczsh+q+uRypf13pvU2R45vqEiFhP469//mhwssW/RT6SrszBs1t3tw2
         swJH1rauK4f/VyRdz4AQyGWzuJmrX8uMzacHMqQlv4FXpie7pd1NjEfXknuvfQrjyTZo
         +mHOtvcMVCNSGIi9ENSQWOCb914NmmgRX9NKo=
Received: by 10.103.182.3 with SMTP id j3mr1178816mup.113.1235093552331;
        Thu, 19 Feb 2009 17:32:32 -0800 (PST)
Received: from localhost (host-78-13-59-64.cust-adsl.tiscali.it [78.13.59.64])
        by mx.google.com with ESMTPS id n10sm2104642mue.39.2009.02.19.17.32.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Feb 2009 17:32:31 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.179.g17e82
In-Reply-To: <cb7bb73a0902191634n30f97c24t4d1840f5660c3eb3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110779>

Refactor checking for a bare repository into its own proc, that relies
on git rev-parse --is-bare-repository if possible. If that fails (e.g.
older versions of git) we fall back to a logic such that the repository
is considered bare if:
 * either the core.bare setting is true
 * or the worktree is not set and the directory name ends with .git
The error message for the case of an unhandled bare repository is also
updated to reflect the fact that the problem is not the funny name but
the bareness.

The new refactored proc is also used to disable the menu entry to
explore the working copy, and to skip changing to the worktree before
the gitk invocation.
---
 git-gui/git-gui.sh |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 12c7ff3..e42d254 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -122,6 +122,7 @@ unset oguimsg
 set _appname {Git Gui}
 set _gitdir {}
 set _gitworktree {}
+set _isbare {}
 set _gitexec {}
 set _reponame {}
 set _iscygwin {}
@@ -254,6 +255,32 @@ proc get_config {name} {
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
@@ -1084,9 +1111,9 @@ if {$_prefix ne {}} {
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
@@ -1913,7 +1940,7 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		if { $_gitworktree ne {} } {
+		if { ![is_bare] } {
 			cd $_gitworktree
 		}
 		set env(GIT_DIR) [file normalize [gitdir]]
@@ -2317,10 +2344,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
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
1.6.2.rc1.179.g17e82
