From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Make "gitk" work better with dense revlists
Date: Thu, 27 Oct 2005 17:04:47 +0200
Message-ID: <20051027150447.GZ8383MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0510251253110.10477@g5.osdl.org>
 <17248.28857.90315.543669@cargo.ozlabs.ibm.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 17:11:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV9Jo-0002q8-NH
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVJ0PEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 11:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVJ0PEv
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 11:04:51 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:20405 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S1750875AbVJ0PEu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 11:04:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IP0006BVXVZBK@psmtp04.wxs.nl> for git@vger.kernel.org; Thu,
 27 Oct 2005 17:04:49 +0200 (MEST)
Received: (qmail 26829 invoked by uid 500); Thu, 27 Oct 2005 15:04:47 +0000
In-reply-to: <17248.28857.90315.543669@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Mail-followup-to: Paul Mackerras <paulus@samba.org>,
 Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
 Git Mailing List <git@vger.kernel.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10715>

On Thu, Oct 27, 2005 at 04:16:25PM +1000, Paul Mackerras wrote:
> git-rev-list is better.  It does mean that I now want to be able to
> get gitk to contract the view to just a given set of files or
> directories and then expand back to the whole tree view, which means
> running git-rev-list multiple times, which gitk can't do at the
> moment...

My "gitk Update" patch could be useful here.
Instead of being careful about what is new and what is old,
you can just throw everything out.

skimo
------------------

gitk: add Update menu item.

Update will redraw the commits if any commits have been added to any
of the selected heads.  The new commits appear on the top.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit d867cc8df4b7756dbc738358540e845ac5cd8a86
tree f762e01ce91365d95cfed147f3b605d492aeb7f4
parent f3123c4ab3d3698262e59561ac084de45b10365a
author Sven Verdoolaege <skimo@kotnet.org> Thu, 22 Sep 2005 15:27:19 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Wed, 26 Oct 2005 23:05:23 +0200

 gitk |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 141 insertions(+), 34 deletions(-)

diff --git a/gitk b/gitk
index f1ea4e1..8c37b60 100755
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
     global commitlisted phase commitinfo nextupdate
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
     foreach line [split $contents "\n"] {
 	if {$inhdr} {
 	    if {$line == {}} {
@@ -240,6 +263,9 @@ proc parsecommit {id contents listed old
 proc readrefs {} {
     global tagids idtags headids idheads tagcontents
 
+    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
+	catch {unset $v}
+    }
     set tags [glob -nocomplain -types f [gitdir]/refs/tags/*]
     foreach f $tags {
 	catch {
@@ -324,7 +350,7 @@ proc error_popup msg {
     tkwait window $w
 }
 
-proc makewindow {} {
+proc makewindow {rargs} {
     global canv canv2 canv3 linespc charspc ctext cflist textfont
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
@@ -334,6 +360,7 @@ proc makewindow {} {
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
     menu .bar.file
+    .bar.file add command -label "Update" -command [list updatecommits $rargs]
     .bar.file add command -label "Reread references" -command rereadrefs
     .bar.file add command -label "Quit" -command doquit
     menu .bar.help
@@ -1445,7 +1472,7 @@ proc decidenext {{noread 0}} {
     return $level
 }
 
-proc drawcommit {id} {
+proc drawcommit {id reading} {
     global phase todo nchildren datemode nextupdate
     global numcommits ncmupdate displayorder todo onscreen
 
@@ -1474,20 +1501,29 @@ proc drawcommit {id} {
 	    break
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
@@ -3611,9 +3647,6 @@ proc rereadrefs {} {
 	    set ref($id) [listrefs $id]
 	}
     }
-    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
-	catch {unset $v}
-    }
     readrefs
     set refids [lsort -unique [concat $refids [array names idtags] \
 			[array names idheads] [array names idotherrefs]]]
@@ -3625,6 +3658,80 @@ proc rereadrefs {} {
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
 
@@ -3692,6 +3799,6 @@ set redisplaying 0
 set stuffsaved 0
 set patchnum 0
 setcoords
-makewindow
+makewindow $revtreeargs
 readrefs
 getcommits $revtreeargs
