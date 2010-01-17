From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] cvsimport: update to use non-dash git commands
Date: Sat, 16 Jan 2010 22:55:23 -0500
Message-ID: <1263700523-2111-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 06:14:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWNSe-0006qn-S5
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 06:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab0AQFJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 00:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851Ab0AQFJo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 00:09:44 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:55390 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab0AQFJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 00:09:43 -0500
X-Greylist: delayed 4448 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2010 00:09:43 EST
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:38617 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NWMEd-0000Cf-SF; Sat, 16 Jan 2010 22:55:31 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NWMEd-0000Yf-Ph; Sat, 16 Jan 2010 22:55:31 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o0H3tVQd002145;
	Sat, 16 Jan 2010 22:55:31 -0500
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137274>

The cvsimport module was using the old git subcommand calling
convention (eg: git-init) in several places.  Clean this up to use
only modern calling conventions and be internally consistent in how
commands are passed to system().

Reported-by: Alexander Maier <amaier@opencsw.org>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-cvsimport.perl |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index a7d215c..39e5842 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -609,16 +609,16 @@ $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 my %index; # holds filenames of one index per branch
 
 unless (-d $git_dir) {
-	system("git-init");
+	system(qw(git init));
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system("git-read-tree");
+	system(qw(git read-tree));
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
-	open(F, "git-symbolic-ref HEAD |") or
-		die "Cannot run git-symbolic-ref: $!\n";
+	open(F, "git symbolic-ref HEAD |") or
+		die "Cannot run git symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
 	$last_branch = basename($last_branch);
 	close(F);
@@ -761,9 +761,9 @@ sub commit {
 		$index{$branch} = tmpnam();
 		$ENV{GIT_INDEX_FILE} = $index{$branch};
 		if ($ancestor) {
-		    system("git-read-tree", "$remote/$ancestor");
+		    system(qw(git read-tree), "$remote/$ancestor");
 		} else {
-		    system("git-read-tree", "$remote/$branch");
+		    system(qw(git read-tree), "$remote/$branch");
 		}
 		die "read-tree failed: $?\n" if $?;
 	    }
@@ -822,7 +822,7 @@ sub commit {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	system('git-update-ref', "$remote/$branch", $cid) == 0
+	system(qw(git update-ref), "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
@@ -832,7 +832,7 @@ sub commit {
 		$xtag =~ s/[\/]/$opt_s/g;
 		$xtag =~ s/\[//g;
 
-		system('git-tag', '-f', $xtag, $cid) == 0
+		system(qw(git tag -f), $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
@@ -993,7 +993,7 @@ while (<CVS>) {
 		}
 		commit();
 		if (($commitcount & 1023) == 0) {
-			system("git repack -a -d");
+			system(qw(git repack -a -d));
 		}
 		$state = 1;
 	} elsif ($state == 11 and /^-+$/) {
@@ -1017,7 +1017,7 @@ my $line = `git-count-objects`;
 if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
   my ($n_objects, $kb) = ($1, $2);
   1024 < $kb
-    and system("git repack -a -d");
+    and system(qw(git repack -a -d));
 }
 
 foreach my $git_index (values %index) {
@@ -1042,24 +1042,24 @@ if ($orig_branch) {
 	if ($tip_at_start ne $tip_at_end) {
 		for ($tip_at_start, $tip_at_end) { chomp; }
 		print "Fetched into the current branch.\n" if $opt_v;
-		system(qw(git-read-tree -u -m),
+		system(qw(git read-tree -u -m),
 		       $tip_at_start, $tip_at_end);
 		die "Fast-forward update failed: $?\n" if $?;
 	}
 	else {
-		system(qw(git-merge cvsimport HEAD), "$remote/$opt_o");
+		system(qw(git merge cvsimport HEAD), "$remote/$opt_o");
 		die "Could not merge $opt_o into the current branch.\n" if $?;
 	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
+	system(qw(git update-ref refs/heads/master), "$remote/$opt_o")
 		unless defined get_headref('refs/heads/master');
-	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
+	system(qw(git symbolic-ref), "$remote/HEAD", "$remote/$opt_o")
 		if ($opt_r && $opt_o ne 'HEAD');
-	system('git-update-ref', 'HEAD', "$orig_branch");
+	system(qw(git update-ref HEAD), "$orig_branch");
 	unless ($opt_i) {
-		system('git checkout -f');
+		system(qw(git checkout -f));
 		die "checkout failed: $?\n" if $?;
 	}
 }
-- 
1.6.6
