From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/9] contrib/git-svn: allow --authors-file to be specified
Date: Fri, 3 Mar 2006 01:20:08 -0800
Message-ID: <11413776082506-git-send-email-normalperson@yhbt.net>
References: <11413776082010-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Si-00041U-7K
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbWCCJUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbWCCJUO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:65410 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752199AbWCCJUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:08 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8AB6B7DC023;
	Fri,  3 Mar 2006 01:20:08 -0800 (PST)
In-Reply-To: <11413776082010-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17144>

Syntax is compatible with git-svnimport and git-cvsimport:

	normalperson = Eric Wong <normalperson@yhbt.net>

If this option is specified and git-svn encounters an SVN
committer name that it cannot parse, it git-svn will abort.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

c501f8378dfb5529993755caaf99ca632418e382
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index edae9d4..c2b4ee9 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,8 +34,8 @@ use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
-	$_find_copies_harder, $_l, $_version, $_upgrade);
-my (@_branch_from, %tree_map);
+	$_find_copies_harder, $_l, $_version, $_upgrade, $_authors);
+my (@_branch_from, %tree_map, %users);
 
 GetOptions(	'revision|r=s' => \$_revision,
 		'no-ignore-externals' => \$_no_ignore_ext,
@@ -46,6 +46,7 @@ GetOptions(	'revision|r=s' => \$_revisio
 		'help|H|h' => \$_help,
 		'branch|b=s' => \@_branch_from,
 		'find-copies-harder' => \$_find_copies_harder,
+		'authors-file|authors|A=s' => \$_authors,
 		'l=i' => \$_l,
 		'version|V' => \$_version,
 		'no-stop-on-copy' => \$_no_stop_copy );
@@ -73,6 +74,19 @@ foreach (keys %cmd) {
 		last;
 	}
 }
+
+# '<svn username> = real-name <email address>' mapping based on git-svnimport:
+if ($_authors) {
+	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
+	while (<$authors>) {
+		chomp;
+		next unless /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/;
+		my ($user, $name, $email) = ($1, $2, $3);
+		$users{$user} = [$name, $email];
+	}
+	close $authors or croak $!;
+}
+
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless (defined $cmd);
@@ -740,6 +754,10 @@ sub svn_log_raw {
 					author => $author,
 					lines => $lines,
 					msg => '' );
+			if (defined $_authors && ! defined $users{$author}) {
+				die "Author: $author not defined in ",
+						"$_authors file\n";
+			}
 			push @svn_log, \%log_msg;
 			$state = 'msg_start';
 			next;
@@ -884,12 +902,8 @@ sub git_commit {
 		$msg_fh->flush == 0 or croak $!;
 		seek $msg_fh, 0, 0 or croak $!;
 
-		$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} =
-						$log_msg->{author};
-		$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} =
-						$log_msg->{author}."\@$uuid";
-		$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} =
-						$log_msg->{date};
+		set_commit_env($log_msg, $uuid);
+
 		my @exec = ('git-commit-tree',$tree);
 		push @exec, '-p', $_  foreach @exec_parents;
 		open STDIN, '<&', $msg_fh or croak $!;
@@ -915,6 +929,16 @@ sub git_commit {
 	return $commit;
 }
 
+sub set_commit_env {
+	my ($log_msg, $uuid) = @_;
+	my $author = $log_msg->{author};
+	my ($name,$email) = defined $users{$author} ?  @{$users{$author}}
+				: ($author,"$author\@$uuid");
+	$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} = $name;
+	$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} = $email;
+	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_msg->{date};
+}
+
 sub apply_mod_line_blob {
 	my $m = shift;
 	if ($m->{mode_b} =~ /^120/) {
-- 
1.2.3.g4676
