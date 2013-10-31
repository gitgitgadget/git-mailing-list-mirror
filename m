From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Thu, 31 Oct 2013 20:05:26 +1100
Message-ID: <20131031090526.GA9164@iris.ozlabs.ibm.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
 <5270F4FC.60900@viscovery.net>
 <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 10:05:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VboCH-0005We-E0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3JaJFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:05:41 -0400
Received: from ozlabs.org ([203.10.76.45]:33097 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab3JaJFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:05:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 419F82C04AC; Thu, 31 Oct 2013 20:05:39 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237083>

On Wed, Oct 30, 2013 at 01:47:08PM +0100, Nicolas Cornu wrote:
> This is useful on all our repos, every times, as we put a tag per day.
> If the HEAD didn't move during 150 days, we got 150 tags.

Here is a patch that I did some time ago but have never pushed out.
Do you think it is an improvement when using gitk on a repo with lots
of tags?

Paul.

[PATCH] gitk: Tag display improvements

When a commit has many tags, the tag icons in the graph display can
easily become so wide as to push the commit message off the right-hand
edge of the graph display pane.  This changes the display so that if
there are more than 3 tags or they would take up more than a quarter
of the width of the pane, we instead display a single tag icon with
a legend inside it like "4 tags...".  If the user clicks on the tag
icon, gitk then displays all the tags in the diff display pane.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 gitk | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/gitk b/gitk
index 5cd00d8..0bdb146 100755
--- a/gitk
+++ b/gitk
@@ -2385,6 +2385,7 @@ proc makewindow {} {
     $ctext tag conf found -back $foundbgcolor
     $ctext tag conf currentsearchhit -back $currentsearchhitbgcolor
     $ctext tag conf wwrap -wrap word
+    $ctext tag conf bold -font textfontbold
 
     .pwbottom add .bleft
     if {!$use_ttk} {
@@ -6387,6 +6388,25 @@ proc bindline {t id} {
     $canv bind $t <Button-1> "lineclick %x %y $id 1"
 }
 
+proc graph_pane_width {} {
+    global use_ttk
+
+    if {$use_ttk} {
+	set g [.tf.histframe.pwclist sashpos 0]
+    } else {
+	set g [.tf.histframe.pwclist sash coord 0]
+    }
+    return [lindex $g 0]
+}
+
+proc totalwidth {l font extra} {
+    set tot 0
+    foreach str $l {
+	set tot [expr {$tot + [font measure $font $str] + $extra}]
+    }
+    return $tot
+}
+
 proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
@@ -6398,9 +6418,27 @@ proc drawtags {id x xt y1} {
     set marks {}
     set ntags 0
     set nheads 0
+    set singletag 0
+    set maxtags 3
+    set maxtagpct 25
+    set maxwidth [expr {[graph_pane_width] * $maxtagpct / 100}]
+    set delta [expr {int(0.5 * ($linespc - $lthickness))}]
+    set extra [expr {$delta + $lthickness + $linespc}]
+
     if {[info exists idtags($id)]} {
 	set marks $idtags($id)
 	set ntags [llength $marks]
+	if {$ntags > $maxtags ||
+	    [totalwidth $marks mainfont $extra] > $maxwidth} {
+	    # show just a single "n tags..." tag
+	    set singletag 1
+	    if {$ntags == 1} {
+		set marks [list "tag..."]
+	    } else {
+		set marks [list [format "%d tags..." $ntags]]
+	    }
+	    set ntags 1
+	}
     }
     if {[info exists idheads($id)]} {
 	set marks [concat $marks $idheads($id)]
@@ -6413,7 +6451,6 @@ proc drawtags {id x xt y1} {
 	return $xt
     }
 
-    set delta [expr {int(0.5 * ($linespc - $lthickness))}]
     set yt [expr {$y1 - 0.5 * $linespc}]
     set yb [expr {$yt + $linespc - 1}]
     set xvals {}
@@ -6428,7 +6465,7 @@ proc drawtags {id x xt y1} {
 	}
 	lappend xvals $xt
 	lappend wvals $wid
-	set xt [expr {$xt + $delta + $wid + $lthickness + $linespc}]
+	set xt [expr {$xt + $wid + $extra}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
 	       -width $lthickness -fill $reflinecolor -tags tag.$id]
@@ -6444,7 +6481,12 @@ proc drawtags {id x xt y1} {
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
 		       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
 		       -tags tag.$id]
-	    $canv bind $t <1> [list showtag $tag_quoted 1]
+	    if {$singletag} {
+		set tagclick [list showtags $id 1]
+	    } else {
+		set tagclick [list showtag $tag_quoted 1]
+	    }
+	    $canv bind $t <1> $tagclick
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
@@ -6471,7 +6513,7 @@ proc drawtags {id x xt y1} {
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >= 0} {
-	    $canv bind $t <1> [list showtag $tag_quoted 1]
+	    $canv bind $t <1> $tagclick
 	} elseif {$nheads >= 0} {
 	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
 	}
@@ -10878,6 +10920,23 @@ proc listrefs {id} {
     return [list $x $y $z]
 }
 
+proc add_tag_ctext {tag} {
+    global ctext cached_tagcontent tagids
+
+    if {![info exists cached_tagcontent($tag)]} {
+	catch {
+	    set cached_tagcontent($tag) [exec git cat-file -p $tag]
+	}
+    }
+    $ctext insert end "[mc "Tag"]: $tag\n" bold
+    if {[info exists cached_tagcontent($tag)]} {
+	set text $cached_tagcontent($tag)
+    } else {
+	set text "[mc "Id"]:  $tagids($tag)"
+    }
+    appendwithlinks $text {}
+}
+
 proc showtag {tag isnew} {
     global ctext cached_tagcontent tagids linknum tagobjid
 
@@ -10888,17 +10947,28 @@ proc showtag {tag isnew} {
     clear_ctext
     settabs 0
     set linknum 0
-    if {![info exists cached_tagcontent($tag)]} {
-	catch {
-           set cached_tagcontent($tag) [exec git cat-file -p $tag]
-	}
+    add_tag_ctext $tag
+    maybe_scroll_ctext 1
+    $ctext conf -state disabled
+    init_flist {}
+}
+
+proc showtags {id isnew} {
+    global idtags ctext linknum
+
+    if {$isnew} {
+	addtohistory [list showtags $id 0] savectextpos
     }
-    if {[info exists cached_tagcontent($tag)]} {
-	set text $cached_tagcontent($tag)
-    } else {
-	set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)"
+    $ctext conf -state normal
+    clear_ctext
+    settabs 0
+    set linknum 0
+    set sep {}
+    foreach tag $idtags($id) {
+	$ctext insert end $sep
+	add_tag_ctext $tag
+	set sep "\n\n"
     }
-    appendwithlinks $text {}
     maybe_scroll_ctext 1
     $ctext conf -state disabled
     init_flist {}
-- 
1.8.4.rc3
