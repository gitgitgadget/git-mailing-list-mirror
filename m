From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 5/6] gitk: Implement a user-friendly Edit View dialog.
Date: Sun,  2 Nov 2008 21:59:48 +0300
Message-ID: <1225652389-22082-6-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiEF-0005yD-Sv
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbYKBTCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYKBTCB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:02:01 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:15346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYKBTB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:58 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2459943fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m6NFrdYNeeKk0spzd2I6ETVrNH8mK4cCFUwWn4nzor8=;
        b=Glv/pUjM0xQUCUDaUk4aKxiK4R7kHUg+5RttU+L4wOa3qdnrqwD0l0n0avlpAwbySt
         GcBh7Pp+4/Pvza51jslds9PQqv8asyXMMBcq41LpXGLFpuA/T/Wu1+vf1CVRhcq1zOZb
         u6Xd5+1ZHjppU2Ma4eaVr2P6y0AM+U6ktiNW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tR3gMBOCpJOyL7ABieGq0ZYo8Sdxg7d4JVwkfsr9h+DG4q/Hh+bLthVyNcQbiaiaDO
         +aubByEvbVkUVmA2o3K1nTX5Ry2JqdkXxP1P6rMvFq9KVA2r12gsX89YECa4jWpDjdZG
         KSrftgAtafOJlaw6uzwbCrE84eh2hSxGoFHiQ=
Received: by 10.181.61.9 with SMTP id o9mr3925958bkk.86.1225652516141;
        Sun, 02 Nov 2008 11:01:56 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:54 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99866>

Originally gitk required the user to specify all limiting
options manually in the same field with the list of commits.
It is rather unfriendly for new users, who may not know
which options can be used, or, indeed, that it is possible
to specify them at all.

This patch modifies the dialog to present the most useful
options as individual fields. Note that options that may
be useful to an extent, but produce a severely broken view,
are deliberately not included.

It is still possible to specify options in the commit list
field, but when the dialog is reopened, they will be extracted
into their own separate fields.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |  207 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 163 insertions(+), 44 deletions(-)

