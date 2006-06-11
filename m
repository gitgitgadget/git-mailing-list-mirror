From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/5] git-svn: restore original LC_ALL setting (or unset) for commit
Date: Sun, 11 Jun 2006 00:03:44 -0700
Message-ID: <11500094313384-git-send-email-normalperson@yhbt.net>
References: <11500094252972-git-send-email-normalperson@yhbt.net> <11500094271080-git-send-email-normalperson@yhbt.net> <11500094281515-git-send-email-normalperson@yhbt.net> <11500094292561-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzP-0005iD-Oq
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFKHDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFKHDy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:31409 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751558AbWFKHDw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:52 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5600B7DC020;
	Sun, 11 Jun 2006 00:03:51 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:51 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
In-Reply-To: <11500094292561-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21640>

svn forces UTF-8 for commit messages, and with LC_ALL set to 'C'
it is unable to determine encoding of the git commit message.

Now we'll just assume the user has set LC_* correctly for
the commit message they're using.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 8d2e7f7..8bc3d69 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -14,6 +14,7 @@ use Cwd qw/abs_path/;
 $GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
 $ENV{GIT_DIR} = $GIT_DIR;
 
+my $LC_ALL = $ENV{LC_ALL};
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
@@ -704,23 +705,34 @@ sub svn_commit_tree {
 	my ($oneline) = ($log_msg{msg} =~ /([^\n\r]+)/);
 	print "Committing $commit: $oneline\n";
 
+	if (defined $LC_ALL) {
+		$ENV{LC_ALL} = $LC_ALL;
+	} else {
+		delete $ENV{LC_ALL};
+	}
 	my @ci_output = safe_qx(qw(svn commit -F),$commit_msg);
-	my ($committed) = grep(/^Committed revision \d+\./,@ci_output);
+	$ENV{LC_ALL} = 'C';
 	unlink $commit_msg;
-	defined $committed or croak
+	my ($committed) = ($ci_output[$#ci_output] =~ /(\d+)/);
+	if (!defined $committed) {
+		my $out = join("\n",@ci_output);
+		print STDERR "W: Trouble parsing \`svn commit' output:\n\n",
+				$out, "\n\nAssuming English locale...";
+		($committed) = ($out =~ /^Committed revision \d+\./sm);
+		defined $committed or die " FAILED!\n",
 			"Commit output failed to parse committed revision!\n",
-			join("\n",@ci_output),"\n";
-	my ($rev_committed) = ($committed =~ /^Committed revision (\d+)\./);
+		print STDERR " OK\n";
+	}
 
 	my @svn_up = qw(svn up);
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-	if ($rev_committed == ($svn_rev + 1)) {
-		push @svn_up, "-r$rev_committed";
+	if ($committed == ($svn_rev + 1)) {
+		push @svn_up, "-r$committed";
 		sys(@svn_up);
 		my $info = svn_info('.');
 		my $date = $info->{'Last Changed Date'} or die "Missing date\n";
-		if ($info->{'Last Changed Rev'} != $rev_committed) {
-			croak "$info->{'Last Changed Rev'} != $rev_committed\n"
+		if ($info->{'Last Changed Rev'} != $committed) {
+			croak "$info->{'Last Changed Rev'} != $committed\n"
 		}
 		my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
 					/(\d{4})\-(\d\d)\-(\d\d)\s
@@ -728,16 +740,16 @@ sub svn_commit_tree {
 					 or croak "Failed to parse date: $date\n";
 		$log_msg{date} = "$tz $Y-$m-$d $H:$M:$S";
 		$log_msg{author} = $info->{'Last Changed Author'};
-		$log_msg{revision} = $rev_committed;
+		$log_msg{revision} = $committed;
 		$log_msg{msg} .= "\n";
 		my $parent = file_to_s("$REV_DIR/$svn_rev");
 		git_commit(\%log_msg, $parent, $commit);
-		return $rev_committed;
+		return $committed;
 	}
 	# resync immediately
 	push @svn_up, "-r$svn_rev";
 	sys(@svn_up);
-	return fetch("$rev_committed=$commit")->{revision};
+	return fetch("$committed=$commit")->{revision};
 }
 
 # read the entire log into a temporary file (which is removed ASAP)
-- 
1.3.3.g2dc7b-dirty
