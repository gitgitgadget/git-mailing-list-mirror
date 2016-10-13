Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3D1215F6
	for <e@80x24.org>; Thu, 13 Oct 2016 02:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933610AbcJMCJM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 22:09:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42378 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933475AbcJMCJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 22:09:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 65D11215F6;
        Thu, 13 Oct 2016 01:52:33 +0000 (UTC)
Date:   Thu, 13 Oct 2016 01:52:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Mathieu Arnold <mat@freebsd.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org
Subject: Re: problem with git worktree and git svn
Message-ID: <20161013015233.GA18001@whir>
References: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
 <CAGZ79kZo5W1r0s26G3foB7caP6+u66mdzqzyneqXBX_B7A0RKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZo5W1r0s26G3foB7caP6+u66mdzqzyneqXBX_B7A0RKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> On Wed, Oct 12, 2016 at 7:45 AM, Mathieu Arnold <mat@freebsd.org> wrote:
> 
> > I discovered git worktree earlier this week, and I found it a great
> > asset to be able to have more than one branch of my worktree accessible
> > at the same time...
> >
> > Anyway, back to my problem, the way git-svn works, is that it looks for
> > a directory named "svn" in its gitdir and if it is not present, decide
> > the repository is using git-svn version 1 (whatever that is) and goes to
> > parse all the revisions to recreate the svn directory.
> > So I can only use git svn commands in my main worktree, the one with the
> > real gitdir.

Right, I haven't updated git-svn to be worktree-aware, yet, but
a work-in-progress is below

> > To fix that, all I had to do is to add a symlink named svn in each
> > worktree's gitdir and pointing to ../../svn.
> 
> For some definition of fix. ;)
> Sure it fixes your local setup now, but would we want to use that as well here?
> My gut reaction:
> 
> * not all platforms know symlinks
> * IIRC there is some worktree magic that tells you the "main" dir,
>   so if that was used in git-svn instead it should "just work".
> 
> >
> > I think all that needs to happen is that when adding a new worktree, if
> > the main git directory has a "svn" directory, add a symlink to it in the
> > worktree's gitdir.

I'm fairly sure the worktree C code should not care about how
git-svn works, but rather git-svn should be made aware of
worktree bits...

I haven't studied worktrees much nor do I use git-svn much,
but the following seems to work for fetch/rebase/dcommit:

------------8<-----------
Subject: [PATCH] git-svn: WIP worktree awareness

---
 perl/Git/SVN.pm           | 29 ++++++++++++++++++++---------
 perl/Git/SVN/Migration.pm | 23 ++++++++++++-----------
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 018beb8..267cc09 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -807,10 +807,20 @@ sub get_fetch_range {
 	(++$min, $max);
 }
 
+sub svn_dir {
+	my $git_dir = scalar @_ ? $_[0] : $ENV{GIT_DIR};
+	my $common = $ENV{GIT_COMMON_DIR} || "$git_dir/commondir";
+	$git_dir .= '/'.::file_to_s($common) if -e $common;
+	my $svn_dir = $git_dir . '/svn';
+	$svn_dir =~ tr!/!/!s;
+	$svn_dir;
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
@@ -1671,7 +1681,7 @@ sub tie_for_persistent_memoization {
 		return if $memoized;
 		$memoized = 1;
 
-		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		my $cache_path = svn_dir() . '/.caches/';
 		mkpath([$cache_path]) unless -d $cache_path;
 
 		my %lookup_svn_merge_cache;
@@ -1712,7 +1722,7 @@ sub tie_for_persistent_memoization {
 	sub clear_memoized_mergeinfo_caches {
 		die "Only call this method in non-memoized context" if ($memoized);
 
-		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		my $cache_path = svn_dir() . '/.caches/';
 		return unless -d $cache_path;
 
 		for my $cache_file (("$cache_path/lookup_svn_merge",
@@ -2446,12 +2456,13 @@ sub _new {
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
@@ -2461,7 +2472,7 @@ sub _new {
 	mkpath([$dir]);
 	my $obj = bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
-	        config => "$ENV{GIT_DIR}/svn/config",
+	        config => "$svn_dir/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
 
 	# Ensure it gets canonicalized
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index cf6ffa7..887fd93 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -45,6 +45,7 @@ use Git qw(
 	command_output_pipe
 	command_close_pipe
 );
+use Git::SVN;
 
 sub migrate_from_v0 {
 	my $git_dir = $ENV{GIT_DIR};
@@ -82,7 +83,7 @@ sub migrate_from_v1 {
 	my $git_dir = $ENV{GIT_DIR};
 	my $migrated = 0;
 	return $migrated unless -d $git_dir;
-	my $svn_dir = "$git_dir/svn";
+	my $svn_dir = Git::SVN::svn_dir($git_dir);
 
 	# just in case somebody used 'svn' as their $id at some point...
 	return $migrated if -d $svn_dir && ! -f "$svn_dir/info/url";
@@ -100,24 +101,23 @@ sub migrate_from_v1 {
 		next unless -f "$git_dir/$x/info/url";
 		my $u = eval { ::file_to_s("$git_dir/$x/info/url") };
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
@@ -139,9 +139,10 @@ sub read_old_urls {
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
@@ -150,7 +151,7 @@ sub migrate_from_v2 {
 	my @cfg = command(qw/config -l/);
 	return if grep /^svn-remote\..+\.url=/, @cfg;
 	my %l_map;
-	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
+	read_old_urls(\%l_map, '', Git::SVN::svn_dir());
 	my $migrated = 0;
 
 	require Git::SVN;
-- 
EW
