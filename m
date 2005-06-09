From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk-1.1 out
Date: Thu, 9 Jun 2005 22:50:08 +1000
Message-ID: <17064.15104.847009.390149@cargo.ozlabs.ibm.com>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 15:09:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgMU9-0002AE-5v
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVFIMyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVFIMyD
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:54:03 -0400
Received: from ozlabs.org ([203.10.76.45]:48822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262210AbVFIMuN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:50:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4C7B467B35; Thu,  9 Jun 2005 22:50:10 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> Can you do the same for things in .git/refs/heads? Possibly using another 
> color?

Try this patch against gitk-1.1 and let me know what you think.  I
draw the heads as a green rectangle with a black border.

I also added a -t option to gitk which makes it use gitk-rev-tree
instead of git-rev-list, so that you can do

	gitk -t $(ls .git/refs/heads)

Paul.
---

diff -urN gitk-1.1/gitk current/gitk
--- gitk-1.1/gitk	2005-06-01 18:14:51.000000000 +1000
+++ current/gitk	2005-06-09 22:41:56.000000000 +1000
@@ -10,13 +10,18 @@
 # CVS $Revision: 1.20 $
 
 proc getcommits {rargs} {
-    global commits commfd phase canv mainfont
+    global commits commfd phase canv mainfont treemode
     if {$rargs == {}} {
 	set rargs HEAD
     }
     set commits {}
     set phase getcommits
-    if [catch {set commfd [open "|git-rev-list $rargs" r]} err] {
+    if {$treemode} {
+	set cmd "git-rev-tree"
+    } else {
+	set cmd "git-rev-list"
+    }
+    if [catch {set commfd [open "|$cmd $rargs" r]} err] {
 	puts stderr "Error executing git-rev-list: $err"
 	exit 1
     }
@@ -28,7 +33,7 @@
 }
 
 proc getcommitline {commfd}  {
-    global commits parents cdate nparents children nchildren
+    global commits parents cdate nparents children nchildren treemode
     set n [gets $commfd line]
     if {$n < 0} {
 	if {![eof $commfd]} return
@@ -39,8 +44,9 @@
 	    return
 	}
 	if {[string range $err 0 4] == "usage"} {
+	    set cmd [expr {$treemode? "tree": "list"}]
 	    set err "\
-Gitk: error reading commits: bad arguments to git-rev-list.\n\
+Gitk: error reading commits: bad arguments to git-rev-$cmd.\n\
 (Note: arguments to gitk are passed to git-rev-list\
 to allow selection of commits to be displayed.)"
 	} else {
@@ -49,11 +55,19 @@
 	error_popup $err
 	exit 1
     }
-    if {![regexp {^[0-9a-f]{40}$} $line]} {
-	error_popup "Can't parse git-rev-tree output: {$line}"
-	exit 1
+    if {$treemode} {
+	if {![regexp {^[0-9]* ([0-9a-f]{40}):} $line match id]} {
+	    error_popup "Can't parse git-rev-tree output: {$line}"
+	    exit 1
+	}
+	lappend commits $id
+    } else {
+	if {![regexp {^[0-9a-f]{40}$} $line]} {
+	    error_popup "Can't parse git-rev-list output: {$line}"
+	    exit 1
+	}
+	lappend commits $line
     }
-    lappend commits $line
 }
 
 proc readallcommits {} {
@@ -130,7 +144,7 @@
 }
 
 proc readrefs {} {
-    global tagids idtags
+    global tagids idtags headids idheads
     set tags [glob -nocomplain -types f .git/refs/tags/*]
     foreach f $tags {
 	catch {
@@ -154,6 +168,20 @@
 		    lappend idtags($obj) $tag
 		}
 	    }
+	    close $fd
+	}
+    }
+    set heads [glob -nocomplain -types f .git/refs/heads/*]
+    foreach f $heads {
+	catch {
+	    set fd [open $f r]
+	    set line [read $fd 40]
+	    if {[regexp {^[0-9a-f]{40}} $line id]} {
+		set head [file tail $f]
+		set headids($head) $line
+		lappend idheads($line) $head
+	    }
+	    close $fd
 	}
     }
 }
@@ -537,6 +565,7 @@
     global lineid linehtag linentag linedtag commitinfo
     global nextcolor colormap numcommits
     global stopped phase redisplaying selectedline idtags idline
+    global idheads
 
     allcanvs delete all
     set start {}
@@ -616,13 +645,22 @@
 	if {$nparents($id) > 2} {
 	    set xt [expr {$xt + ($nparents($id) - 2) * $linespc}]
 	}
-	if {[info exists idtags($id)] && $idtags($id) != {}} {
+	set marks {}
+	set ntags 0
+	if {[info exists idtags($id)]} {
+	    set marks $idtags($id)
+	    set ntags [llength $marks]
+	}
+	if {[info exists idheads($id)]} {
+	    set marks [concat $marks $idheads($id)]
+	}
+	if {$marks != {}} {
 	    set delta [expr {int(0.5 * ($linespc - $lthickness))}]
 	    set yt [expr $canvy - 0.5 * $linespc]
 	    set yb [expr $yt + $linespc - 1]
 	    set xvals {}
 	    set wvals {}
-	    foreach tag $idtags($id) {
+	    foreach tag $marks {
 		set wid [font measure $mainfont $tag]
 		lappend xvals $xt
 		lappend wvals $wid
@@ -631,12 +669,20 @@
 	    set t [$canv create line $x $canvy [lindex $xvals end] $canvy \
 		       -width $lthickness -fill black]
 	    $canv lower $t
-	    foreach tag $idtags($id) x $xvals wid $wvals {
+	    foreach tag $marks x $xvals wid $wvals {
 		set xl [expr $x + $delta]
 		set xr [expr $x + $delta + $wid + $lthickness]
-		$canv create polygon $x [expr $yt + $delta] $xl $yt\
-		    $xr $yt $xr $yb $xl $yb $x [expr $yb - $delta] \
-		    -width 1 -outline black -fill yellow
+		if {[incr ntags -1] >= 0} {
+		    # draw a tag
+		    $canv create polygon $x [expr $yt + $delta] $xl $yt\
+			$xr $yt $xr $yb $xl $yb $x [expr $yb - $delta] \
+			-width 1 -outline black -fill yellow
+		} else {
+		    # draw a head
+		    set xl [expr $xl - $delta/2]
+		    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
+			-width 1 -outline black -fill green
+		}
 		$canv create text $xl $canvy -anchor w -text $tag \
 		    -font $mainfont
 	    }
@@ -1334,7 +1380,8 @@
 set textfont {Courier 9}
 
 set colors {green red blue magenta darkgrey brown orange}
-set colorbycommitter false
+set colorbycommitter 0
+set treemode 0
 
 catch {source ~/.gitk}
 
@@ -1350,6 +1397,7 @@
 	"^-b" { set boldnames 1 }
 	"^-c" { set colorbycommitter 1 }
 	"^-d" { set datemode 1 }
+	"^-t" { set treemode 1 }
 	default {
 	    lappend revtreeargs $arg
 	}
