From: David Fries <david@fries.net>
Subject: [PATCH] gitk: improve dark background support
Date: Wed, 3 Nov 2010 19:35:24 -0500
Message-ID: <20101104003524.GI7835@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 01:42:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDnuA-000182-LF
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0KDAmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 20:42:07 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:37533 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0KDAmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 20:42:06 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2010 20:42:06 EDT
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oA40ZPLU007725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 3 Nov 2010 19:35:25 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oA40ZO9h007724
	for git@vger.kernel.org; Wed, 3 Nov 2010 19:35:24 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 03 Nov 2010 19:35:25 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160654>

Replace most uses of black with $fgcolor as items such as a black
outline on the tag or tag lines with a black background doesn't show
up.  Use $fgcolor instead to make it contrast with the background.

Use diffcolor 2 for link as blue on a black background might as well
look like dark blue on black and is very difficult to read.  The
"Diff: hunk header" keeps the colors more consistent and both default
to blue.

If the foreground color is dark use light tags, branches, and
remote fill colors.  If it is light use darker versions so the
text is readable.

Signed-off-by: David Fries <David@Fries.net>
---
 gitk-git/gitk |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..ca9244f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6233,6 +6233,7 @@ proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
+    global tagcolor branchcolor remotecolor
 
     set marks {}
     set ntags 0
@@ -6270,7 +6271,7 @@ proc drawtags {id x xt y1} {
 	set xt [expr {$xt + $delta + $wid + $lthickness + $linespc}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-	       -width $lthickness -fill black -tags tag.$id]
+	       -width $lthickness -fill $fgcolor -tags tag.$id]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
 	set xl [expr {$x + $delta}]
@@ -6280,13 +6281,13 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline black -fill yellow -tags tag.$id]
+		       -width 1 -outline $fgcolor -fill $tagcolor -tags tag.$id]
 	    $canv bind $t <1> [list showtag $tag 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		set col $branchcolor
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
@@ -6295,14 +6296,14 @@ proc drawtags {id x xt y1} {
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
+		-width 1 -outline $fgcolor -fill $col -tags tag.$id
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
 		set xri [expr {$x + $rwid}]
 		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
-			-width 0 -fill "#ffddaa" -tags tag.$id
+			-width 0 -fill $remotecolor -tags tag.$id
 	    }
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor \
@@ -6673,7 +6674,7 @@ proc appendwithlinks {text tags} {
 }
 
 proc setlink {id lk} {
-    global curview ctext pendinglinks
+    global curview ctext pendinglinks diffcolors
 
     set known 0
     if {[string length $id] < 40} {
@@ -6687,7 +6688,7 @@ proc setlink {id lk} {
 	set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground blue -underline 1
+	$ctext tag conf $lk -foreground [lindex $diffcolors 2] -underline 1
 	$ctext tag bind $lk <1> [list selbyid $id]
 	$ctext tag bind $lk <Enter> {linkcursor %W 1}
 	$ctext tag bind $lk <Leave> {linkcursor %W -1}
@@ -8215,6 +8216,7 @@ proc linehover {} {
     global hoverx hovery hoverid hovertimer
     global canv linespc lthickness
     global commitinfo
+    global fgcolor
 
     set text [lindex $commitinfo($hoverid) 0]
     set ymax [lindex [$canv cget -scrollregion] 3]
@@ -8227,7 +8229,7 @@ proc linehover {} {
     set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness}]
     set y1 [expr {$y + $linespc + 2 * $lthickness}]
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-	       -fill \#ffff80 -outline black -width 1 -tags hover]
+	       -fill \#ffff80 -outline $fgcolor -width 1 -tags hover]
     $canv raise $t
     set t [$canv create text $x $y -anchor nw -text $text -tags hover \
 	       -font mainfont]
@@ -10877,6 +10879,23 @@ proc setbg {c} {
     }
 }
 
+proc setfill {c} {
+    global tagcolor branchcolor remotecolor
+
+    set fg [winfo rgb . $c]
+    if {[lindex $fg 0] + 1.5 * [lindex $fg 1] + 0.5 * [lindex $fg 2] > 100000} {
+	# dark fill to read a light foreground font
+	set tagcolor yellow4
+	set branchcolor green4
+	set remotecolor "#806F55"
+    } else {
+	# light fill to read a dark foreground font
+        set tagcolor yellow
+        set branchcolor green
+        set remotecolor "#ffddaa"
+    }
+}
+
 proc setfg {c} {
     global fglist canv
 
@@ -10886,6 +10905,8 @@ proc setfg {c} {
     allcanvs itemconf text -fill $c
     $canv itemconf circle -outline $c
     $canv itemconf markid -outline $c
+
+    setfill $c
 }
 
 proc prefscan {} {
@@ -11381,11 +11402,13 @@ if {[tk windowingsystem] eq "win32"} {
     set uicolor SystemButtonFace
     set bgcolor SystemWindow
     set fgcolor SystemButtonText
+    setfill $fgcolor
     set selectbgcolor SystemHighlight
 } else {
     set uicolor grey85
     set bgcolor white
     set fgcolor black
+    setfill $fgcolor
     set selectbgcolor gray85
 }
 set diffcolors {red "#00a000" blue}
@@ -11422,6 +11445,7 @@ namespace import ::msgcat::mc
 ::msgcat::mcload $gitk_msgsdir
 
 catch {source ~/.gitk}
+setfill $fgcolor
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
1.7.1
