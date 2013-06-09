From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH gitk 1/4] gitk: refactor per-line part of getblobdiffline and its support
Date: Sun, 9 Jun 2013 21:44:12 +0200
Message-ID: <dfa701201191471b86eb9e375537498971dafb6a.1370806329.git.trast@inf.ethz.ch>
References: <cover.1370806329.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllXZ-0003Xs-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab3FITo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:44:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41722 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab3FIToT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:44:19 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:01 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:15 +0200
X-Mailer: git-send-email 1.8.3.496.g0d0267b
In-Reply-To: <cover.1370806329.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227154>

For later use with data sources other than a pipe, refactor the big
worker part of getblobdiffline to a separate function
parseblobdiffline.  Also refactor its initialization and wrap-up to
separate routines.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 408 +++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 213 insertions(+), 195 deletions(-)

diff --git a/gitk b/gitk
index 5cd00d8..81dce20 100755
--- a/gitk
+++ b/gitk
@@ -7710,15 +7710,25 @@ proc changeworddiff {name ix op} {
     reselectline
 }
 
+proc initblobdiffvars {} {
+    global diffencoding targetline diffnparents
+    global diffinhdr currdiffsubmod diffseehere
+    set targetline {}
+    set diffnparents 0
+    set diffinhdr 0
+    set diffencoding [get_path_encoding {}]
+    set currdiffsubmod ""
+    set diffseehere -1
+}
+
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
-    global diffinhdr treediffs
+    global treediffs
     global diffcontext
     global ignorespace
     global worddiff
     global limitdiffs vfilelimit curview
-    global diffencoding targetline diffnparents
-    global git_version currdiffsubmod
+    global git_version
 
     set textconv {}
     if {[package vcompare $git_version "1.6.1"] >= 0} {
@@ -7742,13 +7752,9 @@ proc getblobdiffs {ids} {
 	error_popup [mc "Error getting diffs: %s" $err]
 	return
     }
-    set targetline {}
-    set diffnparents 0
-    set diffinhdr 0
-    set diffencoding [get_path_encoding {}]
     fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
-    set currdiffsubmod ""
+    initblobdiffvars
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }
 
@@ -7814,13 +7820,17 @@ proc makediffhdr {fname ids} {
     set diffline 0
 }
 
