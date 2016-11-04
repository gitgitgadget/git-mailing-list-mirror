Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A408D2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 22:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762157AbcKDWg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 18:36:28 -0400
Received: from ud03.udmedia.de ([194.117.254.43]:52120 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762151AbcKDWg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 18:36:27 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Nov 2016 18:36:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=FvNMb9FLqRugDc9EzEcVPCf/q6a
        IPtmONpSCq0sJC3A=; b=YNJSrvl6jZvo7sAbPH/TYaoJfZJtWB0zXJ01QUGav2O
        JhTg8g8TGsBIwIahmMdD+JEf77G90Mb8S/jLx9KUjadyVNErrl9QXdfrIHwbVeUe
        g9Y5hWIzu4a2WjBFGHJsu7PKa4RQfY5jtH24YcffXfYGz2UBP1SKYlZJPlA5UxxU
        =
Received: (qmail 27079 invoked from network); 4 Nov 2016 20:49:41 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 4 Nov 2016 20:49:41 +0100
To:     git@vger.kernel.org
From:   Markus Hitter <mah@jump-ing.de>
Subject: gitk: avoid obscene memory consumption
Message-ID: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
Date:   Fri, 4 Nov 2016 20:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello all,

after Gitk brought my shabby development machine (Core2Duo, 4 GB RAM, Ubuntu 16.10, no swap to save the SSD) to its knees once more than I'm comfortable with, I decided to investigate this issue.

Result of this investigation is, my Git repo has a commit with a diff of some 365'000 lines and Gitk tries to display all of them, consuming more than 1.5 GB of memory.

The solution is to cut off diffs at 50'000 lines for the display. This consumes about 350 MB RAM, still a lot. These first 50'000 lines are shown, followed by a copyable message on how to view the full diff on the command line. Diffs shorter than this limit are displayed as before.

To test the waters whether such a change is welcome, here's the patch as I currently use it. If this patch makes sense I'll happily apply change requests and bring it more in line with Git's patch submission expectations. The patch is made against git(k) version 2.9.3, the one coming with latest Ubuntu. Please also note that this is the first time I wrote some Tcl code, so the strategy used might not follow best Tcl practices.

$ diff -uw /usr/bin/gitk.org /usr/bin/gitk
--- /usr/bin/gitk.org	2016-08-16 22:32:47.000000000 +0200
+++ /usr/bin/gitk	2016-11-04 20:06:14.805920404 +0100
@@ -7,6 +7,15 @@
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+# Markus: trying to limit memory consumption. It happened that
+#         complex commits led to more than 1.5 GB of memory usage.
+#
+# The problem was identified to be caused by extremely long diffs. The
+# commit leading to this research had some 365'000 lines of diff, consuming
+# these 1.5 GB when drawn into the canvas. The solution is to limit diffs to
+# 50'000 lines and skipping the rest. In case of a cutoff, a CLI command for
+# getting the full diff is shown.
+
 package require Tk
 
 proc hasworktree {} {
@@ -7956,6 +7965,7 @@
 
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
+    global parseddifflines
     global treediffs
     global diffcontext
     global ignorespace
@@ -7987,6 +7997,7 @@
     }
     fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
+    set parseddifflines 0
     initblobdiffvars
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }
@@ -8063,20 +8074,34 @@
 
 proc getblobdiffline {bdf ids} {
     global diffids blobdifffd
+    global parseddifflines
     global ctext
 
     set nr 0
+    set maxlines 50000
     $ctext conf -state normal
     while {[incr nr] <= 1000 && [gets $bdf line] >= 0} {
+        incr parseddifflines
+        if {$parseddifflines >= $maxlines} {
+            break
+        }
 	if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
 	    catch {close $bdf}
 	    return 0
 	}
 	parseblobdiffline $ids $line
     }
+    if {$parseddifflines >= $maxlines} {
+        $ctext insert end "\n------------------" hunksep
+        $ctext insert end " Lines exceeding $maxlines skipped " hunksep
+        $ctext insert end "------------------\n\n" hunksep
+        $ctext insert end "To get a full diff, run\n\n" hunksep
+        $ctext insert end "  git diff-tree -p -C --cc $ids\n\n" hunksep
+        $ctext insert end "on the command line.\n" hunksep
+    }
     $ctext conf -state disabled
     blobdiffmaybeseehere [eof $bdf]
-    if {[eof $bdf]} {
+    if {[eof $bdf] || $parseddifflines >= $maxlines} {
 	catch {close $bdf}
 	return 0
     }
@@ -9093,6 +9118,7 @@
 
 proc diffcommits {a b} {
     global diffcontext diffids blobdifffd diffinhdr currdiffsubmod
+    global parseddifflines
 
     set tmpdir [gitknewtmpdir]
     set fna [file join $tmpdir "commit-[string range $a 0 7]"]
@@ -9114,6 +9140,7 @@
     set blobdifffd($diffids) $fd
     set diffinhdr 0
     set currdiffsubmod ""
+    set parseddifflines 0
     filerun $fd [list getblobdiffline $fd $diffids]
 }
 

Cheers,
Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
