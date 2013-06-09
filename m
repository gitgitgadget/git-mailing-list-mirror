From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH gitk 3/4] gitk: support showing the gathered inline diffs
Date: Sun, 9 Jun 2013 21:44:14 +0200
Message-ID: <209fa0023dbb323e36665e37274adaefcd72c471.1370806329.git.trast@inf.ethz.ch>
References: <cover.1370806329.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllXY-0003Xs-9D
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3FIToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:44:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41722 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab3FIToU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:44:20 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:02 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:16 +0200
X-Mailer: git-send-email 1.8.3.496.g0d0267b
In-Reply-To: <cover.1370806329.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227155>

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
index 261bda8..3715136 100755
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
@@ -7086,6 +7088,7 @@ proc selectline {l isnew {desired_loc {}}} {
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
     global autoselect autosellen jump_to_here
+    global vinlinediff
 
     catch {unset pending_select}
     $canv delete hover
@@ -7227,6 +7230,8 @@ proc selectline {l isnew {desired_loc {}}} {
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
+    } elseif {$vinlinediff($curview) == 1} {
+	showinlinediff $id
     } elseif {[llength $olds] <= 1} {
 	startdiff $id
     } else {
@@ -7563,6 +7568,39 @@ proc startdiff {ids} {
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
1.8.3.496.g0d0267b
