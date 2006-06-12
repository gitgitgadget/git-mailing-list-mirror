From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: keep one index per branch during import
Date: Mon, 12 Jun 2006 23:50:49 +1200
Message-ID: <11501130491187-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jun 12 13:43:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpkpL-0000eB-7U
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 13:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWFLLnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 07:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWFLLnY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 07:43:24 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:38350 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751883AbWFLLnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 07:43:24 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FpkpF-00049z-8r; Mon, 12 Jun 2006 23:43:21 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1FpkwT-000343-00; Mon, 12 Jun 2006 23:50:49 +1200
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.g5fba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21703>

With this patch we have a speedup and much lower IO when
importing trees with many branches. Instead of forcing
index re-population for each branch switch, we keep
many index files around, one per branch.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

This patch should get some review. It is trivial, but not fully tested.
I am testing it on the moz repo (which will take a while) to check that I get
the same result with and without it. 

Performance-wise, it seems to be doing ~15K commits per hour, with
the mozilla repo, up from ~6Kcph on the same hardware. Of course, 
this is only noticeable in projects with lots of concurrent branches.
Linear projects don't get much from this patch.

With this change, we are now truly waiting on cvs to hand over the
files pronto! Running locally, it is apparent that it isn't IO wait
but the latency of the chatty cvs protocol that is making this slow.

Probably forking 2 or 3 processes to prefetch filerevs from cvs
and put them in a queue directory for the main process to pick
up would work wonders. Actually, they could call git-hash-object
and just put some file metadata in the queue directory. 
---
 git-cvsimport.perl |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
old mode 100755
new mode 100644
index 76f6246..9c4588f
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -465,10 +465,15 @@ my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
 my $orig_git_index;
 $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
-my ($git_ih, $git_index) = tempfile('gitXXXXXX', SUFFIX => '.idx',
-				    DIR => File::Spec->tmpdir());
-close ($git_ih);
-$ENV{GIT_INDEX_FILE} = $git_index;
+
+my %index; # holds filenames of one index per branch
+{   # init with an index for origin
+    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
+			     DIR => File::Spec->tmpdir());
+    close ($fh);
+    $index{$opt_o} = $fn;
+}
+$ENV{GIT_INDEX_FILE} = $index{$opt_o};
 unless(-d $git_dir) {
 	system("git-init-db");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
@@ -496,6 +501,13 @@ unless(-d $git_dir) {
 	$tip_at_start = `git-rev-parse --verify HEAD`;
 
 	# populate index
+	unless ($index{$last_branch}) {
+	    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
+				     DIR => File::Spec->tmpdir());
+	    close ($fh);
+	    $index{$last_branch} = $fn;
+	}
+	$ENV{GIT_INDEX_FILE} = $index{$last_branch};
 	system('git-read-tree', $last_branch);
 	die "read-tree failed: $?\n" if $?;
 
@@ -776,8 +788,17 @@ while(<CVS>) {
 		}
 		if(($ancestor || $branch) ne $last_branch) {
 			print "Switching from $last_branch to $branch\n" if $opt_v;
-			system("git-read-tree", $branch);
-			die "read-tree failed: $?\n" if $?;
+			unless ($index{$branch}) {
+			    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
+						     DIR => File::Spec->tmpdir());
+			    close ($fh);
+			    $index{$branch} = $fn;
+			    $ENV{GIT_INDEX_FILE} = $index{$branch};
+			    system("git-read-tree", $branch);
+			    die "read-tree failed: $?\n" if $?;
+			} else {
+			    $ENV{GIT_INDEX_FILE} = $index{$branch};
+		        }
 		}
 		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
@@ -841,7 +862,9 @@ #	VERSION:1.96->1.96.2.1
 }
 commit() if $branch and $state != 11;
 
-unlink($git_index);
+foreach my $git_index (values %index) {
+    unlink($git_index);
+}
 
 if (defined $orig_git_index) {
 	$ENV{GIT_INDEX_FILE} = $orig_git_index;
-- 
1.4.0.g5fba
