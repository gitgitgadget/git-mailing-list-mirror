Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CD31FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbcLSQqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:22 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45772 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933442AbcLSQpc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:32 -0500
X-AuditID: 12074413-465ff70000000a33-fa-58580ea7552a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.82.02611.7AE08585; Mon, 19 Dec 2016 11:45:28 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQw011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:26 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/13] gitk: fill in `wvals` as the tags are first processed
Date:   Mon, 19 Dec 2016 17:45:04 +0100
Message-Id: <d7b6999f7e3ba271c6932925cd26ea2884df3014.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsUixO6iqLuCLyLC4McKHouuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj0p21rAVrBCv2nl3G1sA4
        j6eLkZNDQsBEouvhS5YuRi4OIYHLjBJH/69kBUkICZxikrg7WwDEZhPQlVjU08zUxcjBISKg
        KrH+ghBImFnAQWLz50ZGEFtYwEfiyIJ5TCA2C1DJ/YfHmEHKeQWiJKZfLYFYJSdxadsXZhCb
        U8BC4ub8K+wQm8wlNjz7zTKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3U
        lNJNjJBwEN7BuOuk3CFGAQ5GJR7egvdhEUKsiWXFlbmHGCU5mJREeffzREQI8SXlp1RmJBZn
        xBeV5qQWH2KU4GBWEuEVA8nxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4
        lCR4w3mBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGp4PU8BYXJOYWZ6ZD5E8xKkqJ8zqCJARAEhml
        eXC9sHh9xSgO9IowLycweoV4gLEO1/0KaDAT0OCF3eEgg0sSEVJSDYzL2XS3z6jhbX7+dq5x
        tMvps1Gvt6uVCe9dlymkVpFRkqR0+tgbXfVpSUVKXVk9E644PkyecF2l5pr0uQY1fwFt4ab9
        Z/18/9hOZ2Fs+3jvwmwt4XknXwg2l5s/cTnGbP1csFdyyxH2GJeaOYp2Jy/PmnUm1Xfm0vB4
        7Ss+xy5U+p0NiPuWEKTEUpyRaKjFXFScCACEAVorsgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's no longer, and a little bit more direct, to fill in `wvals` at the
same time as we determine the tag's type.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index d2e3803..fb2f653 100755
--- a/gitk
+++ b/gitk
@@ -6561,6 +6561,7 @@ proc drawtags {id x xt y1} {
 
     set marks {}
     set types {}
+    set wvals {}
     set maxtags 3
     set maxtagpct 25
     set maxwidth [expr {[graph_pane_width] * $maxtagpct / 100}]
@@ -6575,14 +6576,17 @@ proc drawtags {id x xt y1} {
 	    # show just a single "n tags..." tag
 	    lappend types tags
 	    if {$ntags == 1} {
-		lappend marks "tag..."
+		set text "tag..."
 	    } else {
-		lappend marks [format "%d tags..." $ntags]
+		set text [format "%d tags..." $ntags]
 	    }
+	    lappend marks $text
+	    lappend wvals [font measure mainfont $text]
 	} else {
 	    foreach tag $tags {
 		lappend types tag
 		lappend marks $tag
+		lappend wvals [font measure mainfont $tag]
 	    }
 	}
     }
@@ -6590,8 +6594,10 @@ proc drawtags {id x xt y1} {
 	foreach head $idheads($id) {
 	    if {$head eq $mainhead} {
 		lappend types mainhead
+		lappend wvals [font measure mainfontbold $head]
 	    } else {
 		lappend types head
+		lappend wvals [font measure mainfont $head]
 	    }
 	    lappend marks $head
 	}
@@ -6600,6 +6606,7 @@ proc drawtags {id x xt y1} {
 	foreach other $idotherrefs($id) {
 	    lappend types other
 	    lappend marks $other
+	    lappend wvals [font measure mainfont $other]
 	}
     }
     if {$marks eq {}} {
@@ -6609,15 +6616,8 @@ proc drawtags {id x xt y1} {
     set yt [expr {$y1 - 0.5 * $linespc}]
     set yb [expr {$yt + $linespc - 1}]
     set xvals {}
-    set wvals {}
-    foreach tag $marks type $types {
-	if {$type eq "mainhead"} {
-	    set wid [font measure mainfontbold $tag]
-	} else {
-	    set wid [font measure mainfont $tag]
-	}
+    foreach wid $wvals {
 	lappend xvals $xt
-	lappend wvals $wid
 	set xt [expr {$xt + $wid + $extra}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-- 
2.9.3

