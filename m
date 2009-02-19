From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/2] git-gui: handle bare repos correctly
Date: Thu, 19 Feb 2009 02:15:45 +0100
Message-ID: <1235006145-16760-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 02:17:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxXo-0002cd-D7
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbZBSBP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZBSBP6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:15:58 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:56817 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZBSBP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:15:56 -0500
Received: by bwz5 with SMTP id 5so475283bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 17:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=98wfhTZVG4ggJkmJtP//pasFrBfjA7Z6xgqOavkKhBY=;
        b=MVKyjmaBWrSt836uu4JY4CDZdelLCBnjNTo2XBL4mfoqRirH6enZpIY1x/uVp/ayww
         HEeUM+p2PE0iKiU3yn8Fi7p52jNB9U+8v5i/Vf1Yopd1byzfPp2Axoj/iCqQ5TtpDMqt
         UcOQTjoxJAYd3xQsHKR/JCmTIE+PBkwbkr3ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e2VVbVhra42f9um4MhrAkfVyWjTkBu9HwQO8oyuE/TCPhMP8FM/oUpIr9cz0ySs6b+
         H59ay4IcSdBA8fZQhZ+Cn6I92i7dDY33Tu2WzihuKuSfLp6+8SmHMTNUYo2KBCtz3Zld
         W3/KqBrw7Q5DQ3eyh5FyTsykRu3o//r6bxw64=
Received: by 10.103.221.5 with SMTP id y5mr22262muq.66.1235006153733;
        Wed, 18 Feb 2009 17:15:53 -0800 (PST)
Received: from localhost ([94.37.6.213])
        by mx.google.com with ESMTPS id j10sm43497mue.56.2009.02.18.17.15.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 17:15:53 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.179.g17e82
In-Reply-To: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110607>

Refactor checking for a bare repository into its own proc, with a new
logic such that the repository is considered bare if:
 * either the core.bare setting is true
 * or the worktree is not set and the directory name ends with .git
The error message for the case of an unhandled bare repository is also
updated to reflect the fact that the problem is not the funny name but
the bareness.

The new refactored proc is also used to disable the menu entry to
explore the working copy, and to skip changing to the worktree before
the gitk invocation.
---

The only thing that I see no easy way to support is the "git --bare gui"
syntax, which would probably require git setting up an appropriate
environment variable.

 git-gui/git-gui.sh |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 12c7ff3..a4c0d4b 100755
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
@@ -254,6 +255,23 @@ proc get_config {name} {
 	}
 }
 
+proc is_bare {} {
+	global _isbare
+	global _gitdir
+	global _gitworktree
+
+	if {$_isbare eq {}} {
+		if {[is_config_true core.bare]
+			|| ($_gitworktree eq {}
+				&& [lindex [file split $_gitdir] end] ne {.git})} {
+			set _isbare 1
+		} else {
+			set _isbare 0
+		}
+	}
+	return $_isbare
+}
+
 ######################################################################
 ##
 ## handy utils
@@ -1084,9 +1102,9 @@ if {$_prefix ne {}} {
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
@@ -1913,7 +1931,7 @@ proc do_gitk {revs} {
 		}
 
 		set pwd [pwd]
-		if { $_gitworktree ne {} } {
+		if { ![is_bare] } {
 			cd $_gitworktree
 		}
 		set env(GIT_DIR) [file normalize [gitdir]]
@@ -2317,10 +2335,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
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
