From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] gitk: handle --full-diff correctly
Date: Fri, 19 Oct 2012 12:56:53 +0200
Message-ID: <1350644213-4882-3-git-send-email-felipe.contreras@gmail.com>
References: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 12:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPAGb-0006MR-HS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 12:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899Ab2JSK5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 06:57:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39447 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814Ab2JSK5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 06:57:09 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so154468bkc.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G8YYIoJZd4zAm3/Oost623az+MetVTqH0aFZoY6gaEQ=;
        b=rMpTzhdv0l+4ffheJKsGg1bvU74IaS2GJNZDVfJV6HA+Gfh3+jb2hLtJShdzSKXo7F
         P3NGRzmGKOY1Zs0G0Rl+VxDsIJl5khS/hZsGVnFyf9NcdOZKinH6LSzGP8MpAXluJFSv
         gbH/evx3XvrW5Ja3yS3vYq4I5kLcu9i8vhCG/j9cxij1InBcT2nGTKIQdBF4k0EYP9sT
         xawClgAyiDEwQj974/+QjRVGT/++f00M3BRfOlvRLvfEA0aaORpQc9DqRyTThQ2AnMQz
         cuq2ynXoDWa/2bBoXXp3dCtNw1gu2wzFH6xrwIjO0m83Wq6sDGLR5eROfyF4MMHcVZdK
         hxlQ==
Received: by 10.204.156.74 with SMTP id v10mr271354bkw.39.1350644229247;
        Fri, 19 Oct 2012 03:57:09 -0700 (PDT)
Received: from localhost (ip-109-43-0-103.web.vodafone.de. [109.43.0.103])
        by mx.google.com with ESMTPS id ia2sm683617bkc.11.2012.10.19.03.57.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 03:57:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208044>

Otherwise the files are missing from the diff, and the list of files.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk-git/gitk | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b79dfdf..8109eed 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -155,7 +155,7 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs vfileargs env
     global worddiff git_version
 
     set vdatemode($n) 0
@@ -165,6 +165,7 @@ proc parseviewargs {n arglist} {
     set nextisval 0
     set revargs {}
     set origargs $arglist
+    set fileargs {}
     set allknown 1
     set filtered 0
     set i -1
@@ -187,7 +188,7 @@ proc parseviewargs {n arglist} {
 	    "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
 	    "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
 	    "--src-prefix=*" - "--dst-prefix=*" - "--no-prefix" -
-	    "-O*" - "--text" - "--full-diff" - "--ignore-space-at-eol" -
+	    "-O*" - "--text" - "--ignore-space-at-eol" -
 	    "--ignore-space-change" - "-U*" - "--unified=*" {
 		# These request or affect diff output, which we don't want.
 		# Some could be used to set our defaults for diff display.
@@ -233,6 +234,9 @@ proc parseviewargs {n arglist} {
 		set filtered 1
 		lappend glflags $arg
 	    }
+	    "--full-diff" {
+		lappend fileargs $arg
+	    }
 	    "-n" {
 		# This appears to be the only one that has a value as a
 		# separate word following it
@@ -276,6 +280,7 @@ proc parseviewargs {n arglist} {
     set vrevs($n) $revargs
     set vfiltered($n) $filtered
     set vorigargs($n) $origargs
+    set vfileargs($n) $fileargs
     return $allknown
 }
 
@@ -7519,10 +7524,11 @@ proc diffcmd {ids flags} {
 }
 
 proc gettreediffs {ids} {
-    global treediff treepending limitdiffs vfilelimit curview
+    global treediff treepending limitdiffs vfilelimit vfileargs curview
 
     set cmd [diffcmd $ids {--no-commit-id}]
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
+	    set cmd [concat $cmd $vfileargs($curview)]
 	    set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set gdtf [open $cmd r]}]} return
@@ -7613,7 +7619,7 @@ proc getblobdiffs {ids} {
     global diffcontext
     global ignorespace
     global worddiff
-    global limitdiffs vfilelimit curview
+    global limitdiffs vfilelimit vfileargs curview
     global diffencoding targetline diffnparents
     global git_version currdiffsubmod
 
@@ -7633,6 +7639,7 @@ proc getblobdiffs {ids} {
 	append cmd " --word-diff=porcelain"
     }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
+	set cmd [concat $cmd $vfileargs($curview)]
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set bdf [open $cmd r]} err]} {
-- 
1.8.0.rc2.7.g0961fdf.dirty
