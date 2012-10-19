From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] gitk: simplify file filtering
Date: Fri, 19 Oct 2012 12:56:52 +0200
Message-ID: <1350644213-4882-2-git-send-email-felipe.contreras@gmail.com>
References: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 12:57:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPAGT-0006KT-P6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 12:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794Ab2JSK5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 06:57:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39447 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab2JSK5F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 06:57:05 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so154468bkc.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=krSlPCphWHLrCgp7XCF1S2crb282gh1u4ckElFCADow=;
        b=M3usQMaO+MMXURd0kmVOx5oEKE8m6H6ZnFW49i36HwcQRpEdHclWRoKMFenSuEbw3m
         41AhOmoy6ycD7Idp7yZ+VyFd/y9LUcopyF5ZM61Ro8OGVM5LDOQ+HoNZfkv07ebZeDRe
         bHuGWKFecJ53R9U2OSsqJTbys4AXyqKLPLYlH4r4I/RbSo8Av4EFqu0++Um21Lpe0OXk
         2fu6FWZP0DrsoG85y/pdTslFpysPkjh5YhK63xTNgDT4D2COs8S16LMBB245ga1y7Ias
         W6XNRTF7yIqkXdoK2SI1IhvzTf2VrBOmsNOgbTapXQq84aFN/ni2uLo+KhlLord3k8qX
         iObQ==
Received: by 10.204.151.26 with SMTP id a26mr262875bkw.43.1350644224515;
        Fri, 19 Oct 2012 03:57:04 -0700 (PDT)
Received: from localhost (ip-109-43-0-103.web.vodafone.de. [109.43.0.103])
        by mx.google.com with ESMTPS id s20sm683863bkw.15.2012.10.19.03.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 03:57:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208043>

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
1.8.0.rc2.7.g0961fdf.dirty
