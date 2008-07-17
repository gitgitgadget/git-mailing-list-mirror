From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add cvs co -c support
Date: Thu, 17 Jul 2008 19:00:29 +0200
Message-ID: <1216314030-10887-5-git-send-email-lars@public.noschinski.de>
References: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-2-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-3-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-4-git-send-email-lars@public.noschinski.de>
Cc: lars@public.noschinski.de, fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWri-0000Xh-2D
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbYGQRAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbYGQRAq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:00:46 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59540 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbYGQRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:00:38 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJWqK-0007Q9-MJ; Thu, 17 Jul 2008 19:00:36 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216314030-10887-4-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88884>

Implement cvs checkout's -c option by returning a list of all "modules".
This is more useful than displaying a perl warning if -c is given.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 git-cvsserver.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 66aebf8..064952e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -801,6 +801,18 @@ sub req_co
 
     argsplit("co");
 
+    # Provide list of modules, if -c was used.
+    if (exists $state->{opt}{c}) {
+        my $showref = `git show-ref --heads`;
+        for my $line (split '\n', $showref) {
+            if ( $line =~ m% refs/heads/(.*)$% ) {
+                print "M $1\t$1\n";
+            }
+        }
+        print "ok\n";
+        return 1;
+    }
+
     my $module = $state->{args}[0];
     $state->{module} = $module;
     my $checkout_path = $module;
-- 
1.5.6.2
