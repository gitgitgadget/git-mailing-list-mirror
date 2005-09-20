From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] gitk: add Update menu item.
Date: Tue, 20 Sep 2005 14:24:23 +0200
Message-ID: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 14:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHhAs-0007PB-VI
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 14:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVITMYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 08:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVITMYe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 08:24:34 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:29645 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S964994AbVITMYd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 08:24:33 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN400CSX7SNID@smtp16.wxs.nl> for git@vger.kernel.org; Tue,
 20 Sep 2005 14:24:23 +0200 (CEST)
Received: (qmail 4246 invoked by uid 500); Tue, 20 Sep 2005 12:24:23 +0000
To: Paul Mackerras <paulus@samba.org>
Mail-followup-to: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8992>

Update will redraw the commits if any commits have been added to any
of the selected heads.  The new commits appear on the top.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---

 gitk |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 73 insertions(+), 18 deletions(-)

7f319aaadb801da3bccd7b78d372f03e09575b47
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -16,8 +16,22 @@ proc gitdir {} {
     }
 }
 
+proc parse_args {rargs} {
+    if [catch {
+	set parse_args [concat --default HEAD $rargs]
+	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
+    }] {
+	# if git-rev-parse failed for some reason...
+	if {$rargs == {}} {
+	    set rargs HEAD
+	}
+	set parsed_args $rargs
+    }
+    return $parsed_args
+}
+
 proc getcommits {rargs} {
-    global commits commfd phase canv mainfont env
+    global oldcommits commits commfd phase canv mainfont env
     global startmsecs nextupdate ncmupdate
     global ctext maincursor textcursor leftover
 
@@ -27,21 +41,13 @@ proc getcommits {rargs} {
 	error_popup "Cannot find the git directory \"$gitdir\"."
 	exit 1
     }
+    set oldcommits {}
     set commits {}
     set phase getcommits
     set startmsecs [clock clicks -milliseconds]
     set nextupdate [expr $startmsecs + 100]
     set ncmupdate 1
-    if [catch {
-	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
-    }] {
-	# if git-rev-parse failed for some reason...
-	if {$rargs == {}} {
-	    set rargs HEAD
-	}
-	set parsed_args $rargs
-    }
+    set parsed_args [parse_args $rargs]
     if [catch {
 	set commfd [open "|git-rev-list --header --topo-order --parents $parsed_args" r]
     } err] {
@@ -59,7 +65,7 @@ proc getcommits {rargs} {
 }
 
 proc getcommitlines {commfd}  {
-    global commits parents cdate children
+    global oldcommits commits parents cdate children
     global commitlisted phase commitinfo nextupdate
     global stopped redisplaying leftover
 
@@ -119,6 +125,11 @@ to allow selection of commits to be disp
 	set id [lindex $ids 0]
 	set olds [lrange $ids 1 end]
 	set cmit [string range $cmit [expr {$j + 1}] end]
+	if {$phase == "updatecommits"} {
+	    set oldcommits $commits
+	    set commits {}
+	    set phase getcommits
+	}
 	lappend commits $id
 	set commitlisted($id) 1
 	parsecommit $id $cmit 1 [lrange $ids 1 end]
@@ -324,7 +335,7 @@ proc error_popup msg {
     tkwait window $w
 }
 
-proc makewindow {} {
+proc makewindow {rargs} {
     global canv canv2 canv3 linespc charspc ctext cflist textfont
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
@@ -334,6 +345,7 @@ proc makewindow {} {
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
     menu .bar.file
+    .bar.file add command -label "Update" -command "updatecommits [list $rargs]"
     .bar.file add command -label "Reread references" -command rereadrefs
     .bar.file add command -label "Quit" -command doquit
     menu .bar.help
@@ -1470,16 +1482,22 @@ proc drawcommit {id} {
 }
 
 proc finishcommits {} {
-    global phase
+    global phase oldcommits
     global canv mainfont ctext maincursor textcursor
 
-    if {$phase != "incrdraw"} {
+    if {$phase == "incrdraw"} {
+	foreach id $oldcommits {
+	    drawcommit $id
+	}
+	set oldcommits {}
+	drawrest
+    } elseif {$phase == "updatecommits"} {
+	set phase {}
+    } else {
 	$canv delete all
 	$canv create text 3 3 -anchor nw -text "No commits selected" \
 	    -font $mainfont -tags textitems
 	set phase {}
-    } else {
-	drawrest
     }
     . config -cursor $maincursor
     settextcursor $textcursor
@@ -3617,6 +3635,43 @@ proc rereadrefs {} {
     }
 }
 
+proc updatecommits {rargs} {
+    global phase
+    global startmsecs nextupdate ncmupdate
+    global idtags idheads idotherrefs
+    global leftover
+
+    set refids [concat [array names idtags] \
+		    [array names idheads] [array names idotherrefs]]
+    foreach id $refids {
+	if {[info exists ref($id)]} continue
+	set ref($id) $id
+	lappend ignore "^$id"
+    }
+    set parsed_args {}
+    foreach a [parse_args $rargs] {
+	if {![info exists ref($a)]} {
+	    lappend parsed_args $a
+	}
+    }
+    rereadrefs
+    if [catch {
+	set commfd [open "|git-rev-list --header --topo-order --parents $parsed_args $ignore" r]
+    } err] {
+	puts stderr "Error executing git-rev-list: $err"
+	exit 1
+    }
+    set phase updatecommits
+    set startmsecs [clock clicks -milliseconds]
+    set nextupdate [expr $startmsecs + 100]
+    set ncmupdate 1
+    set leftover {}
+    fconfigure $commfd -blocking 0 -translation lf
+    fileevent $commfd readable [list getcommitlines $commfd]
+    . config -cursor watch
+    settextcursor watch
+}
+
 proc showtag {tag isnew} {
     global ctext cflist tagcontents tagids linknum
 
@@ -3684,6 +3739,6 @@ set redisplaying 0
 set stuffsaved 0
 set patchnum 0
 setcoords
-makewindow
+makewindow $revtreeargs
 readrefs
 getcommits $revtreeargs
