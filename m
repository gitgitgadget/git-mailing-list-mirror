From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: Alter the ordering for the "Tags and heads" view
Date: Tue,  2 Jun 2015 07:11:10 -0400
Message-ID: <1433243470-93392-2-git-send-email-rappazzo@gmail.com>
References: <1433243470-93392-1-git-send-email-rappazzo@gmail.com>
Cc: paulus@samba.org, Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 13:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzk6T-0007D4-2L
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbFBLLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 07:11:24 -0400
Received: from mail-vn0-f46.google.com ([209.85.216.46]:42127 "EHLO
	mail-vn0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbbFBLLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:11:23 -0400
Received: by vnbg129 with SMTP id g129so19853783vnb.9
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7ceqGMvFcp+bpx4jHdy1TJwMdkQhEjbcQ1WaASlPho=;
        b=B0ddmhSvhxKRzx/Fjy/NzgMcWcgKG+y3k/Fb7b4zNzTa5NWOae0SXqPRXeSFThl07N
         l7TgV03+RMMqjfbAi4glVLb90XDu2kAEZWcNIxlliC7R02UtMvIofu/jZn2pFVO2G24f
         k4DxtaqTZGdLJJ5FRj+nJcsL/rtA/7uG/rm+/T0kzQghgrP0bCFa+8A+t6DafaEXRg6W
         uxdDCMrQU/GkZaZLG5RsSZBLXhjAahXccwxN7muJL19fnVTkSEdP47VRayBnxCQNR6zd
         wCiX1Z5HrqQdvz51Fl/u9OCZjPCnyoj/V77STBU8/AlJ4XqZOcmLmX8mRFCcPTjU6a20
         z6xA==
X-Received: by 10.52.142.49 with SMTP id rt17mr13991756vdb.50.1433243480348;
        Tue, 02 Jun 2015 04:11:20 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id hq1sm26403056vdb.24.2015.06.02.04.11.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 04:11:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433243470-93392-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270520>

In the "Tags and heads" view, the list of refs is globally sorted.
The list of local refs (heads) is separated by the remote refs.  This
change re-orders the view toi be: local refs, remote refs tracked by
local refs, remote refs, tags, and then other refs

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk-git/gitk | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..431a6a1 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9879,35 +9879,71 @@ proc refill_reflist {} {
     global curview
 
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
-    set refs {}
+    set localrefs {}
+    set remoterefs {}
+    set locally_tracked_remote_refs {}
+    set tagrefs {}
+    set otherrefs {}
     foreach n [array names headids] {
-	if {[string match $reflistfilter $n]} {
+	if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
+	    if {[commitinview $headids($n) $curview]} {
+		lappend localrefs [list $n H]
+		catch {set remote_name [exec git config --get branch.$n.remote]}
+		if {$remote_name ne ""} {
+		    catch {set remote_ref [exec git config --get branch.$n.merge]}
+		    set remote_ref [string map {"refs/heads/" ""} $remote_ref]
+		    set locally_tracked_remote_ref "remotes/$remote_name/$remote_ref"
+		    catch {set exists [exec git rev-parse --verify $locally_tracked_remote_ref]}
+		    if {$exists ne ""} {
+			if {[lsearch $locally_tracked_remote_refs [list $locally_tracked_remote_ref H]] < 0} {
+			    lappend locally_tracked_remote_refs [list $locally_tracked_remote_ref H]
+			}
+		    }
+		    set exists ""
+		}
+	    } else {
+    		interestedin $headids($n) {run refill_reflist}
+	    }
+	}
+    }
+    set locally_tracked_remote_refs [lsort -index 0 $locally_tracked_remote_refs]
+    set localrefs [lsort -index 0 $localrefs]
+       
+    foreach n [array names headids] {
+	if {[string match "remotes/*" $n] && [string match $reflistfilter $n]} {
 	    if {[commitinview $headids($n) $curview]} {
-		lappend refs [list $n H]
+		if {[lsearch $locally_tracked_remote_refs [list $n H]] < 0} {
+		    lappend remoterefs [list $n H]
+        	}
 	    } else {
 		interestedin $headids($n) {run refill_reflist}
 	    }
 	}
     }
+    set remoterefs [lsort -index 0 $remoterefs]
+
     foreach n [array names tagids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $tagids($n) $curview]} {
-		lappend refs [list $n T]
+		lappend tagrefs [list $n T]
 	    } else {
 		interestedin $tagids($n) {run refill_reflist}
 	    }
 	}
     }
+    set tagrefs [lsort -index 0 $tagrefs]
+
     foreach n [array names otherrefids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $otherrefids($n) $curview]} {
-		lappend refs [list $n o]
+		lappend otherrefs [list "$n" o]
 	    } else {
 		interestedin $otherrefids($n) {run refill_reflist}
 	    }
 	}
     }
-    set refs [lsort -index 0 $refs]
+    set otherrefs [lsort -index 0 $otherrefs]
+    lappend refs {*}$localrefs {*}$locally_tracked_remote_refs {*}$remoterefs {*}$tagrefs {*}$otherrefs
     if {$refs eq $reflist} return
 
     # Update the contents of $showrefstop.list according to the
-- 
2.4.2
