From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 1/2] gitk: write only changed configuration variables
Date: Mon, 10 Nov 2014 00:20:01 +0200
Message-ID: <1415571602-5858-2-git-send-email-max@max630.net>
References: <1415571602-5858-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnarB-0006Fw-GP
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbaKIWVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 17:21:03 -0500
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:36143
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751413AbaKIWVB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 17:21:01 -0500
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id DaLs1p0095B68XE01aM09Z; Sun, 09 Nov 2014 15:21:01 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1415571602-5858-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gitk contains some changed parameter, and there is existing
instance of gitk where the parameter is still old, it is reverted to
that old value when the instance exits.

Instead, store a parameter in config only it is has been modified in the
exiting instance. Otherwise, preserve the value which currently is in
file.  This allows editing the configuration when several instances are
running, and don't get rollback of the modification if some other
instance where the configuration was not edited is closed last.

For scalar variables, use trace(3tcl) to detect their change. Since `trace` can
send bogus events, doublecheck if the value has really been changed, but once
it is marked as changed, do not reset it back to unchanged ever, because if
user has restored the original value, it's the decision which should be stored
as well as modified value.

Treat view list especially: instead of rewriting the whole list, merge
individual views. Place old and updated views at their older placed, add
new ones to the end of list. Collect modified view explicitly, in newviewok{}
and delview{}.

Do not merge geometry values. They are almost always changing because
user moves and resises windows, and there is no way to find which one of
the geometries is most desired. Just overwrite them unconditionally,
like earlier.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index 78358a7..ed4f71e 100755
--- a/gitk
+++ b/gitk
@@ -2776,12 +2776,38 @@ proc doprogupdate {} {
     }
 }
 
+proc config_init_trace {name} {
+    global config_variable_changed config_variable_original
+
+    upvar #0 $name var
+    set config_variable_changed($name) 0
+    set config_variable_original($name) $var
+}
+
+proc config_variable_change_cb {name name2 op} {
+    global config_variable_changed config_variable_original
+
+    upvar #0 $name var
+    if {$op eq "write" &&
+	(![info exists config_variable_original($name)] ||
+	 $config_variable_original($name) ne $var)} {
+	set config_variable_changed($name) 1
+    }
+}
+
 proc savestuff {w} {
-    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
-    global use_ttk
     global stuffsaved
     global config_file config_file_tmp
-    global config_variables
+    global config_variables config_variable_changed
+    global viewchanged
+
+    upvar #0 viewname current_viewname
+    upvar #0 viewfiles current_viewfiles
+    upvar #0 viewargs current_viewargs
+    upvar #0 viewargscmd current_viewargscmd
+    upvar #0 viewperm current_viewperm
+    upvar #0 nextviewnum current_nextviewnum
+    upvar #0 use_ttk current_use_ttk
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2793,16 +2819,24 @@ proc savestuff {w} {
 	if {$::tcl_platform(platform) eq {windows}} {
 	    file attributes $config_file_tmp -hidden true
 	}
+	if {[file exists $config_file]} {
+	    source $config_file
+	}
 	foreach var_name $config_variables {
 	    upvar #0 $var_name var
-	    puts $f [list set $var_name $var]
+	    upvar 0 $var_name old_var
+	    if {!$config_variable_changed($var_name) && [info exists old_var]} {
+		puts $f [list set $var_name $old_var]
+	    } else {
+		puts $f [list set $var_name $var]
+	    }
 	}
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
-	if {$use_ttk} {
+	if {$current_use_ttk} {
 	    puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sashpos 0] 1\""
 	    puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
 	} else {
@@ -2812,11 +2846,34 @@ proc savestuff {w} {
 	puts $f "set geometry(botwidth) [winfo width .bleft]"
 	puts $f "set geometry(botheight) [winfo height .bleft]"
 
+	array set view_save {}
+	array set views {}
+	if {![info exists permviews]} { set permviews {} }
+	foreach view $permviews {
+	    set view_save([lindex $view 0]) 1
+	    set views([lindex $view 0]) $view
+	}
 	puts -nonewline $f "set permviews {"
-	for {set v 0} {$v < $nextviewnum} {incr v} {
-	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
+	for {set v 1} {$v < $current_nextviewnum} {incr v} {
+	    if {$viewchanged($v)} {
+		if {$current_viewperm($v)} {
+		    set views($current_viewname($v)) [list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]
+		} else {
+		    set view_save($current_viewname($v)) 0
+		}
+		lappend views_modified_names $current_viewname($v)
+	    }
+	}
+	# write old and updated view to their places and append remaining to the end
+	foreach view $permviews {
+	    set view_name [lindex $view 0]
+	    if {$view_save($view_name)} {
+		puts $f "{$views($view_name)}"
 	    }
+	    unset views($view_name)
+	}
+	foreach view_name [array names views] {
+	    puts $f "{$views($view_name)}"
 	}
 	puts $f "}"
 	close $f
@@ -4238,7 +4295,7 @@ proc allviewmenus {n op args} {
 
 proc newviewok {top n {apply 0}} {
     global nextviewnum newviewperm newviewname newishighlight
-    global viewname viewfiles viewperm selectedview curview
+    global viewname viewfiles viewperm viewchanged selectedview curview
     global viewargs viewargscmd newviewopts viewhlmenu
 
     if {[catch {
@@ -4259,6 +4316,7 @@ proc newviewok {top n {apply 0}} {
 	incr nextviewnum
 	set viewname($n) $newviewname($n)
 	set viewperm($n) $newviewopts($n,perm)
+	set viewchanged($n) 1
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
 	set viewargscmd($n) $newviewopts($n,cmd)
@@ -4271,6 +4329,7 @@ proc newviewok {top n {apply 0}} {
     } else {
 	# editing an existing view
 	set viewperm($n) $newviewopts($n,perm)
+	set viewchanged($n) 1
 	if {$newviewname($n) ne $viewname($n)} {
 	    set viewname($n) $newviewname($n)
 	    doviewmenu .bar.view 5 [list showview $n] \
@@ -4293,7 +4352,7 @@ proc newviewok {top n {apply 0}} {
 }
 
 proc delview {} {
-    global curview viewperm hlview selectedhlview
+    global curview viewperm hlview selectedhlview viewchanged
 
     if {$curview == 0} return
     if {[info exists hlview] && $hlview == $curview} {
@@ -4302,6 +4361,7 @@ proc delview {} {
     }
     allviewmenus $curview delete
     set viewperm($curview) 0
+    set viewchanged($curview) 1
     showview 0
 }
 
@@ -12122,6 +12182,10 @@ set config_variables {
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
 }
+foreach var $config_variables {
+    config_init_trace $var
+    trace add variable $var write config_variable_change_cb
+}
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
@@ -12249,6 +12313,7 @@ set highlight_related [mc "None"]
 set highlight_files {}
 set viewfiles(0) {}
 set viewperm(0) 0
+set viewchanged(0) 0
 set viewargs(0) {}
 set viewargscmd(0) {}
 
@@ -12307,6 +12372,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewargs(1) $revtreeargs
     set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
+    set viewchanged(1) 0
     set vdatemode(1) 0
     addviewmenu 1
     .bar.view entryconf [mca "Edit view..."] -state normal
@@ -12322,6 +12388,7 @@ if {[info exists permviews]} {
 	set viewargs($n) [lindex $v 2]
 	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
+	set viewchanged($n) 0
 	addviewmenu $n
     }
 }
-- 
2.0.1.1697.g73c6810
