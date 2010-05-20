From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2] gitk: Show notes by default (like git log do)
Date: Thu, 20 May 2010 13:50:41 +0400
Message-ID: <1274349041-7886-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu May 20 11:49:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2O0-0001GG-Hl
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 11:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab0ETJts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 05:49:48 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:56757 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0ETJtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 05:49:46 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1OF2NQ-00005E-EI; Thu, 20 May 2010 13:49:16 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1OF2Ot-00023h-EY; Thu, 20 May 2010 13:50:47 +0400
X-Mailer: git-send-email 1.7.1.91.ga63a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147370>

Starting from ~ git-1.6.6, log, show & whatchanged show notes by default.

On the other hand, gitk does not show notes by default, because under
the hood it calls `git log --pretty=raw ...` to get the log, and in
`git log` notes are turned off, when user specifies format or pretty
settings.

Yes, it is possible to invoke `gitk --show-notes` explicitly, but since
from user's perspective, gitk is gui enabled git log, it would be
logical for gitk to show notes by default too for consistency.

In git, --show-notes was introduced in 66b2ed (Fix "log" family not to
be too agressive about showing notes) which predates 1.6.6.2

Notes can still be supressed with `gitk --no-notes`.

Cc: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 gitk |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Changes since first post:

 o as suggested by Michael, removed --show-notes from do_readcommit

 o as suggested by Michael, tried to put --show-notes arg into a central place

 o --show-notes is only used for git >= 1.6.6.2 (though because $git_version
   has only 3 digits, this may turn to be actually activated only from
   git >= 1.7.0)

diff --git a/gitk b/gitk
index 1b0e09a..45e3380 100755
--- a/gitk
+++ b/gitk
@@ -313,6 +313,7 @@ proc start_rev_list {view} {
     global viewactive viewinstances vmergeonly
     global mainheadid viewmainheadid viewmainheadid_orig
     global vcanopt vflags vrevs vorigargs
+    global show_notes
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
@@ -361,8 +362,8 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			 --boundary $args "--" $files] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+			--parents --boundary $args "--" $files] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
@@ -456,6 +457,7 @@ proc updatecommits {} {
     global mainheadid viewmainheadid viewmainheadid_orig pending_select
     global isworktree
     global varcid vposids vnegids vflags vrevs
+    global show_notes
 
     set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
     rereadrefs
@@ -508,8 +510,8 @@ proc updatecommits {} {
 	set args $vorigargs($view)
     }
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			  --boundary $args "--" $vfilelimit($view)] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+			--parents --boundary $args "--" $vfilelimit($view)] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return
@@ -11521,6 +11523,11 @@ set NS [expr {$use_ttk ? "ttk" : ""}]
 
 set git_version [join [lrange [split [lindex [exec git version] end] .] 0 2] .]
 
+set show_notes {}
+if {[package vcompare $git_version "1.6.6.2"] >= 0} {
+    set show_notes "--show-notes"
+}
+
 set runq {}
 set history {}
 set historyindex 0
-- 
1.7.1.91.ga63a7
