From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] archimport: remove files from the index before adding/updating
Date: Sat, 18 Feb 2006 03:49:38 -0800
Message-ID: <20060218114628.GA24678@BL4ST>
References: <11402390872301-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 18 12:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAQau-0002oF-Vb
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 12:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBRLtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 06:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWBRLtk
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 06:49:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61862 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751106AbWBRLtk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 06:49:40 -0500
Received: from mayonaise.dyndns.org (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 48E2C2DC01A;
	Sat, 18 Feb 2006 03:49:38 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 18 Feb 2006 03:49:38 -0800
To: git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
In-Reply-To: <11402390872301-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16408>

This fixes a bug when importing where a directory gets removed/renamed
but is immediately replaced by a file of the same name in the same
changeset.

This fix only applies to the accurate (default) strategy the moment.

This patch should also fix the fast strategy if/when it is updated
to handle the cases that would've triggered this bug.

This bug was originally found in git-svn, but I remembered I did the
same thing with archimport as well.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

011fe464212c52d46ad5b797eb1d8f86c1d77916
diff --git a/git-archimport.perl b/git-archimport.perl
index 841738d..6792624 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -346,12 +346,10 @@ sub process_patchset_accurate {
     } 
     
     # update the index with all the changes we got
+    system('git-diff-files --name-only -z | '.
+            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
     system('git-ls-files --others -z | '.
             'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
-    system('git-ls-files --deleted -z | '.
-            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
-    system('git-ls-files -z | '.
-             'git-update-index -z --stdin') == 0 or die "$! $?\n";
     return 1;
 }
 
@@ -416,22 +414,14 @@ sub process_patchset_fast {
     # imports don't give us good info
     # on added files. Shame on them
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
-        system('git-ls-files --others -z | '.
-                'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
         system('git-ls-files --deleted -z | '.
                 'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
+        system('git-ls-files --others -z | '.
+                'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
     }
 
     # TODO: handle removed_directories and renamed_directories:
-   
-    if (my $add = $ps->{new_files}) {
-        while (@$add) {
-            my @slice = splice(@$add, 0, 100);
-            system('git-update-index','--add','--',@slice) == 0 or
-                            die "Error in git-update-index --add: $! $?\n";
-        }
-    }
-   
+
     if (my $del = $ps->{removed_files}) {
         unlink @$del;
         while (@$del) {
@@ -462,6 +452,14 @@ sub process_patchset_fast {
         }
     }
 
+    if (my $add = $ps->{new_files}) {
+        while (@$add) {
+            my @slice = splice(@$add, 0, 100);
+            system('git-update-index','--add','--',@slice) == 0 or
+                            die "Error in git-update-index --add: $! $?\n";
+        }
+    }
+
     if (my $mod = $ps->{modified_files}) {
         while (@$mod) {
             my @slice = splice(@$mod, 0, 100);
-- 
1.2.1.gffaf
