From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 16:17:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Mike Nefari <fastestspinner@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHDP-0006kz-5V
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbXAaPRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbXAaPRW
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:17:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:48687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965239AbXAaPRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:17:19 -0500
Received: (qmail invoked by alias); 31 Jan 2007 15:17:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 31 Jan 2007 16:17:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38259>

Hi,

On Wed, 31 Jan 2007, Mike Nefari wrote:

> The gitk gui layout was completely broken on Cygwin.

This was noted before. I tried to argue with Paulus (now Cc'ed, as per 
SubmittingPatches) that he should include it in gitk. Somehow this did not 
have the effect intended be me.

I also verified that with my Tcl/Tk installation on MacOSX, a patch like 
this was needed. IIRC Paulus argued that I should get a native TclTk, 
which is supposed to work (though not with the paths on Cygwin, oh well).

Oh, and it is also needed for MinGW. But I guess it will remain unfixed.

> gitk |  282 ++++++++++++++++++++++++++++++++++++------------------------------
> 1 files changed, 154 insertions(+), 128 deletions(-)

FWIW my patch is less intrusive:

 gitk |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 31d0aad..d3dc8f1 100755
--- a/gitk
+++ b/gitk
@@ -451,7 +451,10 @@ proc makewindow {} {
 	set geometry(ctexth) [expr {($texth - 8) /
 				    [font metrics $textfont -linespace]}]
     }
-    frame .ctop.top
+    if {![info exists geometry(ctoptoph)]} {
+	set geometry(ctoptoph) [expr $geometry(canvh)+34]
+    }
+    frame .ctop.top -height $geometry(ctoptoph)
     frame .ctop.top.bar
     frame .ctop.top.lbar
     pack .ctop.top.lbar -side bottom -fill x
@@ -459,7 +462,7 @@ proc makewindow {} {
     set cscroll .ctop.top.csb
     scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
     pack $cscroll -side right -fill y
-    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 -handlesize 4
+    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 -handlesize 4 -height $geometry(canvh)
     pack .ctop.top.clist -side top -fill both -expand 1
     .ctop add .ctop.top
     set canv .ctop.top.clist.canv
@@ -568,9 +571,17 @@ proc makewindow {} {
     trace add variable highlight_related write vrel_change
     pack .ctop.top.lbar.relm -side left -fill y
 
-    panedwindow .ctop.cdet -orient horizontal
+    if {![info exists geometry(cdeth)]} {
+	set geometry(cdeth) \
+	    [expr $geometry(ctexth)*[font metrics $textfont -linespace]+4]
+    }
+    panedwindow .ctop.cdet -orient horizontal -height $geometry(cdeth)
     .ctop add .ctop.cdet
-    frame .ctop.cdet.left
+    if {![info exists geometry(cdetleftw)]} {
+	set geometry(cdetleftw) \
+	    [expr $geometry(ctextw)*[font measure $textfont "0"]+8] 
+    }
+    frame .ctop.cdet.left -width $geometry(cdetleftw)
     frame .ctop.cdet.left.bot
     pack .ctop.cdet.left.bot -side bottom -fill x
     button .ctop.cdet.left.bot.search -text "Search" -command dosearch \
@@ -814,6 +825,9 @@ proc savestuff {w} {
 	set wid [expr {([winfo width $cflist] - 11) \
 			   / [font measure [$cflist cget -font] "0"]}]
 	puts $f "set geometry(cflistw) $wid"
+	puts $f "set geometry(ctoptoph) [winfo height .ctop.top]"
+	puts $f "set geometry(cdeth) [winfo height .ctop.cdet]"
+	puts $f "set geometry(cdetleftw) [winfo width .ctop.cdet.left]"
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
