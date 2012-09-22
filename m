From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH 1/2] gitk: Highlight current search hit in orange
Date: Sat, 22 Sep 2012 09:40:24 +0200
Message-ID: <1348299625-90207-2-git-send-email-stefan@haller-berlin.de>
References: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 09:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFKKz-0008Bh-AI
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 09:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab2IVHks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 03:40:48 -0400
Received: from server90.greatnet.de ([83.133.96.186]:55591 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab2IVHkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 03:40:47 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 4F64F3B0E8F;
	Sat, 22 Sep 2012 09:40:45 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.1.399.gae20e0d
In-Reply-To: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206196>

When searching for text in the diff, and there are multiple occurrences
of the search string, the current one is highlighted in orange, and the
other ones in yellow. This makes it much easier to understand what happens
when you then click the Search button or hit Ctrl-S repeatedly.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 16832a9..e2c0f1c 100755
--- a/gitk
+++ b/gitk
@@ -2361,6 +2361,7 @@ proc makewindow {} {
     $ctext tag conf mresult -font textfontbold
     $ctext tag conf msep -font textfontbold
     $ctext tag conf found -back yellow
+    $ctext tag conf currentsearchhit -back orange
 
     .pwbottom add .bleft
     if {!$use_ttk} {
@@ -2523,6 +2524,7 @@ proc makewindow {} {
     bind $cflist $ctxbut {pop_flist_menu %W %X %Y %x %y}
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
     bind $ctext <Button-1> {focus %W}
+    bind $ctext <<Selection>> rehighlight_search_results
 
     set maincursor [. cget -cursor]
     set textcursor [$ctext cget -cursor]
@@ -8039,7 +8041,6 @@ proc settabs {{firstab {}}} {
 proc incrsearch {name ix op} {
     global ctext searchstring searchdirn
 
-    $ctext tag remove found 1.0 end
     if {[catch {$ctext index anchor}]} {
 	# no anchor set, use start of selection, or of visible area
 	set sel [$ctext tag ranges sel]
@@ -8058,8 +8059,8 @@ proc incrsearch {name ix op} {
 	    suppress_highlighting_file_for_current_scrollpos
 	    highlightfile_for_scrollpos $here
 	}
-	searchmarkvisible 1
     }
+    rehighlight_search_results
 }
 
 proc dosearch {} {
@@ -8087,6 +8088,7 @@ proc dosearch {} {
 	set mend "$match + $mlen c"
 	$ctext tag add sel $match $mend
 	$ctext mark unset anchor
+	rehighlight_search_results
     }
 }
 
@@ -8115,18 +8117,36 @@ proc dosearchback {} {
 	set mend "$match + $ml c"
 	$ctext tag add sel $match $mend
 	$ctext mark unset anchor
+	rehighlight_search_results
+    }
+}
+
+proc rehighlight_search_results {} {
+    global ctext searchstring
+
+    $ctext tag remove found 1.0 end
+    $ctext tag remove currentsearchhit 1.0 end
+
+    if {$searchstring ne {}} {
+	searchmarkvisible 1
     }
 }
 
 proc searchmark {first last} {
     global ctext searchstring
 
+    set sel [$ctext tag ranges sel]
+
     set mend $first.0
     while {1} {
 	set match [$ctext search -count mlen -- $searchstring $mend $last.end]
 	if {$match eq {}} break
 	set mend "$match + $mlen c"
-	$ctext tag add found $match $mend
+	if {$sel ne {} && [$ctext compare $match == [lindex $sel 0]]} {
+	    $ctext tag add currentsearchhit $match $mend
+	} else {
+	    $ctext tag add found $match $mend
+	}
     }
 }
 
-- 
1.7.12.1.399.gae20e0d
