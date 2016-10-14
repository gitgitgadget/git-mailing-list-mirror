Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A50E209A9
	for <e@80x24.org>; Fri, 14 Oct 2016 01:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756338AbcJNBsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 21:48:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51424 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756285AbcJNBsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 21:48:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E95DA216A0;
        Fri, 14 Oct 2016 01:46:27 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Mathieu Arnold <mat@FreeBSD.org>
Cc:     =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH 2/2] git-svn: "git worktree" awareness
Date:   Fri, 14 Oct 2016 01:46:23 +0000
Message-Id: <20161014014623.15223-3-e@80x24.org>
In-Reply-To: <20161014014623.15223-1-e@80x24.org>
References: <20161014014623.15223-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-svn internals were previously not aware of repository
layout differences for users of the "git worktree" command.
Introduce this awareness by using "git rev-parse --git-path"
instead of relying on outdated uses of GIT_DIR and friends.

Thanks-to: Duy Nguyen <pclouds@gmail.com>
Reported-by: Mathieu Arnold <mat@freebsd.org>
Signed-off-by: Eric Wong <e@80x24.org>
---
 git-svn.perl              |  9 +++++----
 perl/Git/SVN.pm           | 24 +++++++++++++++---------
 perl/Git/SVN/Migration.pm | 37 ++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6d1a142..fa42364 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1700,7 +1700,7 @@ sub cmd_gc {
 		     "files will not be compressed.\n";
 	}
 	File::Find::find({ wanted => \&gc_directory, no_chdir => 1},
-			 "$ENV{GIT_DIR}/svn");
+			 Git::SVN::svn_dir());
 }
 
 ########################### utility functions #########################
