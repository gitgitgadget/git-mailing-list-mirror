From: Michael Witten <mfwitten@mit.edu>
Subject: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 23 Nov 2007 04:12:54 -0500
Message-ID: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
Cc: Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 23 10:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvV8Y-0002hi-Gt
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXKWJrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 04:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXKWJrb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:47:31 -0500
Received: from MACGREGOR-TWO-FORTY.MIT.EDU ([18.239.5.240]:51194 "EHLO
	macgregor-two-forty.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755857AbXKWJr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 04:47:29 -0500
X-Greylist: delayed 2076 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2007 04:47:29 EST
Received: by macgregor-two-forty.mit.edu (Postfix, from userid 501)
	id 9C2E12BC533; Fri, 23 Nov 2007 04:12:54 -0500 (EST)
X-Mailer: git-send-email 1.5.3.5.1623.g37154
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65884>

git-cvsserver just did the following:
    (1) run hooks/update
    (2) commit if hooks/update passed

This commit simply adds:
    (3) run hooks/post-receive

Also, there are a few grammar cleanups and
consistency improvements.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-cvsserver.perl |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 0d55fec..8d4d735 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1211,13 +1211,13 @@ sub req_ci
 
     chdir $tmpdir;
 
-    # populate the temporary index based
+    # populate the temporary index
     system("git-read-tree", $parenthash);
     unless ($? == 0)
     {
 	die "Error running git-read-tree $state->{module} $file_index $!";
     }
-    $log->info("Created index '$file_index' with for head $state->{module} - exit status $?");
+    $log->info("Created index '$file_index' for head $state->{module} - exit status $?");
 
     my @committedfiles = ();
     my %oldmeta;
@@ -1237,7 +1237,7 @@ sub req_ci
 
         my ( $filepart, $dirpart ) = filenamesplit($filename);
 
-        # do a checkout of the file if it part of this tree
+        # do a checkout of the file if it is part of this tree
         if ($wrev) {
             system('git-checkout-index', '-f', '-u', $filename);
             unless ($? == 0) {
@@ -1324,11 +1324,11 @@ sub req_ci
         exit;
     }
 
-	# Check that this is allowed, just as we would with a receive-pack
-	my @cmd = ( $ENV{GIT_DIR}.'hooks/update', "refs/heads/$state->{module}",
+	### Emulate git-receive-pack by running hooks/update
+	my @hook = ( $ENV{GIT_DIR}.'hooks/update', "refs/heads/$state->{module}",
 			$parenthash, $commithash );
-	if( -x $cmd[0] ) {
-		unless( system( @cmd ) == 0 )
+	if( -x $hook[0] ) {
+		unless( system( @hook ) == 0 )
 		{
 			$log->warn("Commit failed (update hook declined to update ref)");
 			print "error 1 Commit failed (update hook declined)\n";
@@ -1337,6 +1337,7 @@ sub req_ci
 		}
 	}
 
+	### Update the ref
 	if (system(qw(git update-ref -m), "cvsserver ci",
 			"refs/heads/$state->{module}", $commithash, $parenthash)) {
 		$log->warn("update-ref for $state->{module} failed.");
@@ -1344,6 +1345,18 @@ sub req_ci
 		exit;
 	}
 
+	### Emulate git-receive-pack by running hooks/post-receive
+	my $hook = $ENV{GIT_DIR}.'hooks/post-receive';
+	if( -x $hook ) {
+		open(my $pipe, "| $hook") || die "can't fork $!";
+
+		local $SIG{PIPE} = sub { die 'pipe broke' };
+
+		print $pipe "$parenthash $commithash refs/heads/$state->{module}\n";
+
+		close $pipe || die "bad pipe: $! $?";
+	}
+
     $updater->update();
 
     # foreach file specified on the command line ...
-- 
1.5.3.5.1623.g37154
