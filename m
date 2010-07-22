From: David Fries <david@fries.net>
Subject: [PATCH 3/3] gitk: improve dark background, select light or dark
	tags
Date: Thu, 22 Jul 2010 18:14:59 -0500
Message-ID: <20100722231459.GA25179@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 01:15:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4ys-0006BE-T3
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab0GVXPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 19:15:01 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:47496 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0GVXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 19:15:00 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o6MNExxT025261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 18:15:00 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id o6MNExT0025260
	for git@vger.kernel.org; Thu, 22 Jul 2010 18:14:59 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (SpacedOut.fries.net [127.0.0.1]); Thu, 22 Jul 2010 18:15:00 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151496>

If the foreground color is dark use light tags, branches, and
remote fill colors.  If it is light use darker versions so the
text is readable.
---
 gitk-git/gitk |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a851762..ca9244f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6233,6 +6233,7 @@ proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
+    global tagcolor branchcolor remotecolor
 
     set marks {}
     set ntags 0
@@ -6280,13 +6281,13 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline $fgcolor -fill yellow -tags tag.$id]
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
@@ -6302,7 +6303,7 @@ proc drawtags {id x xt y1} {
 		set yti [expr {$yt + 1}]
 		set xri [expr {$x + $rwid}]
 		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
-			-width 0 -fill "#ffddaa" -tags tag.$id
+			-width 0 -fill $remotecolor -tags tag.$id
 	    }
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor \
@@ -10878,6 +10879,23 @@ proc setbg {c} {
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
 
@@ -10887,6 +10905,8 @@ proc setfg {c} {
     allcanvs itemconf text -fill $c
     $canv itemconf circle -outline $c
     $canv itemconf markid -outline $c
+
+    setfill $c
 }
 
 proc prefscan {} {
@@ -11382,11 +11402,13 @@ if {[tk windowingsystem] eq "win32"} {
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
@@ -11423,6 +11445,7 @@ namespace import ::msgcat::mc
 ::msgcat::mcload $gitk_msgsdir
 
 catch {source ~/.gitk}
+setfill $fgcolor
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
1.7.1
