From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 2/4] gitk: Enhance file encoding support.
Date: Mon, 13 Oct 2008 12:12:32 +0400
Message-ID: <1223885554-27718-3-git-send-email-angavrilov@gmail.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
 <1223885554-27718-2-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 10:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIbM-0003kw-Ft
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbYJMIO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbYJMIO0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:14:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:21638 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbYJMIOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:14:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1550933fkq.5
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6z/9QmHa7B39qnsG1ZmaEAUtphj4dLNXR/b7GvHZVxY=;
        b=RNR94WtQMtcH5ERgU1BxR9ybpm0gJeniLeqaVyJjSiu1cjov1o3YJQFaUzx0sgMN7G
         HMZSVDcpYddBlTaRaURFM2M7mLKUcuzkotrQSn0yjJ5mZUpWxt6QPnS2ftvgSC/lulbG
         YLvcetTwv/NxcXx5mucuOzu60slNffy2oSY8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BiFn22AYpdyq1F8+psGmnKL37dRHH43ZQzYLxbpkL7EPkZvM3v7btmm1MjPEybgAOf
         GSvwWVmZp4DuT+X+2tT35m4aq+eXyb4Wvdwx+hWvje2fZqrp+zgDLBLx0purk59T1nnE
         fHN/ib+Z2584qEhPRy/s75pRp/f/rcVVvym30=
Received: by 10.181.146.14 with SMTP id y14mr4210816bkn.70.1223885659272;
        Mon, 13 Oct 2008 01:14:19 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm6128723fks.6.2008.10.13.01.14.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:14:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223885554-27718-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98093>

The previous patch has added functions that implement
per-file contents encoding selection logic. This one
modifies core gitk code to use them.

Since diffs usually contain multiple files, which may
have different values of the encoding attribute, they
are initially read as binary, and encoding conversion
is applied to individual lines, based on the active
set of diff headers.

As a side job, this patch also fixes some bugs in
handling of non-ASCII filenames. Core git apparently
supports only locale-encoded filenames, so processing
is done using the system encoding.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/gitk b/gitk
index 8682838..5f35f61 100755
--- a/gitk
+++ b/gitk
@@ -6229,7 +6229,7 @@ proc gettree {id} {
 	    set treepending $id
 	    set treefilelist($id) {}
 	    set treeidlist($id) {}
-	    fconfigure $gtf -blocking 0
+	    fconfigure $gtf -blocking 0 -encoding binary
 	    filerun $gtf [list gettreeline $gtf $id]
 	}
     } else {
@@ -6251,11 +6251,12 @@ proc gettreeline {gtf id} {
 	    set line [string range $line 0 [expr {$i-1}]]
 	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
 	    set sha1 [lindex $line 2]
-	    if {[string index $fname 0] eq "\""} {
-		set fname [lindex $fname 0]
-	    }
 	    lappend treeidlist($id) $sha1
 	}
+	if {[string index $fname 0] eq "\""} {
+	    set fname [lindex $fname 0]
+	}
+	set fname [encoding convertfrom $fname]
 	lappend treefilelist($id) $fname
     }
     if {![eof $gtf]} {
@@ -6296,7 +6297,7 @@ proc showfile {f} {
 	    return
 	}
     }
-    fconfigure $bf -blocking 0
+    fconfigure $bf -blocking 0 -encoding [get_path_encoding $f]
     filerun $bf [list getblobline $bf $diffids]
     $ctext config -state normal
     clear_ctext $commentend
@@ -6334,6 +6335,7 @@ proc mergediff {id} {
     global diffids
     global parents
     global diffcontext
+    global diffencoding
     global limitdiffs vfilelimit curview
 
     set diffmergeid $id
@@ -6347,9 +6349,10 @@ proc mergediff {id} {
 	error_popup "[mc "Error getting merge diffs:"] $err"
 	return
     }
-    fconfigure $mdf -blocking 0
+    fconfigure $mdf -blocking 0 -encoding binary
     set mdifffd($id) $mdf
     set np [llength $parents($curview,$id)]
+    set diffencoding [get_path_encoding {}]
     settabs $np
     filerun $mdf [list getmergediffline $mdf $id $np]
 }
