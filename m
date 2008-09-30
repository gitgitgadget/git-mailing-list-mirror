From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2 3/4] gitk: Support filenames in the locale encoding.
Date: Tue, 30 Sep 2008 15:00:21 +0400
Message-ID: <1222772422-28020-4-git-send-email-angavrilov@gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
 <1222772422-28020-3-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 13:03:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd0k-0000DF-HM
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYI3LCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYI3LCH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:02:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:61682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYI3LCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:02:04 -0400
Received: by ug-out-1314.google.com with SMTP id k3so544011ugf.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OWCK3qPzFe7ytjdms9blgtU1xDyr9yZht6tmPoES//o=;
        b=QIDYyxUncLZQdk/3hDi4T+Tqm3oY9kTFMzwl9L+QQq9XRA3pJL8gIC/maw6Qj2HJDt
         vPaFJNZcteiwrAZjZ5QwH12FJzJAZdPLuzLmLBPr3Hyt6Xc3v0dK0Z51fMSXSZgcNSG1
         3I/hMAsmFTIw9NLjAJL/Deetx04bdWVKBYc1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sbk7UaVBOQK2bZ8/pQ4JLYRmIn485i/nRtqwC8H52QU28Ev0P8CoEkGU2Z5FsxFd1h
         z5eLYnryXvIuFRFv9WB47ShuZWkv5PEnhioRwKrnnt4o36dRKVYzJQFHXt1DFC9k/uLP
         2hpmmOADmqZvpMC7NQJAObLwqZiZaTnIqfWhI=
Received: by 10.103.11.7 with SMTP id o7mr4686921mui.103.1222772522256;
        Tue, 30 Sep 2008 04:02:02 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id y6sm7517378mug.7.2008.09.30.04.02.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:02:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1222772422-28020-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97098>

The previous patch changed the encoding used for
reading diffs to binary, which broke non-ASCII filename
support. This one fixes the breakage, together with some
existing bugs related to filename encoding.

Since core git apparently assumes that filenames are
specified in the locale encoding, this is what we should
use for them in gitk as well.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
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
