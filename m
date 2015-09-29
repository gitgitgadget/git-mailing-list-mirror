From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] git-gui: remove the garbage collection hint
Date: Tue, 29 Sep 2015 19:33:59 +0200
Message-ID: <1443548039-16276-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 19:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgynY-0007K8-4i
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 19:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934490AbbI2Reg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 13:34:36 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:58468 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932398AbbI2Ree (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 13:34:34 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id A78A1C3448;
	Tue, 29 Sep 2015 19:34:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 874B5C343E;
	Tue, 29 Sep 2015 19:34:31 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 5670221396; Tue, 29 Sep 2015 19:34:31 +0200 (CEST)
X-Mailer: git-send-email 2.5.0.492.g918e48c
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278830>

Git core has had automatic garbage collection for a long time.
Git-gui does not need a similar heuristic.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 git-gui.sh       |  3 ---
 lib/database.tcl | 26 --------------------------
 2 files changed, 29 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 11048c7..2866777 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -4004,9 +4004,6 @@ after 1 {
 		$ui_comm configure -state disabled -background gray
 	}
 }
-if {[is_enabled multicommit] && ![is_config_false gui.gcwarning]} {
-	after 1000 hint_gc
-}
 if {[is_enabled retcode]} {
 	bind . <Destroy> {+terminate_me %W}
 }
diff --git a/lib/database.tcl b/lib/database.tcl
index 1f187ed..808bdf6 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -87,29 +87,3 @@ proc do_fsck_objects {} {
 	lappend cmd --strict
 	console::exec $w $cmd
 }
-
-proc hint_gc {} {
-	set ndirs 1
-	set limit 8
-	if {[is_Windows]} {
-		set ndirs 4
-		set limit 1
-	}
-
-	set count [llength [glob \
-		-nocomplain \
-		-- \
-		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
-
-	if {$count >= $limit * $ndirs} {
-		set objects_current [expr {$count * 256/$ndirs}]
-		if {[ask_popup \
-			[mc "This repository currently has approximately %i loose objects.
-
-To maintain optimal performance it is strongly recommended that you compress the database.
-
-Compress the database now?" $objects_current]] eq yes} {
-			do_gc
-		}
-	}
-}
-- 
2.5.0.492.g918e48c
