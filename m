From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport - cleanup of the multi-indexes handling
Date: Wed, 28 Jun 2006 22:13:23 +1200
Message-ID: <11514896033560-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Jun 28 12:13:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvX2y-0001cB-Oj
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423256AbWF1KNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbWF1KNV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:13:21 -0400
Received: from bm-1a.paradise.net.nz ([203.96.152.180]:57275 "EHLO
	linda-1.paradise.net.nz") by vger.kernel.org with ESMTP
	id S1423256AbWF1KNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 06:13:20 -0400
Received: from smtp-2.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-1.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0J1K00ECXF26V1@linda-1.paradise.net.nz> for
 git@vger.kernel.org; Wed, 28 Jun 2006 22:13:19 +1200 (NZST)
Received: from localhost.localdomain
 (203-79-116-174.cable.paradise.net.nz [203.79.116.174])
	by smtp-2.paradise.net.nz (Postfix) with ESMTP id 6CC68E6DABF; Wed,
 28 Jun 2006 22:13:18 +1200 (NZST)
To: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
X-Mailer: git-send-email 1.4.1.rc1.g1ef9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22799>

Indexes are only needed when we are about preparing to commit. Prime them
inside commit() when we have all the info we need, and remove all the
redundant index setups.

While we are at it, make sure that index handling is correct when opening
new branches, and on initial import.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

This has passed some light testing. Applies on top of master, and seems to
do the right thing with tidier code . It even makes sense ;-)

---
 git-cvsimport.perl |   62 ++++++++++++++++++++--------------------------------
 1 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 50f5d96..9fa598a 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -467,11 +467,6 @@ my $orig_git_index;
 $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 
 my %index; # holds filenames of one index per branch
-$index{$opt_o} = tmpnam();
-
-$ENV{GIT_INDEX_FILE} = $index{$opt_o};
-system("git-read-tree", $opt_o);
-die "read-tree failed: $?\n" if $?;
 
 unless(-d $git_dir) {
 	system("git-init-db");
@@ -499,14 +494,6 @@ unless(-d $git_dir) {
 	$orig_branch = $last_branch;
 	$tip_at_start = `git-rev-parse --verify HEAD`;
 
-	# populate index
-	unless ($index{$last_branch}) {
-	    $index{$last_branch} = tmpnam();
-	}
-	$ENV{GIT_INDEX_FILE} = $index{$last_branch};
-	system('git-read-tree', $last_branch);
-	die "read-tree failed: $?\n" if $?;
-
 	# Get the last import timestamps
 	opendir(D,"$git_dir/refs/heads");
 	while(defined(my $head = readdir(D))) {
@@ -623,6 +610,27 @@ # commits that cvsps cannot place anywhe
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
 
 sub commit {
+	if ($branch eq $opt_o && !$index{branch} && !get_headref($branch, $git_dir)) { 
+	    # looks like an initial commit
+	    # use the index primed by git-init-db
+	    $ENV{GIT_INDEX_FILE} = '.git/index';
+	    $index{$branch} = '.git/index';
+	} else {
+	    # use an index per branch to speed up
+	    # imports of projects with many branches
+	    unless ($index{$branch}) {
+		$index{$branch} = tmpnam();
+		$ENV{GIT_INDEX_FILE} = $index{$branch};
+		if ($ancestor) {
+		    system("git-read-tree", $ancestor);
+		} else {
+		    system("git-read-tree", $branch);
+		}
+		die "read-tree failed: $?\n" if $?;
+	    }
+	}
+        $ENV{GIT_INDEX_FILE} = $index{$branch};
+
 	update_index(@old, @new);
 	@old = @new = ();
 	my $tree = write_tree();
@@ -811,30 +819,6 @@ while(<CVS>) {
 			close(H)
 				or die "Could not write branch $branch: $!";
 		}
-		if(($ancestor || $branch) ne $last_branch) {
-			print "Switching from $last_branch to $branch\n" if $opt_v;
-			unless ($index{$branch}) {
-			    $index{$branch} = tmpnam();
-			    $ENV{GIT_INDEX_FILE} = $index{$branch};
-			    system("git-read-tree", $branch);
-			    die "read-tree failed: $?\n" if $?;
-			}
-			# just in case
-			$ENV{GIT_INDEX_FILE} = $index{$branch};
-			if ($ancestor) {
-			    print "have ancestor $ancestor" if $opt_v;
-			    system("git-read-tree", $ancestor);
-			    die "read-tree failed: $?\n" if $?;
-			}
-		} else {
-			# just in case
-			unless ($index{$branch}) {
-			    $index{$branch} = tmpnam();
-			    $ENV{GIT_INDEX_FILE} = $index{$branch};
-			    system("git-read-tree", $branch);
-			    die "read-tree failed: $?\n" if $?;
-			}
-		}
 		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
 	} elsif($state == 8) {
@@ -898,7 +882,9 @@ #	VERSION:1.96->1.96.2.1
 commit() if $branch and $state != 11;
 
 foreach my $git_index (values %index) {
-    unlink($git_index);
+    if ($git_index ne '.git/index') {
+	unlink($git_index);
+    }
 }
 
 if (defined $orig_git_index) {
-- 
1.4.1.rc1.g1ef9
