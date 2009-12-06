From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 2/3] git-gui: handle bare repos correctly
Date: Sun,  6 Dec 2009 09:06:40 +0100
Message-ID: <1260086801-4331-3-git-send-email-giuseppe.bilotta@gmail.com>
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
	id 1NHC9t-0002wZ-N5
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbZLFIHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbZLFIHk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:07:40 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:65247 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbZLFIHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 03:07:38 -0500
Received: by mail-fx0-f213.google.com with SMTP id 5so3872218fxm.28
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AMfcXp6NlaAuzjob3eug4lnhHZ255vC9E42A2fYW/sk=;
        b=MnEnHzCw8YbNMvGSV+NCcSeInaW9TcHdRffhtGOUmM57IY12JzW8Jc+nmk0Ae0ZGgh
         sIq0h/wUdWgwtw47LeKmS++zDosJCt0hDN7zsEnuKz3iWeLEt7zLWqmolY5hVp27Wqqj
         hTVKpL1KVYpWJWI8Lei0CK3bb/7SHriP3e8CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cSYQF737EF8tkB/aVfilflOSzf3+Ca9ctwJgP1OVyuagk8yv1oN17+HBuK02ETs54S
         BVVSUB2p7g+rge/4+dAfp1af55x//SbdBjiTSqXME2J6NbUdwWbz7lVHpvjWy5JIleWA
         Y6499TbrHIQ0RZbQauNMfNtTY4bfuICNfUZxk=
Received: by 10.86.11.40 with SMTP id 40mr4349874fgk.20.1260086864423;
        Sun, 06 Dec 2009 00:07:44 -0800 (PST)
Received: from localhost (host-78-13-51-245.cust-adsl.tiscali.it [78.13.51.245])
        by mx.google.com with ESMTPS id e20sm14267775fga.2.2009.12.06.00.07.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 00:07:44 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134653>

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
index fc766ca..99ca4c0 100755
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
@@ -2378,10 +2405,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
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
1.6.5.4
