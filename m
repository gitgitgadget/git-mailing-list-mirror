From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] gitk: simplify file filtering
Date: Thu, 25 Oct 2012 19:23:20 +0200
Message-ID: <1351185801-18543-2-git-send-email-felipe.contreras@gmail.com>
References: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 19:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRR9r-0004Qs-UL
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 19:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992463Ab2JYRXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 13:23:39 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47413 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946120Ab2JYRXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 13:23:39 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so6228539wib.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hdR1OiHNu1z1GlJt3JdtbCy1qbHHrJFOz99J57VA4+Q=;
        b=akBJaQo1BtTwMMbYr/ZD7CRFdH/U1q58180E/ZFqlLD3MzI0LY+mtV5qk08kxXnw1a
         J137rVJcvyLu3zeKHEH9eRIlf+d6AFjqWpysWkRH7y8vmqcrROLgdGq8j0F6K/TiouX1
         G4/IBCw9e07WthuGHLAOIF7ix0iV7m/ZhcaBbjFhWjox5QEIANa8OiwnSNpHWiGjKSDr
         Pi5NjHCUHRrtZ/O6wySL4C4ZXesqLM8jYuJnhvPjusV8Pf7SfWy3/acpecIt5454GnaH
         LA6diQUDttacubA89aT9foxj3RISCrhPINekSBTFgtAyxWOVulcwx+Msj0MsRFCIIinq
         UeRg==
Received: by 10.180.102.131 with SMTP id fo3mr11989552wib.1.1351185817588;
        Thu, 25 Oct 2012 10:23:37 -0700 (PDT)
Received: from localhost (ip-109-43-0-94.web.vodafone.de. [109.43.0.94])
        by mx.google.com with ESMTPS id ei1sm12283730wid.7.2012.10.25.10.23.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 10:23:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208412>

git diff is perfectly able to do this with '-- files', no need for
manual filtering.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk-git/gitk | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..b79dfdf 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7519,9 +7519,13 @@ proc diffcmd {ids flags} {
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
@@ -7565,17 +7569,7 @@ proc gettreediffline {gdtf ids} {
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
1.8.0
