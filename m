From: Max Kirillov <max@max630.net>
Subject: [RFC] HACK: use anchor mark instead of sel tag
Date: Thu, 12 Dec 2013 01:36:40 +0200
Message-ID: <20131211233640.GA4985@wheezy.local>
References: <20131201224132.GB12576@iris.ozlabs.ibm.com>
 <1ld8zlh.1h4guajnkaralM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 00:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqtLE-0005u9-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 00:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab3LKXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 18:37:08 -0500
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:36453
	"EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276Ab3LKXhG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Dec 2013 18:37:06 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa07-05.prod.phx3.secureserver.net with 
	id 0Pcv1n00H4CavkR01Pd2qd; Wed, 11 Dec 2013 16:37:04 -0700
Content-Disposition: inline
In-Reply-To: <1ld8zlh.1h4guajnkaralM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239219>

---

I hacked somehow around this. It seems that just usilg the
anchor mark should be enough to implement almost the same
behavior. The hard part is that I don't know which feature
is intentional and which is just random consequence of using
sel for search highlight.

One thing which seems to me important and not possible to
implement without using another mask or tag is to return
currentsearchhit back when user removes characters from the
end of search string, and it starts to match previous
places.

This is not intended as patch for merging, just proof of
concept.

 gitk-git/gitk | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cf25472..c8b223f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8320,24 +8320,29 @@ proc settabs {{firstab {}}} {
 proc incrsearch {name ix op} {
     global ctext searchstring searchdirn
 
-    if {[catch {$ctext index anchor}]} {
+    if {[catch {set prev_anchor [$ctext index anchor]}]} {
 	# no anchor set, use start of selection, or of visible area
 	set sel [$ctext tag ranges sel]
 	if {$sel ne {}} {
-	    $ctext mark set anchor [lindex $sel 0]
+	    set start [lindex $sel 0]
 	} elseif {$searchdirn eq "-forwards"} {
-	    $ctext mark set anchor @0,0
+	    set start @0,0
+	} else {
+	    set start @0,[winfo height $ctext]
+	}
+    } else {
+	if {$searchdirn eq "-forwards"} {
+	    set start $prev_anchor
 	} else {
-	    $ctext mark set anchor @0,[winfo height $ctext]
+	    set start "$prev_anchor + [string length $searchstring] c"
 	}
     }
     if {$searchstring ne {}} {
-	set here [$ctext search -count mlen $searchdirn -- $searchstring anchor]
+	set here [$ctext search -count mlen $searchdirn -- $searchstring $start]
 	if {$here ne {}} {
 	    $ctext see $here
 	    set mend "$here + $mlen c"
-	    $ctext tag remove sel 1.0 end
-	    $ctext tag add sel $here $mend
+	    $ctext mark set anchor $here
 	    suppress_highlighting_file_for_current_scrollpos
 	    highlightfile_for_scrollpos $here
 	}
@@ -8355,7 +8360,7 @@ proc dosearch {} {
 	set sel [$ctext tag ranges sel]
 	if {$sel ne {}} {
 	    set start "[lindex $sel 0] + 1c"
-	} elseif {[catch {set start [$ctext index anchor]}]} {
+	} elseif {[catch {set start "[$ctext index anchor] + 1c"}]} {
 	    set start "@0,0"
 	}
 	set match [$ctext search -count mlen -- $searchstring $start]
@@ -8368,8 +8373,7 @@ proc dosearch {} {
 	suppress_highlighting_file_for_current_scrollpos
 	highlightfile_for_scrollpos $match
 	set mend "$match + $mlen c"
-	$ctext tag add sel $match $mend
-	$ctext mark unset anchor
+	$ctext mark set anchor $match
 	rehighlight_search_results
     }
 }
@@ -8397,8 +8401,7 @@ proc dosearchback {} {
 	suppress_highlighting_file_for_current_scrollpos
 	highlightfile_for_scrollpos $match
 	set mend "$match + $ml c"
-	$ctext tag add sel $match $mend
-	$ctext mark unset anchor
+        $ctext mark set anchor $match
 	rehighlight_search_results
     }
 }
@@ -8418,14 +8421,15 @@ proc searchmark {first last} {
     global ctext searchstring
     puts [list $first $last]
 
-    set sel [$ctext tag ranges sel]
+    #TODO: catch no anchor
+    set anchor [$ctext index anchor]
 
     set mend $first.0
     while {1} {
 	set match [$ctext search -count mlen -- $searchstring $mend $last.end]
 	if {$match eq {}} break
 	set mend "$match + $mlen c"
-	if {$sel ne {} && [$ctext compare $match == [lindex $sel 0]]} {
+	if {$anchor eq $match} {
 	    $ctext tag add currentsearchhit $match $mend
 	} else {
 	    $ctext tag add found $match $mend
-- 
1.8.4.2.1566.g3c1a064
