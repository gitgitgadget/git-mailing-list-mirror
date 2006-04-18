From: Jim Radford <radford@blackbean.org>
Subject: [RESEND] [PATCH] fix gitk with lots of tags
Date: Tue, 18 Apr 2006 11:06:14 -0700
Message-ID: <20060418180614.GA31543@blackbean.org>
References: <20060406203637.GA15009@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 18 20:06:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVub9-0007yT-Qs
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWDRSGi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWDRSGi
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:06:38 -0400
Received: from cpe-67-49-92-118.socal.res.rr.com ([67.49.92.118]:52623 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S932183AbWDRSGi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:06:38 -0400
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.6/8.13.4) with ESMTP id k3II6FoC032592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Apr 2006 11:06:15 -0700
Received: (from jim@localhost)
	by home.blackbean.org (8.13.6/8.13.6/Submit) id k3II6Elc032589;
	Tue, 18 Apr 2006 11:06:14 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060406203637.GA15009@blackbean.org>
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on home.blackbean.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18862>

Hi Junio,

I've gotten no reposnse from Paul on this patch[1].  If it seems ok to
you, would you mind putting it in your queue for him?  I hate to see
gitk die with "argument list too long" messages.  They're so 640k.

Thanks,
-Jim

[1] Maybe he judges people by the color of their IP address?
    Then again, he could just be busy.

---

This fix allow gitk to be used on repositories with lots of tags.  It
bypasses git-rev-parse and passes its arguments to git-rev-list
directly to avoid tcl's argument list length restrictions.

Signed-Off-By: Jim Radford <radford@blackbean.org>

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