diff --git a/gitk b/gitk
index 71f1b27..5b4eaa2 100755
--- a/gitk
+++ b/gitk
@@ -3479,8 +3479,8 @@ proc shellsplit {str} {
 # Code to implement multiple views
 
 proc newview {ishighlight} {
-    global nextviewnum newviewname newviewperm newishighlight
-    global newviewargs revtreeargs viewargscmd newviewargscmd curview
+    global nextviewnum newviewname newishighlight
+    global revtreeargs viewargscmd newviewopts curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -3489,9 +3489,9 @@ proc newview {ishighlight} {
 	return
     }
     set newviewname($nextviewnum) "[mc "View"] $nextviewnum"
-    set newviewperm($nextviewnum) 0
-    set newviewargs($nextviewnum) [shellarglist $revtreeargs]
-    set newviewargscmd($nextviewnum) $viewargscmd($curview)
+    set newviewopts($nextviewnum,perm) 0
+    set newviewopts($nextviewnum,cmd)  $viewargscmd($curview)
+    decode_view_opts $nextviewnum $revtreeargs
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
 
@@ -3505,53 +3505,167 @@ proc edit_or_newview {} {
     }
 }
 
+set known_view_options {
+    {perm    b    . {}               {mc "Remember this view"}}
+    {args    t50= + {}               {mc "Commits to include (arguments to git log):"}}
+    {all     b    * "--all"          {mc "Use all refs"}}
+    {dorder  b    . {"--date-order" "-d"}      {mc "Strictly sort by date"}}
+    {lright  b    . "--left-right"   {mc "Mark branch sides"}}
+    {since   t15  + {"--since=*" "--after=*"}  {mc "Since date:"}}
+    {until   t15  . {"--until=*" "--before=*"} {mc "Until date:"}}
+    {limit   t10  + "--max-count=*"  {mc "Max count:"}}
+    {skip    t10  . "--skip=*"       {mc "Skip:"}}
+    {first   b    . "--first-parent" {mc "Limit to first parent"}}
+    {cmd     t50= + {}               {mc "Command to generate more commits to include:"}}
+    }
+
+proc encode_view_opts {n} {
+    global known_view_options newviewopts
+
+    set rargs [list]
+    foreach opt $known_view_options {
+	set patterns [lindex $opt 3]
+	if {$patterns eq {}} continue
+	set pattern [lindex $patterns 0]
+
+	set val $newviewopts($n,[lindex $opt 0])
+	
+	if {[lindex $opt 1] eq "b"} {
+	    if {$val} {
+		lappend rargs $pattern
+	    }
+	} else {
+	    set val [string trim $val]
+	    if {$val ne {}} {
+		set pfix [string range $pattern 0 end-1]
+		lappend rargs $pfix$val
+	    }
+	}
+    }
+    return [concat $rargs [shellsplit $newviewopts($n,args)]]
+}
+
+proc decode_view_opts {n view_args} {
+    global known_view_options newviewopts
+
+    foreach opt $known_view_options {
+	if {[lindex $opt 1] eq "b"} {
+	    set val 0
+	} else {
+	    set val {}
+	}
+	set newviewopts($n,[lindex $opt 0]) $val
+    }
+    set oargs [list]
+    foreach arg $view_args {
+	if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
+	    && ![info exists found(limit)]} {
+	    set newviewopts($n,limit) $cnt
+	    set found(limit) 1
+	    continue
+	}
+	catch { unset val }
+	foreach opt $known_view_options {
+	    set id [lindex $opt 0]
+	    if {[info exists found($id)]} continue
+	    foreach pattern [lindex $opt 3] {
+		if {![string match $pattern $arg]} continue
+		if {[lindex $opt 1] ne "b"} {
+		    set size [string length $pattern]
+		    set val [string range $arg [expr {$size-1}] end]
+		} else {
+		    set val 1
+		}
+		set newviewopts($n,$id) $val
+		set found($id) 1
+		break
+	    }
+	    if {[info exists val]} break
+	}
+	if {[info exists val]} continue
+	lappend oargs $arg
+    }
+    set newviewopts($n,args) [shellarglist $oargs]
+}
+
 proc editview {} {
     global curview
-    global viewname viewperm newviewname newviewperm
-    global viewargs newviewargs viewargscmd newviewargscmd
+    global viewname viewperm newviewname newviewopts
+    global viewargs viewargscmd
 
     set top .gitkvedit-$curview
     if {[winfo exists $top]} {
 	raise $top
 	return
     }
-    set newviewname($curview) $viewname($curview)
-    set newviewperm($curview) $viewperm($curview)
-    set newviewargs($curview) [shellarglist $viewargs($curview)]
-    set newviewargscmd($curview) $viewargscmd($curview)
+    set newviewname($curview)      $viewname($curview)
+    set newviewopts($curview,perm) $viewperm($curview)
+    set newviewopts($curview,cmd)  $viewargscmd($curview)
+    decode_view_opts $curview $viewargs($curview)
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
 proc vieweditor {top n title} {
-    global newviewname newviewperm viewfiles bgcolor
+    global newviewname newviewopts viewfiles bgcolor
+    global known_view_options
 
     toplevel $top
     wm title $top $title
     wm transient $top .
+
+    # View name
+    frame $top.nfr
     label $top.nl -text [mc "Name"]
     entry $top.name -width 20 -textvariable newviewname($n)
-    grid $top.nl $top.name -sticky w -pady 5
-    checkbutton $top.perm -text [mc "Remember this view"] \
-	-variable newviewperm($n)
-    grid $top.perm - -pady 5 -sticky w
-    message $top.al -aspect 1000 \
-	-text [mc "Commits to include (arguments to git log):"]
-    grid $top.al - -sticky w -pady 5
-    entry $top.args -width 50 -textvariable newviewargs($n) \
-	-background $bgcolor
-    grid $top.args - -sticky ew -padx 5
-
-    message $top.ac -aspect 1000 \
-	-text [mc "Command to generate more commits to include:"]
-    grid $top.ac - -sticky w -pady 5
-    entry $top.argscmd -width 50 -textvariable newviewargscmd($n) \
-	-background white
-    grid $top.argscmd - -sticky ew -padx 5
-
-    message $top.l -aspect 1000 \
+    pack $top.nfr -in $top -fill x -pady 5 -padx 3
+    pack $top.nl -in $top.nfr -side left -padx {0 30}
+    pack $top.name -in $top.nfr -side left
+
+    # View options
+    set cframe $top.nfr
+    set cexpand 0
+    set cnt 0
+    foreach opt $known_view_options {
+	set id [lindex $opt 0]
+	set type [lindex $opt 1]
+	set flags [lindex $opt 2]
+	set title [eval [lindex $opt 4]]
+	set lxpad 0
+
+	if {$flags eq "+" || $flags eq "*"} {
+	    set cframe $top.fr$cnt
+	    incr cnt
+	    frame $cframe
+	    pack $cframe -in $top -fill x -pady 3 -padx 3
+	    set cexpand [expr {$flags eq "*"}]
+	} else {
+	    set lxpad 5
+	}
+
+	if {$type eq "b"} {
+	    checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$id)
+	    pack $cframe.c_$id -in $cframe -side left \
+		-padx [list $lxpad 0] -expand $cexpand -anchor w
+	} elseif {[regexp {^t(\d+)$} $type type sz]} {
+	    message $cframe.l_$id -aspect 1500 -text $title
+	    entry $cframe.e_$id -width $sz -background $bgcolor \
+		-textvariable newviewopts($n,$id)
+	    pack $cframe.l_$id -in $cframe -side left -padx [list $lxpad 0]
+	    pack $cframe.e_$id -in $cframe -side left -expand 1 -fill x
+	} elseif {[regexp {^t(\d+)=$} $type type sz]} {
+	    message $cframe.l_$id -aspect 1500 -text $title
+	    entry $cframe.e_$id -width $sz -background $bgcolor \
+		-textvariable newviewopts($n,$id)
+	    pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor w
+	    pack $cframe.e_$id -in $cframe -side top -fill x
+	}
+    }
+
+    # Path list
+    message $top.l -aspect 1500 \
 	-text [mc "Enter files and directories to include, one per line:"]
-    grid $top.l - -sticky w
-    text $top.t -width 40 -height 10 -background $bgcolor -font uifont
+    pack $top.l -in $top -side top -pady [list 7 0] -anchor w -padx 3
+    text $top.t -width 40 -height 5 -background $bgcolor -font uifont
     if {[info exists viewfiles($n)]} {
 	foreach f $viewfiles($n) {
 	    $top.t insert end $f
@@ -3560,15 +3674,19 @@ proc vieweditor {top n title} {
 	$top.t delete {end - 1c} end
 	$top.t mark set insert 0.0
     }
-    grid $top.t - -sticky ew -padx 5
+    pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand 1 -padx 3
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command [list newviewok $top $n]
+    button $top.buts.apply -text [mc "Apply (F5)"] -command [list newviewok $top $n 1]
     button $top.buts.can -text [mc "Cancel"] -command [list destroy $top]
+    bind $top <Control-Return> [list newviewok $top $n]
+    bind $top <F5> [list newviewok $top $n 1]
     bind $top <Escape> [list destroy $top]
-    grid $top.buts.ok $top.buts.can
+    grid $top.buts.ok $top.buts.apply $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
-    grid $top.buts - -pady 10 -sticky ew
+    grid columnconfigure $top.buts 2 -weight 1 -uniform a
+    pack $top.buts -in $top -side top -fill x
     focus $top.t
 }
 
@@ -3589,13 +3707,13 @@ proc allviewmenus {n op args} {
     # doviewmenu $viewhlmenu 1 [list addvhighlight $n] $op $args
 }
 
-proc newviewok {top n} {
+proc newviewok {top n {apply 0}} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
+    global viewargs viewargscmd newviewopts viewhlmenu
 
     if {[catch {
-	set newargs [shellsplit $newviewargs($n)]
+	set newargs [encode_view_opts $n]
     } err]} {
 	error_popup "[mc "Error in commit selection arguments:"] $err" $top
 	return
@@ -3611,10 +3729,10 @@ proc newviewok {top n} {
 	# creating a new view
 	incr nextviewnum
 	set viewname($n) $newviewname($n)
-	set viewperm($n) $newviewperm($n)
+	set viewperm($n) $newviewopts($n,perm)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
-	set viewargscmd($n) $newviewargscmd($n)
+	set viewargscmd($n) $newviewopts($n,cmd)
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -3623,7 +3741,7 @@ proc newviewok {top n} {
 	}
     } else {
 	# editing an existing view
-	set viewperm($n) $newviewperm($n)
+	set viewperm($n) $newviewopts($n,perm)
 	if {$newviewname($n) ne $viewname($n)} {
 	    set viewname($n) $newviewname($n)
 	    doviewmenu .bar.view 5 [list showview $n] \
@@ -3632,15 +3750,16 @@ proc newviewok {top n} {
 		# entryconf [list -label $viewname($n) -value $viewname($n)]
 	}
 	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n) || \
-		$newviewargscmd($n) ne $viewargscmd($n)} {
+		$newviewopts($n,cmd) ne $viewargscmd($n)} {
 	    set viewfiles($n) $files
 	    set viewargs($n) $newargs
-	    set viewargscmd($n) $newviewargscmd($n)
+	    set viewargscmd($n) $newviewopts($n,cmd)
 	    if {$curview == $n} {
 		run reloadcommits
 	    }
 	}
     }
+    if {$apply} return
     catch {destroy $top}
 }
 
-- 
1.6.0.3.15.gb8d36
