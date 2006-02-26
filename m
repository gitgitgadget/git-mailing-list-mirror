From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: optimize sequential commits to svn
Date: Sun, 26 Feb 2006 02:22:27 -0800
Message-ID: <11409493473344-git-send-email-normalperson@yhbt.net>
References: <11409493473353-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 26 11:22:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDJ2x-0003Fz-2O
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 11:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWBZKW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 05:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWBZKW3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 05:22:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57250 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751314AbWBZKW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 05:22:28 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C60812DC089;
	Sun, 26 Feb 2006 02:22:27 -0800 (PST)
In-Reply-To: <11409493473353-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16778>

Avoid running 'svn up' to a previous revision if we know the
revision we just committed is the first descendant of the
revision we came from.

This reduces the time to do a series of commits by about 25%.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

ea810425ed7d5d16c12b3f49246ba2a03ac3d23d
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 84d43de..29c8690 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -30,6 +30,7 @@ use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use File::Spec qw//;
+use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{6,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
@@ -591,6 +592,7 @@ sub handle_rmdir {
 sub svn_commit_tree {
 	my ($svn_rev, $commit) = @_;
 	my $commit_msg = "$GIT_DIR/$GIT_SVN/.svn-commit.tmp.$$";
+	my %log_msg = ( msg => '' );
 	open my $msg, '>', $commit_msg  or croak $!;
 
 	chomp(my $type = `git-cat-file -t $commit`);
@@ -606,6 +608,7 @@ sub svn_commit_tree {
 			if (!$in_msg) {
 				$in_msg = 1 if (/^\s*$/);
 			} else {
+				$log_msg{msg} .= $_;
 				print $msg $_ or croak $!;
 			}
 		}
@@ -625,9 +628,30 @@ sub svn_commit_tree {
 			join("\n",@ci_output),"\n";
 	my ($rev_committed) = ($committed =~ /^Committed revision (\d+)\./);
 
-	# resync immediately
-	my @svn_up = (qw(svn up), "-r$svn_rev");
+	my @svn_up = qw(svn up);
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
+	if ($rev_committed == ($svn_rev + 1)) {
+		push @svn_up, "-r$rev_committed";
+		sys(@svn_up);
+		my $info = svn_info('.');
+		my $date = $info->{'Last Changed Date'} or die "Missing date\n";
+		if ($info->{'Last Changed Rev'} != $rev_committed) {
+			croak "$info->{'Last Changed Rev'} != $rev_committed\n"
+		}
+		my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
+					/(\d{4})\-(\d\d)\-(\d\d)\s
+					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
+					 or croak "Failed to parse date: $date\n";
+		$log_msg{date} = "$tz $Y-$m-$d $H:$M:$S";
+		$log_msg{author} = $info->{'Last Changed Author'};
+		$log_msg{revision} = $rev_committed;
+		$log_msg{msg} .= "\n";
+		my $parent = file_to_s("$REV_DIR/$svn_rev");
+		git_commit(\%log_msg, $parent, $commit);
+		return $rev_committed;
+	}
+	# resync immediately
+	push @svn_up, "-r$svn_rev";
 	sys(@svn_up);
 	return fetch("$rev_committed=$commit")->{revision};
 }
@@ -724,7 +748,7 @@ sub svn_info {
 	# only single-lines seem to exist in svn info output
 	while (<$info_fh>) {
 		chomp $_;
-		if (m#^([^:]+)\s*:\s*(\S*)$#) {
+		if (m#^([^:]+)\s*:\s*(\S.*)$#) {
 			$ret->{$1} = $2;
 			push @{$ret->{-order}}, $1;
 		}
-- 
1.2.2.ga559
