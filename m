From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] gitk: Display commit messages with word wrap (try 2)
Date: Mon, 15 May 2006 19:13:14 +0400
Message-ID: <20060515151314.GE19254@master.mivlgu.local>
References: <20060514151456.GA18012@procyon.home> <17511.48749.631725.358279@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfelA-0002bp-3a
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWEOPNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWEOPNR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:13:17 -0400
Received: from mivlgu.ru ([81.18.140.87]:60338 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964969AbWEOPNQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 11:13:16 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id A9663180086; Mon, 15 May 2006 19:13:14 +0400 (MSD)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17511.48749.631725.358279@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20054>

Some people put very long strings into commit messages, which then
become invisible in gitk (word wrapping in the commit details window is
turned off, and there is no horizontal scroll bar).  Enabling word wrap
for just the commit message looks much better.

Wrapping is controlled by the "wrapcomment" option in ~/.gitk.  By
default this option is set to "none", which disables wrapping; setting
it to "word" enables word wrap for commit messages.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

---

 gitk |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

 The text about the "comment" variable IMHO just does not fit in the
 commit message above - if you prefer, I'll just make two separate
 patches, the first which leaves the "comment" name in place (ignoring the
 fact that the variable is no longer holding the comment text), and the
 second which just renames it to "headers".

f23c00577c9a4379c794313f8e54132a159f7f43
diff --git a/gitk b/gitk
index 4aa57c0..8d046af 100755
--- a/gitk
+++ b/gitk
@@ -380,7 +380,7 @@ proc makewindow {} {
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global maincursor textcursor curtextcursor
-    global rowctxmenu mergemax
+    global rowctxmenu mergemax wrapcomment
 
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
@@ -527,6 +527,7 @@ proc makewindow {} {
     pack $ctext -side left -fill both -expand 1
     .ctop.cdet add .ctop.cdet.left
 
+    $ctext tag conf comment -wrap $wrapcomment
     $ctext tag conf filesep -font [concat $textfont bold] -back "#aaaaaa"
     $ctext tag conf hunksep -fore blue
     $ctext tag conf d0 -fore red
@@ -696,7 +697,7 @@ proc savestuff {w} {
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth
     global viewname viewfiles viewargs viewperm nextviewnum
-    global cmitmode
+    global cmitmode wrapcomment
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -709,6 +710,7 @@ proc savestuff {w} {
 	puts $f [list set maxgraphpct $maxgraphpct]
 	puts $f [list set maxwidth $maxwidth]
 	puts $f [list set cmitmode $cmitmode]
+	puts $f [list set wrapcomment $wrapcomment]
 	puts $f "set geometry(width) [winfo width .ctop]"
 	puts $f "set geometry(height) [winfo height .ctop]"
 	puts $f "set geometry(canv1) [expr {[winfo width $canv]-2}]"
@@ -3222,11 +3224,11 @@ proc commit_descriptor {p} {
 
 # append some text to the ctext widget, and make any SHA1 ID
 # that we know about be a clickable link.
-proc appendwithlinks {text} {
+proc appendwithlinks {text tags} {
     global ctext commitrow linknum curview
 
     set start [$ctext index "end - 1c"]
-    $ctext insert end $text
+    $ctext insert end $text $tags
     $ctext insert end "\n"
     set links [regexp -indices -all -inline {[0-9a-f]{40}} $text]
     foreach l $links {
@@ -3354,7 +3356,7 @@ proc selectline {l isnew} {
 	$ctext insert end "\n"
     }
  
-    set comment {}
+    set headers {}
     set olds [lindex $parentlist $l]
     if {[llength $olds] > 1} {
 	set np 0
@@ -3365,23 +3367,22 @@ proc selectline {l isnew} {
 		set tag m$np
 	    }
 	    $ctext insert end "Parent: " $tag
-	    appendwithlinks [commit_descriptor $p]
+	    appendwithlinks [commit_descriptor $p] {}
 	    incr np
 	}
     } else {
 	foreach p $olds {
-	    append comment "Parent: [commit_descriptor $p]\n"
+	    append headers "Parent: [commit_descriptor $p]\n"
 	}
     }
 
     foreach c [lindex $childlist $l] {
-	append comment "Child:  [commit_descriptor $c]\n"
+	append headers "Child:  [commit_descriptor $c]\n"
     }
-    append comment "\n"
-    append comment [lindex $info 5]
 
     # make anything that looks like a SHA1 ID be a clickable link
-    appendwithlinks $comment
+    appendwithlinks $headers {}
+    appendwithlinks [lindex $info 5] {comment}
 
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
@@ -4504,7 +4505,7 @@ proc showtag {tag isnew} {
     } else {
 	set text "Tag: $tag\nId:  $tagids($tag)"
     }
-    appendwithlinks $text
+    appendwithlinks $text {}
     $ctext conf -state disabled
     init_flist {}
 }
@@ -4890,6 +4891,7 @@ set downarrowlen 7
 set mingaplen 30
 set flistmode "flat"
 set cmitmode "patch"
+set wrapcomment "none"
 
 set colors {green red blue magenta darkgrey brown orange}
 
-- 
1.3.2.g10c1
