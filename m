From: Paul Mackerras <paulus@samba.org>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Fri, 13 Jul 2007 19:55:45 +1000
Message-ID: <18071.19489.6733.665052@cargo.ozlabs.ibm.com>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Hsq-0003mA-JS
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936860AbXGMJ4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936822AbXGMJ4H
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:56:07 -0400
Received: from ozlabs.org ([203.10.76.45]:60483 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936367AbXGMJ4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:56:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BD670DDE0C; Fri, 13 Jul 2007 19:56:01 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52378>

Linus Torvalds writes:

> It would be very nice to have *two* such commits (either or both of which 
> just disappear), where the top-most is the diff to the index, and the 
> second is the diff from the index to HEAD.

Try this, let me know what you think.  I called the changes in the
working directory "Local uncommitted changes, not checked in to index"
and the changes in the index "Local changes checked in to index but
not committed".  If you prefer some other wording, let me know.  I
made the working directory commit red (as before) and the index commit
magenta, as being between red and blue.  The index commit gets a fake
SHA1 id of 00..001.

Paul.

diff --git a/gitk b/gitk
index 39e452a..7ce86b8 100755
--- a/gitk
+++ b/gitk
@@ -262,11 +262,11 @@ proc chewcommits {view} {
 	set tlimit [expr {[clock clicks -milliseconds] + 50}]
 	set more [layoutmore $tlimit $allread]
 	if {$allread && !$more} {
-	    global displayorder nullid commitidx phase
+	    global displayorder commitidx phase
 	    global numcommits startmsecs
 
 	    if {[info exists pending_select]} {
-		set row [expr {[lindex $displayorder 0] eq $nullid}]
+		set row [first_real_row]
 		selectline $row 1
 	    }
 	    if {$commitidx($curview) > 0} {
@@ -437,6 +437,19 @@ proc readrefs {} {
     }
 }
 
+# skip over fake commits
+proc first_real_row {} {
+    global nullid nullid2 displayorder numcommits
+
+    for {set row 0} {$row < $numcommits} {incr row} {
+	set id [lindex $displayorder $row]
+	if {$id ne $nullid && $id ne $nullid2} {
+	    break
+	}
+    }
+    return $row
+}
+
 # update things for a head moved to a child of its previous location
 proc movehead {id name} {
     global headids idheads
@@ -1871,7 +1884,7 @@ proc showview {n} {
     } elseif {$selid ne {}} {
 	set pending_select $selid
     } else {
-	set row [expr {[lindex $displayorder 0] eq $nullid}]
+	set row [first_real_row]
 	if {$row < $numcommits} {
 	    selectline $row 0
 	} else {
@@ -2643,7 +2656,7 @@ proc layoutmore {tmax allread} {
 
 proc showstuff {canshow last} {
     global numcommits commitrow pending_select selectedline curview
-    global lookingforhead mainheadid displayorder nullid selectfirst
+    global lookingforhead mainheadid displayorder selectfirst
     global lastscrollset
 
     if {$numcommits == 0} {
@@ -2676,7 +2689,7 @@ proc showstuff {canshow last} {
 	if {[info exists selectedline] || [info exists pending_select]} {
 	    set selectfirst 0
 	} else {
-	    set l [expr {[lindex $displayorder 0] eq $nullid}]
+	    set l [first_real_row]
 	    selectline $l 1
 	    set selectfirst 0
 	}
@@ -2700,48 +2713,93 @@ proc doshowlocalchanges {} {
 }
 
 proc dohidelocalchanges {} {
-    global lookingforhead localrow lserial
+    global lookingforhead localfrow localirow lserial
 
     set lookingforhead 0
-    if {$localrow >= 0} {
-	removerow $localrow
-	set localrow -1
+    if {$localfrow >= 0} {
+	removerow $localfrow
+	set localfrow -1
+	if {$localirow > 0} {
+	    incr localirow -1
+	}
+    }
+    if {$localirow >= 0} {
+	removerow $localirow
+	set localirow -1
     }
     incr lserial
 }
 
-# spawn off a process to do git diff-index HEAD
+# spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
-    global localrow lserial
+    global localirow localfrow lserial
 
     incr lserial
-    set localrow -1
-    set fd [open "|git diff-index HEAD" r]
+    set localfrow -1
+    set localirow -1
+    set fd [open "|git diff-index --cached HEAD" r]
     fconfigure $fd -blocking 0
     filerun $fd [list readdiffindex $fd $lserial]
 }
 
 proc readdiffindex {fd serial} {
-    global localrow commitrow mainheadid nullid curview
+    global localirow commitrow mainheadid nullid2 curview
     global commitinfo commitdata lserial
 
+    set isdiff 1
     if {[gets $fd line] < 0} {
-	if {[eof $fd]} {
-	    close $fd
-	    return 0
+	if {![eof $fd]} {
+	    return 1
 	}
-	return 1
+	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
     close $fd
 
-    if {$serial == $lserial && $localrow == -1} {
+    # now see if there are any local changes not checked in to the index
+    if {$serial == $lserial} {
+	set fd [open "|git diff-files" r]
+	fconfigure $fd -blocking 0
+	filerun $fd [list readdifffiles $fd $serial]
+    }
+
+    if {$isdiff && $serial == $lserial && $localirow == -1} {
+	# add the line for the changes in the index to the graph
+	set localirow $commitrow($curview,$mainheadid)
+	set hl "Local changes checked in to index but not committed"
+	set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
+	set commitdata($nullid2) "\n    $hl\n"
+	insertrow $localirow $nullid2
+    }
+    return 0
+}
+
+proc readdifffiles {fd serial} {
+    global localirow localfrow commitrow mainheadid nullid curview
+    global commitinfo commitdata lserial
+
+    set isdiff 1
+    if {[gets $fd line] < 0} {
+	if {![eof $fd]} {
+	    return 1
+	}
+	set isdiff 0
+    }
+    # we only need to see one line and we don't really care what it says...
+    close $fd
+
+    if {$isdiff && $serial == $lserial && $localfrow == -1} {
 	# add the line for the local diff to the graph
-	set localrow $commitrow($curview,$mainheadid)
-	set hl "Local uncommitted changes"
+	if {$localirow >= 0} {
+	    set localfrow $localirow
+	    incr localirow
+	} else {
+	    set localfrow $commitrow($curview,$mainheadid)
+	}
+	set hl "Local uncommitted changes, not checked in to index"
 	set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
 	set commitdata($nullid) "\n    $hl\n"
-	insertrow $localrow $nullid
+	insertrow $localfrow $nullid
     }
     return 0
 }
@@ -3338,12 +3396,14 @@ proc drawcmittext {id row col} {
     global commitlisted commitinfo rowidlist parentlist
     global rowtextx idpos idtags idheads idotherrefs
     global linehtag linentag linedtag markingmatches
-    global mainfont canvxmax boldrows boldnamerows fgcolor nullid
+    global mainfont canvxmax boldrows boldnamerows fgcolor nullid nullid2
 
     # listed is 0 for boundary, 1 for normal, 2 for left, 3 for right
     set listed [lindex $commitlisted $row]
     if {$id eq $nullid} {
 	set ofill red
+    } elseif {$id eq $nullid2} {
+	set ofill magenta
     } else {
 	set ofill [expr {$listed != 0? "blue": "white"}]
     }
@@ -4582,16 +4642,19 @@ proc goforw {} {
 }
 
 proc gettree {id} {
-    global treefilelist treeidlist diffids diffmergeid treepending nullid
+    global treefilelist treeidlist diffids diffmergeid treepending
+    global nullid nullid2
 
     set diffids $id
     catch {unset diffmergeid}
     if {![info exists treefilelist($id)]} {
 	if {![info exists treepending]} {
-	    if {$id ne $nullid} {
-		set cmd [concat | git ls-tree -r $id]
+	    if {$id eq $nullid} {
+		set cmd [list | git ls-files]
+	    } elseif {$id eq $nullid2} {
+		set cmd [list | git ls-files --stage -t]
 	    } else {
-		set cmd [concat | git ls-files]
+		set cmd [list | git ls-tree -r $id]
 	    }
 	    if {[catch {set gtf [open $cmd r]}]} {
 		return
@@ -4608,12 +4671,14 @@ proc gettree {id} {
 }
 
 proc gettreeline {gtf id} {
-    global treefilelist treeidlist treepending cmitmode diffids nullid
+    global treefilelist treeidlist treepending cmitmode diffids nullid nullid2
 
     set nl 0
     while {[incr nl] <= 1000 && [gets $gtf line] >= 0} {
-	if {$diffids ne $nullid} {
-	    if {[lindex $line 1] ne "blob"} continue
+	if {$diffids eq $nullid} {
+	    set fname $line
+	} else {
+	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
 	    set i [string first "\t" $line]
 	    if {$i < 0} continue
 	    set sha1 [lindex $line 2]
@@ -4622,8 +4687,6 @@ proc gettreeline {gtf id} {
 		set fname [lindex $fname 0]
 	    }
 	    lappend treeidlist($id) $sha1
-	} else {
-	    set fname $line
 	}
 	lappend treefilelist($id) $fname
     }
@@ -4645,7 +4708,7 @@ proc gettreeline {gtf id} {
 }
 
 proc showfile {f} {
-    global treefilelist treeidlist diffids nullid
+    global treefilelist treeidlist diffids nullid nullid2
     global ctext commentend
 
     set i [lsearch -exact $treefilelist($diffids) $f]
@@ -4653,15 +4716,15 @@ proc showfile {f} {
 	puts "oops, $f not in list for id $diffids"
 	return
     }
-    if {$diffids ne $nullid} {
-	set blob [lindex $treeidlist($diffids) $i]
-	if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
-	    puts "oops, error reading blob $blob: $err"
+    if {$diffids eq $nullid} {
+	if {[catch {set bf [open $f r]} err]} {
+	    puts "oops, can't read $f: $err"
 	    return
 	}
     } else {
-	if {[catch {set bf [open $f r]} err]} {
-	    puts "oops, can't read $f: $err"
+	set blob [lindex $treeidlist($diffids) $i]
+	if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
+	    puts "oops, error reading blob $blob: $err"
 	    return
 	}
     }
@@ -4789,11 +4852,13 @@ proc getmergediffline {mdf id np} {
 }
 
 proc startdiff {ids} {
-    global treediffs diffids treepending diffmergeid nullid
+    global treediffs diffids treepending diffmergeid nullid nullid2
 
     set diffids $ids
     catch {unset diffmergeid}
-    if {![info exists treediffs($ids)] || [lsearch -exact $ids $nullid] >= 0} {
+    if {![info exists treediffs($ids)] ||
+	[lsearch -exact $ids $nullid] >= 0 ||
+	[lsearch -exact $ids $nullid2] >= 0} {
 	if {![info exists treepending]} {
 	    gettreediffs $ids
 	}
@@ -4809,22 +4874,41 @@ proc addtocflist {ids} {
 }
 
 proc diffcmd {ids flags} {
-    global nullid
+    global nullid nullid2
 
     set i [lsearch -exact $ids $nullid]
+    set j [lsearch -exact $ids $nullid2]
     if {$i >= 0} {
-	set cmd [concat | git diff-index $flags]
+	if {[llength $ids] > 1 && $j < 0} {
+	    # comparing working directory with some specific revision
+	    set cmd [concat | git diff-index $flags]
+	    if {$i == 0} {
+		lappend cmd -R [lindex $ids 1]
+	    } else {
+		lappend cmd [lindex $ids 0]
+	    }
+	} else {
+	    # comparing working directory with index
+	    set cmd [concat | git diff-files $flags]
+	    if {$j == 1} {
+		lappend cmd -R
+	    }
+	}
+    } elseif {$j >= 0} {
+	set cmd [concat | git diff-index --cached $flags]
 	if {[llength $ids] > 1} {
+	    # comparing index with specific revision
 	    if {$i == 0} {
 		lappend cmd -R [lindex $ids 1]
 	    } else {
 		lappend cmd [lindex $ids 0]
 	    }
 	} else {
+	    # comparing index with HEAD
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree --no-commit-id -r $flags $ids]
+	set cmd [concat | git diff-tree -r $flags $ids]
     }
     return $cmd
 }
@@ -4834,7 +4918,7 @@ proc gettreediffs {ids} {
 
     set treepending $ids
     set treediff {}
-    if {[catch {set gdtf [open [diffcmd $ids {}] r]}]} return
+    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
     fconfigure $gdtf -blocking 0
     filerun $gdtf [list gettreediffline $gdtf $ids]
 }
@@ -4877,7 +4961,7 @@ proc getblobdiffs {ids} {
     global diffinhdr treediffs
 
     set env(GIT_DIFF_OPTS) $diffopts
-    if {[catch {set bdf [open [diffcmd $ids {-p -C}] r]} err]} {
+    if {[catch {set bdf [open [diffcmd $ids {-p -C --no-commit-id}] r]} err]} {
 	puts "error getting diffs: $err"
 	return
     }
@@ -5468,7 +5552,7 @@ proc mstime {} {
 
 proc rowmenu {x y id} {
     global rowctxmenu commitrow selectedline rowmenuid curview
-    global nullid fakerowmenu mainhead
+    global nullid nullid2 fakerowmenu mainhead
 
     set rowmenuid $id
     if {![info exists selectedline]
@@ -5477,7 +5561,7 @@ proc rowmenu {x y id} {
     } else {
 	set state normal
     }
-    if {$id ne $nullid} {
+    if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
 	$menu entryconfigure 7 -label "Reset $mainhead branch to here"
     } else {
@@ -5596,18 +5680,12 @@ proc mkpatchrev {} {
 }
 
 proc mkpatchgo {} {
-    global patchtop nullid
+    global patchtop nullid nullid2
 
     set oldid [$patchtop.fromsha1 get]
     set newid [$patchtop.tosha1 get]
     set fname [$patchtop.fname get]
-    if {$newid eq $nullid} {
-	set cmd [list git diff-index -p $oldid]
-    } elseif {$oldid eq $nullid} {
-	set cmd [list git diff-index -p -R $newid]
-    } else {
-	set cmd [list git diff-tree -p $oldid $newid]
-    }
+    set cmd [diffcmd [list $oldid $newid] -p]
     lappend cmd >$fname &
     if {[catch {eval exec $cmd} err]} {
 	error_popup "Error creating patch: $err"
@@ -7522,6 +7600,8 @@ if {$i >= [llength $argv] && $revtreeargs ne {}} {
 }
 
 set nullid "0000000000000000000000000000000000000000"
+set nullid2 "0000000000000000000000000000000000000001"
+
 
 set runq {}
 set history {}
@@ -7550,7 +7630,8 @@ set stopped 0
 set stuffsaved 0
 set patchnum 0
 set lookingforhead 0
-set localrow -1
+set localirow -1
+set localfrow -1
 set lserial 0
 setcoords
 makewindow
