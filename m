Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3392018B
	for <e@80x24.org>; Tue, 19 Jul 2016 03:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbcGSD6N (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 23:58:13 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34788 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbcGSD6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 23:58:04 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so491913pac.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 20:58:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkBs0/wsjNmYsO8b2YaPUAV/nqjYtSPybOEPNuMGL+k=;
        b=IdzfTcA9jJhM9crwrkf4Svxm4mvAGtr76JvGxqV3++8NZtFxv1joUNtFOdXyjy1k3g
         Z8lwaCrz2Z5nK+cF7MKaJcbNPTMXP8DTTZfsiGLciyuFgPtzysLqpV+zrW5MgL6/03iC
         c5hcAP9Xb44VUxiO+03sM1OMbLwW72YiCAAWnue0MRUMqrDYHBpJXBtYgy5UwNF1Guy7
         VZFwR+EIzqJylraPwpUuj5e776gp7j3WPRgT7SUxgqqP04NMGUb0QpKaM5U6Z42PdEAa
         b86WZ+9bHPsXy69vi8k1gagZ2bcEXbanghdDO/2mlIqE7x6+VrKx55u2tshOo84gYHWF
         IquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkBs0/wsjNmYsO8b2YaPUAV/nqjYtSPybOEPNuMGL+k=;
        b=jDMdc3mElPJvExvFTkvt8LinvuaqrJ+efWIzujzCeqOR/uoasGO0LcsFujYG47dSJ7
         FuPmC58EffwU+JaAdPQqXtYbAkdY+ogzNkyN2xNtkF0+xyLdmxGDhn/VmJ9vyzH2tmV7
         EdomdztwM0mgsRD8EmUDwS6fqSmAMUKBulduZHaftvIkpjT0FvWpXCI33+sLu7ni5Tep
         gLdWe5GFm+SOAvvez+kgQpBshSxIY9GIYATypAyUVMG6wFOVHISqBUPjgr+m/tG4leKV
         nJcbdk2LPe/zvu/UvEQwxyKUhC5QDeIDSIOytlViwdkrZe7Czm9QS4vA/5jSPnQ0NLTt
         JGcA==
X-Gm-Message-State: ALyK8tJIo35QK9ZzfzS2rK93qdhriUv0GRRB3Jebj38flSmVn/So3/qpl75ULKWD46kPww==
X-Received: by 10.66.181.139 with SMTP id dw11mr62458011pac.2.1468900683734;
        Mon, 18 Jul 2016 20:58:03 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id xs12sm172523pac.7.2016.07.18.20.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 20:58:02 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] difftool: use Git::* functions instead of passing around state
Date:	Mon, 18 Jul 2016 20:57:56 -0700
Message-Id: <20160719035756.24961-3-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.280.g385e27a
In-Reply-To: <20160719035756.24961-1-davvid@gmail.com>
References: <20160719035756.24961-1-davvid@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Call Git::command() and friends directly wherever possible.
This makes it clear that these operations can be invoked directly
without needing to manage the current directory and related GIT_*
environment variables.

Eliminate find_repository() since we can now use wc_path() and
not worry about side-effects involving environment variables.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 54 ++++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index bc2267f..a5790d0 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -37,14 +37,6 @@ USAGE
 	exit($exitcode);
 }
 
