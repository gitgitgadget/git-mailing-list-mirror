From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] gitk: add Update menu item.
Date: Wed, 23 Nov 2005 23:20:03 +0100
Message-ID: <20051123222003.GA16290MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 23:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef2yO-0008Ai-JN
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 23:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVKWWUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 17:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVKWWUL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 17:20:11 -0500
Received: from psmtp03.wxs.nl ([195.121.247.12]:18135 "EHLO psmtp03.wxs.nl")
	by vger.kernel.org with ESMTP id S932581AbVKWWUI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 17:20:08 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IQF004WFI1F6F@psmtp03.wxs.nl> for git@vger.kernel.org; Wed,
 23 Nov 2005 23:20:04 +0100 (MET)
Received: (qmail 16347 invoked by uid 500); Wed, 23 Nov 2005 22:20:03 +0000
To: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>
Mail-followup-to: Paul Mackerras <paulus@samba.org>,
 Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12655>

Update will redraw the commits if any commits have been added to any
of the selected heads.  The new commits appear on the top.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
Updated patch against recent gitk in case someone is interested.
Previous version has been working for without any glitches.

skimo

 gitk |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 142 insertions(+), 34 deletions(-)

applies-to: c183291c9f13912f9111ee0ab2e24ac47f3147ed
6a2a3df712ce55ecbae91367b285ce295f38a558
diff --git a/gitk b/gitk
index 3dd97e2..352a319 100755
--- a/gitk
+++ b/gitk
@@ -16,8 +16,24 @@ proc gitdir {} {
     }
 }
 
