Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E741202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbdCIV06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:26:58 -0500
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:53912
        "EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751619AbdCIV06 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 16:26:58 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Mar 2017 16:26:58 EST
Received: from jessie.local ([82.181.81.240])
        by :SMTPAUTH: with SMTP
        id m5SQcU5f22uVem5SVcpQzF; Thu, 09 Mar 2017 14:18:52 -0700
From:   Max Kirillov <max@max630.net>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH] gitk: blame older file in case of copied and renamed files
Date:   Thu,  9 Mar 2017 23:18:31 +0200
Message-Id: <20170309211831.11295-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
X-CMAE-Envelope: MS4wfB6HQMmBWZNwyIIXjIyiseq9bxzmdcLNHOtZJkKHaLqltVy2sLjUkLrvI2sjVKrqNRo51veVpEyZsnbzER6+6ImFDM6ka6i2l/s4pQ5TO5RgCBm38++F
 0SVmC3d51O2rNENIai+3UuaNIMZCQqwCiSTqBdTSI71Lz5r65e5nuH0hKxf0g0G0Gm84SbJ9nhiea6ClWqgdomtOQToLSTL46LI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If file was renamed or copied, and in the same time edited, attempt to run
"Show origin of this line" or "Run gui blame on this line" would result in
error "fatal: no such path FILE in HASH". Reason is that it tried to use
the newer filename, while it should use the older one.

Since ctext_file_names in diff mode only used for parent commit
filenames, there is no need to split it to 2 lists, just change its
so that for diff mode it means older filename always.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index d3e9e459c3..0b8b1a4e9f 100755
--- a/gitk
+++ b/gitk
@@ -8349,9 +8349,16 @@ proc setinlist {var i val} {
     }
 }
 
+proc add_ctext_file {fname} {
+    global ctext_file_names
+
+    set fname [encoding convertfrom $fname]
+    lset ctext_file_names end $fname
+}
+
 proc makediffhdr {fname ids} {
     global ctext curdiffstart treediffs diffencoding
-    global ctext_file_names jump_to_here targetline diffline
+    global jump_to_here targetline diffline
 
     set fname [encoding convertfrom $fname]
     set diffencoding [get_path_encoding $fname]
@@ -8359,7 +8366,6 @@ proc makediffhdr {fname ids} {
     if {$i >= 0} {
 	setinlist difffilestart $i $curdiffstart
     }
-    lset ctext_file_names end $fname
     set l [expr {(78 - [string length $fname]) / 2}]
     set pad [string range "----------------------------------------" 1 $l]
     $ctext insert $curdiffstart "$pad $fname $pad" filesep
@@ -8454,6 +8460,7 @@ proc parseblobdiffline {ids line} {
 		set fname [string range $line 2 [expr {$i - 1}]]
 	    }
 	}
+	add_ctext_file $fname
 	makediffhdr $fname $ids
 
     } elseif {![string compare -length 16 "* Unmerged path " $line]} {
@@ -8492,6 +8499,7 @@ proc parseblobdiffline {ids line} {
 	lappend ctext_file_names ""
 	if {$currdiffsubmod != $fname} {
 	    lappend ctext_file_lines $fname
+	    add_ctext_file $fname
 	    makediffhdr $fname $ids
 	    set currdiffsubmod $fname
 	    $ctext insert end "\n$line\n" filesep
@@ -8512,11 +8520,18 @@ proc parseblobdiffline {ids line} {
 	    if {[string index $fname 0] eq "\""} {
 		set fname [lindex $fname 0]
 	    }
+	    add_ctext_file $fname
 	    set fname [encoding convertfrom $fname]
 	    set i [lsearch -exact $treediffs($ids) $fname]
 	    if {$i >= 0} {
 		setinlist difffilestart $i $curdiffstart
 	    }
+	} elseif {![string compare -length 10 $line "copy from "]} {
+	    set fname [string range $line [expr 6 + [string first " from " $line] ] end]
+	    if {[string index $fname 0] eq "\""} {
+		set fname [lindex $fname 0]
+	    }
+	    add_ctext_file $fname
 	} elseif {![string compare -length 10 $line "rename to "] ||
 		  ![string compare -length 8 $line "copy to "]} {
 	    set fname [string range $line [expr 4 + [string first " to " $line] ] end]
-- 
2.11.0.1122.gc3fec58.dirty

