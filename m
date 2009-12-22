From: Sam Vilain <sam@vilain.net>
Subject: Re: Regression: git-svn clone failure
Date: Wed, 23 Dec 2009 10:13:36 +1300
Message-ID: <1261516416.23944.44.camel@denix>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
	 <20091222192115.GA10313@dcvr.yhbt.net>
	  <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNCCc-0004eC-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZLVVXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 16:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbZLVVX3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 16:23:29 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:57664 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbZLVVX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 16:23:29 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2009 16:23:28 EST
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0AC8021C4FF; Wed, 23 Dec 2009 10:14:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7A88921C46F;
	Wed, 23 Dec 2009 10:14:49 +1300 (NZDT)
Received: from samv by denix with local (Exim 4.69)
	(envelope-from <samv@denix.utsl.gen.nz>)
	id 1NNC49-0006vF-6h; Wed, 23 Dec 2009 10:14:49 +1300
In-Reply-To: <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135599>

On Tue, 2009-12-22 at 11:38 -0800, Andrew Myrick wrote:
> Worked like a charm; the fetch is proceeding now.  Thanks, Eric!
> 
> Do you know what the "svn cherry-pick ignored" warnings mean, and if it's
>  something I should be concerned about?  This particular project is missing
>  up to 65 commits at some revisions.

With git, merge parent relationships imply (conceptually, anyway) that
all of the changes reachable from that branch are included in the
commit.  If someone is doing cherry-picking, then they are specifically
excluding some commits, so adding a merge parent to that branch isn't
right.  This is what the warning is saying.  It's happening every commit
because that section of code doesn't know whether a mergeinfo record is
new or not.

This wasn't happening with the old code, because it was simply not
detecting them correctly and adding merge parents anyway.

However in the case that someone is merging from another branch, merging
most commits, and only skipping a few, then it may make sense to record
it as a real merge.  Here we start getting into non-deterministic
conversion; I had to do this for perl.git, because the merge records
weren't reliable.  Basically I had the script, when the amount of merged
records was within a certain window, prompt me to ask me whether - based
on the change comment and outstanding files to merge - whether it should
be recorded as a real merge or not.  Then, depending on which option I
picked, it would write out to the commit message a note of which files
were not *actually* merged in that commit.

Something like the below change might be the right thing for you, it
might not - before using it, make sure you keep a complete copy of your
git-svn clone so you can restart if required.  Run it for a bit and
inspect the results.  Basically considers a 90% merge "good enough" and
records the differences in the log.  It could be possible to record the
cherry-pick information in the commit message, too - but we'd need to
also know which merge records were *added* in the current commit.
Actually, knowing that would make the whole thing much faster anyway, so
perhaps we need to bite the bullet and record it somewhere in the
metadata.

Anyway, this change may work - it doesn't break the test suite so that's
a good sign.  But hopefully it should give you an idea of the direction
things could have to take.  Perhaps you can see why I built a
high-performance fastimport importer for perl.git...

Subject: [PATCH] git-svn: consider 90% of a branch cherry picked to be a merge

Be slightly fuzzy when deciding if a branch is a merge or a cherry pick; in
some instances this might indicate intentionally skipping changes as not
required, as if they had performed a real merge and then skipped those
files.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f06e535..3064504 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2562,6 +2562,10 @@ sub do_git_commit {
 	unless ($self->no_metadata) {
 		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
 		              or croak $!;
+		if ($log_entry->{merge_notes}) {
+			print $msg_fh "\ngit-svn-merge: $log_entry->{merge_notes}\n"
+		              or croak $!;
+		}
 	}
 	$msg_fh->flush == 0 or croak $!;
 	close $msg_fh or croak $!;
@@ -3027,10 +3031,11 @@ sub check_cherry_pick {
 	my @ranges = @_;
 	my %commits = map { $_ => 1 }
 		_rev_list("--no-merges", $tip, "--not", $base);
+	my $before = keys %commits;
 	for my $range ( @ranges ) {
 		delete @commits{_rev_list($range)};
 	}
-	return (keys %commits);
+	return ($before, keys %commits);
 }
 
 BEGIN {
@@ -3103,6 +3108,8 @@ sub find_extra_svn_parents {
 	my %excluded = map { $_ => 1 }
 		parents_exclude($parents, grep { defined } @merge_tips);
 
+	my @merge_warnings;
+
 	# check merge tips for new parents
 	my @new_parents;
 	for my $merge_tip ( @merge_tips ) {
@@ -3118,14 +3125,25 @@ sub find_extra_svn_parents {
 		       );
 
 		# double check that there are no missing non-merge commits
-		my (@incomplete) = check_cherry_pick(
+		my ($total, @incomplete) = check_cherry_pick(
 			$merge_base, $merge_tip,
 			@$ranges,
 		       );
 
-		if ( @incomplete ) {
+		if ( @incomplete and @incomplete > ($total*0.10) ) {
 			warn "W:svn cherry-pick ignored ($spec) - missing "
-				.@incomplete." commit(s) (eg $incomplete[0])\n";
+				.@incomplete."/$total commit(s) (eg $incomplete[0])\n";
+			# XXX - can't do this, it will appear every time;
+			# we need to know this record was added this commit
+			#push @merge_warnings, "picked: ". join(" ",
+			#     map { my $x=$_; $x=~
+			#	s{([a-f0-9]{12})[a-f0-9]+}{$1}g } @$ranges)
+		} elsif ( @incomplete ) {
+			warn "W:treating svn cherry-pick as merge "
+				.@incomplete."/$total commit(s) included\n";
+			push @merge_warnings, "skipped: ".
+				join(" ", map { substr $_, 0, 12 } @incomplete)
+				.")";
 		} else {
 			warn
 				"Found merge parent (svn:mergeinfo prop): ",
@@ -3151,6 +3169,7 @@ sub find_extra_svn_parents {
 		}
 	}
 	push @$parents, grep { defined } @new_parents;
+	return ( @merge_warnings ? join("; ", @merge_warnings) : undef );
 }
 
 sub make_log_entry {
@@ -3159,6 +3178,7 @@ sub make_log_entry {
 
 	my @parents = @$parents;
 	my $ps = $ed->{path_strip} || "";
+	my $merge_notes;
 	for my $path ( grep { m/$ps/ } %{$ed->{dir_prop}} ) {
 		my $props = $ed->{dir_prop}{$path};
 		if ( $props->{"svk:merge"} ) {
@@ -3166,7 +3186,7 @@ sub make_log_entry {
 				($ed, $props->{"svk:merge"}, \@parents);
 		}
 		if ( $props->{"svn:mergeinfo"} ) {
-			$self->find_extra_svn_parents
+			$merge_notes = $self->find_extra_svn_parents
 				($ed,
 				 $props->{"svn:mergeinfo"},
 				 \@parents);
@@ -3269,6 +3289,7 @@ sub make_log_entry {
 	$log_entry{email} = $email;
 	$log_entry{commit_name} = $commit_name;
 	$log_entry{commit_email} = $commit_email;
+	$log_entry{merge_notes} = $merge_notes;
 	\%log_entry;
 }
 
-- 
1.6.3.3
