From: ericc <eric.chamberland@giref.ulaval.ca>
Subject: [PATCH] Make 'cvs -n commit ...' not to commit
Date: Thu, 22 Mar 2012 16:57:43 -0400
Message-ID: <20120323131100.7262D440B33@melkor.giref.ulaval.ca>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Fri Mar 23 14:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB4NX-0003yG-Hj
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 14:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2CWNR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 09:17:59 -0400
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:44451 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2CWNR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 09:17:58 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 09:17:58 EDT
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 90E771021A8
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 09:11:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XkVRIUce6+Lg for <git@vger.kernel.org>;
	Fri, 23 Mar 2012 09:11:00 -0400 (EDT)
Received: from melkor.giref.ulaval.ca (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 756D3102193
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 09:11:00 -0400 (EDT)
Received: by melkor.giref.ulaval.ca (Postfix, from userid 20103)
	id 7262D440B33; Fri, 23 Mar 2012 09:11:00 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193760>

Actually, doing a 'cvs -n commit' will _do_ the commit...
With this patch, it now goes through the code, but don't do the commit.
A further progress would be to do the pre-commit hook is possible...

Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
---
 git-cvsserver.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b8eddab..67ec4d0 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1395,6 +1395,9 @@ sub req_ci
         push @committedfiles, $committedfile;
         $log->info("Committing $filename");
 
+        # Don't want to actually _DO_ the update if -n specified
+        unless ( $state->{globaloptions}{-n} ) 
+        {
         system("mkdir","-p",$dirpart) unless ( -d $dirpart );
 
         unless ( $rmflag )
@@ -1424,6 +1427,7 @@ sub req_ci
             $log->info("Updating file '$filename'");
             system("git", "update-index", $filename);
         }
+        }
     }
 
     unless ( scalar(@committedfiles) > 0 )
@@ -1434,6 +1438,9 @@ sub req_ci
         return;
     }
 
+    # Don't want to actually _DO_ the update if -n specified
+    unless ( $state->{globaloptions}{-n} ) 
+    {
     my $treehash = `git write-tree`;
     chomp $treehash;
 
@@ -1537,7 +1544,7 @@ sub req_ci
             print "/$filepart/1.$meta->{revision}//$kopts/\n";
         }
     }
-
+    }
     cleanupWorkTree();
     print "ok\n";
 }
-- 
1.7.3.4
