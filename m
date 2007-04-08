From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: dcommit/rebase confused by patches with git-svn-id: lines
Date: Sun,  8 Apr 2007 00:59:19 -0700
Message-ID: <11760191593408-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 10:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaSJJ-0002uk-81
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXDHH7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 03:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbXDHH7V
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 03:59:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50218 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbXDHH7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 03:59:21 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5A9E07DC091;
	Sun,  8 Apr 2007 00:59:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 08 Apr 2007 00:59:19 -0700
X-Mailer: git-send-email 1.5.1.82.g8c65-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43999>

When patches are merged from another git-svn managed branch,
they will have the git-svn-id: metadata line in them (generated
by git-format-patch).

When doing rebase or dcommit via git-svn, this would cause
git-svn to find the wrong upstream branch.  We now verify
that the commit is consistent with the value in the .rev_db
file.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6216cad..e4079fb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -363,13 +363,12 @@ sub cmd_dcommit {
 	my $head = shift;
 	$head ||= 'HEAD';
 	my @refs;
-	my ($url, $rev, $uuid) = working_head_info($head, \@refs);
-	my $c = $refs[-1];
-	unless (defined $url && defined $rev && defined $uuid) {
+	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history\n";
 	}
-	my $gs = Git::SVN->find_by_url($url);
+	my $c = $refs[-1];
 	my $last_rev;
 	foreach my $d (@refs) {
 		if (!verify_ref("$d~1")) {
@@ -431,16 +430,11 @@ sub cmd_dcommit {
 
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
-	my $url = (working_head_info('HEAD'))[0];
-	if (!defined $url) {
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
 	}
-
-	my $gs = Git::SVN->find_by_url($url);
-	unless ($gs) {
-		die "Unable to determine remote information from URL: $url\n";
-	}
 	if (command(qw/diff-index HEAD --/)) {
 		print STDERR "Cannot rebase with uncommited changes:\n";
 		command_noisy('status');
@@ -453,8 +447,8 @@ sub cmd_rebase {
 }
 
 sub cmd_show_ignore {
-	my $url = (::working_head_info('HEAD'))[0];
-	my $gs = Git::SVN->find_by_url($url) || Git::SVN->new;
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
 	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
 }
@@ -776,16 +770,23 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my ($url, $rev, $uuid);
 	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
 	while (<$fh>) {
 		chomp;
-		($url, $rev, $uuid) = cmt_metadata($_);
-		last if (defined $url && defined $rev && defined $uuid);
+		my ($url, $rev, $uuid) = cmt_metadata($_);
+		if (defined $url && defined $rev) {
+			if (my $gs = Git::SVN->find_by_url($url)) {
+				my $c = $gs->rev_db_get($rev);
+				if ($c && $c eq $_) {
+					close $fh; # break the pipe
+					return ($url, $rev, $uuid, $gs);
+				}
+			}
+		}
 		unshift @$refs, $_ if $refs;
 	}
-	close $fh; # break the pipe
-	($url, $rev, $uuid);
+	command_close_pipe($fh, $ctx);
+	(undef, undef, undef, undef);
 }
 
 package Git::SVN;
@@ -3321,8 +3322,8 @@ sub git_svn_log_cmd {
 		last;
 	}
 
-	my $url = (::working_head_info($head))[0];
-	my $gs = Git::SVN->find_by_url($url) || Git::SVN->_new;
+	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+	$gs ||= Git::SVN->_new;
 	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
 	           $gs->refname);
 	push @cmd, '-r' unless $non_recursive;
-- 
1.5.1.82.g8c65-dirty
