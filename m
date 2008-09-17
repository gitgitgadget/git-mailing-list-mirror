From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 7/8] gitk: Implement file contents encoding support.
Date: Thu, 18 Sep 2008 01:07:38 +0400
Message-ID: <1221685659-476-8-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
 <1221685659-476-5-git-send-email-angavrilov@gmail.com>
 <1221685659-476-6-git-send-email-angavrilov@gmail.com>
 <1221685659-476-7-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IW-0003an-OQ
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbYIQVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYIQVJT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:50439 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbYIQVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125256fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/+WMlGEDXejYwnV47KLa8kz+gizx59TrLAY2qG/46II=;
        b=K+63NKz0BsyHimq6BO7DrQ8na39phviXRk2M/hWKvOe3r3+SIuqr9qE6rCjT22eYMa
         2oJlCiq5N4udYlSjNhWGPx23aLxZ8aYPE+NOhi17yjXloKa1f+z4MgyELq/5I5Hr+ih+
         lp54e062b7GlJs0ozYA4z7tREx7Ea0dvQupCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Syn6HBPG9rj0g2Oh5tvnuyFy9qKXW6xeCB2Sjy8zB7+/IOJQeASz9SDqGF3Ij7mWKw
         Qvr7+704SGvL6s5sz1wb3F+ZlfGq//MNwJJAIsPWDEzy0Ao4AsAjs6Y+WNZ8Y//O2Fyr
         oTl7G3ds3duAJ7ZmzXHDmrWQtsj/v5DNP9r5w=
Received: by 10.180.232.9 with SMTP id e9mr2325567bkh.63.1221685743319;
        Wed, 17 Sep 2008 14:09:03 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.09.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:09:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-7-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96144>

Use new functions to support using explicit encoding
configuration for file contents.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
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
