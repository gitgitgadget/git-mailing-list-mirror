From: Jim Radford <radford@blackbean.org>
Subject: [PATCH] fix gitk with lots of tags
Date: Thu, 6 Apr 2006 13:36:37 -0700
Message-ID: <20060406203637.GA15009@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 22:37:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRbEC-0001eG-KG
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 22:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDFUhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWDFUhH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 16:37:07 -0400
Received: from cpe-67-49-92-118.socal.res.rr.com ([67.49.92.118]:41914 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S1751273AbWDFUhF
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 16:37:05 -0400
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.6/8.13.4) with ESMTP id k36KacVI015081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Apr 2006 13:36:38 -0700
Received: (from jim@localhost)
	by home.blackbean.org (8.13.6/8.13.6/Submit) id k36Kab3d015078;
	Thu, 6 Apr 2006 13:36:37 -0700
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on home.blackbean.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18480>

Hi Paul,

This fix allow gitk to be used on repositories with lots of tags.  It
bypasses git-rev-parse and passes its arguments to git-rev-list
directly to avoid the command line length restrictions.

Signed-Off-By: Jim Radford <radford@blackbean.org>

-Jim

---
diff --git a/gitk b/gitk
index 26fa79a..40672fb 100755
--- a/gitk
+++ b/gitk
@@ -17,19 +17,11 @@ proc gitdir {} {
 }
 
 proc parse_args {rargs} {
-    global parsed_args
-
-    if {[catch {
-	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
-    }]} {
-	# if git-rev-parse failed for some reason...
-	if {$rargs == {}} {
-	    set rargs HEAD
-	}
-	set parsed_args $rargs
+    if {$rargs == {}} {
+        return HEAD
+    } else {
+	return $rargs
     }
-    return $parsed_args
 }
 
 proc start_rev_list {rlargs} {
