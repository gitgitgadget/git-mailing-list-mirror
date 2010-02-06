From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat,  6 Feb 2010 00:00:40 -0500
Message-ID: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 06:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndcwp-0000dP-7o
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 06:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751Ab0BFFHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 00:07:42 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:39786 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0BFFHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 00:07:41 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Feb 2010 00:07:41 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D90651FFC1CE; Sat,  6 Feb 2010 05:00:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	by silverinsanity.com (Postfix) with ESMTPA id C8A811FFC06B;
	Sat,  6 Feb 2010 05:00:30 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139145>

Currently gitweb only knows how to check for load using /proc/loadavg,
which isn't available on all systems.  We shouldn't fail the test just
because we don't know how to check the system load.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t9501-gitweb-standalone-http-status.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 7590f10..992d729 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -115,12 +115,19 @@ test_debug 'cat gitweb.output'
 # ----------------------------------------------------------------------
 # load checking
 
+if test -e /proc/loadavg
+then
+	test_set_prereq PROC_LOADAVG
+else
+	say 'skipping load tests (no /proc/loadavg found)'
+fi
+
 # always hit the load limit
 cat >>gitweb_config.perl <<\EOF
 our $maxload = 0;
 EOF
 
-test_expect_success 'load checking: load too high (default action)' '
+test_expect_success PROC_LOADAVG 'load checking: load too high (default action)' '
 	gitweb_run "p=.git" &&
 	grep "Status: 503 Service Unavailable" gitweb.headers &&
 	grep "503 - The load average on the server is too high" gitweb.body
-- 
1.7.0.rc1.141.gd3fd2
