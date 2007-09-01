From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix dcommit clobbering upstream when committing multiple changes
Date: Fri, 31 Aug 2007 18:16:12 -0700
Message-ID: <20070901011612.GA3407@untitled>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site> <20070831234854.GA6451@mimvista.com> <20070901002501.GA11591@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHbY-00015f-Gp
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXIABQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbXIABQt
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:16:49 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39039 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbXIABQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 21:16:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EAB1A2DC08D;
	Fri, 31 Aug 2007 18:16:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070901002501.GA11591@mimvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57238>

Although dcommit could detect if the first commit in the series
would conflict with the HEAD revision in SVN, it could not
detect conflicts in further commits it made.

Now we rebase each uncommitted change after each revision is
committed to SVN to ensure that we are up-to-date.  git-rebase
will bail out on conflict errors if our next change cannot be
applied and committed to SVN cleanly, preventing accidental
clobbering of changes on the SVN-side.

--no-rebase users will have trouble with this, and are thus
warned if they are committing more than one commit.  Fixing this
for (hopefully uncommon) --no-rebase users would be more complex
and will probably happen at a later date.

Thanks to David Watson for finding this and the original test.
---
  David Watson <dwatson@mimvista.com> wrote:
  > If you make multiple commits, and a commit other than the first applies

  > to the same file as a new change in the SVN repository, git-svn will blow
  > away the other commit's changes.

  Thanks David.  I separated out the test case to not modify existing
  ones.

 git-svn.perl                           |   60 +++++++++++++++++---------------
 t/t9106-git-svn-commit-diff-clobber.sh |   30 ++++++++++++++++
 2 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 98218da..d3c8cd0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -384,6 +384,12 @@ sub cmd_dcommit {
 	}
 	my $last_rev;
 	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
+	if ($_no_rebase && scalar(@$linear_refs) > 1) {
+		warn "Attempting to commit more than one change while ",
+		     "--no-rebase is enabled.\n",
+		     "If these changes depend on each other, re-running ",
+		     "without --no-rebase will be required."
+	}
 	foreach my $d (@$linear_refs) {
 		unless (defined $last_rev) {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
@@ -395,6 +401,7 @@ sub cmd_dcommit {
 		if ($_dry_run) {
 			print "diff-tree $d~1 $d\n";
 		} else {
+			my $cmt_rev;
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
 			                ra => Git::SVN::Ra->new($gs->full_url),
@@ -402,42 +409,39 @@ sub cmd_dcommit {
 			                tree_b => $d,
 			                editor_cb => sub {
 			                       print "Committed r$_[0]\n";
-			                       $last_rev = $_[0]; },
+			                       $cmt_rev = $_[0];
+			                },
 			                svn_path => '');
 			if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
 			} elsif ($parents->{$d} && @{$parents->{$d}}) {
-				$gs->{inject_parents_dcommit}->{$last_rev} =
+				$gs->{inject_parents_dcommit}->{$cmt_rev} =
 				                               $parents->{$d};
 			}
+			$_fetch_all ? $gs->fetch_all : $gs->fetch;
+			next if $_no_rebase;
+
+			# we always want to rebase against the current HEAD,
+			# not any head that was passed to us
+			my @diff = command('diff-tree', 'HEAD',
+			                   $gs->refname, '--');
+			my @finish;
+			if (@diff) {
+				@finish = rebase_cmd();
+				print STDERR "W: HEAD and ", $gs->refname,
+				             " differ, using @finish:\n",
+				             "@diff";
+			} else {
+				print "No changes between current HEAD and ",
+				      $gs->refname,
+				      "\nResetting to the latest ",
+				      $gs->refname, "\n";
+				@finish = qw/reset --mixed/;
+			}
+			command_noisy(@finish, $gs->refname);
+			$last_rev = $cmt_rev;
 		}
 	}
-	return if $_dry_run;
-	unless ($gs) {
-		warn "Could not determine fetch information for $url\n",
-		     "Will not attempt to fetch and rebase commits.\n",
-		     "This probably means you have useSvmProps and should\n",
-		     "now resync your SVN::Mirror repository.\n";
-		return;
-	}
-	$_fetch_all ? $gs->fetch_all : $gs->fetch;
-	unless ($_no_rebase) {
-		# we always want to rebase against the current HEAD, not any
-		# head that was passed to us
-		my @diff = command('diff-tree', 'HEAD', $gs->refname, '--');
-		my @finish;
-		if (@diff) {
-			@finish = rebase_cmd();
-			print STDERR "W: HEAD and ", $gs->refname, " differ, ",
-				     "using @finish:\n", "@diff";
-		} else {
-			print "No changes between current HEAD and ",
-			      $gs->refname, "\nResetting to the latest ",
-			      $gs->refname, "\n";
-			@finish = qw/reset --mixed/;
-		}
-		command_noisy(@finish, $gs->refname);
-	}
 }
 
 sub cmd_find_rev {
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 6f132f2..79b7968 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -66,4 +66,34 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	git-svn dcommit
 	"
 
+test_expect_success 'commit another change from svn side' "
+	svn co $svnrepo t.svn &&
+	cd t.svn &&
+		echo third line from svn >> file &&
+		poke file &&
+		svn commit -m 'third line from svn' &&
+	cd .. &&
+	rm -rf t.svn
+	"
+
+test_expect_failure 'multiple dcommit from git-svn will not clobber svn' "
+	git reset --hard refs/remotes/git-svn &&
+	echo new file >> new-file &&
+	git update-index --add new-file &&
+	git commit -a -m 'new file' &&
+	echo clobber > file &&
+	git commit -a -m 'clobber' &&
+	git svn dcommit
+	" || true
+
+
+test_expect_success 'check that rebase really failed' 'test -d .dotest'
+
+test_expect_success 'resolve, continue the rebase and dcommit' "
+	echo clobber and I really mean it > file &&
+	git update-index file &&
+	git rebase --continue &&
+	git svn dcommit
+	"
+
 test_done
-- 
Eric Wong