+proc blobdiffmaybeseehere {ateof} {
+    global diffseehere
+    if {$diffseehere >= 0} {
+	mark_ctext_line [lindex [split $diffseehere .] 0]
+    }
+    maybe_scroll_ctext ateof
+}
+
 proc getblobdiffline {bdf ids} {
-    global diffids blobdifffd ctext curdiffstart
-    global diffnexthead diffnextnote difffilestart
-    global ctext_file_names ctext_file_lines
-    global diffinhdr treediffs mergemax diffnparents
-    global diffencoding jump_to_here targetline diffline currdiffsubmod
-    global worddiff
+    global diffids blobdifffd
+    global ctext
 
     set nr 0
     $ctext conf -state normal
@@ -7829,212 +7839,220 @@ proc getblobdiffline {bdf ids} {
 	    catch {close $bdf}
 	    return 0
 	}
-	if {![string compare -length 5 "diff " $line]} {
-	    if {![regexp {^diff (--cc|--git) } $line m type]} {
-		set line [encoding convertfrom $line]
-		$ctext insert end "$line\n" hunksep
-		continue
+	parseblobdiffline $ids $line
+    }
+    $ctext conf -state disabled
+    blobdiffmaybeseehere [eof $bdf]
+    if {[eof $bdf]} {
+	catch {close $bdf}
+	return 0
+    }
+    return [expr {$nr >= 1000? 2: 1}]
+}
+
+proc parseblobdiffline {ids line} {
+    global ctext curdiffstart
+    global diffnexthead diffnextnote difffilestart
+    global ctext_file_names ctext_file_lines
+    global diffinhdr treediffs mergemax diffnparents
+    global diffencoding jump_to_here targetline diffline currdiffsubmod
+    global worddiff diffseehere
+
+    if {![string compare -length 5 "diff " $line]} {
+	if {![regexp {^diff (--cc|--git) } $line m type]} {
+	    set line [encoding convertfrom $line]
+	    $ctext insert end "$line\n" hunksep
+	    continue
+	}
+	# start of a new file
+	set diffinhdr 1
+	$ctext insert end "\n"
+	set curdiffstart [$ctext index "end - 1c"]
+	lappend ctext_file_names ""
+	lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
+	$ctext insert end "\n" filesep
+
+	if {$type eq "--cc"} {
+	    # start of a new file in a merge diff
+	    set fname [string range $line 10 end]
+	    if {[lsearch -exact $treediffs($ids) $fname] < 0} {
+		lappend treediffs($ids) $fname
+		add_flist [list $fname]
 	    }
-	    # start of a new file
-	    set diffinhdr 1
-	    $ctext insert end "\n"
-	    set curdiffstart [$ctext index "end - 1c"]
-	    lappend ctext_file_names ""
-	    lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
-	    $ctext insert end "\n" filesep
-
-	    if {$type eq "--cc"} {
-		# start of a new file in a merge diff
-		set fname [string range $line 10 end]
-		if {[lsearch -exact $treediffs($ids) $fname] < 0} {
-		    lappend treediffs($ids) $fname
-		    add_flist [list $fname]
-		}
 
+	} else {
+	    set line [string range $line 11 end]
+	    # If the name hasn't changed the length will be odd,
+	    # the middle char will be a space, and the two bits either
+	    # side will be a/name and b/name, or "a/name" and "b/name".
+	    # If the name has changed we'll get "rename from" and
+	    # "rename to" or "copy from" and "copy to" lines following
+	    # this, and we'll use them to get the filenames.
+	    # This complexity is necessary because spaces in the
+	    # filename(s) don't get escaped.
+	    set l [string length $line]
+	    set i [expr {$l / 2}]
+	    if {!(($l & 1) && [string index $line $i] eq " " &&
+		  [string range $line 2 [expr {$i - 1}]] eq \
+		      [string range $line [expr {$i + 3}] end])} {
+		return
+	    }
+	    # unescape if quoted and chop off the a/ from the front
+	    if {[string index $line 0] eq "\""} {
+		set fname [string range [lindex $line 0] 2 end]
 	    } else {
-		set line [string range $line 11 end]
-		# If the name hasn't changed the length will be odd,
-		# the middle char will be a space, and the two bits either
-		# side will be a/name and b/name, or "a/name" and "b/name".
-		# If the name has changed we'll get "rename from" and
-		# "rename to" or "copy from" and "copy to" lines following
-		# this, and we'll use them to get the filenames.
-		# This complexity is necessary because spaces in the
-		# filename(s) don't get escaped.
-		set l [string length $line]
-		set i [expr {$l / 2}]
-		if {!(($l & 1) && [string index $line $i] eq " " &&
-		      [string range $line 2 [expr {$i - 1}]] eq \
-			  [string range $line [expr {$i + 3}] end])} {
-		    continue
-		}
-		# unescape if quoted and chop off the a/ from the front
-		if {[string index $line 0] eq "\""} {
-		    set fname [string range [lindex $line 0] 2 end]
-		} else {
-		    set fname [string range $line 2 [expr {$i - 1}]]
-		}
+		set fname [string range $line 2 [expr {$i - 1}]]
 	    }
-	    makediffhdr $fname $ids
+	}
+	makediffhdr $fname $ids
 
-	} elseif {![string compare -length 16 "* Unmerged path " $line]} {
-	    set fname [encoding convertfrom [string range $line 16 end]]
-	    $ctext insert end "\n"
-	    set curdiffstart [$ctext index "end - 1c"]
-	    lappend ctext_file_names $fname
-	    lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
+    } elseif {![string compare -length 16 "* Unmerged path " $line]} {
+	set fname [encoding convertfrom [string range $line 16 end]]
+	$ctext insert end "\n"
+	set curdiffstart [$ctext index "end - 1c"]
+	lappend ctext_file_names $fname
+	lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
+	$ctext insert end "$line\n" filesep
+	set i [lsearch -exact $treediffs($ids) $fname]
+	if {$i >= 0} {
+	    setinlist difffilestart $i $curdiffstart
+	}
+
+    } elseif {![string compare -length 2 "@@" $line]} {
+	regexp {^@@+} $line ats
+	set line [encoding convertfrom $diffencoding $line]
+	$ctext insert end "$line\n" hunksep
+	if {[regexp { \+(\d+),\d+ @@} $line m nl]} {
+	    set diffline $nl
+	}
+	set diffnparents [expr {[string length $ats] - 1}]
+	set diffinhdr 0
+
+    } elseif {![string compare -length 10 "Submodule " $line]} {
+	# start of a new submodule
+	if {[regexp -indices "\[0-9a-f\]+\\.\\." $line nameend]} {
+	    set fname [string range $line 10 [expr [lindex $nameend 0] - 2]]
+	} else {
+	    set fname [string range $line 10 [expr [string first "contains " $line] - 2]]
+	}
+	if {$currdiffsubmod != $fname} {
+	    $ctext insert end "\n";     # Add newline after commit message
+	}
+	set curdiffstart [$ctext index "end - 1c"]
+	lappend ctext_file_names ""
+	if {$currdiffsubmod != $fname} {
+	    lappend ctext_file_lines $fname
+	    makediffhdr $fname $ids
+	    set currdiffsubmod $fname
+	    $ctext insert end "\n$line\n" filesep
+	} else {
 	    $ctext insert end "$line\n" filesep
+	}
+    } elseif {![string compare -length 3 "  >" $line]} {
+	set $currdiffsubmod ""
+	set line [encoding convertfrom $diffencoding $line]
+	$ctext insert end "$line\n" dresult
+    } elseif {![string compare -length 3 "  <" $line]} {
+	set $currdiffsubmod ""
+	set line [encoding convertfrom $diffencoding $line]
+	$ctext insert end "$line\n" d0
+    } elseif {$diffinhdr} {
+	if {![string compare -length 12 "rename from " $line]} {
+	    set fname [string range $line [expr 6 + [string first " from " $line] ] end]
+	    if {[string index $fname 0] eq "\""} {
+		set fname [lindex $fname 0]
+	    }
+	    set fname [encoding convertfrom $fname]
 	    set i [lsearch -exact $treediffs($ids) $fname]
 	    if {$i >= 0} {
 		setinlist difffilestart $i $curdiffstart
 	    }
-
-	} elseif {![string compare -length 2 "@@" $line]} {
-	    regexp {^@@+} $line ats
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" hunksep
-	    if {[regexp { \+(\d+),\d+ @@} $line m nl]} {
-		set diffline $nl
+	} elseif {![string compare -length 10 $line "rename to "] ||
+		  ![string compare -length 8 $line "copy to "]} {
+	    set fname [string range $line [expr 4 + [string first " to " $line] ] end]
+	    if {[string index $fname 0] eq "\""} {
+		set fname [lindex $fname 0]
 	    }
-	    set diffnparents [expr {[string length $ats] - 1}]
+	    makediffhdr $fname $ids
+	} elseif {[string compare -length 3 $line "---"] == 0} {
+	    # do nothing
+	    return
+	} elseif {[string compare -length 3 $line "+++"] == 0} {
 	    set diffinhdr 0
+	    return
+	}
+	$ctext insert end "$line\n" filesep
 
-	} elseif {![string compare -length 10 "Submodule " $line]} {
-	    # start of a new submodule
-	    if {[regexp -indices "\[0-9a-f\]+\\.\\." $line nameend]} {
-		set fname [string range $line 10 [expr [lindex $nameend 0] - 2]]
-	    } else {
-		set fname [string range $line 10 [expr [string first "contains " $line] - 2]]
-	    }
-	    if {$currdiffsubmod != $fname} {
-		$ctext insert end "\n";     # Add newline after commit message
-	    }
-	    set curdiffstart [$ctext index "end - 1c"]
-	    lappend ctext_file_names ""
-	    if {$currdiffsubmod != $fname} {
-		lappend ctext_file_lines $fname
-		makediffhdr $fname $ids
-		set currdiffsubmod $fname
-		$ctext insert end "\n$line\n" filesep
-	    } else {
-		$ctext insert end "$line\n" filesep
-	    }
-	} elseif {![string compare -length 3 "  >" $line]} {
-	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" dresult
-	} elseif {![string compare -length 3 "  <" $line]} {
-	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" d0
-	} elseif {$diffinhdr} {
-	    if {![string compare -length 12 "rename from " $line]} {
-		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
-		if {[string index $fname 0] eq "\""} {
-		    set fname [lindex $fname 0]
-		}
-		set fname [encoding convertfrom $fname]
-		set i [lsearch -exact $treediffs($ids) $fname]
-		if {$i >= 0} {
-		    setinlist difffilestart $i $curdiffstart
+    } else {
+	set line [string map {\x1A ^Z} \
+		      [encoding convertfrom $diffencoding $line]]
+	# parse the prefix - one ' ', '-' or '+' for each parent
+	set prefix [string range $line 0 [expr {$diffnparents - 1}]]
+	set tag [expr {$diffnparents > 1? "m": "d"}]
+	set dowords [expr {$worddiff ne [mc "Line diff"] && $diffnparents == 1}]
+	set words_pre_markup ""
+	set words_post_markup ""
+	if {[string trim $prefix " -+"] eq {}} {
+	    # prefix only has " ", "-" and "+" in it: normal diff line
+	    set num [string first "-" $prefix]
+	    if {$dowords} {
+		set line [string range $line 1 end]
+	    }
+	    if {$num >= 0} {
+		# removed line, first parent with line is $num
+		if {$num >= $mergemax} {
+		    set num "max"
 		}
-	    } elseif {![string compare -length 10 $line "rename to "] ||
-		      ![string compare -length 8 $line "copy to "]} {
-		set fname [string range $line [expr 4 + [string first " to " $line] ] end]
-		if {[string index $fname 0] eq "\""} {
-		    set fname [lindex $fname 0]
+		if {$dowords && $worddiff eq [mc "Markup words"]} {
+		    $ctext insert end "\[-$line-\]" $tag$num
+		} else {
+		    $ctext insert end "$line" $tag$num
 		}
-		makediffhdr $fname $ids
-	    } elseif {[string compare -length 3 $line "---"] == 0} {
-		# do nothing
-		continue
-	    } elseif {[string compare -length 3 $line "+++"] == 0} {
-		set diffinhdr 0
-		continue
-	    }
-	    $ctext insert end "$line\n" filesep
-
-	} else {
-	    set line [string map {\x1A ^Z} \
-                          [encoding convertfrom $diffencoding $line]]
-	    # parse the prefix - one ' ', '-' or '+' for each parent
-	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
-	    set tag [expr {$diffnparents > 1? "m": "d"}]
-	    set dowords [expr {$worddiff ne [mc "Line diff"] && $diffnparents == 1}]
-	    set words_pre_markup ""
-	    set words_post_markup ""
-	    if {[string trim $prefix " -+"] eq {}} {
-		# prefix only has " ", "-" and "+" in it: normal diff line
-		set num [string first "-" $prefix]
-		if {$dowords} {
-		    set line [string range $line 1 end]
+		if {!$dowords} {
+		    $ctext insert end "\n" $tag$num
 		}
-		if {$num >= 0} {
-		    # removed line, first parent with line is $num
-		    if {$num >= $mergemax} {
-			set num "max"
-		    }
-		    if {$dowords && $worddiff eq [mc "Markup words"]} {
-			$ctext insert end "\[-$line-\]" $tag$num
-		    } else {
-			$ctext insert end "$line" $tag$num
-		    }
-		    if {!$dowords} {
-			$ctext insert end "\n" $tag$num
-		    }
-		} else {
-		    set tags {}
-		    if {[string first "+" $prefix] >= 0} {
-			# added line
-			lappend tags ${tag}result
-			if {$diffnparents > 1} {
-			    set num [string first " " $prefix]
-			    if {$num >= 0} {
-				if {$num >= $mergemax} {
-				    set num "max"
-				}
-				lappend tags m$num
+	    } else {
+		set tags {}
+		if {[string first "+" $prefix] >= 0} {
+		    # added line
+		    lappend tags ${tag}result
+		    if {$diffnparents > 1} {
+			set num [string first " " $prefix]
+			if {$num >= 0} {
+			    if {$num >= $mergemax} {
+				set num "max"
 			    }
+			    lappend tags m$num
 			}
-			set words_pre_markup "{+"
-			set words_post_markup "+}"
 		    }
-		    if {$targetline ne {}} {
-			if {$diffline == $targetline} {
-			    set seehere [$ctext index "end - 1 chars"]
-			    set targetline {}
-			} else {
-			    incr diffline
-			}
-		    }
-		    if {$dowords && $worddiff eq [mc "Markup words"]} {
-			$ctext insert end "$words_pre_markup$line$words_post_markup" $tags
+		    set words_pre_markup "{+"
+		    set words_post_markup "+}"
+		}
+		if {$targetline ne {}} {
+		    if {$diffline == $targetline} {
+			set diffseehere [$ctext index "end - 1 chars"]
+			set targetline {}
 		    } else {
-			$ctext insert end "$line" $tags
-		    }
-		    if {!$dowords} {
-			$ctext insert end "\n" $tags
+			incr diffline
 		    }
 		}
-	    } elseif {$dowords && $prefix eq "~"} {
-		$ctext insert end "\n" {}
-	    } else {
-		# "\ No newline at end of file",
-		# or something else we don't recognize
-		$ctext insert end "$line\n" hunksep
+		if {$dowords && $worddiff eq [mc "Markup words"]} {
+		    $ctext insert end "$words_pre_markup$line$words_post_markup" $tags
+		} else {
+		    $ctext insert end "$line" $tags
+		}
+		if {!$dowords} {
+		    $ctext insert end "\n" $tags
+		}
 	    }
+	} elseif {$dowords && $prefix eq "~"} {
+	    $ctext insert end "\n" {}
+	} else {
+	    # "\ No newline at end of file",
+	    # or something else we don't recognize
+	    $ctext insert end "$line\n" hunksep
 	}
     }
-    if {[info exists seehere]} {
-	mark_ctext_line [lindex [split $seehere .] 0]
-    }
-    maybe_scroll_ctext [eof $bdf]
-    $ctext conf -state disabled
-    if {[eof $bdf]} {
-	catch {close $bdf}
-	return 0
-    }
-    return [expr {$nr >= 1000? 2: 1}]
 }
 
 proc changediffdisp {} {
-- 
1.8.3.496.g0d0267b
