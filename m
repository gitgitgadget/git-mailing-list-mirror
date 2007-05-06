From: Junio C Hamano <junkio@cox.net>
Subject: Re: FFmpeg considering GIT
Date: Sun, 06 May 2007 00:49:56 -0700
Message-ID: <7vabwifl23.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070502T111026-882@post.gmane.org>
	<20070503180016.GB21333@informatik.uni-freiburg.de>
	<20070503200013.GG4489@pasky.or.cz>
	<loom.20070504T143538-533@post.gmane.org>
	<87y7k4lahq.wl%cworth@cworth.org>
	<20070505133543.GC3379@diana.vm.bytemark.co.uk>
	<alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Hasselstr?m <kha@treskal.com>,
	Paul Mackerras <paulus@samba.org>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 06 09:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkbVJ-0002hR-U8
	for gcvg-git@gmane.org; Sun, 06 May 2007 09:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbXEFHt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbXEFHt7
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 03:49:59 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43776 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbXEFHt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 03:49:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506074958.LWWH26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 03:49:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vjpw1W00P1kojtg0000000; Sun, 06 May 2007 03:49:57 -0400
In-Reply-To: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 5 May 2007 15:30:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46312>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> and have the commits colored appropriately. That would be cool, but it 
>> might need more tcl/tk knowledge than I actually possess).
>
> Ok, that turned out to be the case.
>
> Here's an updated patch to gitk, which at least *parses* the 
> "--left-right" data properly, it just doesn't use it.

This on top of yours makes it use it.

 gitk |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 0bf00ee..a6e762d 100755
--- a/gitk
+++ b/gitk
@@ -74,7 +74,7 @@ proc getcommits {} {
 proc getcommitlines {fd view}  {
     global commitlisted nextupdate
     global leftover commfd
-    global displayorder commitidx commitrow commitdata
+    global displayorder commitidx commitrow commitdata commitside
     global parentlist childlist children curview hlview
     global vparentlist vchildlist vdisporder vcmitlisted
 
@@ -178,6 +178,7 @@ proc getcommitlines {fd view}  {
 	}
 	set commitdata($id) [string range $cmit [expr {$j + 1}] end]
 	set commitrow($view,$id) $commitidx($view)
+	set commitside($id) $leftright
 	incr commitidx($view)
 	if {$view == $curview} {
 	    lappend parentlist $olds
@@ -2986,7 +2987,7 @@ proc drawlines {id} {
 
 proc drawcmittext {id row col rmx} {
     global linespc canv canv2 canv3 canvy0 fgcolor
-    global commitlisted commitinfo rowidlist
+    global commitlisted commitinfo commitside rowidlist
     global rowtextx idpos idtags idheads idotherrefs
     global linehtag linentag linedtag
     global mainfont canvxmax boldrows boldnamerows fgcolor
@@ -2995,9 +2996,29 @@ proc drawcmittext {id row col rmx} {
     set x [xc $row $col]
     set y [yc $row]
     set orad [expr {$linespc / 3}]
-    set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
-	       [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-	       -fill $ofill -outline $fgcolor -width 1 -tags circle]
+
+    if {[info exists commitside($id)]} {
+	set leftright $commitside($id)
+    } else {
+	set leftright 0
+    }
+    if {$leftright == 0} {
+	set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
+		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+    } elseif {$leftright < 0} {
+	set t [$canv create polygon \
+		   [expr {$x - $orad}] $y \
+		   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
+		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+    } else {
+	set t [$canv create polygon \
+		   [expr {$x + $orad - 1}] $y \
+		   [expr {$x - $orad}] [expr {$y - $orad}] \
+		   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
+		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+    }
     $canv raise $t
     $canv bind $t <1> {selcanvline {} %x %y}
     set xt [xc $row [llength [lindex $rowidlist $row]]]
