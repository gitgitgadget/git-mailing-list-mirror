From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 6/13] git-svn: minor cleanups, extra error-checking
Date: Tue, 13 Jun 2006 11:02:08 -0700
Message-ID: <11502217433396-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE6-0004t6-90
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWFMSC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWFMSC0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48069 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932083AbWFMSCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BDFC37DC021;
	Tue, 13 Jun 2006 11:02:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:23 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21799>

While we're at it, read_repo_config has been added and
expanded to handle case where command-line arguments are
optional to Getopt::Long

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   82 ++++++++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 2dce4e7..a243060 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -77,39 +77,15 @@ for (my $i = 0; $i < @ARGV; $i++) {
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
-# convert GetOpt::Long specs for use by git-repo-config
-foreach my $o (keys %opts) {
-	my $v = $opts{$o};
-	my ($key) = ($o =~ /^([a-z\-]+)/);
-	$key =~ s/-//g;
-	my $arg = 'git-repo-config';
-	$arg .= ' --int' if ($o =~ /=i$/);
-	$arg .= ' --bool' if ($o !~ /=[sfi]$/);
-	if (ref $v eq 'ARRAY') {
-		chomp(my @tmp = `$arg --get-all svn.$key`);
-		@$v = @tmp if @tmp;
-	} else {
-		chomp(my $tmp = `$arg --get svn.$key`);
-		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
-			$$v = $tmp;
-		}
-	}
-}
-
+read_repo_config(\%opts);
 GetOptions(%opts, 'help|H|h' => \$_help,
 		'version|V' => \$_version,
 		'id|i=s' => \$GIT_SVN) or exit 1;
 
-$GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
-$GIT_SVN_DIR = "$GIT_DIR/svn/$GIT_SVN";
-$GIT_SVN_INDEX = "$GIT_SVN_DIR/index";
-$SVN_URL = undef;
-$REV_DIR = "$GIT_SVN_DIR/revs";
-$SVN_WC = "$GIT_SVN_DIR/tree";
-
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
+init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
 svn_compat_check();
@@ -132,7 +108,7 @@ Usage: $0 <command> [options] [arguments
 		print $fd '  ',pack('A13',$_),$cmd{$_}->[1],"\n";
 		foreach (keys %{$cmd{$_}->[2]}) {
 			# prints out arguments as they should be passed:
-			my $x = s#=s$## ? '<arg>' : s#=i$## ? '<num>' : '';
+			my $x = s#[:=]s$## ? '<arg>' : s#[:=]i$## ? '<num>' : '';
 			print $fd ' ' x 17, join(', ', map { length $_ > 1 ?
 							"--$_" : "-$_" }
 						split /\|/,$_)," $x\n";
@@ -220,9 +196,10 @@ sub rebuild {
 		sys(@svn_up,"-r$newest_rev");
 		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
 		index_changes();
-		exec('git-write-tree');
+		exec('git-write-tree') or croak $!;
 	}
 	waitpid $pid, 0;
+	croak $? if $?;
 
 	if ($_upgrade) {
 		print STDERR <<"";
@@ -295,6 +272,7 @@ sub fetch {
 	unless (-e "$GIT_DIR/refs/heads/master") {
 		sys(qw(git-update-ref refs/heads/master),$last_commit);
 	}
+	close $svn_log->{fh};
 	return $last;
 }
 
@@ -830,7 +808,7 @@ sub svn_log_raw {
 		exec (qw(svn log), @log_args) or croak $!
 	}
 	waitpid $pid, 0;
-	croak if $?;
+	croak $? if $?;
 	seek $log_fh, 0, 0 or croak $!;
 	return { state => 'sep', fh => $log_fh };
 }
@@ -1090,7 +1068,7 @@ sub git_commit {
 		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
 		index_changes();
 		chomp(my $tree = `git-write-tree`);
-		croak if $?;
+		croak $? if $?;
 		if (exists $tree_map{$tree}) {
 			my %seen_parent = map { $_ => 1 } @exec_parents;
 			foreach (@{$tree_map{$tree}}) {
@@ -1118,7 +1096,7 @@ sub git_commit {
 		exec @exec or croak $!;
 	}
 	waitpid($pid,0);
-	croak if $?;
+	croak $? if $?;
 
 	$out_fh->flush == 0 or croak $!;
 	seek $out_fh, 0, 0 or croak $!;
@@ -1134,7 +1112,7 @@ sub git_commit {
 			close STDERR;
 			close STDOUT;
 			exec 'git-rev-parse','--verify',
-						"refs/remotes/$GIT_SVN^0";
+					"refs/remotes/$GIT_SVN^0" or croak $!;
 		}
 		waitpid $pid, 0;
 		push @update_ref, $primary_parent unless $?;
@@ -1190,7 +1168,7 @@ sub blob_to_file {
 
 	if ($pid == 0) {
 		open STDOUT, '>&', $blob_fh or croak $!;
-		exec('git-cat-file','blob',$blob);
+		exec('git-cat-file','blob',$blob) or croak $!;
 	}
 	waitpid $pid, 0;
 	croak $? if $?;
@@ -1202,7 +1180,7 @@ sub safe_qx {
 	my $pid = open my $child, '-|';
 	defined $pid or croak $!;
 	if ($pid == 0) {
-		exec(@_) or croak $?;
+		exec(@_) or croak $!;
 	}
 	my @ret = (<$child>);
 	close $child or croak $?;
@@ -1252,7 +1230,7 @@ sub check_upgrade_needed {
 		defined $pid or croak $!;
 		if ($pid == 0) {
 			close STDERR;
-			exec('git-rev-parse',"$GIT_SVN-HEAD") or croak $?;
+			exec('git-rev-parse',"$GIT_SVN-HEAD") or croak $!;
 		}
 		my @ret = (<$child>);
 		close $child or croak $?;
@@ -1276,7 +1254,7 @@ sub map_tree_joins {
 		defined $pid or croak $!;
 		if ($pid == 0) {
 			exec(qw(git-rev-list --topo-order --pretty=raw), $br)
-								or croak $?;
+								or croak $!;
 		}
 		while (<$pipe>) {
 			if (/^commit ($sha1)$/o) {
@@ -1352,6 +1330,38 @@ sub migration_check {
 	print "Done upgrading.\n";
 }
 
+sub init_vars {
+	$GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
+	$GIT_SVN_DIR = "$GIT_DIR/svn/$GIT_SVN";
+	$GIT_SVN_INDEX = "$GIT_SVN_DIR/index";
+	$SVN_URL = undef;
+	$REV_DIR = "$GIT_SVN_DIR/revs";
+	$SVN_WC = "$GIT_SVN_DIR/tree";
+}
+
+# convert GetOpt::Long specs for use by git-repo-config
+sub read_repo_config {
+	return unless -d $GIT_DIR;
+	my $opts = shift;
+	foreach my $o (keys %$opts) {
+		my $v = $opts->{$o};
+		my ($key) = ($o =~ /^([a-z\-]+)/);
+		$key =~ s/-//g;
+		my $arg = 'git-repo-config';
+		$arg .= ' --int' if ($o =~ /[:=]i$/);
+		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
+		if (ref $v eq 'ARRAY') {
+			chomp(my @tmp = `$arg --get-all svn.$key`);
+			@$v = @tmp if @tmp;
+		} else {
+			chomp(my $tmp = `$arg --get svn.$key`);
+			if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
+				$$v = $tmp;
+			}
+		}
+	}
+}
+
 __END__
 
 Data structures:
-- 
1.4.0
