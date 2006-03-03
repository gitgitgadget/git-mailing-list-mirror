From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/9] contrib/git-svn: several small bug fixes and changes
Date: Fri, 3 Mar 2006 01:20:07 -0800
Message-ID: <114137760733-git-send-email-normalperson@yhbt.net>
References: <11413776074148-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Si-00041U-OT
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbWCCJUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbWCCJUP
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:64130 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752197AbWCCJUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:08 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E71E77DC020;
	Fri,  3 Mar 2006 01:20:07 -0800 (PST)
In-Reply-To: <11413776074148-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17146>

 * Fixed manually-edited commit messages not going to
   remotes/git-svn on sequential commits after the sequential
   commit optimization.
 * format help correctly after adding 'show-ignore'
 * sha1_short regexp matches down to 4 hex characters
   (from git-rev-parse --short documentation)
 * Print the first line of the commit message when we commit to
   SVN next to the sha1.
 * Document 'T' (type change) in the comments

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

43965ace71422148acb1bae488d78cbcfc5ca65e
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 1f9a470..67368a5 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -32,7 +32,7 @@ use Getopt::Long qw/:config gnu_getopt n
 use File::Spec qw//;
 use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
-my $sha1_short = qr/[a-f\d]{6,40}/;
+my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_version, $_upgrade);
 my (@_branch_from, %tree_map);
@@ -90,12 +90,12 @@ Usage: $0 <command> [options] [arguments
 Available commands:
 
 	foreach (sort keys %cmd) {
-		print $fd '  ',pack('A10',$_),$cmd{$_}->[1],"\n";
+		print $fd '  ',pack('A13',$_),$cmd{$_}->[1],"\n";
 	}
 	print $fd <<"";
 \nGIT_SVN_ID may be set in the environment to an arbitrary identifier if
 you're tracking multiple SVN branches/repositories in one git repository
-and want to keep them separate.
+and want to keep them separate.  See git-svn(1) for more information.
 
 	exit $exit;
 }
@@ -245,7 +245,7 @@ sub commit {
 		print "Reading from stdin...\n";
 		@commits = ();
 		while (<STDIN>) {
-			if (/\b([a-f\d]{6,40})\b/) {
+			if (/\b($sha1_short)\b/) {
 				unshift @commits, $1;
 			}
 		}
@@ -267,7 +267,6 @@ sub commit {
 	chdir $SVN_WC or croak $!;
 	my $svn_current_rev =  svn_info('.')->{'Last Changed Rev'};
 	foreach my $c (@revs) {
-		print "Committing $c\n";
 		my $mods = svn_checkout_tree($svn_current_rev, $c);
 		if (scalar @$mods == 0) {
 			print "Skipping, no changes detected\n";
@@ -514,7 +513,7 @@ sub svn_checkout_tree {
 	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
 	assert_svn_wc_clean($svn_rev,$from);
-	print "diff-tree '$from' '$treeish'\n";
+	print "diff-tree $from $treeish\n";
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
 	if ($pid == 0) {
@@ -525,7 +524,7 @@ sub svn_checkout_tree {
 	}
 	my $mods = parse_diff_tree($diff_fh);
 	unless (@$mods) {
-		# git can do empty commits, SVN doesn't allow it...
+		# git can do empty commits, but SVN doesn't allow it...
 		return $mods;
 	}
 	my ($rm, $add) = precommit_check($mods);
@@ -612,7 +611,7 @@ sub svn_commit_tree {
 	my ($svn_rev, $commit) = @_;
 	my $commit_msg = "$GIT_DIR/$GIT_SVN/.svn-commit.tmp.$$";
 	my %log_msg = ( msg => '' );
-	open my $msg, '>', $commit_msg  or croak $!;
+	open my $msg, '>', $commit_msg or croak $!;
 
 	chomp(my $type = `git-cat-file -t $commit`);
 	if ($type eq 'commit') {
@@ -627,7 +626,6 @@ sub svn_commit_tree {
 			if (!$in_msg) {
 				$in_msg = 1 if (/^\s*$/);
 			} else {
-				$log_msg{msg} .= $_;
 				print $msg $_ or croak $!;
 			}
 		}
@@ -639,6 +637,15 @@ sub svn_commit_tree {
 		my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
 		system($editor, $commit_msg);
 	}
+
+	# file_to_s removes all trailing newlines, so just use chomp() here:
+	open $msg, '<', $commit_msg or croak $!;
+	{ local $/; chomp($log_msg{msg} = <$msg>); }
+	close $msg or croak $!;
+
+	my ($oneline) = ($log_msg{msg} =~ /([^\n\r]+)/);
+	print "Committing $commit: $oneline\n";
+
 	my @ci_output = safe_qx(qw(svn commit -F),$commit_msg);
 	my ($committed) = grep(/^Committed revision \d+\./,@ci_output);
 	unlink $commit_msg;
@@ -1037,7 +1044,7 @@ diff-index line ($m hash)
 	mode_a => first column of diff-index output, no leading ':',
 	mode_b => second column of diff-index output,
 	sha1_b => sha1sum of the final blob,
-	chg => change type [MCRAD],
+	chg => change type [MCRADT],
 	file_a => original file name of a file (iff chg is 'C' or 'R')
 	file_b => new/current file name of a file (any chg)
 }
-- 
1.2.3.g4676
