From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] gitk: simplify file filtering
Date: Sat, 27 Apr 2013 17:01:39 -0500
Message-ID: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 00:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWDCx-00079y-5X
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 00:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab3D0WC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 18:02:58 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42585 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab3D0WC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 18:02:58 -0400
Received: by mail-ob0-f182.google.com with SMTP id dn14so4534166obc.13
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=MZcVzBFXy0laWEqA2p36bF9UHrDyhuCBHCwHooJ/0Xw=;
        b=bLs/F6oWUqXpZUJonHg4WX/uKUdM2tRMC9pv6E/MsUNwo3VuQSjmTAmK4izUqZbFDU
         cT+59Al6erTfGrk6H6MjKAR+j4i++aLoyTL6XANDkedV5ZXUtsAnvss9/b3+iPnugtn7
         JuSKa3p9Gr1kXS6xm1vGO9ZC5NcbC+1dqnmtgZ62CSzT4R/qdYnb8S6zTrAkjJJDEHLE
         OdKDnjobdLrAXG/x+n8necKVEvgqOIf0RriXAeBNQm8/Beat1FrIeG9q0nupiFPnGcDQ
         6GrVPJEH47hNKMy2j6a4K9yUUYeDv/5SzyEKAULZ5/VqarydgFqR1LVmY0Xvk3XBBj5p
         RFSQ==
X-Received: by 10.60.94.9 with SMTP id cy9mr20743179oeb.58.1367100177607;
        Sat, 27 Apr 2013 15:02:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm14155762oeb.4.2013.04.27.15.02.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 15:02:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222709>

git diff is perfectly able to do this with '-- files', no need for
manual filtering.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk-git/gitk | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b3706fc..0863877 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7571,9 +7571,13 @@ proc diffcmd {ids flags} {
 }
 
 proc gettreediffs {ids} {
-    global treediff treepending
+    global treediff treepending limitdiffs vfilelimit curview
 
-    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
+    set cmd [diffcmd $ids {--no-commit-id}]
+    if {$limitdiffs && $vfilelimit($curview) ne {}} {
+	    set cmd [concat $cmd -- $vfilelimit($curview)]
+    }
+    if {[catch {set gdtf [open $cmd r]}]} return
 
     set treepending $ids
     set treediff {}
@@ -7617,17 +7621,7 @@ proc gettreediffline {gdtf ids} {
 	return [expr {$nr >= $max? 2: 1}]
     }
     close $gdtf
-    if {$limitdiffs && $vfilelimit($curview) ne {}} {
-	set flist {}
-	foreach f $treediff {
-	    if {[path_filter $vfilelimit($curview) $f]} {
-		lappend flist $f
-	    }
-	}
-	set treediffs($ids) $flist
-    } else {
-	set treediffs($ids) $treediff
-    }
+    set treediffs($ids) $treediff
     unset treepending
     if {$cmitmode eq "tree" && [llength $diffids] == 1} {
 	gettree $diffids
-- 
1.8.2.1.1031.g2ee5873
