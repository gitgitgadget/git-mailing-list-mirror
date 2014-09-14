From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 2/3] gitk: write only changed configuration variables
Date: Sun, 14 Sep 2014 23:35:58 +0300
Message-ID: <1410726959-20353-3-git-send-email-max@max630.net>
References: <1410726959-20353-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 22:37:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTGXh-0000bs-G4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 22:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbaINUgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 16:36:55 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:41331
	"EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816AbaINUgo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2014 16:36:44 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-04.prod.phx3.secureserver.net with 
	id r8cb1o0065B68XE018cjsi; Sun, 14 Sep 2014 13:36:44 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1410726959-20353-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257030>

When gitk contains some changed parameter, and there is existing
instance of gitk where the parameter is still old, it is reverted to
that old value when the instance exits.

Instead, store a parameter in config only it is has been modified in the
exiting instance. Otherwise, preserve the value which currently is in
file.  This allows editing the configuration when several instances are
running, and don't get rollback of the modification if some other
instance where the configuration was not edited is closed last.

Since trace(3tcl) can send bogus events, doublecheck if the value has
really been changed, but once it is marked as changed, do not reset it
back to unchanged ever, because if user has restored the original value,
it's the decision which should be stored as well as modified value.

Treat view list especially: instead of rewriting the whole list, merge
individual views. Place old and updated views at their older placed, add
new ones to the end of list.

Do not merge geometry values. They are almost always changing because
user moves and resises windows, and there is no way to find which one of
the geometries is most desired. Just overwrite them unconditionally,
like earlier.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/gitk b/gitk
index bc57c11..e76445b 100755
--- a/gitk
+++ b/gitk
@@ -2771,12 +2771,51 @@ proc doprogupdate {} {
     }
 }
 
+proc config_resolve_variable {name name2} {
+    set var_name ""
+    set key ""
+    if {$name2 eq ""} {
+	set key $name
+	set var_name $name
+    } else {
+	set key "$name,$name2"
+	set var_name "${name}($name2)"
+    }
+    upvar #0 $var_name var
+    return [list $key $var]
+}
+
+proc config_init_trace {name name2} {
+    global config_variable_changed config_variable_original
+
+    set var_info [config_resolve_variable $name $name2]
+    set config_variable_changed([lindex $var_info 0]) 0
+    set config_variable_original([lindex $var_info 0]) [lindex $var_info 1]
+}
+
+proc config_variable_change_cb {name name2 op} {
+    global config_variable_changed config_variable_original
+
+    set var_info [config_resolve_variable $name $name2]
+    if {$op eq "write" &&
+	([llength [array names config_variable_original -exact [lindex $var_info 0]]] == 0 ||
+	 $config_variable_original([lindex $var_info 0]) ne [lindex $var_info 1])} {
+	set config_variable_changed([lindex $var_info 0]) 1
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
@@ -2788,16 +2827,24 @@ proc savestuff {w} {
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
@@ -2807,12 +2854,39 @@ proc savestuff {w} {
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
+	    if {$config_variable_changed(viewname,$v) ||
+		$config_variable_changed(viewfiles,$v) ||
+		$config_variable_changed(viewargs,$v) ||
+		$config_variable_changed(viewargscmd,$v) ||
+		$config_variable_changed(viewperm,$v)} {
+		if {$current_viewperm($v)} {
+		    set views($current_viewname($v)) [list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]
+		} else {
+		    set view_save($current_viewname($v)) 0
+		}
+		lappend views_modified_names $current_viewname($v)
 	    }
 	}
+	# write old and updated view to their places and append remaining to the end
+	foreach view $permviews {
+	    set view_name [lindex $view 0]
+	    if {$view_save($view_name)} {
+		puts $f "{$views($view_name)}"
+	    }
+	    unset views($view_name)
+	}
+	foreach view_name [array names views] {
+	    puts $f "{$views($view_name)}"
+	}
 	puts $f "}"
 	close $f
 	file rename -force $config_file_tmp $config_file
@@ -12108,6 +12182,10 @@ set config_variables {
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
 }
+foreach var $config_variables {
+    config_init_trace $var ""
+    trace add variable $var write config_variable_change_cb
+}
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
@@ -12311,6 +12389,12 @@ if {[info exists permviews]} {
 	addviewmenu $n
     }
 }
+foreach var {viewname viewfiles viewargs viewargscmd viewperm} {
+    for {set v 1} {$v < $nextviewnum} {incr v} {
+	config_init_trace $var $v
+    }
+    trace add variable $var write config_variable_change_cb
+}
 
 if {[tk windowingsystem] eq "win32"} {
     focus -force .
-- 
2.0.1.1697.g73c6810
