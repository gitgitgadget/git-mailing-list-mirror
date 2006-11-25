X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: correctly access repos when only given partial read permissions
Date: Fri, 24 Nov 2006 22:38:17 -0800
Message-ID: <11644366982320-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Sat, 25 Nov 2006 06:39:17 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32257>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnrBc-0007K5-MD for gcvg-git@gmane.org; Sat, 25 Nov
 2006 07:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757848AbWKYGiV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 01:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757849AbWKYGiV
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 01:38:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58330 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757848AbWKYGiU (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 01:38:20 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 97DFB2DC035; Fri, 24 Nov 2006 22:38:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 22:38:18 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Sometimes users are given only read access to a subtree inside a
repository, and git-svn could not read log information (and thus
fetch commits) when connecting a session to the root of the
repository.  We now start an SVN::Ra session with the full URL
of what we're tracking, and not the repository root as before.

This change was made much easier with a cleanup of
repo_path_split() usage as well as improving the accounting of
authentication batons.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  137 +++++++++++++++++++++++++++------------------------------
 1 files changed, 65 insertions(+), 72 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 47cd3e2..5d67771 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -39,7 +39,7 @@ memoize('revisions_eq');
 memoize('cmt_metadata');
 memoize('get_commit_time');
 
-my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib, $AUTH_BATON, $AUTH_CALLBACKS);
+my ($SVN, $_use_lib);
 
 sub nag_lib {
 	print STDERR <<EOF;
@@ -381,10 +381,7 @@ sub fetch_cmd {
 sub fetch_lib {
 	my (@parents) = @_;
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
-	my $repo;
-	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
-	$SVN_LOG ||= libsvn_connect($repo);
-	$SVN ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($SVN_URL);
 	my ($last_rev, $last_commit) = svn_grab_base_rev();
 	my ($base, $head) = libsvn_parse_revision($last_rev);
 	if ($base > $head) {
@@ -426,7 +423,7 @@ sub fetch_lib {
 			# performance sucks with it enabled, so it's much
 			# faster to fetch revision ranges instead of relying
 			# on the limiter.
-			libsvn_get_log($SVN_LOG, '/'.$SVN_PATH,
+			libsvn_get_log(libsvn_dup_ra($SVN), [''],
 					$min, $max, 0, 1, 1,
 				sub {
 					my $log_msg;
@@ -528,7 +525,6 @@ sub commit_lib {
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 
 	my $repo;
-	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
 	set_svn_commit_env();
 	foreach my $c (@revs) {
 		my $log_msg = get_commit_message($c, $commit_msg);
@@ -537,13 +533,11 @@ sub commit_lib {
 		# can't track down... (it's probably in the SVN code)
 		defined(my $pid = open my $fh, '-|') or croak $!;
 		if (!$pid) {
-			$SVN_LOG = libsvn_connect($repo);
-			$SVN = libsvn_connect($repo);
 			my $ed = SVN::Git::Editor->new(
 					{	r => $r_last,
-						ra => $SVN_LOG,
+						ra => libsvn_dup_ra($SVN),
 						c => $c,
-						svn_path => $SVN_PATH
+						svn_path => $SVN->{svn_path},
 					},
 					$SVN->get_commit_editor(
 						$log_msg->{msg},
@@ -661,10 +655,9 @@ sub show_ignore_cmd {
 
 sub show_ignore_lib {
 	my $repo;
-	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
-	$SVN ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($SVN_URL);
 	my $r = defined $_revision ? $_revision : $SVN->get_latest_revnum;
-	libsvn_traverse_ignore(\*STDOUT, $SVN_PATH, $r);
+	libsvn_traverse_ignore(\*STDOUT, $SVN->{svn_path}, $r);
 }
 
 sub graft_branches {
@@ -790,7 +783,7 @@ sub show_log {
 		} elsif (/^:\d{6} \d{6} $sha1_short/o) {
 			push @{$c->{raw}}, $_;
 		} elsif (/^[ACRMDT]\t/) {
-			# we could add $SVN_PATH here, but that requires
+			# we could add $SVN->{svn_path} here, but that requires
 			# remote access at the moment (repo_path_split)...
 			s#^([ACRMDT])\t#   $1 #;
 			push @{$c->{changed}}, $_;
@@ -856,10 +849,7 @@ sub commit_diff {
 		$_message ||= get_commit_message($tb,
 					"$GIT_DIR/.svn-commit.tmp.$$")->{msg};
 	}
-	my $repo;
-	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
-	$SVN_LOG ||= libsvn_connect($repo);
-	$SVN ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($SVN_URL);
 	if ($r eq 'HEAD') {
 		$r = $SVN->get_latest_revnum;
 	} elsif ($r !~ /^\d+$/) {
@@ -868,8 +858,9 @@ sub commit_diff {
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 	my $rev_committed;
 	my $ed = SVN::Git::Editor->new({	r => $r,
-						ra => $SVN_LOG, c => $tb,
-						svn_path => $SVN_PATH
+						ra => libsvn_dup_ra($SVN),
+						c => $tb,
+						svn_path => $SVN->{svn_path}
 					},
 				$SVN->get_commit_editor($_message,
 					sub {
@@ -1147,8 +1138,7 @@ sub graft_file_copy_lib {
 	my $tree_paths = $l_map->{$u};
 	my $pfx = common_prefix([keys %$tree_paths]);
 	my ($repo, $path) = repo_path_split($u.$pfx);
-	$SVN_LOG ||= libsvn_connect($repo);
-	$SVN ||= libsvn_connect($repo);
+	$SVN = libsvn_connect($repo);
 
 	my ($base, $head) = libsvn_parse_revision();
 	my $inc = 1000;
@@ -1157,7 +1147,8 @@ sub graft_file_copy_lib {
 	$SVN::Error::handler = \&libsvn_skip_unknown_revs;
 	while (1) {
 		my $pool = SVN::Pool->new;
-		libsvn_get_log($SVN_LOG, "/$path", $min, $max, 0, 1, 1,
+		libsvn_get_log(libsvn_dup_ra($SVN), [$path],
+		               $min, $max, 0, 1, 1,
 			sub {
 				libsvn_graft_file_copies($grafts, $tree_paths,
 							$path, @_);
@@ -1267,13 +1258,9 @@ sub repo_path_split {
 			return ($u, $full_url);
 		}
 	}
-
 	if ($_use_lib) {
 		my $tmp = libsvn_connect($full_url);
-		my $url = $tmp->get_repos_root;
-		$full_url =~ s#^\Q$url\E/*##;
-		push @repo_path_split_cache, qr/^(\Q$url\E)/;
-		return ($url, $full_url);
+		return ($tmp->{repos_root}, $tmp->{svn_path});
 	} else {
 		my ($url, $path) = ($full_url =~ m!^([a-z\+]+://[^/]*)(.*)$!i);
 		$path =~ s#^/+##;
@@ -2815,34 +2802,41 @@ sub _read_password {
 
 sub libsvn_connect {
 	my ($url) = @_;
-	if (!$AUTH_BATON || !$AUTH_CALLBACKS) {
-		SVN::_Core::svn_config_ensure($_config_dir, undef);
-		($AUTH_BATON, $AUTH_CALLBACKS) = SVN::Core::auth_open_helper([
-		    SVN::Client::get_simple_provider(),
-		    SVN::Client::get_ssl_server_trust_file_provider(),
-		    SVN::Client::get_simple_prompt_provider(
-		      \&_simple_prompt, 2),
-		    SVN::Client::get_ssl_client_cert_prompt_provider(
-		      \&_ssl_client_cert_prompt, 2),
-		    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
-		      \&_ssl_client_cert_pw_prompt, 2),
-		    SVN::Client::get_username_provider(),
-		    SVN::Client::get_ssl_server_trust_prompt_provider(
-		      \&_ssl_server_trust_prompt),
-		    SVN::Client::get_username_prompt_provider(
-		      \&_username_prompt, 2),
-		  ]);
-	}
-	SVN::Ra->new(url => $url, auth => $AUTH_BATON,
-	             auth_provider_callbacks => $AUTH_CALLBACKS);
+	SVN::_Core::svn_config_ensure($_config_dir, undef);
+	my ($baton, $callbacks) = SVN::Core::auth_open_helper([
+	    SVN::Client::get_simple_provider(),
+	    SVN::Client::get_ssl_server_trust_file_provider(),
+	    SVN::Client::get_simple_prompt_provider(
+	      \&_simple_prompt, 2),
+	    SVN::Client::get_ssl_client_cert_prompt_provider(
+	      \&_ssl_client_cert_prompt, 2),
+	    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
+	      \&_ssl_client_cert_pw_prompt, 2),
+	    SVN::Client::get_username_provider(),
+	    SVN::Client::get_ssl_server_trust_prompt_provider(
+	      \&_ssl_server_trust_prompt),
+	    SVN::Client::get_username_prompt_provider(
+	      \&_username_prompt, 2),
+	  ]);
+	my $ra = SVN::Ra->new(url => $url, auth => $baton,
+	                      pool => SVN::Pool->new,
+	                      auth_provider_callbacks => $callbacks);
+	$ra->{svn_path} = $url;
+	$ra->{repos_root} = $ra->get_repos_root;
+	$ra->{svn_path} =~ s#^\Q$ra->{repos_root}\E/*##;
+	push @repo_path_split_cache, qr/^(\Q$ra->{repos_root}\E)/;
+	return $ra;
+}
+
+sub libsvn_dup_ra {
+	my ($ra) = @_;
+	SVN::Ra->new(map { $_ => $ra->{$_} }
+	             qw/url auth auth_provider_callbacks repos_root svn_path/);
 }
 
 sub libsvn_get_file {
 	my ($gui, $f, $rev, $chg) = @_;
-	my $p = $f;
-	if (length $SVN_PATH > 0) {
-		return unless ($p =~ s#^\Q$SVN_PATH\E/##);
-	}
+	$f =~ s#^/##;
 	print "\t$chg\t$f\n" unless $_q;
 
 	my ($hash, $pid, $in, $out);
@@ -2879,7 +2873,7 @@ sub libsvn_get_file {
 		waitpid $pid, 0;
 		$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
 	}
-	print $gui $mode,' ',$hash,"\t",$p,"\0" or croak $!;
+	print $gui $mode,' ',$hash,"\t",$f,"\0" or croak $!;
 }
 
 sub libsvn_log_entry {
@@ -2897,7 +2891,6 @@ sub libsvn_log_entry {
 
 sub process_rm {
 	my ($gui, $last_commit, $f) = @_;
-	$f =~ s#^\Q$SVN_PATH\E/?## or return;
 	# remove entire directories.
 	if (safe_qx('git-ls-tree',$last_commit,'--',$f) =~ /^040000 tree/) {
 		defined(my $pid = open my $ls, '-|') or croak $!;
@@ -2919,9 +2912,11 @@ sub libsvn_fetch {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	my @amr;
+	my $p = $SVN->{svn_path};
 	foreach my $f (keys %$paths) {
 		my $m = $paths->{$f}->action();
-		$f =~ s#^/+##;
+		$f =~ s#^/\Q$p\E/##;
+		next if $f =~ m#^/#;
 		if ($m =~ /^[DR]$/) {
 			print "\t$m\t$f\n" unless $_q;
 			process_rm($gui, $last_commit, $f);
@@ -3011,9 +3006,9 @@ sub libsvn_parse_revision {
 
 sub libsvn_traverse {
 	my ($gui, $pfx, $path, $rev, $files) = @_;
-	my $cwd = "$pfx/$path";
+	my $cwd = length $pfx ? "$pfx/$path" : $path;
 	my $pool = SVN::Pool->new;
-	$cwd =~ s#^/+##g;
+	$cwd =~ s#^\Q$SVN->{svn_path}\E##;
 	my ($dirent, $r, $props) = $SVN->get_dir($cwd, $rev, $pool);
 	foreach my $d (keys %$dirent) {
 		my $t = $dirent->{$d}->kind;
@@ -3037,7 +3032,7 @@ sub libsvn_traverse_ignore {
 	my $pool = SVN::Pool->new;
 	my ($dirent, undef, $props) = $SVN->get_dir($path, $r, $pool);
 	my $p = $path;
-	$p =~ s#^\Q$SVN_PATH\E/?##;
+	$p =~ s#^\Q$SVN->{svn_path}\E/##;
 	print $fh length $p ? "\n# $p\n" : "\n# /\n";
 	if (my $s = $props->{'svn:ignore'}) {
 		$s =~ s/[\r\n]+/\n/g;
@@ -3064,7 +3059,7 @@ sub revisions_eq {
 	if ($_use_lib) {
 		# should be OK to use Pool here (r1 - r0) should be small
 		my $pool = SVN::Pool->new;
-		libsvn_get_log($SVN, "/$path", $r0, $r1,
+		libsvn_get_log($SVN, [$path], $r0, $r1,
 				0, 1, 1, sub {$nr++}, $pool);
 		$pool->clear;
 	} else {
@@ -3079,7 +3074,7 @@ sub revisions_eq {
 
 sub libsvn_find_parent_branch {
 	my ($paths, $rev, $author, $date, $msg) = @_;
-	my $svn_path = '/'.$SVN_PATH;
+	my $svn_path = '/'.$SVN->{svn_path};
 
 	# look for a parent from another branch:
 	my $i = $paths->{$svn_path} or return;
@@ -3090,7 +3085,7 @@ sub libsvn_find_parent_branch {
 	$branch_from =~ s#^/##;
 	my $l_map = {};
 	read_url_paths_all($l_map, '', "$GIT_DIR/svn");
-	my $url = $SVN->{url};
+	my $url = $SVN->{repos_root};
 	defined $l_map->{$url} or return;
 	my $id = $l_map->{$url}->{$branch_from};
 	if (!defined $id && $_follow_parent) {
@@ -3112,7 +3107,7 @@ sub libsvn_find_parent_branch {
 			$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
 			init_vars();
 			$SVN_URL = "$url/$branch_from";
-			$SVN_LOG = $SVN = undef;
+			$SVN = undef;
 			setup_git_svn();
 			# we can't assume SVN_URL exists at r+1:
 			$_revision = "0:$r";
@@ -3149,7 +3144,7 @@ sub libsvn_new_tree {
 	}
 	my ($paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
-	libsvn_traverse($gui, '', $SVN_PATH, $rev);
+	libsvn_traverse($gui, '', $SVN->{svn_path}, $rev);
 	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg);
 }
@@ -3234,11 +3229,10 @@ sub libsvn_commit_cb {
 
 sub libsvn_ls_fullurl {
 	my $fullurl = shift;
-	my ($repo, $path) = repo_path_split($fullurl);
-	$SVN ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($fullurl);
 	my @ret;
 	my $pool = SVN::Pool->new;
-	my ($dirent, undef, undef) = $SVN->get_dir($path,
+	my ($dirent, undef, undef) = $SVN->get_dir($SVN->{svn_path},
 						$SVN->get_latest_revnum, $pool);
 	foreach my $d (keys %$dirent) {
 		if ($dirent->{$d}->kind == $SVN::Node::dir) {
@@ -3260,8 +3254,9 @@ sub libsvn_skip_unknown_revs {
 	# Wonderfully consistent library, eh?
 	# 160013 - svn:// and file://
 	# 175002 - http(s)://
+	# 175007 - http(s):// (this repo required authorization, too...)
 	#   More codes may be discovered later...
-	if ($errno == 175002 || $errno == 160013) {
+	if ($errno == 175007 || $errno == 175002 || $errno == 160013) {
 		return;
 	}
 	croak "Error from SVN, ($errno): ", $err->expanded_message,"\n";
@@ -3349,8 +3344,7 @@ sub split_path {
 }
 
 sub repo_path {
-	(defined $_[1] && length $_[1]) ? "$_[0]->{svn_path}/$_[1]"
-					: $_[0]->{svn_path}
+	(defined $_[1] && length $_[1]) ? $_[1] : ''
 }
 
 sub url_path {
@@ -3382,10 +3376,9 @@ sub rmdirs {
 		exec qw/git-ls-tree --name-only -r -z/, $self->{c} or croak $!;
 	}
 	local $/ = "\0";
-	my @svn_path = split m#/#, $self->{svn_path};
 	while (<$fh>) {
 		chomp;
-		my @dn = (@svn_path, (split m#/#, $_));
+		my @dn = split m#/#, $_;
 		while (pop @dn) {
 			delete $rm->{join '/', @dn};
 		}
-- 
1.4.4.1.g22a08
