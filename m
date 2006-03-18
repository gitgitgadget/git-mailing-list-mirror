From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Sat, 18 Mar 2006 15:21:15 -0800
Message-ID: <7vveubqqz8.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
	<7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
	<86fylh20x6.fsf@blue.stonehenge.com>
	<7vfylh7lkh.fsf@assigned-by-dhcp.cox.net>
	<86bqw51z5q.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 00:21:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKkjY-0006gj-SA
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 00:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWCRXVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCRXVR
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 18:21:17 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1959 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751124AbWCRXVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 18:21:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318231954.PSMD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 18:19:54 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17705>

I tested the version in today's "next" branch, and it fixes the
problem for me in my tests that use my day-job CVS repository as
a guinea pig.

In case you are not brave enough to switch to "next" wholesale,
but are kind enough to try out the relevant cvsimport change for
us, here is a patch that applies on top of "master".  It is a
roll-up of two commits on my jc/cvsimport branch.

-- >8 --
cvsimport: honor -i and non -i upon subsequent imports

Documentation says -i is "import only", so without it,
subsequent import should update the current branch and working
tree files in a sensible way.

"A sensible way" defined by this commit is "act as if it is a
git pull from foreign repository which happens to be CVS not
git".  So:

 - If importing into the current branch (note that cvsimport
   requires the tracking branch is pristine -- you checked out
   the tracking branch but it is your responsibility not to make
   your own commits there), fast forward the branch head and
   match the index and working tree using two-way merge, just
   like "git pull" does.

 - If importing into a separate tracking branch, update that
   branch head, and merge it into your current branch, again,
   just like "git pull" does.

Initial round of the updated code read the tip of the current
branch before and after the import runs, but forgot to chomp
what we read from the command.  The read-tree command did not
them with the trailing LF.  This has been fixed.

---

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 02d1928..3728294 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -453,6 +453,7 @@ chdir($git_tree);
 my $last_branch = "";
 my $orig_branch = "";
 my %branch_date;
+my $tip_at_start = undef;
 
 my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $git_dir = getwd()."/".$git_dir unless $git_dir =~ m#^/#;
@@ -487,6 +488,7 @@ unless(-d $git_dir) {
 		$last_branch = "master";
 	}
 	$orig_branch = $last_branch;
+	$tip_at_start = `git-rev-parse --verify HEAD`;
 
 	# populate index
 	system('git-read-tree', $last_branch);
@@ -873,7 +875,22 @@ if (defined $orig_git_index) {
 
 # Now switch back to the branch we were in before all of this happened
 if($orig_branch) {
-	print "DONE; you may need to merge manually.\n" if $opt_v;
+	print "DONE.\n" if $opt_v;
+	if ($opt_i) {
+		exit 0;
+	}
+	my $tip_at_end = `git-rev-parse --verify HEAD`;
+	if ($tip_at_start ne $tip_at_end) {
+		for ($tip_at_start, $tip_at_end) { chomp; }
+		print "Fetched into the current branch.\n" if $opt_v;
+		system(qw(git-read-tree -u -m),
+		       $tip_at_start, $tip_at_end);
+		die "Fast-forward update failed: $?\n" if $?;
+	}
+	else {
+		system(qw(git-merge cvsimport HEAD), "refs/heads/$opt_o");
+		die "Could not merge $opt_o into the current branch.\n" if $?;
+	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
