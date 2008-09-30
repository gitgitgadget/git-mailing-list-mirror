From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2 2/4] gitk: Implement file contents encoding support.
Date: Tue, 30 Sep 2008 15:00:20 +0400
Message-ID: <1222772422-28020-3-git-send-email-angavrilov@gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 13:03:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd0l-0000DF-9C
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYI3LCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYI3LCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:02:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:55898 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbYI3LCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:02:03 -0400
Received: by ug-out-1314.google.com with SMTP id k3so544008ugf.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/MqjhN/oR+XlEzDBjG+2K4JjUbPAH2ghURke6J6Ctgo=;
        b=nyGND3WLmYde/yMwydZQUy3vFb/7v++qmx01Di8t8ROM+PutNq87urbiNo1Asvu6lz
         BF8YEBXbSvp3/XSOQ9I7jucMM22wkCigy7tjRM4U0AaS4cLrUPuvVmdkcY3vzUBggr68
         i0gFkm2Qy4PgIt0bUzj38nJOix3SV/zqigGAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j6Do92MOb73kiv32XW49TAlBoIds8guTGiCHtt3elbBgmQiazo2m2akPnUtn7MVNgi
         IanHdiSKnHuvzgpzeAU2ruChKFEIMovVfkgnlozMRYsDXYtimOG/uFrXmgsN1O2Q72Ja
         GDnk3ENL09s2xWjRfamXbiY/fbbxo0LXsXkTo=
Received: by 10.103.228.12 with SMTP id f12mr4727497mur.28.1222772520760;
        Tue, 30 Sep 2008 04:02:00 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id y6sm7517378mug.7.2008.09.30.04.01.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:02:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97099>

The previous patch has added functions that implement
per-file encoding selection logic. This one modifies
core gitk code to use them.

Since diffs usually contain multiple files, which may
have different values of the encoding attribute, they
are initially read as binary, and encoding conversion
is applied to individual lines, based on the active
set of diff headers.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index b210f79..98923e7 100755
--- a/gitk
+++ b/gitk
@@ -6295,7 +6295,7 @@ proc showfile {f} {
 	    return
 	}
     }
-    fconfigure $bf -blocking 0
+    fconfigure $bf -blocking 0 -encoding [get_cached_encoding $f]
     filerun $bf [list getblobline $bf $diffids]
     $ctext config -state normal
     clear_ctext $commentend
@@ -6333,6 +6333,7 @@ proc mergediff {id} {
     global diffids
     global parents
     global diffcontext
+    global diffencoding
     global limitdiffs vfilelimit curview
 
     set diffmergeid $id
@@ -6346,9 +6347,10 @@ proc mergediff {id} {
 	error_popup "[mc "Error getting merge diffs:"] $err"
 	return
     }
-    fconfigure $mdf -blocking 0
+    fconfigure $mdf -blocking 0 -encoding binary
     set mdifffd($id) $mdf
     set np [llength $parents($curview,$id)]
+    set diffencoding [get_cached_encoding {}]
     settabs $np
     filerun $mdf [list getmergediffline $mdf $id $np]
 }
@@ -6356,6 +6358,7 @@ proc mergediff {id} {
 proc getmergediffline {mdf id np} {
     global diffmergeid ctext cflist mergemax
     global difffilestart mdifffd
+    global diffencoding
 
     $ctext conf -state normal
     set nr 0
@@ -6371,14 +6374,17 @@ proc getmergediffline {mdf id np} {
 	    set here [$ctext index "end - 1c"]
 	    lappend difffilestart $here
 	    add_flist [list $fname]
+	    set diffencoding [get_cached_encoding $fname]
 	    set l [expr {(78 - [string length $fname]) / 2}]
 	    set pad [string range "----------------------------------------" 1 $l]
 	    $ctext insert end "$pad $fname $pad\n" filesep
 	} elseif {[regexp {^@@} $line]} {
+	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" hunksep
 	} elseif {[regexp {^[0-9a-f]{40}$} $line] || [regexp {^index} $line]} {
 	    # do nothing
 	} else {
+	    set line [encoding convertfrom $diffencoding $line]
 	    # parse the prefix - one ' ', '-' or '+' for each parent
 	    set spaces {}
 	    set minuses {}
@@ -6586,6 +6592,7 @@ proc getblobdiffs {ids} {
     global diffcontext
     global ignorespace
     global limitdiffs vfilelimit curview
+    global diffencoding
 
     set cmd [diffcmd $ids "-p -C --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
@@ -6599,7 +6606,8 @@ proc getblobdiffs {ids} {
 	return
     }
     set diffinhdr 0
-    fconfigure $bdf -blocking 0
+    set diffencoding [get_cached_encoding {}]
+    fconfigure $bdf -blocking 0 -encoding binary
     set blobdifffd($ids) $bdf
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }
@@ -6633,6 +6641,7 @@ proc getblobdiffline {bdf ids} {
     global diffids blobdifffd ctext curdiffstart
     global diffnexthead diffnextnote difffilestart
     global diffinhdr treediffs
+    global diffencoding
 
     set nr 0
     $ctext conf -state normal
@@ -6670,10 +6679,12 @@ proc getblobdiffline {bdf ids} {
 	    } else {
 		set fname [string range $line 2 [expr {$i - 1}]]
 	    }
+	    set diffencoding [get_cached_encoding $fname]
 	    makediffhdr $fname $ids
 
 	} elseif {[regexp {^@@ -([0-9]+)(,[0-9]+)? \+([0-9]+)(,[0-9]+)? @@(.*)} \
 		       $line match f1l f1c f2l f2c rest]} {
+	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" hunksep
 	    set diffinhdr 0
 
@@ -6693,6 +6704,7 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
+		set diffencoding [get_cached_encoding $fname]
 		makediffhdr $fname $ids
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
 		# do nothing
@@ -6704,6 +6716,7 @@ proc getblobdiffline {bdf ids} {
 	    $ctext insert end "$line\n" filesep
 
 	} else {
+	    set line [encoding convertfrom $diffencoding $line]
 	    set x [string range $line 0 0]
 	    if {$x == "-" || $x == "+"} {
 		set tag [expr {$x == "+"}]
-- 
1.6.0.20.g6148bc
