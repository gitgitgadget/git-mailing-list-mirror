From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH v3] gitk: Synchronize highlighting in file view when scrolling diff
Date: Wed, 19 Sep 2012 20:17:27 +0200
Message-ID: <1348078647-22516-1-git-send-email-stefan@haller-berlin.de>
References: <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOqW-0001vB-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab2ISSRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:17:51 -0400
Received: from server90.greatnet.de ([83.133.96.186]:59400 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2ISSRu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:17:50 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 1FEE33B0E88;
	Wed, 19 Sep 2012 20:17:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.517.g6dec59e
In-Reply-To: <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205968>

Whenever the diff pane scrolls, highlight the corresponding file in the
file list on the right. For a large commit with many files and long
per-file diffs, this makes it easier to keep track of what you're looking
at.

This allows simplifying the prevfile and nextfile functions, because
all they have to do is scroll the diff pane.

In some situations we want to suppress this mechanism, for example when
clicking on a file in the file list to select it, or when searching in the
diff, in which case we want to highlight based on the current search hit
and not the top line visible. In these cases it's not sufficiant to set
a "suppress" flag before scrolling and reset it afterwards, because the
scrolltext notification is sent deferred from a timer or some such; so we
need to remember the scroll position for which we want to suppress the
auto-highlighting until the next call to scrolltext; a bit ugly, but does
the job.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
Here's one way how to address your concern. When pressing the search button
it will highlight the file that contains the current search hit; if you then
scroll from there though, the normal mechanism kicks in again and might
highlight the previous file. The same happens now if you select the last file
in the list, but it's diff is smaller than a screenful. In the previous
patch versions it would select a different file than you clicked on, which
is probably also confusing.

Is this what you had in mind?

Stefan.

 gitk | 54 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/gitk b/gitk
index d93bd99..16832a9 100755
--- a/gitk
+++ b/gitk
@@ -3309,6 +3309,7 @@ proc sel_flist {w x y} {
     } else {
 	catch {$ctext yview [lindex $difffilestart [expr {$l - 2}]]}
     }
+    suppress_highlighting_file_for_current_scrollpos
 }
 
 proc pop_flist_menu {w X Y x y} {
@@ -7947,32 +7948,42 @@ proc changediffdisp {} {
     $ctext tag conf dresult -elide [lindex $diffelide 1]
 }
 
-proc highlightfile {loc cline} {
-    global ctext cflist cflist_top
+proc highlightfile {cline} {
+    global cflist cflist_top
 
-    $ctext yview $loc
     $cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend"
     $cflist tag add highlight $cline.0 "$cline.0 lineend"
     $cflist see $cline.0
     set cflist_top $cline
 }
 
+proc highlightfile_for_scrollpos {topidx} {
+    global difffilestart
+
+    if {![info exists difffilestart]} return
+
+    set top [lindex [split $topidx .] 0]
+    if {$difffilestart eq {} || $top < [lindex $difffilestart 0]} {
+	highlightfile 0
+    } else {
+	highlightfile [expr {[bsearch $difffilestart $top] + 2}]
+    }
+}
+
 proc prevfile {} {
     global difffilestart ctext cmitmode
 
     if {$cmitmode eq "tree"} return
     set prev 0.0
-    set prevline 1
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc >= $here]} {
-	    highlightfile $prev $prevline
+	    $ctext yview $prev
 	    return
 	}
 	set prev $loc
-	incr prevline
     }
-    highlightfile $prev $prevline
+    $ctext yview $prev
 }
 
 proc nextfile {} {
@@ -7980,11 +7991,9 @@ proc nextfile {} {
 
     if {$cmitmode eq "tree"} return
     set here [$ctext index @0,0]
-    set line 1
     foreach loc $difffilestart {
-	incr line
 	if {[$ctext compare $loc > $here]} {
-	    highlightfile $loc $line
+	    $ctext yview $loc
 	    return
 	}
     }
@@ -8046,6 +8055,8 @@ proc incrsearch {name ix op} {
 	set here [$ctext search $searchdirn -- $searchstring anchor]
 	if {$here ne {}} {
 	    $ctext see $here
+	    suppress_highlighting_file_for_current_scrollpos
+	    highlightfile_for_scrollpos $here
 	}
 	searchmarkvisible 1
     }
@@ -8071,6 +8082,8 @@ proc dosearch {} {
 	    return
 	}
 	$ctext see $match
+	suppress_highlighting_file_for_current_scrollpos
+	highlightfile_for_scrollpos $match
 	set mend "$match + $mlen c"
 	$ctext tag add sel $match $mend
 	$ctext mark unset anchor
@@ -8097,6 +8110,8 @@ proc dosearchback {} {
 	    return
 	}
 	$ctext see $match
+	suppress_highlighting_file_for_current_scrollpos
+	highlightfile_for_scrollpos $match
 	set mend "$match + $ml c"
 	$ctext tag add sel $match $mend
 	$ctext mark unset anchor
@@ -8137,8 +8152,25 @@ proc searchmarkvisible {doall} {
     }
 }
 
+proc suppress_highlighting_file_for_current_scrollpos {} {
+    global ctext suppress_highlighting_file_for_this_scrollpos
+
+    set suppress_highlighting_file_for_this_scrollpos [$ctext index @0,0]
+}
+
 proc scrolltext {f0 f1} {
-    global searchstring
+    global searchstring cmitmode ctext
+    global suppress_highlighting_file_for_this_scrollpos
+
+    if {$cmitmode ne "tree"} {
+	set topidx [$ctext index @0,0]
+	if {![info exists suppress_highlighting_file_for_this_scrollpos]
+	    || $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
+	    highlightfile_for_scrollpos $topidx
+	}
+    }
+
+    catch {unset suppress_highlighting_file_for_this_scrollpos}
 
     .bleft.bottom.sb set $f0 $f1
     if {$searchstring ne {}} {
-- 
1.7.12.517.g6dec59e
