From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH] gitk: Synchronize highlighting in file view when scrolling diff
Date: Tue, 18 Sep 2012 07:57:54 +0200
Message-ID: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDqxt-0006Aa-CO
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab2IRGHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:07:10 -0400
Received: from server90.greatnet.de ([83.133.96.186]:39140 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab2IRGHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:07:08 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2012 02:07:08 EDT
Received: from macbook-stk.office.ableton.com (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 913D62C4054;
	Tue, 18 Sep 2012 07:58:20 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.376.g8258bbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205792>

Whenever the diff pane scrolls, highlight the corresponding file in the
file list on the right. For a large commit with many files and long
per-file diffs, this makes it easier to keep track of what you're looking
at.

This allows simplifying the prevfile and nextfile functions, because
all they have to do is scroll the diff pane.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/gitk b/gitk
index d93bd99..9e3ec71 100755
--- a/gitk
+++ b/gitk
@@ -7947,10 +7947,9 @@ proc changediffdisp {} {
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
@@ -7962,17 +7961,15 @@ proc prevfile {} {
 
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
@@ -7980,11 +7977,9 @@ proc nextfile {} {
 
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
@@ -8138,7 +8133,17 @@ proc searchmarkvisible {doall} {
 }
 
 proc scrolltext {f0 f1} {
-    global searchstring
+    global searchstring cmitmode
+    global ctext cflist cflist_top difffilestart
+
+    if {$cmitmode ne "tree" && [info exists difffilestart]} {
+	set top [lindex [split [$ctext index @0,0] .] 0]
+	if {$top < [lindex $difffilestart 0]} {
+	    highlightfile 0
+	} else {
+	    highlightfile [expr {[bsearch $difffilestart $top] + 2}]
+	}
+    }
 
     .bleft.bottom.sb set $f0 $f1
     if {$searchstring ne {}} {
-- 
1.7.12.376.g8258bbd
