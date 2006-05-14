From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] gitk: Display commit messages with word wrap
Date: Sun, 14 May 2006 19:14:56 +0400
Message-ID: <20060514151456.GA18012@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 17:15:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfIJM-0004Ic-BI
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWENPPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWENPPI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:15:08 -0400
Received: from master.altlinux.org ([62.118.250.235]:61190 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751448AbWENPPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 11:15:06 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id D13D6E32FE; Sun, 14 May 2006 19:15:03 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id C4282E36689; Sun, 14 May 2006 19:14:56 +0400 (MSD)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19962>

Some people put very long strings into commit messages, which then
become invisible in gitk (word wrapping in the commit details window is
turned off, and there is no horizontal scroll bar).  Enabling word wrap
for just the commit message looks much better.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 gitk |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

be428b9cd6287b214e61c614bd4c4b4fa3d20075
diff --git a/gitk b/gitk
index 4aa57c0..41f25df 100755
--- a/gitk
+++ b/gitk
@@ -527,6 +527,7 @@ proc makewindow {} {
     pack $ctext -side left -fill both -expand 1
     .ctop.cdet add .ctop.cdet.left
 
+    $ctext tag conf comment -wrap word
     $ctext tag conf filesep -font [concat $textfont bold] -back "#aaaaaa"
     $ctext tag conf hunksep -fore blue
     $ctext tag conf d0 -fore red
@@ -3222,12 +3223,12 @@ proc commit_descriptor {p} {
 
 # append some text to the ctext widget, and make any SHA1 ID
 # that we know about be a clickable link.
-proc appendwithlinks {text} {
+proc appendwithlinks {text tags} {
     global ctext commitrow linknum curview
 
     set start [$ctext index "end - 1c"]
-    $ctext insert end $text
-    $ctext insert end "\n"
+    $ctext insert end $text $tags
+    $ctext insert end "\n" {}
     set links [regexp -indices -all -inline {[0-9a-f]{40}} $text]
     foreach l $links {
 	set s [lindex $l 0]
@@ -3354,7 +3355,7 @@ proc selectline {l isnew} {
 	$ctext insert end "\n"
     }
  
-    set comment {}
+    set headers {}
     set olds [lindex $parentlist $l]
     if {[llength $olds] > 1} {
 	set np 0
@@ -3365,23 +3366,22 @@ proc selectline {l isnew} {
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
@@ -4504,7 +4504,7 @@ proc showtag {tag isnew} {
     } else {
 	set text "Tag: $tag\nId:  $tagids($tag)"
     }
-    appendwithlinks $text
+    appendwithlinks $text {}
     $ctext conf -state disabled
     init_flist {}
 }
-- 
1.3.2.g8252
