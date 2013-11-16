From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 gitk 4/5] gitk: support showing the gathered inline diffs
Date: Sat, 16 Nov 2013 18:37:43 +0100
Message-ID: <1907d29ffc703330bebcbe08ec0927a028d62edf.1384622392.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622392.git.tr@thomasrast.ch>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjov-0007Mi-3J
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab3KPRiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:01 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38467 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3KPRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:37:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CCF514D659F;
	Sat, 16 Nov 2013 18:37:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NKxry-0eRXza; Sat, 16 Nov 2013 18:37:54 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D17A04D65A1;
	Sat, 16 Nov 2013 18:37:52 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622392.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237933>

From: Thomas Rast <trast@inf.ethz.ch>

The previous commit split the diffs into a separate field.  Now we
actually want to show them.

To that end we use the stored diff, and

- process it once to build a fake "tree diff", i.e., a list of all
  changed files;

- feed it through parseblobdiffline to actually format it into the
  $ctext field, like the existing diff machinery would.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/gitk b/gitk
index 78b4354..5ece2a1 100755
--- a/gitk
+++ b/gitk
@@ -156,10 +156,12 @@ proc unmerged_files {files} {
 
 proc parseviewargs {n arglist} {
     global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global vinlinediff
     global worddiff git_version
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
+    set vinlinediff($n) 0
     set glflags {}
     set diffargs {}
     set nextisval 0
@@ -7089,6 +7091,7 @@ proc selectline {l isnew {desired_loc {}}} {
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
     global autoselect autosellen jump_to_here
+    global vinlinediff
 
     catch {unset pending_select}
     $canv delete hover
@@ -7230,6 +7233,8 @@ proc selectline {l isnew {desired_loc {}}} {
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
+    } elseif {$vinlinediff($curview) == 1} {
+	showinlinediff $id
     } elseif {[llength $olds] <= 1} {
 	startdiff $id
     } else {
@@ -7566,6 +7571,39 @@ proc startdiff {ids} {
     }
 }
 
+proc showinlinediff {ids} {
+    global commitinfo commitdata ctext
+    global treediffs
+
+    set info $commitinfo($ids)
+    set diff [lindex $info 7]
+    set difflines [split $diff "\n"]
+
+    initblobdiffvars
+    set treediff {}
+
+    set inhdr 0
+    foreach line $difflines {
+	if {![string compare -length 5 "diff " $line]} {
+	    set inhdr 1
+	} elseif {$inhdr && ![string compare -length 4 "+++ " $line]} {
+	    # offset also accounts for the b/ prefix
+	    lappend treediff [string range $line 6 end]
+	    set inhdr 0
+	}
+    }
+
+    set treediffs($ids) $treediff
+    add_flist $treediff
+
+    $ctext conf -state normal
+    foreach line $difflines {
+	parseblobdiffline $ids $line
+    }
+    maybe_scroll_ctext 1
+    $ctext conf -state disabled
+}
+
 # If the filename (name) is under any of the passed filter paths
 # then return true to include the file in the listing.
 proc path_filter {filter name} {
-- 
1.8.5.rc2.348.gb73b695
