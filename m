From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 06:32:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260630570.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 07:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDvxQ-0006eE-4t
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbXGZFcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXGZFcN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:32:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:45830 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751243AbXGZFcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:32:12 -0400
Received: (qmail invoked by alias); 26 Jul 2007 05:32:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 26 Jul 2007 07:32:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9J5NWAX/9dw+kUsUFZo/tssv6xkEKZsTG7LdGqw
	LP0XcUlytBzlTL
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53769>


When you select the context menu item "Split Hunk" in the diff area,
git-gui will now split the current hunk so that a new hunk starts at
the current position.

For this to work, apply has to be called with --unidiff-zero, since
the new hunks can start or stop with a "-" or "+" line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	No more complaining from me about the lack of that feature.

	And I did not even need a C compiler to do that.

 git-gui.sh   |    4 +++
 lib/diff.tcl |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index a38293a..a0f7617 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2400,6 +2400,10 @@ $ctxm add command \
 	-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
+$ctxm add command \
+	-label [mc "Split Hunk"] \
+	-command {split_hunk $cursorX $cursorY}
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
 	-label {Decrease Font Size} \
diff --git a/lib/diff.tcl b/lib/diff.tcl
index e09e125..88ec8f3 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -265,6 +265,79 @@ proc read_diff {fd} {
 	}
 }
 
+proc split_hunk {x y} {
+	global current_diff_path current_diff_header current_diff_side
+	global ui_diff ui_index file_states
+
+	if {$current_diff_path eq {} || $current_diff_header eq {}} return
+	if {![lock_index apply_hunk]} return
+
+	set c_lno [lindex [split [$ui_diff index @$x,$y] .] 0]
+	set s_idx [$ui_diff search -backwards -regexp ^@@ $c_lno.0 0.0]
+	if {$s_idx eq {} || $s_idx >= [expr $c_lno - 1]} {
+		unlock_index
+		return
+	}
+	set s_lno [lindex [split $s_idx .] 0]
+
+	# the first hunk will look like this: @@ -$m1,$m2 +$p1,$p2 @@
+	# the second hunk will look like this: @@ -$m3,$m4 +$p3,$p4 @@
+
+	# get original hunk numbers
+	set hunk_line [$ui_diff get $s_idx "$s_idx lineend"]
+	set re "@@ +-(\[0-9\]+)(,(\[0-9\]+))? +\\+(\[0-9\]+)(,(\[0-9\]+))? *@@"
+	if {![regexp $re $hunk_line dummy m1 dummy m4 p1 dummy p4] ||
+			$m1 == 0 || $p1 == 0} { # create/delete file
+		unlock_index
+		return
+	}
+	if {$m4 == ""} {
+		set m4 1
+	}
+	if {$p4 == ""} {
+		set p4 1
+	}
+
+	# count changes
+	set m2 0
+	set p2 0
+	for {set l [expr $s_lno + 1]} {$l < $c_lno} {incr l} {
+		switch -exact -- [$ui_diff get $l.0] {
+			" " {
+				incr m2
+				incr p2
+			}
+			"+" {
+				incr p2
+			}
+			"-" {
+				incr m2
+			}
+		}
+	}
+
+	# We could check if {$m2 == $p2 && $m2 == [expr $c_lno - $s_lno]}
+	# and just remove the hunk.  But let's not be too clever here.
+
+	set m3 [expr $m1 + $m2]
+	set m4 [expr $m4 - $m2]
+	set p3 [expr $p1 + $p2]
+	set p4 [expr $p4 - $p2]
+
+	if {$m4 == 0 && $p4 == 0} {
+		index_unlock
+		return
+	}
+
+	$ui_diff configure -state normal
+	$ui_diff delete $s_idx "$s_idx lineend"
+	$ui_diff insert $s_idx "@@ -$m1,$m2 +$p1,$p2 @@" d_@
+	$ui_diff insert $c_lno.0 "@@ -$m3,$m4 +$p3,$p4 @@\n" d_@
+	$ui_diff configure -state disabled
+
+	unlock_index
+}
+
 proc apply_hunk {x y} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
@@ -272,7 +345,7 @@ proc apply_hunk {x y} {
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
-	set apply_cmd {apply --cached --whitespace=nowarn}
+	set apply_cmd {apply --cached --whitespace=nowarn --unidiff-zero}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set mode unstage
-- 
1.5.3.rc2.42.gda8d-dirty