-sub find_worktree
-{
-	# Git->repository->wc_path() does not honor changes to the working
-	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
-	# config variable.
-	return Git::command_oneline('rev-parse', '--show-toplevel');
-}
-
 sub print_tool_help
 {
 	# See the comment at the bottom of file_diff() for the reason behind
@@ -67,14 +59,14 @@ sub exit_cleanup
 
 sub use_wt_file
 {
-	my ($repo, $workdir, $file, $sha1) = @_;
+	my ($workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
 	if (-l "$workdir/$file" || ! -e _) {
 		return (0, $null_sha1);
 	}
 
-	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	my $wt_sha1 = Git::command_oneline('hash-object', "$workdir/$file");
 	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
 	return ($use, $wt_sha1);
 }
@@ -88,11 +80,11 @@ sub changed_files
 	my @refreshargs = (
 		@gitargs, 'update-index',
 		'--really-refresh', '-q', '--unmerged');
-	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
 	try {
 		Git::command_oneline(@refreshargs);
 	} catch Git::Error::Command with {};
 
+	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
 	my $line = Git::command_oneline(@diffargs);
 	my @files;
 	if (defined $line) {
@@ -108,11 +100,9 @@ sub changed_files
 
 sub setup_dir_diff
 {
-	my ($repo, $workdir, $symlinks) = @_;
-
-	my $repo_path = $repo->repo_path();
+	my ($workdir, $symlinks) = @_;
 	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
-	my $diffrtn = $repo->command_oneline(@gitargs);
+	my $diffrtn = Git::command_oneline(@gitargs);
 	exit(0) unless defined($diffrtn);
 
 	# Build index info for left and right sides of the diff
@@ -164,12 +154,12 @@ EOF
 
 		if ($lmode eq $symlink_mode) {
 			$symlink{$src_path}{left} =
-				$repo->command_oneline('show', "$lsha1");
+				Git::command_oneline('show', $lsha1);
 		}
 
 		if ($rmode eq $symlink_mode) {
 			$symlink{$dst_path}{right} =
-				$repo->command_oneline('show', "$rsha1");
+				Git::command_oneline('show', $rsha1);
 		}
 
 		if ($lmode ne $null_mode and $status !~ /^C/) {
@@ -181,8 +171,8 @@ EOF
 			if ($working_tree_dups{$dst_path}++) {
 				next;
 			}
-			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
-							  $dst_path, $rsha1);
+			my ($use, $wt_sha1) =
+				use_wt_file($workdir, $dst_path, $rsha1);
 			if ($use) {
 				push @working_tree, $dst_path;
 				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
@@ -203,27 +193,27 @@ EOF
 	my ($inpipe, $ctx);
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
 	($inpipe, $ctx) =
-		$repo->command_input_pipe(qw(update-index -z --index-info));
+		Git::command_input_pipe('update-index', '-z', '--index-info');
 	print($inpipe $lindex);
-	$repo->command_close_pipe($inpipe, $ctx);
+	Git::command_close_pipe($inpipe, $ctx);
 
 	my $rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
 	exit_cleanup($tmpdir, $rc) if $rc != 0;
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
 	($inpipe, $ctx) =
-		$repo->command_input_pipe(qw(update-index -z --index-info));
+		Git::command_input_pipe('update-index', '-z', '--index-info');
 	print($inpipe $rindex);
-	$repo->command_close_pipe($inpipe, $ctx);
+	Git::command_close_pipe($inpipe, $ctx);
 
 	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
 	exit_cleanup($tmpdir, $rc) if $rc != 0;
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/wtindex";
 	($inpipe, $ctx) =
-		$repo->command_input_pipe(qw(update-index --info-only -z --index-info));
+		Git::command_input_pipe('update-index', '--info-only', '-z', '--index-info');
 	print($inpipe $wtindex);
-	$repo->command_close_pipe($inpipe, $ctx);
+	Git::command_close_pipe($inpipe, $ctx);
 
 	# If $GIT_DIR was explicitly set just for the update/checkout
 	# commands, then it should be unset before continuing.
@@ -393,9 +383,9 @@ sub dir_diff
 	my $rc;
 	my $error = 0;
 	my $repo = Git->repository();
-	my $workdir = find_worktree();
-	my ($a, $b, $tmpdir, @worktree) =
-		setup_dir_diff($repo, $workdir, $symlinks);
+	my $repo_path = $repo->repo_path();
+	my $workdir = $repo->wc_path();
+	my ($a, $b, $tmpdir, @worktree) = setup_dir_diff($workdir, $symlinks);
 
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
@@ -421,10 +411,10 @@ sub dir_diff
 		next if ! -f "$b/$file";
 
 		if (!$indices_loaded) {
-			%wt_modified = changed_files($repo->repo_path(),
-				"$tmpdir/wtindex", "$workdir");
-			%tmp_modified = changed_files($repo->repo_path(),
-				"$tmpdir/wtindex", "$b");
+			%wt_modified = changed_files(
+				$repo_path, "$tmpdir/wtindex", $workdir);
+			%tmp_modified = changed_files(
+				$repo_path, "$tmpdir/wtindex", $b);
 			$indices_loaded = 1;
 		}
 
-- 
2.9.2.280.g385e27a

