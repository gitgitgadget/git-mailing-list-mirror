From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 2/4] gitk: refactor: separate generic hunk parsing out of
 find_hunk_blamespecs{}
Date: Tue, 24 Jun 2014 21:19:23 +0300
Message-ID: <20140624181922.GB23114@wheezy.local>
References: <20140624181514.GA23051@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVJl-0001cV-2V
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbaFXSTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:19:38 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:44921
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752845AbaFXSTg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:19:36 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-06.prod.phx3.secureserver.net with 
	id JJKY1o0013gsSd601JKb8G; Tue, 24 Jun 2014 11:19:36 -0700
Content-Disposition: inline
In-Reply-To: <20140624181514.GA23051@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252414>

For requesting a region blame, it is necessary to parse a hunk and
find the region in the parent file corresponding to the selected region.
There is already hunk parsing functionality in find_hunk_blamespec{},
but it returns only information for a single line.

The new function, resolve_hunk_lines{}, scans the hunk once and returns
for all hunk lines between $start_diffline and $end_diffline, in which parent
each of them exists and which is its number there.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 93 ++++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/gitk b/gitk
index 8ef6aa8..7fa7015 100755
--- a/gitk
+++ b/gitk
@@ -3599,11 +3599,11 @@ proc external_diff {} {
     }
 }
 
-proc find_hunk_blamespec {base line} {
+proc resolve_hunk_lines {base start_diffline end_diffline} {
     global ctext
 
     # Find and parse the hunk header
-    set s_lix [$ctext search -backwards -regexp ^@@ "$line.0 lineend" $base.0]
+    set s_lix [$ctext search -backwards -regexp ^@@ "$start_diffline.0 lineend" $base.0]
     if {$s_lix eq {}} return
 
     set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
@@ -3623,49 +3623,70 @@ proc find_hunk_blamespec {base line} {
     }
 
     # Now scan the lines to determine offset within the hunk
-    set max_parent [expr {[llength $base_lines]-2}]
-    set dline 0
+    set max_parent [expr {[llength $base_lines]-1}]
     set s_lno [lindex [split $s_lix "."] 0]
 
-    # Determine if the line is removed
-    set chunk [$ctext get $line.0 "$line.1 + $max_parent chars"]
-    if {[string match {[-+ ]*} $chunk]} {
-	set removed_idx [string first "-" $chunk]
-	# Choose a parent index
-	if {$removed_idx >= 0} {
-	    set parent $removed_idx
+    set commitlines_by_diffline {}
+    array unset commit_lines
+    for {set p 0} {$p <= $max_parent} {incr p} {
+	set commit_lines($p) [expr [lindex $base_lines $p] - 1]
+    }
+    for {set diffline [expr $s_lno + 1]} {$diffline <= $end_diffline} {incr diffline} {
+	set chunk [$ctext get $diffline.0 "$diffline.0 + $max_parent chars"]
+	if {$chunk eq {} || [string match "\[\n@\]*" $chunk]} {
+	    # region is larger than hunk
+	    return {}
+	}
+	set is_removed [expr [string first "-" $chunk] >= 0]
+	if {!$is_removed} {
+	    incr commit_lines(0)
+	    set commitlines [list [list 0 $commit_lines(0)]]
 	} else {
-	    set unchanged_idx [string first " " $chunk]
-	    if {$unchanged_idx >= 0} {
-		set parent $unchanged_idx
-	    } else {
-		# blame the current commit
-		set parent -1
-	    }
-	}
-	# then count other lines that belong to it
-	for {set i $line} {[incr i -1] > $s_lno} {} {
-	    set chunk [$ctext get $i.0 "$i.1 + $max_parent chars"]
-	    # Determine if the line is removed
-	    set removed_idx [string first "-" $chunk]
-	    if {$parent >= 0} {
-		set code [string index $chunk $parent]
-		if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
-		    incr dline
+	    set commitlines {}
+	}
+	for {set p 1} {$p <= $max_parent} {incr p} {
+	    switch -- [string index $chunk "$p-1"] {
+		"+" {
 		}
-	    } else {
-		if {$removed_idx < 0} {
-		    incr dline
+		"-" {
+		    incr commit_lines($p)
+		    lappend commitlines [list $p $commit_lines($p)]
+		}
+		" " {
+		    if {!$is_removed} {
+			incr commit_lines($p)
+			lappend commitlines [list $p $commit_lines($p)]
+		    }
+		}
+		default {
+		    error_popup "resolve_hunk_lines: unexpected diff line($diffline): $chunk"
+		    break
 		}
 	    }
 	}
-	incr parent
-    } else {
-	set parent 0
+	if {$diffline >= $start_diffline} {
+	    lappend commitlines_by_diffline [list $diffline $commitlines]
+	}
     }
+    return $commitlines_by_diffline
+}
 
-    incr dline [lindex $base_lines $parent]
-    return [list $parent $dline]
+proc find_hunk_blamespec {base line} {
+    foreach cl_spec [resolve_hunk_lines $base $line $line] {
+	if {[lindex $cl_spec 0] == $line} {
+	    set commitlines [lindex $cl_spec 1]
+	    if {[llength $commitlines] > 0} {
+		if {[llength $commitlines] > 1 && [lindex $commitlines 0 0] eq 0} {
+		    return [lindex $commitlines 1]
+		} else {
+		    return [lindex $commitlines 0]
+		}
+	    } else {
+		error_popup "find_hunk_blamespec: invalid commitlines: $commitlines"
+	    }
+	}
+    }
+    return {}
 }
 
 proc external_blame_diff {} {
-- 
2.0.0.526.g5318336
