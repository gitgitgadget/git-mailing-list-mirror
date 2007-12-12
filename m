From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach git-gui to split hunks
Date: Wed, 12 Dec 2007 19:37:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121931050.27959@racer.site>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> 
 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> 
 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> 
 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> 
 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> 
 <20071212041002.GN14735@spearce.org>  <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
  <20071212052329.GR14735@spearce.org>  <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
  <Pine.LNX.4.64.0712121814260.27959@racer.site>
 <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2XPn-0007xd-Kn
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbXLLTht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXLLTht
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:37:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:60575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760983AbXLLThr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:37:47 -0500
Received: (qmail invoked by alias); 12 Dec 2007 19:37:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 12 Dec 2007 20:37:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191HoQCvLx14isWo/qEVvXMdj4TYOO41Mq69p6N6L
	htqProtWPoJ4D8
X-X-Sender: gene099@racer.site
In-Reply-To: <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68091>


When you select the context menu item "Split Hunk" in the diff area,
git-gui will now split the current hunk so that a new hunk starts at
the current position.

For this to work, apply has to be called with --unidiff-zero, since
the new hunks can start or stop with a "-" or "+" line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 12 Dec 2007, Jason Sewall wrote:

	> On Dec 12, 2007 1:15 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
	> >
	> > I had a patch for splitting hunks in git-gui in August, but 
	> > there were some issues that I did not yet resolve.  If you 
	> > want to work on it, I'll gladly share that patch with you.
	> 
	> Sure, send it along. I'm not going to make any promises, but I 
	> could probably find time poke around in there.

	This was the next step that I did not yet quite complete:

+proc get_context_lines {line_number context_count direction variable} {
+       global ui_diff
+       upvar result $variable
+
+       set count 0
+       set result ""
+       for {set i $line_number} {$count < $context_count} {incr i $direction} {
+               switch -exact -- [$ui_diff get $i.0] {
+                       " " {
+                               append result [$ui_diff get $i.0 "$i.lineend"]
+                               incr count
+                       }
+                       "-" {
+                               append result [$ui_diff get $i.0 "$i.lineend"]
+                               incr count
+                       }
+                       "@" {
+                               return $count
+                       }
+                       "" {
+                               return $count
+                       }
+               }
+       }
+}

	Of course, this function would be used to add some context 
	to the new hunk boundaries (if needed), and to adjust the contexts
	of the remaining hunks whenever some hunk was applied.

	... and then get rid of that ugly unidiff-zero option.

 git-gui.sh   |    4 +++
 lib/diff.tcl |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 1fca11f..0798d41 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2567,6 +2567,10 @@ $ctxm add command \
 	-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
+$ctxm add command \
+	-label [mc "Split Hunk"] \
+	-command {split_hunk $cursorX $cursorY}
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
 	-label [mc "Decrease Font Size"] \
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 43565e4..0c3f790 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -289,6 +289,79 @@ proc read_diff {fd} {
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
@@ -296,7 +369,7 @@ proc apply_hunk {x y} {
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
-	set apply_cmd {apply --cached --whitespace=nowarn}
+	set apply_cmd {apply --cached --whitespace=nowarn --unidiff-zero}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected hunk."]
-- 
1.5.3.7.2250.g3893
