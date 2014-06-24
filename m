From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 4/4] gitk: show latest change to region
Date: Tue, 24 Jun 2014 21:21:07 +0300
Message-ID: <20140624182107.GD23114@wheezy.local>
References: <20140624181514.GA23051@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:30:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVTl-0007sd-CU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbaFXS3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:29:55 -0400
Received: from p3plsmtpa08-08.prod.phx3.secureserver.net ([173.201.193.109]:33338
	"EHLO p3plsmtpa08-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728AbaFXS3x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:29:53 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa08-08.prod.phx3.secureserver.net with 
	id JJMG1o00e3gsSd601JMKpE; Tue, 24 Jun 2014 11:21:22 -0700
Content-Disposition: inline
In-Reply-To: <20140624181514.GA23051@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252417>

Add a new command to the diffmenu, "Show the latest change of selected
region".  The menu command picks selection, and if it exists and covers
a single hunk, locates the latest change which has been made to the
selected lines in the file.

The menu command is disabled if the region blame is impossible, for
example if nothing is selected or the selection does not lie fully in a
single diff hunk.

The search is implemented by use of "git log -L..." command. Unlike git
blame, it can locate merges which brings together changes to the region
from different branches. This is what is desired, actually.

Unfortunally, using git log -L for finding a single line origin is
suboptimal, because (a) it does not support the "--contents" commandline
argument, or any other way to blame uncommitted changes, and (b) it is
noticeably slower. Hopely in some future git log -L will be mature
enough to be used for picking the single line origin, for now the best
option is to implement region logic separately, reusing the blame's basic io.

For diffs, the first parent is always searched. This decision is quite
voluntary, just to avoid complications to UI.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/gitk b/gitk
index 9c8dca8..4b0dc06 100755
--- a/gitk
+++ b/gitk
@@ -2651,6 +2651,7 @@ proc makewindow {} {
     makemenu $diff_menu {
 	{mc "Show origin of this line" command show_line_source}
 	{mc "Run git gui blame on this line" command {external_blame_diff}}
+	{mc "Show the latest change of selected region" command show_selection_source}
     }
     $diff_menu configure -tearoff 0
 }
@@ -3465,6 +3466,7 @@ proc pop_diff_menu {w X Y x y} {
     global ctext diff_menu flist_menu_file
     global diff_menu_txtpos diff_menu_line
     global diff_menu_filebase
+    global selection_source_data
 
     set diff_menu_txtpos [split [$w index "@$x,$y"] "."]
     set diff_menu_line [lindex $diff_menu_txtpos 0]
@@ -3477,6 +3479,12 @@ proc pop_diff_menu {w X Y x y} {
     if {$f eq {}} return
     set flist_menu_file [lindex $f 0]
     set diff_menu_filebase [lindex $f 1]
+    prepare_show_selection_source
+    if {$selection_source_data ne {}} {
+	$diff_menu entryconf 2 -state normal
+    } else {
+	$diff_menu entryconf 2 -state disabled
+    }
     tk_popup $diff_menu $X $Y
 }
 
@@ -3927,6 +3935,136 @@ proc read_line_source {} {
     return 0
 }
 
+proc show_selection_source {} {
+    global selection_source_data
+    global blameinst blamestuff
+
+    if {$selection_source_data eq {}} {
+	return
+    }
+
+    foreach var {id fname lnum lnumber} val $selection_source_data { set $var $val }
+    set args [list | git log --pretty=format:%H "-L$lnum,+$lnumber:$fname" -M -n1 $id]
+
+    startblaming $args selsource_read
+}
+
+proc selsource_read {} {
+    global blamestuff
+    global curview
+
+    set id {}
+    set lnum {}
+    set state start
+    foreach l $blamestuff {
+	switch -- $state {
+	    start { if {[regexp {^([0-9a-f]{40})$} $l _ id_match]} {
+			set id $id_match
+			set state diff_header_diff
+		    } else {
+			break
+		    }
+	    }
+	    diff_header_diff { if {[regexp {^diff --git} $l]} { set state diff_header_oldfile } else { break } }
+	    diff_header_oldfile { if {[regexp {^---} $l]} {set state diff_header_newfile} else { break } }
+	    diff_header_newfile {
+		if {[regexp {^\+\+\+ b/(.*)$} $l _ fname_match]} {
+		    set fname $fname_match
+		    set state diff_hunk_header
+		} else {
+		    break
+		}
+	    }
+	    diff_hunk_header {
+		if {[regexp {^@@@*.* \+([0-9]+),[0-9]+ @@@*$} $l _ lnum_matched]} {
+		    set lnum $lnum_matched
+		    break
+		}
+	    }
+	}
+    }
+
+    if {$id eq {}} {
+	error_popup [mc "Parsing output of git log failed"]
+	return 0
+    }
+
+    if {![commitinview $id $curview]} {
+	error_popup [mc "The latest change is in commit %s, \
+			 which is not in this view" [shortids $id]]
+	return 0
+    }
+
+    selectline [rowofcommit $id] 1 [list $fname $lnum] 1
+}
+
+proc prepare_show_selection_source {} {
+    global ctext
+    global selection_source_data
+
+    set selection [$ctext tag ranges sel]
+    if {[llength $selection] != 2} {
+	set selection_source_data {}
+	return
+    }
+    set start_line [lindex [split [lindex $selection 0] "."] 0]
+    set end_index [split [lindex $selection 1] "."]
+    if {[lindex $end_index 1] eq 0} {
+	set end_line [expr [lindex $end_index 0] - 1]
+    } else {
+	set end_line [lindex $end_index 0]
+    }
+    set selection_source_data [prepare_show_region_source $start_line $end_line]
+}
+
+proc prepare_show_region_source {start_line end_line} {
+    global cmitmode
+    global currentid parents curview
+    global nullid
+    if {$start_line > $end_line} {
+	error_popup "Cannot blame region: $start_line > $end_line"
+	return {}
+    }
+    set f [find_ctext_fileinfo $start_line]
+    if {$f eq {}} {
+	return {}
+    }
+    if {$currentid eq $nullid} {
+	return {}
+    }
+    set fname [lindex $f 0]
+    set filebase [lindex $f 1]
+    if {$cmitmode eq "tree"} {
+	set id $currentid
+	set start_lnum [expr $start_line - $filebase]
+	set end_lnum [expr $end_line - $filebase]
+    } else {
+	set id [lindex $parents($curview,$currentid) 0]
+	set start_lnum {}
+	set end_lnum {}
+	foreach cl_spec [resolve_hunk_lines $filebase $start_line $end_line] {
+	    set diffline [lindex $cl_spec 0]
+	    if {$diffline > $end_line} {
+		break
+	    } elseif {$diffline >= $start_line} {
+		foreach branch [lindex $cl_spec 1] {
+		    if {[lindex $branch 0] == 1} {
+			if {$start_lnum eq {}} {
+			    set start_lnum [lindex $branch 1]
+			}
+			set end_lnum [lindex $branch 1]
+		    }
+		}
+	    }
+	}
+    }
+    if {$start_lnum ne {} && $end_lnum ne {}} {
+	return [list $id $fname $start_lnum [expr $end_lnum - $start_lnum + 1]]
+    } else {
+	return {}
+    }
+}
+
 # delete $dir when we see eof on $f (presumably because the child has exited)
 proc delete_at_eof {f dir} {
     while {[gets $f line] >= 0} {}
-- 
2.0.0.526.g5318336
