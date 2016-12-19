Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEA31FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbcLSQp2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:45:28 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61893 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933194AbcLSQp0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:26 -0500
X-AuditID: 12074411-fa3ff700000009b7-3d-58580ea47934
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 75.97.02487.4AE08585; Mon, 19 Dec 2016 11:45:24 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQt011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:23 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/13] gitk: keep track of tag types in a separate `types` array
Date:   Mon, 19 Dec 2016 17:45:01 +0100
Message-Id: <e9d546743245a59925fa0ab762a8a1e88ccfc360.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsUixO6iqLuELyLC4HuXukXXlW4mi9sr5jNb
        rDmymN2B2ePv+w9MHnN39TF6fN4kF8AcxWWTkpqTWZZapG+XwJXxe24HY8FmqYq/O9vZGxgv
        C3UxcnJICJhIvOu7wNrFyMUhJHCZUeLI+xVsEM4pJom/jedYQarYBHQlFvU0M3UxcnCICKhK
        rL8A1sws4CCx+XMjI0hYWCBA4lcDC0iYBajiw5H1YDavQJTEyud/WSF2yUlc2vaFGcTmFLCQ
        uDn/CjuILSRgLrHh2W+WCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaU
        bmKEBITgDsYZJ+UOMQpwMCrx8Ba8D4sQYk0sK67MPcQoycGkJMq7nyciQogvKT+lMiOxOCO+
        qDQntfgQowQHs5II7zdeoBxvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoND
        SYL3PkijYFFqempFWmZOCUKaiYMTZDgP0PAHYMOLCxJzizPTIfKnGHU5pj1b/JRJiCUvPy9V
        SpzXEaRIAKQoozQPbg4skl8xigO9JczLCYxrIR5gEoCb9ApoCRPQkoXd4SBLShIRUlINjB66
        cfbGHQ2TFzldVdN93TrvyWfD9YHGt/1PMM80yvMPbOhbfrgqsSl6u8+x+Xydn78VXzXlMk5b
        L3hG/7PoRkP9hVob+rUiHI73njRTP3JtyWmnV5u7dbX3XLbf3SJQLHF+0YuV30okq2VnNs+1
        /6F7Iqx+NsOz5PXCBx9GvRcw+3pUTkN3hxJLcUaioRZzUXEiAJ/ixz6/AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resulting code is easier to follow than the old counting-based code,
plus in a moment we will add some more specific types.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/gitk b/gitk
index 296efb3..7c830c3 100755
--- a/gitk
+++ b/gitk
@@ -6560,8 +6560,7 @@ proc drawtags {id x xt y1} {
     global reflinecolor
 
     set marks {}
-    set ntags 0
-    set nheads 0
+    set types {}
     set singletag 0
     set maxtags 3
     set maxtagpct 25
@@ -6576,22 +6575,30 @@ proc drawtags {id x xt y1} {
 	    [totalwidth $tags mainfont $extra] > $maxwidth} {
 	    # show just a single "n tags..." tag
 	    set singletag 1
+	    lappend types tag
 	    if {$ntags == 1} {
 		lappend marks "tag..."
 	    } else {
 		lappend marks [format "%d tags..." $ntags]
-		set ntags 1
 	    }
 	} else {
-	    set marks [concat $marks $tags]
+	    foreach tag $tags {
+		lappend types tag
+		lappend marks $tag
+	    }
 	}
     }
     if {[info exists idheads($id)]} {
-	set marks [concat $marks $idheads($id)]
-	set nheads [llength $idheads($id)]
+	foreach head $idheads($id) {
+	    lappend types head
+	    lappend marks $head
+	}
     }
     if {[info exists idotherrefs($id)]} {
-	set marks [concat $marks $idotherrefs($id)]
+	foreach other $idotherrefs($id) {
+	    lappend types other
+	    lappend marks $other
+	}
     }
     if {$marks eq {}} {
 	return $xt
@@ -6601,10 +6608,8 @@ proc drawtags {id x xt y1} {
     set yb [expr {$yt + $linespc - 1}]
     set xvals {}
     set wvals {}
-    set i -1
-    foreach tag $marks {
-	incr i
-	if {$i >= $ntags && $i < $ntags + $nheads && $tag eq $mainhead} {
+    foreach tag $marks type $types {
+	if {$type eq "head" && $tag eq $mainhead} {
 	    set wid [font measure mainfontbold $tag]
 	} else {
 	    set wid [font measure mainfont $tag]
@@ -6616,12 +6621,12 @@ proc drawtags {id x xt y1} {
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
 	       -width $lthickness -fill $reflinecolor -tags tag.$id]
     $canv lower $t
-    foreach tag $marks x $xvals wid $wvals {
+    foreach tag $marks type $types x $xvals wid $wvals {
 	set tag_quoted [string map {% %%} $tag]
 	set xl [expr {$x + $delta}]
 	set xr [expr {$x + $delta + $wid + $lthickness}]
 	set font mainfont
-	if {[incr ntags -1] >= 0} {
+	if {$type eq "tag"} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
@@ -6636,7 +6641,7 @@ proc drawtags {id x xt y1} {
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
-	    if {[incr nheads -1] >= 0} {
+	    if {$type eq "head"} {
 		set col $headbgcolor
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
@@ -6658,9 +6663,9 @@ proc drawtags {id x xt y1} {
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
 		   -font $font -tags [list tag.$id text]]
-	if {$ntags >= 0} {
+	if {$type eq "tag"} {
 	    $canv bind $t <1> $tagclick
-	} elseif {$nheads >= 0} {
+	} elseif {$type eq "head"} {
 	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
 	}
     }
-- 
2.9.3