@@ -1734,7 +1734,7 @@ sub post_fetch_checkout {
 	return unless verify_ref('HEAD^0');
 
 	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
-	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
+	my $index = command_oneline(qw(rev-parse --git-path index));
 	return if -f $index;
 
 	return if command_oneline(qw/rev-parse --is-inside-work-tree/) eq 'false';
@@ -1836,8 +1836,9 @@ sub get_tree_from_treeish {
 sub get_commit_entry {
 	my ($treeish) = shift;
 	my %log_entry = ( log => '', tree => get_tree_from_treeish($treeish) );
-	my $commit_editmsg = "$ENV{GIT_DIR}/COMMIT_EDITMSG";
-	my $commit_msg = "$ENV{GIT_DIR}/COMMIT_MSG";
+	my @git_path = qw(rev-parse --git-path);
+	my $commit_editmsg = command_oneline(@git_path, 'COMMIT_EDITMSG');
+	my $commit_msg = command_oneline(@git_path, 'COMMIT_MSG');
 	open my $log_fh, '>', $commit_editmsg or croak $!;
 
 	my $type = command_oneline(qw/cat-file -t/, $treeish);
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 018beb8..499e84b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -807,10 +807,15 @@ sub get_fetch_range {
 	(++$min, $max);
 }
 
+sub svn_dir {
+	command_oneline(qw(rev-parse --git-path svn));
+}
+
 sub tmp_config {
 	my (@args) = @_;
-	my $old_def_config = "$ENV{GIT_DIR}/svn/config";
-	my $config = "$ENV{GIT_DIR}/svn/.metadata";
+	my $svn_dir = svn_dir();
+	my $old_def_config = "$svn_dir/config";
+	my $config = "$svn_dir/.metadata";
 	if (! -f $config && -f $old_def_config) {
 		rename $old_def_config, $config or
 		       die "Failed rename $old_def_config => $config: $!\n";
@@ -1671,7 +1676,7 @@ sub tie_for_persistent_memoization {
 		return if $memoized;
 		$memoized = 1;
 
-		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		my $cache_path = svn_dir() . '/.caches/';
 		mkpath([$cache_path]) unless -d $cache_path;
 
 		my %lookup_svn_merge_cache;
@@ -1712,7 +1717,7 @@ sub tie_for_persistent_memoization {
 	sub clear_memoized_mergeinfo_caches {
 		die "Only call this method in non-memoized context" if ($memoized);
 
-		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		my $cache_path = svn_dir() . '/.caches/';
 		return unless -d $cache_path;
 
 		for my $cache_file (("$cache_path/lookup_svn_merge",
@@ -2446,12 +2451,13 @@ sub _new {
 		             "refs/remotes/$prefix$default_ref_id";
 	}
 	$_[1] = $repo_id;
-	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
+	my $svn_dir = svn_dir();
+	my $dir = "$svn_dir/$ref_id";
 
-	# Older repos imported by us used $GIT_DIR/svn/foo instead of
-	# $GIT_DIR/svn/refs/remotes/foo when tracking refs/remotes/foo
+	# Older repos imported by us used $svn_dir/foo instead of
+	# $svn_dir/refs/remotes/foo when tracking refs/remotes/foo
 	if ($ref_id =~ m{^refs/remotes/(.+)}) {
-		my $old_dir = "$ENV{GIT_DIR}/svn/$1";
+		my $old_dir = "$svn_dir/$1";
 		if (-d $old_dir && ! -d $dir) {
 			$dir = $old_dir;
 		}
@@ -2461,7 +2467,7 @@ sub _new {
 	mkpath([$dir]);
 	my $obj = bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
-	        config => "$ENV{GIT_DIR}/svn/config",
+	        config => "$svn_dir/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
 
 	# Ensure it gets canonicalized
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index cf6ffa7..dc90f6a 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -44,7 +44,9 @@ use Git qw(
 	command_noisy
 	command_output_pipe
 	command_close_pipe
+	command_oneline
 );
+use Git::SVN;
 
 sub migrate_from_v0 {
 	my $git_dir = $ENV{GIT_DIR};
@@ -55,7 +57,9 @@ sub migrate_from_v0 {
 		chomp;
 		my ($id, $orig_ref) = ($_, $_);
 		next unless $id =~ s#^refs/heads/(.+)-HEAD$#$1#;
-		next unless -f "$git_dir/$id/info/url";
+		my $info_url = command_oneline(qw(rev-parse --git-path),
+						"$id/info/url");
+		next unless -f $info_url;
 		my $new_ref = "refs/remotes/$id";
 		if (::verify_ref("$new_ref^0")) {
 			print STDERR "W: $orig_ref is probably an old ",
@@ -82,7 +86,7 @@ sub migrate_from_v1 {
 	my $git_dir = $ENV{GIT_DIR};
 	my $migrated = 0;
 	return $migrated unless -d $git_dir;
-	my $svn_dir = "$git_dir/svn";
+	my $svn_dir = Git::SVN::svn_dir();
 
 	# just in case somebody used 'svn' as their $id at some point...
 	return $migrated if -d $svn_dir && ! -f "$svn_dir/info/url";
@@ -97,27 +101,28 @@ sub migrate_from_v1 {
 		my $x = $_;
 		next unless $x =~ s#^refs/remotes/##;
 		chomp $x;
-		next unless -f "$git_dir/$x/info/url";
-		my $u = eval { ::file_to_s("$git_dir/$x/info/url") };
+		my $info_url = command_oneline(qw(rev-parse --git-path),
+						"$x/info/url");
+		next unless -f $info_url;
+		my $u = eval { ::file_to_s($info_url) };
 		next unless $u;
-		my $dn = dirname("$git_dir/svn/$x");
+		my $dn = dirname("$svn_dir/$x");
 		mkpath([$dn]) unless -d $dn;
 		if ($x eq 'svn') { # they used 'svn' as GIT_SVN_ID:
-			mkpath(["$git_dir/svn/svn"]);
+			mkpath(["$svn_dir/svn"]);
 			print STDERR " - $git_dir/$x/info => ",
-			                "$git_dir/svn/$x/info\n";
-			rename "$git_dir/$x/info", "$git_dir/svn/$x/info" or
+			                "$svn_dir/$x/info\n";
+			rename "$git_dir/$x/info", "$svn_dir/$x/info" or
 			       croak "$!: $x";
 			# don't worry too much about these, they probably
 			# don't exist with repos this old (save for index,
 			# and we can easily regenerate that)
 			foreach my $f (qw/unhandled.log index .rev_db/) {
-				rename "$git_dir/$x/$f", "$git_dir/svn/$x/$f";
+				rename "$git_dir/$x/$f", "$svn_dir/$x/$f";
 			}
 		} else {
-			print STDERR " - $git_dir/$x => $git_dir/svn/$x\n";
-			rename "$git_dir/$x", "$git_dir/svn/$x" or
-			       croak "$!: $x";
+			print STDERR " - $git_dir/$x => $svn_dir/$x\n";
+			rename "$git_dir/$x", "$svn_dir/$x" or croak "$!: $x";
 		}
 		$migrated++;
 	}
@@ -139,9 +144,10 @@ sub read_old_urls {
 			push @dir, $_;
 		}
 	}
+	my $svn_dir = Git::SVN::svn_dir();
 	foreach (@dir) {
 		my $x = $_;
-		$x =~ s!^\Q$ENV{GIT_DIR}\E/svn/!!o;
+		$x =~ s!^\Q$svn_dir\E/!!o;
 		read_old_urls($l_map, $x, $_);
 	}
 }
@@ -150,7 +156,7 @@ sub migrate_from_v2 {
 	my @cfg = command(qw/config -l/);
 	return if grep /^svn-remote\..+\.url=/, @cfg;
 	my %l_map;
-	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
+	read_old_urls(\%l_map, '', Git::SVN::svn_dir());
 	my $migrated = 0;
 
 	require Git::SVN;
@@ -239,7 +245,8 @@ sub minimize_connections {
 		}
 	}
 	if (@emptied) {
-		my $file = $ENV{GIT_CONFIG} || "$ENV{GIT_DIR}/config";
+		my $file = $ENV{GIT_CONFIG} ||
+			command_oneline(qw(rev-parse --git-path config));
 		print STDERR <<EOF;
 The following [svn-remote] sections in your config file ($file) are empty
 and can be safely removed:
-- 
EW

