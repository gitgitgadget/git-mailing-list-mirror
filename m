From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/13] git-svn: Move all git-svn-related paths into $GIT_DIR/svn
Date: Tue, 13 Jun 2006 11:02:07 -0700
Message-ID: <11502217421355-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE9-0004t6-08
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFMSCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWFMSCZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47301 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932069AbWFMSCX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 661E97DC020;
	Tue, 13 Jun 2006 11:02:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:22 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21798>

Since GIT_SVN_ID usage is probably going to become more
widespread <evil grin>, we won't run the chance of somebody
having a GIT_SVN_ID name that conflicts with one of the default
directories that already exist in $GIT_DIR (branches/tags).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl     |   99 ++++++++++++++++++++++++++++++++------
 contrib/git-svn/t/lib-git-svn.sh |    2 -
 2 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 54f3d63..2dce4e7 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -6,7 +6,7 @@ use strict;
 use vars qw/	$AUTHOR $VERSION
 		$SVN_URL $SVN_INFO $SVN_WC $SVN_UUID
 		$GIT_SVN_INDEX $GIT_SVN
-		$GIT_DIR $REV_DIR/;
+		$GIT_DIR $REV_DIR $GIT_SVN_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '1.1.0-pre';
 
@@ -37,6 +37,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_version, $_upgrade, $_authors, $_branch_all_refs);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
+my @repo_path_split_cache;
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
@@ -100,10 +101,11 @@ GetOptions(%opts, 'help|H|h' => \$_help,
 		'id|i=s' => \$GIT_SVN) or exit 1;
 
 $GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
-$GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
+$GIT_SVN_DIR = "$GIT_DIR/svn/$GIT_SVN";
+$GIT_SVN_INDEX = "$GIT_SVN_DIR/index";
 $SVN_URL = undef;
-$REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
-$SVN_WC = "$GIT_DIR/$GIT_SVN/tree";
+$REV_DIR = "$GIT_SVN_DIR/revs";
+$SVN_WC = "$GIT_SVN_DIR/tree";
 
 usage(0) if $_help;
 version() if $_version;
@@ -111,6 +113,7 @@ usage(1) unless defined $cmd;
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
 svn_compat_check();
+migration_check() unless $cmd eq 'init';
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
 
@@ -200,7 +203,7 @@ sub rebuild {
 			$latest = $rev;
 		}
 		assert_revision_eq_or_unknown($rev, $c);
-		sys('git-update-ref',"$GIT_SVN/revs/$rev",$c);
+		sys('git-update-ref',"svn/$GIT_SVN/revs/$rev",$c);
 		$newest_rev = $rev if ($rev > $newest_rev);
 	}
 	close $rev_list or croak $?;
