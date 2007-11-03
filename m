From: Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH] Make gitk use --early-output
Date: Sun, 4 Nov 2007 10:49:01 +1100
Message-ID: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 00:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoSkJ-0001Of-Ea
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 00:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbXKCXt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 19:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbXKCXt2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 19:49:28 -0400
Received: from ozlabs.org ([203.10.76.45]:52218 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbXKCXt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 19:49:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1A0FDDDE3D; Sun,  4 Nov 2007 10:49:25 +1100 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63324>

This makes gitk use the --early-output flag on the git log command.

When gitk sees the "Final output:" line from git log, it goes into a
mode where it basically just checks that it is getting the commits
again in the same order as before.  If they are, well and good; if
not, it truncates its internal list at the point of difference and
proceeds to read in the commits in the new order from there on, and
re-does the graph layout if necessary.

This gives a much more immediate feel to the startup; gitk shows its
window with the first screenful of commits displayed very quickly this
way.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/gitk b/gitk
index 1da0b0a..7d9a2f2 100755
--- a/gitk
+++ b/gitk
@@ -84,25 +84,27 @@ proc start_rev_list {view} {
     global commfd leftover tclencoding datemode
     global viewargs viewfiles commitidx viewcomplete vnextroot
     global showlocalchanges commitinterest mainheadid
-    global progressdirn progresscoords proglastnc curview
+    global progressdirn progresscoords proglastnc curview rereading
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
     set viewcomplete($view) 0
     set vnextroot($view) 0
-    set order "--topo-order"
+    set order "--early-output=50"
     if {$datemode} {
-	set order "--date-order"
+	lappend order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw $order --parents \
-			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw \
+			  $order --parents --boundary \
+			  $viewargs($view) "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
 	exit 1
     }
     set commfd($view) $fd
     set leftover($view) {}
+    set rereading($view) -1
     if {$showlocalchanges} {
 	lappend commitinterest($mainheadid) {dodiffindex}
     }
@@ -161,6 +163,7 @@ proc getcommitlines {fd view}  {
     global parentlist children curview hlview
     global vparentlist vdisporder vcmitlisted
     global ordertok vnextroot idpending
+    global rereading nullid nullid2
 
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
@@ -236,6 +239,15 @@ proc getcommitlines {fd view}  {
 	}
 	set start [expr {$i + 1}]
 	set j [string first "\n" $cmit]
+	if {$j >= 0 && [string match "Final output:*" $cmit]} {
+	    set rereading($view) 0
+	    set cmit [string range $cmit [expr {$j + 1}] end]
+	    set j [string first "\n" $cmit]
+	    if {$view == $curview} {
+		layoutmore
+		update
+	    }
+	}
 	set ok 0
 	set listed 1
 	if {$j >= 0 && [string match "commit *" $cmit]} {
@@ -255,6 +267,7 @@ proc getcommitlines {fd view}  {
 		    break
 		}
 	    }
+	    set cmit [string range $cmit [expr {$j + 1}] end]
 	}
 	if {!$ok} {
 	    set shortcmit $cmit
@@ -265,13 +278,31 @@ proc getcommitlines {fd view}  {
 	    exit 1
 	}
 	set id [lindex $ids 0]
+	if {$rereading($view) >= 0} {
+	    set r $rereading($view)
+	    set oldid [lindex $displayorder $r]
+	    while {$oldid eq $nullid || $oldid eq $nullid2} {
+		set oldid [lindex $displayorder [incr r]]
+	    }
+	    if {$oldid eq $id} {
+		# commits are still in the same order; just skip to the next
+		set rereading($view) [expr {$r + 1}]
+		continue
+	    }
+	    if {$r < $commitidx($view)} {
+		# commits are in a different order now;
+		# truncate the list and redisplay
+		truncate_view $view $r
+	    }
+	    set rereading($view) -1
+	}
 	if {![info exists ordertok($view,$id)]} {
 	    set otok "o[strrep $vnextroot($view)]"
 	    incr vnextroot($view)
 	    set ordertok($view,$id) $otok
 	} else {
 	    set otok $ordertok($view,$id)
-	    unset idpending($view,$id)
+	    catch {unset idpending($view,$id)}
 	}
 	if {$listed} {
 	    set olds [lrange $ids 1 end]
@@ -301,7 +332,7 @@ proc getcommitlines {fd view}  {
 	if {![info exists children($view,$id)]} {
 	    set children($view,$id) {}
 	}
-	set commitdata($id) [string range $cmit [expr {$j + 1}] end]
+	set commitdata($id) $cmit
 	set commitrow($view,$id) $commitidx($view)
 	incr commitidx($view)
 	if {$view == $curview} {
@@ -323,7 +354,7 @@ proc getcommitlines {fd view}  {
     }
     if {$gotsome} {
 	run chewcommits $view
-	if {$view == $curview} {
+	if {0 && $view == $curview} {
 	    # update progress bar
 	    global progressdirn progresscoords proglastnc
 	    set inc [expr {($commitidx($view) - $proglastnc) * 0.0002}]
@@ -354,6 +385,43 @@ proc getcommitlines {fd view}  {
     return 2
 }
 
+proc truncate_view {view row} {
+    global curview commitidx displayorder parentlist commitlisted
+    global vdisporder vparentlist vcmitlisted commitrow children
+    global numcommits localfrow localirow
+
+    set rm1 [expr {$row - 1}]
+    if {$view == $curview} {
+	set disporder $displayorder
+	set displayorder [lrange $disporder 0 $rm1]
+	set parents $parentlist
+	set parentlist [lrange $parents 0 $rm1]
+	set commitlisted [lrange $commitlisted 0 $rm1]
+    } else {
+	set disporder $vdisporder($view)
+	set vdisporder($view) [lrange $disporder 0 $rm1]
+	set parents $vparentlist($view)
+	set vparentlist($view) [lrange $parents 0 $rm1]
+	set vcmitlisted($view) [lrange $vcmitlisted($view) 0 $rm1]
+    }
+    for {set r $commitidx($view)} {[incr r -1] >= $row} {} {
+	set id [lindex $disporder $r]
+	foreach p [lindex $parents $r] {
+	    if {[lindex $children($view,$p) end] eq $id} {
+		set children($view,$p) [lrange $children($view,$p) 0 end-1]
+	    }
+	}
+	unset commitrow($view,$id)
+    }
+    set commitidx($view) $row
+    if {$view == $curview} {
+	truncate_localchanges $row
+	if {$row < $numcommits} {
+	    undolayout $row
+	}
+    }
+}
+
 proc chewcommits {view} {
     global curview hlview viewcomplete
     global selectedline pending_select
@@ -2843,6 +2911,20 @@ proc dohidelocalchanges {} {
     incr lserial
 }
 
+proc truncate_localchanges {row} {
+    global localfrow localirow
+
+    if {$localfrow >= $row} {
+	set localfrow -1
+    }
+    if {$localirow >= $row} {
+	set localirow -1
+    }
+    if {$localfrow == $row - 1 || $localirow == $row - 1} {
+	dohidelocalchanges
+    }
+}
+
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
     global localirow localfrow lserial showlocalchanges
@@ -3840,6 +3922,23 @@ proc drawcommits {row {endrow {}}} {
     }
 }
 
+proc undolayout {row} {
+    global uparrowlen mingaplen downarrowlen
+    global rowidlist rowisopt rowfinal need_redisplay
+
+    set r [expr {$row - ($uparrowlen + $mingaplen + $downarrowlen)}]
+    if {$r < 0} {
+	set r 0
+    }
+    if {[llength $rowidlist] > $r} {
+	set rowidlist [lrange $rowidlist 0 $r]
+	set rowfinal [lrange $rowfinal 0 $r]
+	set rowisopt [lrange $rowisopt 0 $r]
+	set need_redisplay 1
+	run drawvisible
+    }
+}
+
 proc drawfrac {f0 f1} {
     global canv linespc
 
