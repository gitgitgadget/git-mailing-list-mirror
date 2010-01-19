From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 3/3] cvsimport: standarize system() calls to external git tools
Date: Tue, 19 Jan 2010 14:03:10 -0500
Message-ID: <1263927790-1872-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <7v8wbwzgnw.fsf@alter.siamese.dyndns.org>
 <1263927790-1872-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1263927790-1872-2-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 20:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJMr-0001jR-OI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0ASTDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 14:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088Ab0ASTDS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:03:18 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:34876 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab0ASTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:03:16 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:38914 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NXJMB-000462-F8; Tue, 19 Jan 2010 14:03:15 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NXJMB-0000V3-Cb; Tue, 19 Jan 2010 14:03:15 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o0JJ3F8j001921;
	Tue, 19 Jan 2010 14:03:15 -0500
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1263927790-1872-2-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137488>

This patch standardizes calls to system() where.  Instead of
system("git foo ... "), use system(qw(git foo ...)).  This
standarization should see all calls made without the use of an 'sh -c'
process to split the arguments.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-cvsimport.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e838c2e..4853bf7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -609,9 +609,9 @@ $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 my %index; # holds filenames of one index per branch
 
 unless (-d $git_dir) {
-	system("git init");
+	system(qw(git init));
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system("git read-tree");
+	system(qw(git read-tree));
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
@@ -993,7 +993,7 @@ while (<CVS>) {
 		}
 		commit();
 		if (($commitcount & 1023) == 0) {
-			system("git repack -a -d");
+			system(qw(git repack -a -d));
 		}
 		$state = 1;
 	} elsif ($state == 11 and /^-+$/) {
@@ -1017,7 +1017,7 @@ my $line = `git count-objects`;
 if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
   my ($n_objects, $kb) = ($1, $2);
   1024 < $kb
-    and system("git repack -a -d");
+    and system(qw(git repack -a -d));
 }
 
 foreach my $git_index (values %index) {
@@ -1059,7 +1059,7 @@ if ($orig_branch) {
 		if ($opt_r && $opt_o ne 'HEAD');
 	system('git', 'update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
-		system('git checkout -f');
+		system(qw(git checkout -f));
 		die "checkout failed: $?\n" if $?;
 	}
 }
-- 
1.6.5.3
