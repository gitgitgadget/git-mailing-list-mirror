From: Max Kirillov <max@max630.net>
Subject: [PATCH 3/3] gitk: merge views with existing ones
Date: Thu, 11 Sep 2014 08:21:28 +0300
Message-ID: <1410412888-10187-4-git-send-email-max@max630.net>
References: <1410412888-10187-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:22:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRwpm-0002YO-JP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 07:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbaIKFWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 01:22:09 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:51632
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042AbaIKFWH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 01:22:07 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id phMx1o00J5B68XE01hN6be; Wed, 10 Sep 2014 22:22:07 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1410412888-10187-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256834>

Only new and modified views are saved; old ones are saved also
if there are no new, modified or deleted view with same name.

This allows editing view list in concurrent gitk sessions without
losing the changes.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 6e22024..3394415 100755
--- a/gitk
+++ b/gitk
@@ -2807,7 +2807,11 @@ proc doprogupdate {} {
 proc config_variable_change_cb {name name2 op} {
     global config_variable_changed
     if {$op eq "write"} {
-	set config_variable_changed($name) 1
+	if {$name2 eq ""} {
+	    set config_variable_changed($name) 1
+	} else {
+	    set config_variable_changed($name,$name2) 1
+	}
     }
 }
 
@@ -2861,12 +2865,38 @@ proc savestuff {w} {
 	puts $f "set geometry(botwidth) [winfo width .bleft]"
 	puts $f "set geometry(botheight) [winfo height .bleft]"
 
+	array set view_save {}
+	array set views {}
+	foreach view $permviews {
+	    set view_save([lindex $view 0]) 1
+	    set views([lindex $view 0]) $view
+	}
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $current_nextviewnum} {incr v} {
-	    if {$current_viewperm($v)} {
-		puts $f "{[list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]}"
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
@@ -12828,6 +12858,12 @@ if {[info exists permviews]} {
 	addviewmenu $n
     }
 }
+foreach var {viewname viewfiles viewargs viewargscmd viewperm} {
+    for {set v 0} {$v < $nextviewnum} {incr v} {
+	set config_variable_changed($var,$v) 0
+    }
+    trace add variable $var write config_variable_change_cb
+}
 
 if {[tk windowingsystem] eq "win32"} {
     focus -force .
-- 
2.0.1.1697.g73c6810
