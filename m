From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] gitk: handle --full-diff correctly
Date: Thu, 25 Oct 2012 19:23:21 +0200
Message-ID: <1351185801-18543-3-git-send-email-felipe.contreras@gmail.com>
References: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 19:24:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRRA6-0004b6-VO
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 19:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935956Ab2JYRXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 13:23:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36516 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935912Ab2JYRXy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 13:23:54 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1890910wib.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=00giUUSGs7M84CsOnvsdhdmS7EOjdRGtjwVnq0gXB6g=;
        b=1IUy0YUQjq3EFbAVZDnT2lnd/yosWNHfEYh2D36vT9rfTiwYKeaZk9qXC7Kspjy/lZ
         cwkW3mu/2i8T7ZSSYIp/ck0A7bp9e4whA9m0RmQnfXYnMmjhCz8N9StTDWjLygmZNe5r
         /CIfaaRx/u6vZytMBDiveYbI/ydVEYLnoDZbDM3GzEA1zFQ+FjrTUzEW96oiAV+Ppgjq
         5gY0zURpFFUuoYESmBug7ea9xMyFMA6WPHyQ4An0I+1av0PsL1c1V3nTTcUM8W/FgccO
         ly2Pck/oiEn92gaxXEb6s6CDgOaMij0G/fOWgAtYERa+KriP+0rXhGjnib8y0r8+NbYh
         r0AQ==
Received: by 10.180.77.38 with SMTP id p6mr15388649wiw.1.1351185833911;
        Thu, 25 Oct 2012 10:23:53 -0700 (PDT)
Received: from localhost (ip-109-43-0-94.web.vodafone.de. [109.43.0.94])
        by mx.google.com with ESMTPS id m14sm10858522wie.8.2012.10.25.10.23.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 10:23:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208413>

Otherwise the files are missing from the diff, and the list of files.

We do this by creating a limitdiffs variable specific for the view which
can be turned of by using --full-diff.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk-git/gitk | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b79dfdf..4ffabdf 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -155,11 +155,12 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
-    global worddiff git_version
+    global vdatemode vmergeonly vlimitdiffs vflags vdflags vrevs vfiltered vorigargs env
+    global limitdiffs worddiff git_version
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
+    set vlimitdiffs($n) $limitdiffs
     set glflags {}
     set diffargs {}
     set nextisval 0
@@ -187,7 +188,7 @@ proc parseviewargs {n arglist} {
 	    "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
 	    "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
 	    "--src-prefix=*" - "--dst-prefix=*" - "--no-prefix" -
-	    "-O*" - "--text" - "--full-diff" - "--ignore-space-at-eol" -
+	    "-O*" - "--text" - "--ignore-space-at-eol" -
 	    "--ignore-space-change" - "-U*" - "--unified=*" {
 		# These request or affect diff output, which we don't want.
 		# Some could be used to set our defaults for diff display.
@@ -251,6 +252,9 @@ proc parseviewargs {n arglist} {
 	    "--no-replace-objects" {
 		set env(GIT_NO_REPLACE_OBJECTS) "1"
 	    }
+	    "--full-diff" {
+		set vlimitdiffs($n) 0
+	    }
 	    "-*" {
 		# Other flag arguments including -<n>
 		if {[string is digit -strict [string range $arg 1 end]]} {
@@ -7519,10 +7523,10 @@ proc diffcmd {ids flags} {
 }
 
 proc gettreediffs {ids} {
-    global treediff treepending limitdiffs vfilelimit curview
+    global treediff treepending vlimitdiffs vfilelimit curview
 
     set cmd [diffcmd $ids {--no-commit-id}]
-    if {$limitdiffs && $vfilelimit($curview) ne {}} {
+    if {$vlimitdiffs($curview) && $vfilelimit($curview) ne {}} {
 	    set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set gdtf [open $cmd r]}]} return
@@ -7535,7 +7539,7 @@ proc gettreediffs {ids} {
 
 proc gettreediffline {gdtf ids} {
     global treediff treediffs treepending diffids diffmergeid
-    global cmitmode vfilelimit curview limitdiffs perfile_attrs
+    global cmitmode vfilelimit curview perfile_attrs
 
     set nr 0
     set sublist {}
@@ -7613,7 +7617,7 @@ proc getblobdiffs {ids} {
     global diffcontext
     global ignorespace
     global worddiff
-    global limitdiffs vfilelimit curview
+    global vlimitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
     global git_version currdiffsubmod
 
@@ -7632,7 +7636,7 @@ proc getblobdiffs {ids} {
     if {$worddiff ne [mc "Line diff"]} {
 	append cmd " --word-diff=porcelain"
     }
-    if {$limitdiffs && $vfilelimit($curview) ne {}} {
+    if {$vlimitdiffs($curview) && $vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set bdf [open $cmd r]} err]} {
-- 
1.8.0
