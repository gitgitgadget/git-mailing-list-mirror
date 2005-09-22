From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Thu, 22 Sep 2005 15:30:49 +0200
Message-ID: <20050922133049.GV15165MdfPADPa@greensroom.kotnet.org>
References: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
 <17201.61667.465005.53654@cargo.ozlabs.ibm.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 15:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIRAC-0008WJ-IB
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 15:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVIVNaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 09:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVIVNaz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 09:30:55 -0400
Received: from smtp19.wxs.nl ([195.121.6.15]:17596 "EHLO smtp19.wxs.nl")
	by vger.kernel.org with ESMTP id S1030337AbVIVNay (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 09:30:54 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN800BR107D5B@smtp19.wxs.nl> for git@vger.kernel.org; Thu,
 22 Sep 2005 15:30:50 +0200 (CEST)
Received: (qmail 8970 invoked by uid 500); Thu, 22 Sep 2005 13:30:49 +0000
In-reply-to: <17201.61667.465005.53654@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Mail-followup-to: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9117>

On Thu, Sep 22, 2005 at 09:46:43AM +1000, Paul Mackerras wrote:
> Also, I'm not convinced that doing ^$id for all tags, heads and other
> refs is correct.  Although we have read the reference and know the ID,
> that doesn't mean we have seen that commit and displayed it.

You're right.  I typically use "--all", but obviously you don't have to.

> The more general problem is to provide a way for the user to change
> the set of commits displayed using a dialog box.  That would require
> gitk to understand its command-line arguments so that the elements of
> the dialog box could be initialized properly, though.

I'll leave that to you.

The patch below should address your other concerns.

Btw, are you still maintaining dirdiff ?
I really like it, but apparently I'm the only one on this list.

skimo
--
gitk: add Update menu item.

Update will redraw the commits if any commits have been added to any
of the selected heads.  The new commits appear on the top.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit c9b43cd506daf3884cf3ea8ef4fb75f4d010ddc7
tree c838aa39f51a05c1de8da7a0fd648a78b425b38b
parent acfadcfb48e34fdc441e9cffbb385fce9693b363
author Sven Verdoolaege <skimo@kotnet.org> Thu, 22 Sep 2005 15:27:19 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Thu, 22 Sep 2005 15:27:19 +0200

 gitk |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 141 insertions(+), 34 deletions(-)

diff --git a/gitk b/gitk
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
@@ -1437,7 +1464,7 @@ proc decidenext {{noread 0}} {
     return $level
 }
 
-proc drawcommit {id} {
+proc drawcommit {id reading} {
     global phase todo nchildren datemode nextupdate
     global numcommits ncmupdate displayorder todo onscreen
 
@@ -1466,20 +1493,29 @@ proc drawcommit {id} {
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
@@ -3603,9 +3639,6 @@ proc rereadrefs {} {
 	    set ref($id) [listrefs $id]
 	}
     }
-    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
-	catch {unset $v}
-    }
     readrefs
     set refids [lsort -unique [concat $refids [array names idtags] \
 			[array names idheads] [array names idotherrefs]]]
@@ -3617,6 +3650,80 @@ proc rereadrefs {} {
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
 
@@ -3684,6 +3791,6 @@ set redisplaying 0
 set stuffsaved 0
 set patchnum 0
 setcoords
-makewindow
+makewindow $revtreeargs
 readrefs
 getcommits $revtreeargs
