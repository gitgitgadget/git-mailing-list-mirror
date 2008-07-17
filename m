From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add support for packed refs
Date: Thu, 17 Jul 2008 12:01:14 +0200
Message-ID: <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQSG-00072o-Or
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbYGQKKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808AbYGQKKU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:10:20 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47572 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYGQKKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:10:19 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIb-0007y9-TQ; Thu, 17 Jul 2008 12:01:21 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88827>

req_update still parses /refs/heads manually. Replace this by
a call to show-ref.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 git-cvsserver.perl |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b00d1c2..0e4f5f9 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -947,24 +947,17 @@ sub req_update
     # projects (heads in this case) to checkout.
     #
     if ($state->{module} eq '') {
-	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
-	if (!opendir HEADS, $heads_dir) {
-	    print "E [server aborted]: Failed to open directory, "
-	      . "$heads_dir: $!\nerror\n";
-	    return 0;
-	}
-        print "E cvs update: Updating .\n";
-	while (my $head = readdir(HEADS)) {
-	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
-	        print "E cvs update: New directory `$head'\n";
-	    }
-	}
-	closedir HEADS;
-	print "ok\n";
-	return 1;
+        my $showref = `git show-ref --heads`;
+        for my $line (split '\n', $showref) {
+            if ( $line =~ m% refs/heads/(.*)$% ) {
+                print "M $1\t$1\n";
+            }
+        }
+        closedir HEADS;
+        print "ok\n";
+        return 1;
     }
 
-
     # Grab a handle to the SQLite db and do any necessary updates
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
 
-- 
1.5.6.2
