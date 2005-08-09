From: Linus Torvalds <torvalds@osdl.org>
Subject: "Child" information in commit window - and cleanups
Date: Mon, 8 Aug 2005 20:04:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081957150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 05:05:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KQB-00084o-4X
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 05:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVHIDEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 23:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVHIDEr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 23:04:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbVHIDEq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 23:04:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7934LjA006445
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 20:04:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7934KMD014350;
	Mon, 8 Aug 2005 20:04:20 -0700
To: Paul Mackerras <paulus@samba.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This adds "Child: " lines to the commit window, which tells what children 
a commit has. 

It also cleans things up: it marks the text widget as no-wrap, which means
that it doesn't need to truncate the commit description arbitrarily by
hand. Also, the description itself is now done by a common helper routine
that handles both the parent and the children.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ NOTE! The list of children is "calculated" information, since git itself
  doesn't actually keep any child pointers, and that means that it only
  lists any children that gitk has seen. There may be other children of a
  commit in other branches in the same repository, and gitk will not show
  such children that it doesn't know about.

  But this is useful for walking up and down the links - you get the same 
  information as if you had clicked on a link ]

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -387,7 +387,7 @@ proc makewindow {} {
     set ctext .ctop.cdet.left.ctext
     text $ctext -bg white -state disabled -font $textfont \
 	-width $geometry(ctextw) -height $geometry(ctexth) \
-	-yscrollcommand ".ctop.cdet.left.sb set"
+	-yscrollcommand ".ctop.cdet.left.sb set" -wrap none
     scrollbar .ctop.cdet.left.sb -command "$ctext yview"
     pack .ctop.cdet.left.sb -side right -fill y
     pack $ctext -side left -fill both -expand 1
@@ -1704,10 +1704,19 @@ proc selcanvline {w x y} {
     selectline $l 1
 }
 
+proc commit_descriptor {p} {
+    global commitinfo
+    set l "..."
+    if {[info exists commitinfo($p)]} {
+	set l [lindex $commitinfo($p) 0]
+    }
+    return "$p ($l)"
+}
+
 proc selectline {l isnew} {
     global canv canv2 canv3 ctext commitinfo selectedline
     global lineid linehtag linentag linedtag
-    global canvy0 linespc parents nparents
+    global canvy0 linespc parents nparents children nchildren
     global cflist currentid sha1entry
     global commentend idtags idline
 
@@ -1790,15 +1799,15 @@ proc selectline {l isnew} {
  
     set commentstart [$ctext index "end - 1c"]
     set comment {}
-    foreach p $parents($id) {
-	set l "..."
-	if {[info exists commitinfo($p)]} {
-	    set l [lindex $commitinfo($p) 0]
-	    if {[string length $l] > 32} {
-		set l "[string range $l 0 28] ..."
-	    }
+    if {[info exists parents($id)]} {
+	foreach p $parents($id) {
+	    append comment "Parent: [commit_descriptor $p]\n"
+	}
+    }
+    if {[info exists children($id)]} {
+	foreach c $children($id) {
+	    append comment "Child:  [commit_descriptor $c]\n"
 	}
-	append comment "Parent: $p  ($l)\n"
     }
     append comment "\n"
     append comment [lindex $info 5]
