From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-gui: set GIT_DIR and GIT_WORK_TREE after setup
Date: Sun, 24 Jan 2010 00:59:00 +0100
Message-ID: <1264291140-16595-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <20100123232215.GI12679@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 00:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYpt2-0002bA-UL
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 00:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0AWX7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 18:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657Ab0AWX7Y
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 18:59:24 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56922 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab0AWX7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 18:59:23 -0500
Received: by bwz27 with SMTP id 27so1897861bwz.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0uxam+U4+CFQC09yk1PCxbBztwlboaqCVY/fx4lUzMM=;
        b=uUohT+5YjiskW29BXd/R7uOBTNAxczO3z6iNuwxb7BMFAA/KpnAxte1/h3ZK83ZlHY
         KqcWANNQ5AQhNvmaJ1BGZ7Bv9GIWgqIjaUQuXrxFZHpk3fiNlyaISlEbDLrB+YPpp9HQ
         WeLloOwyQ7N5wRxWNb/8StIn0bxTT6LBfnG7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BS6gUv6UO34s8jXHXvLRkmOIJcm7ddTP0bf4b9J186/hJPQHtd2zz/7OQPiOP/x5E/
         T/3QaYJx5FClxsYTQCVxrrx0JwQIfSVx5bGTAkNEIBA5Ur62bcUy1P5mvY7Sotq3Xz7l
         s73VIFef03PPSnYumAflxX5ITAXd4sh2Q1tXg=
Received: by 10.204.11.2 with SMTP id r2mr2687403bkr.30.1264291162130;
        Sat, 23 Jan 2010 15:59:22 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 16sm1600578bwz.15.2010.01.23.15.59.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 15:59:20 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <20100123232215.GI12679@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137879>

Rather than juggling with the env var GIT_DIR around the invocation of
gitk, set it and GIT_WORK_TREE after finishing setup, ensuring that any
external tool works with the setup we're running with.

This also allows us to remove a couple of conditionals when running gitk
or git gui in a submodule, as we know that the variables are present and
have to be unset and reset before and after the invocation.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui.sh |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5d39955..81143c7 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1171,6 +1171,9 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
+set env(GIT_DIR) $_gitdir
+set env(GIT_WORK_TREE) $_gitworktree
+
 ######################################################################
 ##
 ## global init
@@ -1979,7 +1982,7 @@ set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitworktree
+	global _gitdir _gitworktree
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
@@ -1991,19 +1994,12 @@ proc do_gitk {revs {is_submodule false}} {
 	} else {
 		global env
 
-		if {[info exists env(GIT_DIR)]} {
-			set old_GIT_DIR $env(GIT_DIR)
-		} else {
-			set old_GIT_DIR {}
-		}
-
 		set pwd [pwd]
 
 		if {!$is_submodule} {
 			if {![is_bare]} {
 				cd $_gitworktree
 			}
-			set env(GIT_DIR) [file normalize [gitdir]]
 		} else {
 			cd $current_diff_path
 			if {$revs eq {--}} {
@@ -2024,15 +2020,18 @@ proc do_gitk {revs {is_submodule false}} {
 				}
 				set revs $old_sha1...$new_sha1
 			}
-			if {[info exists env(GIT_DIR)]} {
-				unset env(GIT_DIR)
-			}
+			# GIT_DIR and GIT_WORK_TREE for the submodule are not the ones
+			# we've been using for the main repository, so unset them.
+			# TODO we could make life easier (start up faster?) for gitk
+			# by setting these to the appropriate values to allow gitk
+			# to skip the heuristics to find their proper value
+			unset env(GIT_DIR)
+			unset env(GIT_WORK_TREE)
 		}
 		eval exec $cmd $revs "--" "--" &
 
-		if {$old_GIT_DIR ne {}} {
-			set env(GIT_DIR) $old_GIT_DIR
-		}
+		set env(GIT_DIR) $_gitdir
+		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
 		ui_status $::starting_gitk_msg
@@ -2053,22 +2052,20 @@ proc do_git_gui {} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
 		global env
+		global _gitdir _gitworktree
 
-		if {[info exists env(GIT_DIR)]} {
-			set old_GIT_DIR $env(GIT_DIR)
-			unset env(GIT_DIR)
-		} else {
-			set old_GIT_DIR {}
-		}
+		# see note in do_gitk about unsetting these vars when
+		# running tools in a submodule
+		unset env(GIT_DIR)
+		unset env(GIT_WORK_TREE)
 
 		set pwd [pwd]
 		cd $current_diff_path
 
 		eval exec $exe gui &
 
-		if {$old_GIT_DIR ne {}} {
-			set env(GIT_DIR) $old_GIT_DIR
-		}
+		set env(GIT_DIR) $_gitdir
+		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
 		ui_status $::starting_gitk_msg
-- 
1.6.6.rc1.295.g3a4e71
