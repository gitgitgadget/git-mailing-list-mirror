From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: use private index.
Date: Mon, 4 Jul 2005 14:13:44 +0200
Message-ID: <20050704121344.GJ18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 14:32:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpQ7y-0003gv-HR
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 14:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVGDMc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 08:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVGDMc2
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 08:32:28 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:55221 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261663AbVGDMaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 08:30:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 62C1F1D73BB
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:30:29 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 587C01D7284
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:30:27 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 4A00AAED88
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:30:27 +0200 (CEST)
Received: (qmail 6413 invoked by uid 500); 4 Jul 2005 12:13:44 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: use private index.

---
commit 79ee456cf222982f7ee3f003440c57b5f7cffa8b
tree c27c7f8bafa48d81a4d9f7562b851681984a9c7e
parent 2eb6d82eaa869a1faf4ba3326fd628f76f9f93a8
author Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 13:36:59 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 13:36:59 +0200

 git-cvsimport-script |   43 +++++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -16,6 +16,8 @@
 use strict;
 use warnings;
 use Getopt::Std;
+use File::Spec;
+use File::Temp qw(tempfile);
 use File::Path qw(mkpath);
 use File::Basename qw(basename dirname);
 use Time::Local;
@@ -377,6 +379,12 @@ my %branch_date;
 my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $git_dir = getwd()."/".$git_dir unless $git_dir =~ m#^/#;
 $ENV{"GIT_DIR"} = $git_dir;
+my $orig_git_index;
+$orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
+my ($git_ih, $git_index) = tempfile('gitXXXXXX', SUFFIX => '.idx',
+				    DIR => File::Spec->tmpdir());
+close ($git_ih);
+$ENV{GIT_INDEX_FILE} = $git_index;
 unless(-d $git_dir) {
 	system("git-init-db");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
@@ -398,6 +406,9 @@ unless(-d $git_dir) {
 	}
 	$orig_branch = $last_branch;
 
+	# populate index
+	system('git-read-tree', $last_branch);
+
 	# Get the last import timestamps
 	opendir(D,"$git_dir/refs/heads");
 	while(defined(my $head = readdir(D))) {
@@ -643,11 +654,6 @@ while(<CVS>) {
 			system("git-read-tree","-m","$last_branch","$branch");
 			die "read-tree failed: $?\n" if $?;
 		}
-		if($branch ne $last_branch) {
-			unlink("$git_dir/HEAD");
-			symlink("refs/heads/$branch","$git_dir/HEAD");
-			$last_branch = $branch;
-		}
 		$state = 9;
 	} elsif($state == 8) {
 		$logmsg .= "$_\n";
@@ -686,26 +692,23 @@ while(<CVS>) {
 }
 &$commit() if $branch and $state != 11;
 
+unlink($git_index);
+
 # Now switch back to the branch we were in before all of this happened
 if($orig_branch) {
-	print "DONE; switching back to $orig_branch\n" if $opt_v;
+	print "DONE\n" if $opt_v;
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		unless -f "$git_dir/refs/heads/master";
+	unlink("$git_dir/HEAD");
+	symlink("refs/heads/$orig_branch","$git_dir/HEAD");
+	if (defined $orig_git_index) {
+	    $ENV{GIT_INDEX_FILE} = $orig_git_index;
+	} else {
+	    delete $ENV{GIT_INDEX_FILE};
+	}
+	system('git checkout');
+	die "checkout failed: $?\n" if $?;
 }
-
-if ($orig_branch) {
-	system("git-read-tree",$last_branch);
-	die "read-tree failed: $?\n" if $?;
-} else {
-	system('git-read-tree', $orig_branch);
-	die "read-tree failed: $?\n" if $?;
-	system('git-checkout-cache', '-a');
-	die "checkout-cache failed: $?\n" if $?;
-}
-
-unlink("$git_dir/HEAD");
-symlink("refs/heads/$orig_branch","$git_dir/HEAD");
-
