From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add support for packed refs
Date: Thu, 17 Jul 2008 19:00:27 +0200
Message-ID: <1216314030-10887-3-git-send-email-lars@public.noschinski.de>
References: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-2-git-send-email-lars@public.noschinski.de>
Cc: lars@public.noschinski.de, fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWrf-0000Xh-Dm
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbYGQRAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbYGQRAj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:00:39 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59536 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbYGQRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:00:38 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJWqK-0007Q9-Ez; Thu, 17 Jul 2008 19:00:36 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216314030-10887-2-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88882>

req_update still parses /refs/heads manually. Replace this by
a call to show-ref.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 git-cvsserver.perl |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b00d1c2..66aebf8 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -947,21 +947,15 @@ sub req_update
     # projects (heads in this case) to checkout.
     #
     if ($state->{module} eq '') {
-	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
-	if (!opendir HEADS, $heads_dir) {
-	    print "E [server aborted]: Failed to open directory, "
-	      . "$heads_dir: $!\nerror\n";
-	    return 0;
-	}
+        my $showref = `git show-ref --heads`;
         print "E cvs update: Updating .\n";
-	while (my $head = readdir(HEADS)) {
-	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
-	        print "E cvs update: New directory `$head'\n";
-	    }
-	}
-	closedir HEADS;
-	print "ok\n";
-	return 1;
+        for my $line (split '\n', $showref) {
+            if ( $line =~ m% refs/heads/(.*)$% ) {
+                print "E cvs update: New directory `$1'\n";
+            }
+        }
+        print "ok\n";
+        return 1;
     }
 
 
-- 
1.5.6.2