+proc parse_args {rargs} {
+    global parsed_args
+
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
 
@@ -27,21 +43,13 @@ proc getcommits {rargs} {
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
@@ -59,9 +67,10 @@ proc getcommits {rargs} {
 }
 
 proc getcommitlines {commfd}  {
-    global commits parents cdate children
+    global oldcommits commits parents cdate children nchildren
     global commitlisted phase nextupdate
     global stopped redisplaying leftover
+    global canv
 
     set stuff [read $commfd]
     if {$stuff == {}} {
@@ -119,10 +128,18 @@ to allow selection of commits to be disp
 	set id [lindex $ids 0]
 	set olds [lrange $ids 1 end]
 	set cmit [string range $cmit [expr {$j + 1}] end]
+	if {$phase == "updatecommits"} {
+	    $canv delete all
+	    set oldcommits $commits
+	    set commits {}
+	    unset children
+	    unset nchildren
+	    set phase getcommits
+	}
 	lappend commits $id
 	set commitlisted($id) 1
 	parsecommit $id $cmit 1 [lrange $ids 1 end]
-	drawcommit $id
+	drawcommit $id 1
 	if {[clock clicks -milliseconds] >= $nextupdate} {
 	    doupdate 1
 	}
@@ -132,7 +149,7 @@ to allow selection of commits to be disp
 		set stopped 0
 		set phase "getcommits"
 		foreach id $commits {
-		    drawcommit $id
+		    drawcommit $id 1
 		    if {$stopped} break
 		    if {[clock clicks -milliseconds] >= $nextupdate} {
 			doupdate 1
@@ -168,16 +185,9 @@ proc readcommit {id} {
     parsecommit $id $contents 0 {}
 }
 
-proc parsecommit {id contents listed olds} {
-    global commitinfo children nchildren parents nparents cdate ncleft
+proc updatechildren {id olds} {
+    global children nchildren parents nparents ncleft
 
-    set inhdr 1
-    set comment {}
-    set headline {}
-    set auname {}
-    set audate {}
-    set comname {}
-    set comdate {}
     if {![info exists nchildren($id)]} {
 	set children($id) {}
 	set nchildren($id) 0
@@ -196,6 +206,19 @@ proc parsecommit {id contents listed old
 	    incr ncleft($p)
 	}
     }
+}
+
+proc parsecommit {id contents listed olds} {
+    global commitinfo cdate
+
+    set inhdr 1
+    set comment {}
+    set headline {}
+    set auname {}
+    set audate {}
+    set comname {}
+    set comdate {}
+    updatechildren $id $olds
     set hdrend [string first "\n\n" $contents]
     if {$hdrend < 0} {
 	# should never happen...
@@ -243,6 +266,9 @@ proc readrefs {} {
     global tagids idtags headids idheads tagcontents
     global otherrefids idotherrefs
 
+    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
+	catch {unset $v}
+    }
     set refd [open [list | git-ls-remote [gitdir]] r]
     while {0 <= [set n [gets $refd line]]} {
 	if {![regexp {^([0-9a-f]{40})	refs/([^^]*)$} $line \
@@ -292,7 +318,7 @@ proc error_popup msg {
     tkwait window $w
 }
 
-proc makewindow {} {
+proc makewindow {rargs} {
     global canv canv2 canv3 linespc charspc ctext cflist textfont
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
@@ -302,6 +328,7 @@ proc makewindow {} {
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
     menu .bar.file
+    .bar.file add command -label "Update" -command [list updatecommits $rargs]
     .bar.file add command -label "Reread references" -command rereadrefs
     .bar.file add command -label "Quit" -command doquit
     menu .bar.help
@@ -1416,8 +1443,9 @@ proc decidenext {{noread 0}} {
     return $level
 }
 
-proc drawcommit {id} {
+proc drawcommit {id reading} {
     global phase todo nchildren datemode nextupdate revlistorder
+    global numcommits ncmupdate displayorder todo onscreen
     global numcommits ncmupdate displayorder todo onscreen parents
 
     if {$phase != "incrdraw"} {
@@ -1455,20 +1483,29 @@ proc drawcommit {id} {
 	    }
 	}
     }
-    drawmore 1
+    drawmore $reading
 }
 
 proc finishcommits {} {
-    global phase
+    global phase oldcommits commits
     global canv mainfont ctext maincursor textcursor
+    global parents
 
-    if {$phase != "incrdraw"} {
+    if {$phase == "incrdraw" || $phase == "removecommits"} {
+	foreach id $oldcommits {
+	    lappend commits $id
+	    updatechildren $id $parents($id)
+	    drawcommit $id 0
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
@@ -3596,9 +3633,6 @@ proc rereadrefs {} {
 	    set ref($id) [listrefs $id]
 	}
     }
-    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
-	catch {unset $v}
-    }
     readrefs
     set refids [lsort -unique [concat $refids [array names idtags] \
 			[array names idheads] [array names idotherrefs]]]
@@ -3610,6 +3644,80 @@ proc rereadrefs {} {
     }
 }
 
+proc updatecommits {rargs} {
+    global commitlisted commfd phase
+    global startmsecs nextupdate ncmupdate
+    global idtags idheads idotherrefs
+    global leftover
+    global parsed_args
+    global canv
+    global oldcommits commits
+    global parents nchildren children ncleft
+
+    set old_args $parsed_args
+    parse_args $rargs
+
+    foreach id $old_args {
+	if {![regexp {^[0-9a-f]{40}$} $id]} continue
+	if {[info exists oldref($id)]} continue
+	set oldref($id) $id
+	lappend ignoreold "^$id"
+    }
+    foreach id $parsed_args {
+	if {![regexp {^[0-9a-f]{40}$} $id]} continue
+	if {[info exists ref($id)]} continue
+	set ref($id) $id
+	lappend ignorenew "^$id"
+    }
+
+    foreach a $old_args {
+	if {![info exists ref($a)]} {
+	    lappend ignorenew $a
+	}
+    }
+
+    set phase updatecommits
+    set removed_commits [split [eval exec git-rev-list $ignorenew] "\n" ]
+    if {[llength $removed_commits] > 0} {
+	$canv delete all
+	set oldcommits {}
+	foreach c $commits {
+	    if {[lsearch $c $removed_commits] < 0} {
+		lappend oldcommits $c
+	    } else {
+		unset commitlisted($c)
+	    }
+	}
+	set commits {}
+	unset children
+	unset nchildren
+	set phase removecommits
+    }
+
+    set args {}
+    foreach a $parsed_args {
+	if {![info exists oldref($a)]} {
+	    lappend args $a
+	}
+    }
+
+    readrefs
+    if [catch {
+	set commfd [open "|git-rev-list --header --topo-order --parents $args $ignoreold" r]
+    } err] {
+	puts stderr "Error executing git-rev-list: $err"
+	exit 1
+    }
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
 
@@ -3697,6 +3805,6 @@ set redisplaying 0
 set stuffsaved 0
 set patchnum 0
 setcoords
-makewindow
+makewindow $revtreeargs
 readrefs
 getcommits $revtreeargs
---
0.99.9.GIT