@@ -241,7 +244,7 @@ sub init {
 sub fetch {
 	my (@parents) = @_;
 	check_upgrade_needed();
-	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
+	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
 	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
 	unless ($_revision) {
 		$_revision = -d $SVN_WC ? 'BASE:HEAD' : '0:HEAD';
@@ -350,7 +353,7 @@ sub show_ignore {
 	chomp(my @excludes = (<$fh>));
 	close $fh or croak $!;
 
-	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
+	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
 	chdir $SVN_WC or croak $!;
 	my %ign;
 	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
@@ -374,7 +377,44 @@ sub read_uuid {
 	my $info = shift || svn_info('.');
 	$SVN_UUID = $info->{'Repository UUID'} or
 					croak "Repository UUID unreadable\n";
-	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
+	s_to_file($SVN_UUID,"$GIT_SVN_DIR/info/uuid");
+}
+
+sub quiet_run {
+	my $pid = fork;
+	defined $pid or croak $!;
+	if (!$pid) {
+		open my $null, '>', '/dev/null' or croak $!;
+		open STDERR, '>&', $null or croak $!;
+		open STDOUT, '>&', $null or croak $!;
+		exec @_ or croak $!;
+	}
+	waitpid $pid, 0;
+	return $?;
+}
+
+sub repo_path_split {
+	my $full_url = shift;
+	$full_url =~ s#/+$##;
+
+	foreach (@repo_path_split_cache) {
+		if ($full_url =~ s#$_##) {
+			my $u = $1;
+			$full_url =~ s#^/+##;
+			return ($u, $full_url);
+		}
+	}
+
+	my ($url, $path) = ($full_url =~ m!^([a-z\+]+://[^/]*)(.*)$!i);
+	$path =~ s#^/+##;
+	my @paths = split(m#/+#, $path);
+
+	while (quiet_run(qw/svn ls --non-interactive/, $url)) {
+		my $n = shift @paths || last;
+		$url .= "/$n";
+	}
+	push @repo_path_split_cache, qr/^(\Q$url\E)/;
+	return ($url, $path);
 }
 
 sub setup_git_svn {
@@ -382,14 +422,17 @@ sub setup_git_svn {
 	unless (-d $GIT_DIR) {
 		croak "GIT_DIR=$GIT_DIR does not exist!\n";
 	}
-	mkpath(["$GIT_DIR/$GIT_SVN"]);
-	mkpath(["$GIT_DIR/$GIT_SVN/info"]);
+	mkpath([$GIT_SVN_DIR]);
+	mkpath(["$GIT_SVN_DIR/info"]);
 	mkpath([$REV_DIR]);
-	s_to_file($SVN_URL,"$GIT_DIR/$GIT_SVN/info/url");
+	s_to_file($SVN_URL,"$GIT_SVN_DIR/info/url");
 
-	open my $fd, '>>', "$GIT_DIR/$GIT_SVN/info/exclude" or croak $!;
+	open my $fd, '>>', "$GIT_SVN_DIR/info/exclude" or croak $!;
 	print $fd '.svn',"\n";
 	close $fd or croak $!;
+	my ($url, $path) = repo_path_split($SVN_URL);
+	s_to_file($url, "$GIT_SVN_DIR/info/repo_url");
+	s_to_file($path, "$GIT_SVN_DIR/info/repo_path");
 }
 
 sub assert_svn_wc_clean {
@@ -688,7 +731,7 @@ sub handle_rmdir {
 
 sub svn_commit_tree {
 	my ($svn_rev, $commit) = @_;
-	my $commit_msg = "$GIT_DIR/$GIT_SVN/.svn-commit.tmp.$$";
+	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 	my %log_msg = ( msg => '' );
 	open my $msg, '>', $commit_msg or croak $!;
 
@@ -965,7 +1008,7 @@ sub index_changes {
 			'remove',
 			$no_text_base);
 	do_update_index([qw/git-ls-files -z --others/,
-			      "--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude"],
+				"--exclude-from=$GIT_SVN_DIR/info/exclude"],
 			'add',
 			$no_text_base);
 }
@@ -1097,7 +1140,7 @@ sub git_commit {
 		push @update_ref, $primary_parent unless $?;
 	}
 	sys(@update_ref);
-	sys('git-update-ref',"$GIT_SVN/revs/$log_msg->{revision}",$commit);
+	sys('git-update-ref',"svn/$GIT_SVN/revs/$log_msg->{revision}",$commit);
 	print "r$log_msg->{revision} = $commit\n";
 	return $commit;
 }
@@ -1283,6 +1326,32 @@ sub svn_propget_base {
 	return safe_qx(qw/svn propget/, $p, $f);
 }
 
+sub migration_check {
+	return if (-d "$GIT_DIR/svn" || !-d $GIT_DIR);
+	print "Upgrading repository...\n";
+	unless (-d "$GIT_DIR/svn") {
+		mkdir "$GIT_DIR/svn" or croak $!;
+	}
+	print "Data from a previous version of git-svn exists, but\n\t",
+				"$GIT_SVN_DIR\n\t(required for this version ",
+				"($VERSION) of git-svn) does not.\n";
+
+	foreach my $x (`git-rev-parse --symbolic --all`) {
+		next unless $x =~ s#^refs/remotes/##;
+		chomp $x;
+		next unless -f "$GIT_DIR/$x/info/url";
+		my $u = eval { file_to_s("$GIT_DIR/$x/info/url") };
+		next unless $u;
+		my $dn = dirname("$GIT_DIR/svn/$x");
+		mkpath([$dn]) unless -d $dn;
+		rename "$GIT_DIR/$x", "$GIT_DIR/svn/$x" or croak "$!: $x";
+		my ($url, $path) = repo_path_split($u);
+		s_to_file($url, "$GIT_DIR/svn/$x/info/repo_url");
+		s_to_file($path, "$GIT_DIR/svn/$x/info/repo_path");
+	}
+	print "Done upgrading.\n";
+}
+
 __END__
 
 Data structures:
diff --git a/contrib/git-svn/t/lib-git-svn.sh b/contrib/git-svn/t/lib-git-svn.sh
index a98e9d1..58408a6 100644
--- a/contrib/git-svn/t/lib-git-svn.sh
+++ b/contrib/git-svn/t/lib-git-svn.sh
@@ -10,7 +10,7 @@ fi
 . ./test-lib.sh
 
 GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/git-svn
+GIT_SVN_DIR=$GIT_DIR/svn/git-svn
 SVN_TREE=$GIT_SVN_DIR/tree
 
 svnadmin >/dev/null 2>&1
-- 
1.4.0
