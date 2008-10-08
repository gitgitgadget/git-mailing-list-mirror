From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 6/7] gitk: Implement a user-friendly Edit View dialog.
Date: Wed,  8 Oct 2008 11:05:39 +0400
Message-ID: <1223449540-20457-7-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTAT-0006GO-T1
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYJHHHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYJHHHf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbYJHHH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2606173fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S+yjjP2YfKM3/N9HJjJLIc8PWzbpj4rGzRH0NCPMCjY=;
        b=OA5IRAWvyuIECLJ8q7x81da/i41oWPMLjYPP4CcidpCg9lD9LG3qF598c7Bi7sgXyO
         g+m9HHHnEMKjBRGCDh3b7fZ/sBaqYqvIf+V9Q6G/rARYUDs60thxW8WKL3pL7H8MGEdV
         lzBbP5N/7RJC8ceqifpAizbRx5e6eQuoFjHVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tVlS5G3kLtkZX+xaPjUS+4KwvG5VIMKDCHl7mI+STd8uqB0OE5axiCj0orasHZuImN
         NkS2w2AJrW5sK2fw+psA2tbxb+Sxo+AZQGytV0BlOA3MpynN9OwZgsNNICJJ/dvVbFCh
         K8C3jHvbp98MaO4UN1IGwtRG8ilgdBLS+Tz18=
Received: by 10.180.253.13 with SMTP id a13mr5838186bki.42.1223449646678;
        Wed, 08 Oct 2008 00:07:26 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97778>

Originally gitk required the user to specify all limiting
options manually in the same field with the list of commits.
It is extremely unfriendly for new users, who may not know
which options can be used, or, indeed, that it is possible
to specify them at all.

This patch modifies the dialog to present the most useful
options as individual fields. Note that options that may
be useful to an extent, but produce broken view, are
deliberately not included.

It is still possible to specify options in the commit list
field, but when the dialog is reopened, they will be extracted
into their own separate fields.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |  207 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 163 insertions(+), 44 deletions(-)

diff --git a/gitk b/gitk
index e84e109..c7dd487 100755
--- a/gitk
+++ b/gitk
@@ -3289,8 +3289,8 @@ proc shellsplit {str} {
 # Code to implement multiple views
 
 proc newview {ishighlight} {
-    global nextviewnum newviewname newviewperm newishighlight
-    global newviewargs revtreeargs viewargscmd newviewargscmd curview
+    global nextviewnum newviewname newishighlight
+    global revtreeargs viewargscmd newviewopts curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -3299,9 +3299,9 @@ proc newview {ishighlight} {
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
 
@@ -3315,53 +3315,167 @@ proc edit_or_newview {} {
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
@@ -3370,15 +3484,19 @@ proc vieweditor {top n title} {
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
 
@@ -3399,13 +3517,13 @@ proc allviewmenus {n op args} {
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
@@ -3421,10 +3539,10 @@ proc newviewok {top n} {
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
@@ -3433,7 +3551,7 @@ proc newviewok {top n} {
 	}
     } else {
 	# editing an existing view
-	set viewperm($n) $newviewperm($n)
+	set viewperm($n) $newviewopts($n,perm)
 	if {$newviewname($n) ne $viewname($n)} {
 	    set viewname($n) $newviewname($n)
 	    doviewmenu .bar.view 5 [list showview $n] \
@@ -3442,15 +3560,16 @@ proc newviewok {top n} {
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
1.6.0.20.g6148bc
