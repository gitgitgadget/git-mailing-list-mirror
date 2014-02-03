From: Max Kirillov <max@max630.net>
Subject: [PATCH 3/3 v2] gitk: show latest change to region
Date: Tue, 4 Feb 2014 00:48:11 +0200
Message-ID: <20140203224811.GD5136@wheezy.local>
References: <20140203205352.GA5136@wheezy.local>
 <20140203223346.GA14202@wheezy.local>
 <20140203224236.GC5136@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASJc-0001jO-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbaBCWs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:48:29 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:51304
	"EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419AbaBCWs2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 17:48:28 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-06.prod.phx3.secureserver.net with 
	id MyoN1n00F4CavkR01yoRnE; Mon, 03 Feb 2014 15:48:27 -0700
Content-Disposition: inline
In-Reply-To: <20140203224236.GC5136@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241487>

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
Fixed comment, same code
 gitk | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/gitk b/gitk
index eef88a1..676c990 100755
--- a/gitk
+++ b/gitk
@@ -2650,6 +2650,7 @@ proc makewindow {} {
     makemenu $diff_menu {
 	{mc "Show origin of this line" command show_line_source}
 	{mc "Run git gui blame on this line" command {external_blame_diff}}
+	{mc "Show the latest change of selected region" command show_selection_source}
     }
     $diff_menu configure -tearoff 0
 }
@@ -3464,6 +3465,7 @@ proc pop_diff_menu {w X Y x y} {
     global ctext diff_menu flist_menu_file
     global diff_menu_txtpos diff_menu_line
     global diff_menu_filebase
+    global selection_source_data
 
     set diff_menu_txtpos [split [$w index "@$x,$y"] "."]
     set diff_menu_line [lindex $diff_menu_txtpos 0]
@@ -3476,6 +3478,12 @@ proc pop_diff_menu {w X Y x y} {
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
 
@@ -3918,6 +3926,136 @@ proc read_line_source {} {
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
+    selectline [rowofcommit $id] 1 [list $fname $lnum]
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
1.8.5.2.421.g4cdf8d0
