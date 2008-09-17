From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 8/8] gitk: Support filenames in the locale encoding.
Date: Thu, 18 Sep 2008 01:07:39 +0400
Message-ID: <1221685659-476-9-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
 <1221685659-476-5-git-send-email-angavrilov@gmail.com>
 <1221685659-476-6-git-send-email-angavrilov@gmail.com>
 <1221685659-476-7-git-send-email-angavrilov@gmail.com>
 <1221685659-476-8-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IX-0003an-GL
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbYIQVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbYIQVJW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:50446 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbYIQVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125259fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hYhQDMb+EWNRRsAdTwwUpwbvIuzRQM1QOwkAPI0GfpI=;
        b=rUsU7vNcpFFUz7rCk1hIKWW42xi7wME6mkySxZFIDN6sEXQWRvf1+Kyd0VFusjRn3V
         5LtW5CsG5CKUY0ZHtPZ4KMJ7RO+MVUClfJoEuCWUpbGH9eWdtyvFAMEbHEocK1hek5ke
         OZOI4JeoRtRh4jGUNEKoRfTynaxfcRTy6teds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ohx40u3uHiD2N36rmvfZAutuFmrmKEuLhI4Pex3QP8SNG42f/+VwYJFxi0uLlVoOv3
         8rwucLIVRaJF8PZdcWzL2uwLRbpSnKz5FES4USfXhHzS1oykKC9YayNdXSCOIJ0nqmoi
         mPXR5hBKTVSpk6d7WSTeLrJ8F02e9gnM/emEc=
Received: by 10.180.220.5 with SMTP id s5mr2355786bkg.5.1221685744297;
        Wed, 17 Sep 2008 14:09:04 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.09.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:09:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-8-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96139>

Ensure that gitk works properly with non-ASCII names
in the system encoding. Apparently git does not support
using file names encoded differently from the current
locale.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 98923e7..254faa1 100755
--- a/gitk
+++ b/gitk
@@ -6228,7 +6228,7 @@ proc gettree {id} {
 	    set treepending $id
 	    set treefilelist($id) {}
 	    set treeidlist($id) {}
-	    fconfigure $gtf -blocking 0
+	    fconfigure $gtf -blocking 0 -encoding binary
 	    filerun $gtf [list gettreeline $gtf $id]
 	}
     } else {
@@ -6250,11 +6250,12 @@ proc gettreeline {gtf id} {
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
@@ -6370,6 +6371,7 @@ proc getmergediffline {mdf id np} {
 	}
 	if {[regexp {^diff --cc (.*)} $line match fname]} {
 	    # start of a new file
+	    set fname [encoding convertfrom $fname]
 	    $ctext insert end "\n"
 	    set here [$ctext index "end - 1c"]
 	    lappend difffilestart $here
@@ -6519,7 +6521,7 @@ proc gettreediffs {ids} {
 
     set treepending $ids
     set treediff {}
-    fconfigure $gdtf -blocking 0
+    fconfigure $gdtf -blocking 0 -encoding binary
     filerun $gdtf [list gettreediffline $gdtf $ids]
 }
 
@@ -6535,6 +6537,7 @@ proc gettreediffline {gdtf ids} {
 	    if {[string index $file 0] eq "\""} {
 		set file [lindex $file 0]
 	    }
+	    set file [encoding convertfrom $file]
 	    lappend treediff $file
 	}
     }
@@ -6679,6 +6682,7 @@ proc getblobdiffline {bdf ids} {
 	    } else {
 		set fname [string range $line 2 [expr {$i - 1}]]
 	    }
+	    set fname [encoding convertfrom $fname]
 	    set diffencoding [get_cached_encoding $fname]
 	    makediffhdr $fname $ids
 
@@ -6694,6 +6698,7 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
+		set fname [encoding convertfrom $fname]
 		set i [lsearch -exact $treediffs($ids) $fname]
 		if {$i >= 0} {
 		    setinlist difffilestart $i $curdiffstart
@@ -6704,6 +6709,7 @@ proc getblobdiffline {bdf ids} {
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
+		set fname [encoding convertfrom $fname]
 		set diffencoding [get_cached_encoding $fname]
 		makediffhdr $fname $ids
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
-- 
1.6.0.20.g6148bc
