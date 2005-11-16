From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] symref support for import scripts
Date: Wed, 16 Nov 2005 13:27:28 -0500
Message-ID: <1132165648.4024.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 19:33:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcS1z-0003aX-Kn
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 19:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVKPS3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKPS3M
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 13:29:12 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:38798 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030423AbVKPS3M
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 13:29:12 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EcS0R-0006cY-PC
	for git@vger.kernel.org; Wed, 16 Nov 2005 13:29:03 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EcS0G-000279-TM
	for git@vger.kernel.org; Wed, 16 Nov 2005 13:27:28 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12038>

Fix git import script not to assume that .git/HEAD is a symlink.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/git-archimport.perl b/git-archimport.perl
index e22c816..23becb7 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -410,8 +410,7 @@ foreach my $ps (@psets) {
     open  HEAD, ">$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
-    unlink ("$git_dir/HEAD");
-    symlink("refs/heads/$ps->{branch}","$git_dir/HEAD");
+    system('git-update-ref', 'HEAD', "$ps->{branch}");
 
     # tag accordingly
     ptag($ps->{id}, $commitid); # private tag
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7bd9136..efe1934 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -437,7 +437,11 @@ unless(-d $git_dir) {
 		       "Either use the correct '-o branch' option,\n".
 		       "or import to a new repository.\n";
 
-	$last_branch = basename(readlink("$git_dir/HEAD"));
+	open(F, "git-symbolic-ref HEAD |") or
+		die "Cannot run git-symbolic-ref: $!\n";
+	chomp ($last_branch = <F>);
+	$last_branch = basename($last_branch);
+	close(F);
 	unless($last_branch) {
 		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
 		$last_branch = "master";
@@ -829,8 +833,7 @@ if($orig_branch) {
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		unless -f "$git_dir/refs/heads/master";
-	unlink("$git_dir/HEAD");
-	symlink("refs/heads/$orig_branch","$git_dir/HEAD");
+	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
 		system('git checkout');
 		die "checkout failed: $?\n" if $?;
diff --git a/git-svnimport.perl b/git-svnimport.perl
index af13fdd..45d77c5 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -216,7 +216,11 @@ unless(-d $git_dir) {
 	-f "$git_dir/svn2git"
 		or die "'$git_dir/svn2git' does not exist.\n".
 		       "You need that file for incremental imports.\n";
-	$last_branch = basename(readlink("$git_dir/HEAD"));
+	open(F, "git-symbolic-ref HEAD |") or
+		die "Cannot run git-symbolic-ref: $!\n";
+	chomp ($last_branch = <F>);
+	$last_branch = basename($last_branch);
+	close(F);
 	unless($last_branch) {
 		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
 		$last_branch = "master";
@@ -766,8 +770,7 @@ if($orig_branch) {
 	print "DONE; creating $orig_branch branch\n" if $opt_v and (not defined $opt_l or $opt_l > 0);
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		unless -f "$git_dir/refs/heads/master";
-	unlink("$git_dir/HEAD");
-	symlink("refs/heads/$orig_branch","$git_dir/HEAD");
+	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
 		system('git checkout');
 		die "checkout failed: $?\n" if $?;


-- 
Regards,
Pavel Roskin
