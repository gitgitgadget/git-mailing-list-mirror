From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add cvs co -c support
Date: Thu, 17 Jul 2008 12:01:16 +0200
Message-ID: <1216288877-12140-5-git-send-email-lars@public.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQS0-0006wH-Lu
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbYGQKKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755744AbYGQKKH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:10:07 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47446 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYGQKKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:10:04 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIc-0007y9-4b; Thu, 17 Jul 2008 12:01:22 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88825>

Implement cvs checkout's -c option by returning a list of all "modules".
This is more useful than displaying a perl warning if -c is given.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 git-cvsserver.perl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 0e4f5f9..afd9789 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -801,6 +801,19 @@ sub req_co
 
     argsplit("co");
 
+    # Provide list of modules, if -c was used.
+    if (exists $state->{opt}{c}) {
+        my $showref = `git show-ref --heads`;
+        for my $line (split '\n', $showref) {
+            if ( $line =~ m% refs/heads/(.*)$% ) {
+                print "M $1\t$1\n";
+            }
+        }
+        closedir HEADS;
+        print "ok\n";
+        return 1;
+    }
+
     my $module = $state->{args}[0];
     $state->{module} = $module;
     my $checkout_path = $module;
-- 
1.5.6.2
