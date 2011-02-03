From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH] gitk: Honor encoding conversion in a sole place for all possible cases
Date: Thu,  3 Feb 2011 19:42:33 +0300
Message-ID: <1296751353-8632-1-git-send-email-zapped@mail.ru>
Cc: Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 17:52:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl2QR-0006pz-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 17:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab1BCQwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 11:52:50 -0500
Received: from mx2.rarus.ru ([213.247.194.72]:3409 "EHLO mx2.rarus.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab1BCQwt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 11:52:49 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Feb 2011 11:52:49 EST
Received: from mail.rarus.ru
	by vger.kernel.org (mx2.rarus.ru)
	(SecurityGateway 2.0.0)
	with SMTP id SG005267155.MSG 
	for <git@vger.kernel.org>; Thu, 03 Feb 2011 19:42:46 +0300
Received: from ashu.dyn.rarus.ru ([172.20.138.111])
	by mail.rarus.ru with SMTP; Thu, 03 Feb 2011 19:42:39 +0300
Received: by ashu.dyn.rarus.ru (sSMTP sendmail emulation); Thu, 03 Feb 2011 19:42:36 +0300
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165983>

Previously every bug concerning encoding conversion
was fixed with a particular patch in a particular line of code
(e.g. 1f2cecfd53137b76d39b2dcd7bcf7e918cd745b3)
regardless other similar situations.

This patch centralizes reencoding of displayed text
considering all the cases where non-latin encoding may be used:
filenames, submodule names, rename/copy files, diffs (hunks),
commits comparison

Also cleaned up global "diffencoding" variable

Tested on Cygwin 1.5 and Cygwin 1.7

Still buggy on Cygwin 1.7: on a clear working copy shows
non-latin named files as removed and not indexed

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 gitk |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/gitk b/gitk
index 9cbc09d..1f9627d 100755
--- a/gitk
+++ b/gitk
@@ -5047,7 +5047,8 @@ proc dodiffindex {} {
 proc readdiffindex {fd serial inst} {
     global viewmainheadid nullid nullid2 curview commitinfo commitdata lserial
     global vfilelimit
-
+    global gui_encoding
+	
     set isdiff 1
     if {[gets $fd line] < 0} {
 	if {![eof $fd]} {
@@ -5069,6 +5070,9 @@ proc readdiffindex {fd serial inst} {
     }
     set fd [open $cmd r]
     fconfigure $fd -blocking 0
+    if {$gui_encoding != {}} {
+	fconfigure $fd -encoding $gui_encoding
+    }
     set i [reg_instance $fd]
     filerun $fd [list readdifffiles $fd $serial $i]
 
@@ -7541,7 +7545,7 @@ proc getblobdiffs {ids} {
     global ignorespace
     global worddiff
     global limitdiffs vfilelimit curview
-    global diffencoding targetline diffnparents
+    global targetline diffnparents
     global git_version currdiffsubmod
 
     set textconv {}
@@ -7570,7 +7574,7 @@ proc getblobdiffs {ids} {
     set diffnparents 0
     set diffinhdr 0
     set diffencoding [get_path_encoding {}]
-    fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
+    fconfigure $bdf -blocking 0 -encoding $diffencoding -eofchar {}
     set blobdifffd($ids) $bdf
     set currdiffsubmod ""
     filerun $bdf [list getblobdiffline $bdf $diffids]
@@ -7618,11 +7622,9 @@ proc setinlist {var i val} {
 }
 
 proc makediffhdr {fname ids} {
-    global ctext curdiffstart treediffs diffencoding
+    global ctext curdiffstart treediffs
     global ctext_file_names jump_to_here targetline diffline
 
-    set fname [encoding convertfrom $fname]
-    set diffencoding [get_path_encoding $fname]
     set i [lsearch -exact $treediffs($ids) $fname]
     if {$i >= 0} {
 	setinlist difffilestart $i $curdiffstart
@@ -7643,7 +7645,7 @@ proc getblobdiffline {bdf ids} {
     global diffnexthead diffnextnote difffilestart
     global ctext_file_names ctext_file_lines
     global diffinhdr treediffs mergemax diffnparents
-    global diffencoding jump_to_here targetline diffline currdiffsubmod
+    global jump_to_here targetline diffline currdiffsubmod
     global worddiff
 
     set nr 0
@@ -7655,7 +7657,6 @@ proc getblobdiffline {bdf ids} {
 	}
 	if {![string compare -length 5 "diff " $line]} {
 	    if {![regexp {^diff (--cc|--git) } $line m type]} {
-		set line [encoding convertfrom $line]
 		$ctext insert end "$line\n" hunksep
 		continue
 	    }
@@ -7715,7 +7716,6 @@ proc getblobdiffline {bdf ids} {
 
 	} elseif {![string compare -length 2 "@@" $line]} {
 	    regexp {^@@+} $line ats
-	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" hunksep
 	    if {[regexp { \+(\d+),\d+ @@} $line m nl]} {
 		set diffline $nl
@@ -7745,11 +7745,9 @@ proc getblobdiffline {bdf ids} {
 	    }
 	} elseif {![string compare -length 3 "  >" $line]} {
 	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" dresult
 	} elseif {![string compare -length 3 "  <" $line]} {
 	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" d0
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
@@ -7757,7 +7755,6 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
-		set fname [encoding convertfrom $fname]
 		set i [lsearch -exact $treediffs($ids) $fname]
 		if {$i >= 0} {
 		    setinlist difffilestart $i $curdiffstart
@@ -7779,8 +7776,7 @@ proc getblobdiffline {bdf ids} {
 	    $ctext insert end "$line\n" filesep
 
 	} else {
-	    set line [string map {\x1A ^Z} \
-                          [encoding convertfrom $diffencoding $line]]
+		set line [string map {\x1A ^Z} $line]
 	    # parse the prefix - one ' ', '-' or '+' for each parent
 	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
 	    set tag [expr {$diffnparents > 1? "m": "d"}]
-- 
1.7.4
