From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Wed, 18 Apr 2007 11:44:18 +1000
Message-ID: <17957.30706.398078.689096@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	<17951.6252.457936.428919@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0704130812390.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdzEI-00024L-GQ
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbXDRBpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbXDRBpB
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:45:01 -0400
Received: from ozlabs.org ([203.10.76.45]:58180 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161428AbXDRBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:45:00 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E8F20DDE2F; Wed, 18 Apr 2007 11:44:58 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0704130812390.28042@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44853>

Linus Torvalds writes:

> Ok, just a radio button for the patch case for "show patch" vs "show 
> result" would certainly be sufficient for what I normally do. Adding the 
> case "show origin" for completeness (ie filter out the new lines, rather 
> than filtering out the old lines) is probably a good idea, even if I've 
> never used it.

Try this patch, let me know what you think...

Paul.

diff --git a/gitk b/gitk
index b1c65d7..a57e84c 100755
--- a/gitk
+++ b/gitk
@@ -593,6 +593,7 @@ proc makewindow {} {
         frame .bleft -width $geometry(botwidth) -height $geometry(botheight)
     }
     frame .bleft.top
+    frame .bleft.mid
 
     button .bleft.top.search -text "Search" -command dosearch \
 	-font $uifont
@@ -602,12 +603,20 @@ proc makewindow {} {
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
+    radiobutton .bleft.mid.diff -text "Diff" \
+	-command changediffdisp -variable diffelide -value {0 0}
+    radiobutton .bleft.mid.old -text "Old version" \
+	-command changediffdisp -variable diffelide -value {0 1}
+    radiobutton .bleft.mid.new -text "New version" \
+	-command changediffdisp -variable diffelide -value {1 0}
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font $textfont \
 	-yscrollcommand scrolltext -wrap none
     scrollbar .bleft.sb -command "$ctext yview"
     pack .bleft.top -side top -fill x
+    pack .bleft.mid -side top -fill x
     pack .bleft.sb -side right -fill y
     pack $ctext -side left -fill both -expand 1
     lappend bglist $ctext
@@ -4486,6 +4495,13 @@ proc getblobdiffline {bdf ids} {
     }
 }
 
+proc changediffdisp {} {
+    global ctext diffelide
+
+    $ctext tag conf d0 -elide [lindex $diffelide 0]
+    $ctext tag conf d1 -elide [lindex $diffelide 1]
+}
+
 proc prevfile {} {
     global difffilestart ctext
     set prev [lindex $difffilestart 0]
@@ -6330,6 +6346,7 @@ set highlight_paths {}
 set searchdirn -forwards
 set boldrows {}
 set boldnamerows {}
+set diffelide {0 0}
 
 set optim_delay 16
 
