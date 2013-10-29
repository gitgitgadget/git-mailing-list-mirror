From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 4/7] gitk: support showing the gathered inline diffs
Date: Tue, 29 Oct 2013 08:20:37 +0100
Message-ID: <67b991439fe06519e69cf6594497ac1d2cf06228.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cP-0006Sy-GO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab3J2HVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:22 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56292 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab3J2HVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 54DAB4D6580;
	Tue, 29 Oct 2013 08:21:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sH53fDgNSMSU; Tue, 29 Oct 2013 08:21:00 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 67BED4D659F;
	Tue, 29 Oct 2013 08:20:58 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236904>

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
 gitk-git/gitk | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 78b4354..5ece2a1 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
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
1.8.4.2.838.ga9a3e20
