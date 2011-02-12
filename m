From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/2] git-gui: always default to the last merged branch in
	remote delete
Date: Sat, 12 Feb 2011 17:44:58 +0100
Message-ID: <20110212164457.GB19433@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 17:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoIan-0008Hy-25
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 17:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128Ab1BLQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 11:45:00 -0500
Received: from darksea.de ([83.133.111.250]:34036 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751040Ab1BLQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 11:44:59 -0500
Received: (qmail 11071 invoked from network); 12 Feb 2011 17:44:57 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 Feb 2011 17:44:57 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166617>

This is useful if you are directly working together with other
developers pushing feature branches on a shared remote. You typically
push feature branches to the remote so others can review. Once they are
satisfied and the branch is merged into the main branch it needs to be
deleted on the server.

Since we did not yet have a preselected default branch in the remote
delete dialog lets use the last merged branch if it is found on the
server.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui.sh                   |    4 ++++
 lib/merge.tcl                |    2 ++
 lib/remote_branch_delete.tcl |    9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 886719a..d96df63 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -139,6 +139,10 @@ if {$_trace >= 0} {
 	set _trace 0
 }
 
+# variable for the last merged branch (useful for a default when deleting
+# branches).
+set _last_merged_branch {}
+
 proc shellpath {} {
 	global _shellpath env
 	if {[string match @@* $_shellpath]} {
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 5cded23..460d32f 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -83,6 +83,7 @@ method _visualize {} {
 
 method _start {} {
 	global HEAD current_branch remote_url
+	global _last_merged_branch
 
 	set name [_rev $this]
 	if {$name eq {}} {
@@ -109,6 +110,7 @@ method _start {} {
 	regsub ^refs/heads/ $branch {} branch
 	puts $fh "$cmit\t\tbranch '$branch' of $remote"
 	close $fh
+	set _last_merged_branch $branch
 
 	set cmd [list git]
 	lappend cmd merge
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index f872a3d..fcc06d0 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -251,7 +251,7 @@ method _write_url        {args} { set urltype url    }
 method _write_check_head {args} { set checktype head }
 
 method _write_head_list {args} {
-	global current_branch
+	global current_branch _last_merged_branch
 
 	$head_m delete 0 end
 	foreach abr $head_list {
@@ -267,6 +267,13 @@ method _write_head_list {args} {
 			set check_head $current_branch
 		}
 	}
+	set lmb [lsearch -exact -sorted $head_list $_last_merged_branch]
+	if {$lmb >= 0} {
+		$w.heads.l conf -state normal
+		$w.heads.l select set $lmb
+		$w.heads.l yview $lmb
+		$w.heads.l conf -state disabled
+	}
 }
 
 method _write_urltype {args} {
-- 
1.7.4.34.gd2cb1
