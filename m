From: Max Kirillov <max@max630.net>
Subject: [PATCH 2/3] gitk: write only changed configuration variables
Date: Thu, 11 Sep 2014 08:21:27 +0300
Message-ID: <1410412888-10187-3-git-send-email-max@max630.net>
References: <1410412888-10187-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:22:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRwpm-0002YO-28
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 07:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbaIKFWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 01:22:07 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:51632
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021AbaIKFWG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 01:22:06 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id phMx1o00J5B68XE01hN4bU; Wed, 10 Sep 2014 22:22:06 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1410412888-10187-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256833>

If a variable is changed in a concurrent gitk or manually it is
preserved unless it has changed in this instance

This change does not affect geometry and views save; geometry does not
need it, and views need special merging, which treats each view
separately rather that fully replace the shole list.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/gitk b/gitk
index 6069afe..6e22024 100755
--- a/gitk
+++ b/gitk
@@ -2804,12 +2804,25 @@ proc doprogupdate {} {
     }
 }
 
+proc config_variable_change_cb {name name2 op} {
+    global config_variable_changed
+    if {$op eq "write"} {
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
@@ -2821,16 +2834,24 @@ proc savestuff {w} {
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
@@ -2841,9 +2862,9 @@ proc savestuff {w} {
 	puts $f "set geometry(botheight) [winfo height .bleft]"
 
 	puts -nonewline $f "set permviews {"
-	for {set v 0} {$v < $nextviewnum} {incr v} {
-	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
+	for {set v 0} {$v < $current_nextviewnum} {incr v} {
+	    if {$current_viewperm($v)} {
+		puts $f "{[list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -12600,6 +12621,10 @@ set config_variables {
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
 }
+foreach var $config_variables {
+    set config_variable_changed($var) 0
+    trace add variable $var write config_variable_change_cb
+}
 
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
-- 
2.0.1.1697.g73c6810