@@ -6357,6 +6360,7 @@ proc mergediff {id} {
 proc getmergediffline {mdf id np} {
     global diffmergeid ctext cflist mergemax
     global difffilestart mdifffd
+    global diffencoding
 
     $ctext conf -state normal
     set nr 0
@@ -6368,18 +6372,22 @@ proc getmergediffline {mdf id np} {
 	}
 	if {[regexp {^diff --cc (.*)} $line match fname]} {
 	    # start of a new file
+	    set fname [encoding convertfrom $fname]
 	    $ctext insert end "\n"
 	    set here [$ctext index "end - 1c"]
 	    lappend difffilestart $here
 	    add_flist [list $fname]
+	    set diffencoding [get_path_encoding $fname]
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
@@ -6514,7 +6522,7 @@ proc gettreediffs {ids} {
 
     set treepending $ids
     set treediff {}
-    fconfigure $gdtf -blocking 0
+    fconfigure $gdtf -blocking 0 -encoding binary
     filerun $gdtf [list gettreediffline $gdtf $ids]
 }
 
@@ -6530,6 +6538,7 @@ proc gettreediffline {gdtf ids} {
 	    if {[string index $file 0] eq "\""} {
 		set file [lindex $file 0]
 	    }
+	    set file [encoding convertfrom $file]
 	    lappend treediff $file
 	}
     }
@@ -6587,6 +6596,7 @@ proc getblobdiffs {ids} {
     global diffcontext
     global ignorespace
     global limitdiffs vfilelimit curview
+    global diffencoding
 
     set cmd [diffcmd $ids "-p -C --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
@@ -6600,7 +6610,8 @@ proc getblobdiffs {ids} {
 	return
     }
     set diffinhdr 0
-    fconfigure $bdf -blocking 0
+    set diffencoding [get_path_encoding {}]
+    fconfigure $bdf -blocking 0 -encoding binary
     set blobdifffd($ids) $bdf
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }
@@ -6634,6 +6645,7 @@ proc getblobdiffline {bdf ids} {
     global diffids blobdifffd ctext curdiffstart
     global diffnexthead diffnextnote difffilestart
     global diffinhdr treediffs
+    global diffencoding
 
     set nr 0
     $ctext conf -state normal
@@ -6671,10 +6683,13 @@ proc getblobdiffline {bdf ids} {
 	    } else {
 		set fname [string range $line 2 [expr {$i - 1}]]
 	    }
+	    set fname [encoding convertfrom $fname]
+	    set diffencoding [get_path_encoding $fname]
 	    makediffhdr $fname $ids
 
 	} elseif {[regexp {^@@ -([0-9]+)(,[0-9]+)? \+([0-9]+)(,[0-9]+)? @@(.*)} \
 		       $line match f1l f1c f2l f2c rest]} {
+	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" hunksep
 	    set diffinhdr 0
 
@@ -6684,6 +6699,7 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
+		set fname [encoding convertfrom $fname]
 		set i [lsearch -exact $treediffs($ids) $fname]
 		if {$i >= 0} {
 		    setinlist difffilestart $i $curdiffstart
@@ -6694,6 +6710,8 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
+		set fname [encoding convertfrom $fname]
+		set diffencoding [get_path_encoding $fname]
 		makediffhdr $fname $ids
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
 		# do nothing
@@ -6705,6 +6723,7 @@ proc getblobdiffline {bdf ids} {
 	    $ctext insert end "$line\n" filesep
 
 	} else {
+	    set line [encoding convertfrom $diffencoding $line]
 	    set x [string range $line 0 0]
 	    if {$x == "-" || $x == "+"} {
 		set tag [expr {$x == "+"}]
-- 
1.6.0.20.g6148bc
