From: David Fries <david@Fries.net>
Subject: [PATCH 3/3] gitk: improve dark background, select light or dark tags
Date: Wed, 10 Nov 2010 23:19:02 -0600
Message-ID: <1289452742-7235-3-git-send-email-david@fries.net>
References: <1289451597-6950-1-git-send-email-david@fries.net>
Cc: David Fries <David@Fries.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 06:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGPZC-0007I0-Cb
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 06:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab0KKFTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 00:19:08 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:34634 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab0KKFTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 00:19:05 -0500
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAB5J36A007283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Nov 2010 23:19:03 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAB5J3Oc007282;
	Wed, 10 Nov 2010 23:19:03 -0600
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289451597-6950-1-git-send-email-david@fries.net>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 10 Nov 2010 23:19:03 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161210>

If the foreground color is dark use light tags, branches, and
remote fill colors.  If it is light use darker versions so the
text is readable.

Signed-off-by: David Fries <David@Fries.net>
---
 gitk-git/gitk |   41 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bef2e53..6342a31 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6233,6 +6233,7 @@ proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
+    global tagcolor branchcolor remotecolor
 
     set marks {}
     set ntags 0
@@ -6280,29 +6281,32 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline $fgcolor -fill yellow -tags tag.$id]
+		       -width 1 -outline $fgcolor -fill $tagcolor -tags \
+		       [list tag.$id tagcolor]]
 	    $canv bind $t <1> [list showtag $tag 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		set col $branchcolor
+		set t [list tag.$id branchcolor]
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
 	    } else {
 		set col "#ddddff"
+		set t tag.$id
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline $fgcolor -fill $col -tags tag.$id
+		-width 1 -outline $fgcolor -fill $col -tags $t
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
 		set xri [expr {$x + $rwid}]
 		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
-			-width 0 -fill "#ffddaa" -tags tag.$id
+			-width 0 -fill $remotecolor -tags [list tag.$id remotecolor]
 	    }
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor \
@@ -10877,6 +10881,30 @@ proc setbg {c} {
     }
 }
 
+proc setfill {c} {
+    global tagcolor branchcolor remotecolor
+    global canv;
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
+    # update tags assocated with non-text elements
+    if {[info exists canv]} {
+        $canv itemconf tagcolor -fill $tagcolor
+        $canv itemconf branchcolor -fill $branchcolor
+        $canv itemconf remotecolor -fill $remotecolor
+    }
+}
+
 proc setfg {c} {
     global fglist canv
 
@@ -10887,6 +10915,10 @@ proc setfg {c} {
     $canv itemconf circle -outline $c
     $canv itemconf markid -outline $c
     $canv itemconf line -fill $c
+    $canv itemconf tagcolor -outline $c
+    $canv itemconf branchcolor -outline $c
+
+    setfill $c
 }
 
 # update hunksep and each link foreground color
@@ -11436,6 +11468,7 @@ namespace import ::msgcat::mc
 ::msgcat::mcload $gitk_msgsdir
 
 catch {source ~/.gitk}
+setfill $fgcolor
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
1.7.2.3
