X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: enable delta transfers during fetches when using SVN:: libs
Date: Mon, 27 Nov 2006 21:44:48 -0800
Message-ID: <20061128054448.GA396@soma>
References: <loom.20061124T143148-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 05:45:09 +0000 (UTC)
Cc: git@vger.kernel.org, Pazu <pazu@pazu.com.br>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20061124T143148-286@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32485>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Govm3-00026r-9Y for gcvg-git@gmane.org; Tue, 28 Nov
 2006 06:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935631AbWK1Fow (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 00:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935633AbWK1Fow
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 00:44:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9962 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935631AbWK1Fov (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 00:44:51 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 3B42B2DC034; Mon, 27 Nov 2006 21:44:49 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 27 Nov 2006
 21:44:48 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This should drastically reduce bandwidth used for network
transfers.  This is not enabled for file:// repositories by
default because of the increased CPU usage and I/O needed.

GIT_SVN_DELTA_FETCH may be set to a true value to enable or
false (0) to disable delta transfers regardless of the
repository type.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d5d9c49..9b86d91 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -68,7 +68,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
 	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive,
-	$_username, $_config_dir, $_no_auth_cache);
+	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -2675,6 +2675,9 @@ sub libsvn_load {
 		require SVN::Ra;
 		require SVN::Delta;
 		push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
+		push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
+		*SVN::Git::Fetcher::process_rm = *process_rm;
+		*SVN::Git::Fetcher::safe_qx = *safe_qx;
 		my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
 					$SVN::Node::dir.$SVN::Node::unknown.
 					$SVN::Node::none.$SVN::Node::file.
@@ -2827,6 +2830,13 @@ sub libsvn_connect {
 	                      config => $config,
 	                      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
+
+	my $df = $ENV{GIT_SVN_DELTA_FETCH};
+	if (defined $df) {
+		$_xfer_delta = $df;
+	} else {
+		$_xfer_delta = ($url =~ m#^file://#) ? undef : 1;
+	}
 	$ra->{svn_path} = $url;
 	$ra->{repos_root} = $ra->get_repos_root;
 	$ra->{svn_path} =~ s#^\Q$ra->{repos_root}\E/*##;
@@ -2915,6 +2925,24 @@ sub process_rm {
 }
 
 sub libsvn_fetch {
+	$_xfer_delta ? libsvn_fetch_delta(@_) : libsvn_fetch_full(@_);
+}
+
+sub libsvn_fetch_delta {
+	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
+	my $pool = SVN::Pool->new;
+	my $ed = SVN::Git::Fetcher->new({ c => $last_commit, ra => $SVN,
+	                                  paths => $paths });
+	my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
+	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+	my (undef, $last_rev, undef) = cmt_metadata($last_commit);
+	$reporter->set_path('', $last_rev, 0, @lock, $pool);
+	$reporter->finish_report($pool);
+	$pool->clear;
+	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
+}
+
+sub libsvn_fetch_full {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	my @amr;
@@ -3133,7 +3161,11 @@ sub libsvn_find_parent_branch {
 		unlink $GIT_SVN_INDEX;
 		print STDERR "Found branch parent: ($GIT_SVN) $parent\n";
 		sys(qw/git-read-tree/, $parent);
-		return libsvn_fetch($parent, $paths, $rev,
+		# I can't seem to get do_switch() to work correctly with
+		# the SWIG interface (TypeError when passing switch_url...),
+		# so we'll unconditionally bypass the delta interface here
+		# for now
+		return libsvn_fetch_full($parent, $paths, $rev,
 					$author, $date, $msg);
 	}
 	print STDERR "Nope, branch point not imported or unknown\n";
@@ -3153,9 +3185,19 @@ sub libsvn_new_tree {
 		return $log_entry;
 	}
 	my ($paths, $rev, $author, $date, $msg) = @_;
-	open my $gui, '| git-update-index -z --index-info' or croak $!;
-	libsvn_traverse($gui, '', $SVN->{svn_path}, $rev);
-	close $gui or croak $?;
+	if ($_xfer_delta) {
+		my $pool = SVN::Pool->new;
+		my $ed = SVN::Git::Fetcher->new({paths => $paths, ra => $SVN});
+		my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
+		my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+		$reporter->set_path('', $rev, 1, @lock, $pool);
+		$reporter->finish_report($pool);
+		$pool->clear;
+	} else {
+		open my $gui, '| git-update-index -z --index-info' or croak $!;
+		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev);
+		close $gui or croak $?;
+	}
 	return libsvn_log_entry($rev, $author, $date, $msg);
 }
 
@@ -3325,6 +3367,148 @@ sub copy_remote_ref {
 				"refs/remotes/$GIT_SVN on $origin\n";
 	}
 }
+package SVN::Git::Fetcher;
+use vars qw/@ISA/;
+use strict;
+use warnings;
+use Carp qw/croak/;
+use IO::File qw//;
+
+# file baton members: path, mode_a, mode_b, pool, fh, blob, base
+sub new {
+	my ($class, $git_svn) = @_;
+	my $self = SVN::Delta::Editor->new;
+	bless $self, $class;
+	open my $gui, '| git-update-index -z --index-info' or croak $!;
+	$self->{gui} = $gui;
+	$self->{c} = $git_svn->{c} if exists $git_svn->{c};
+	if (my $p = $git_svn->{paths} && $git_svn->{ra}) {
+		my $s = $git_svn->{ra}->{svn_path};
+		$s = length $s ? qr#^/\Q$s\E/# : qr#^/#;
+		$self->{paths} = { map { my $x = $_;
+		                         $x =~ s/$s//;
+		                         $x => $p->{$_} } keys %$p };
+	}
+	require Digest::MD5;
+	$self;
+}
+
+sub delete_entry {
+	my ($self, $path, $rev, $pb) = @_;
+	process_rm($self->{gui}, $self->{c}, $path);
+	undef;
+}
+
+sub open_file {
+	my ($self, $path, $pb, $rev) = @_;
+	my ($mode, $blob) = (safe_qx('git-ls-tree',$self->{c},'--',$path)
+	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
+	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
+	  pool => SVN::Pool->new };
+}
+
+sub add_file {
+	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
+	{ path => $path, mode_a => 100644, mode_b => 100644,
+	  pool => SVN::Pool->new };
+}
+
+sub change_file_prop {
+	my ($self, $fb, $prop, $value) = @_;
+	if ($prop eq 'svn:executable') {
+		if ($fb->{mode_b} != 120000) {
+			$fb->{mode_b} = defined $value ? 100755 : 100644;
+		}
+	} elsif ($prop eq 'svn:special') {
+		$fb->{mode_b} = defined $value ? 120000 : 100644;
+	}
+	undef;
+}
+
+sub apply_textdelta {
+	my ($self, $fb, $exp) = @_;
+	my $fh = IO::File->new_tmpfile;
+	$fh->autoflush(1);
+	# $fh gets auto-closed() by SVN::TxDelta::apply(),
+	# (but $base does not,) so dup() it for reading in close_file
+	open my $dup, '<&', $fh or croak $!;
+	my $base = IO::File->new_tmpfile;
+	$base->autoflush(1);
+	if ($fb->{blob}) {
+		defined (my $pid = fork) or croak $!;
+		if (!$pid) {
+			open STDOUT, '>&', $base or croak $!;
+			print STDOUT 'link ' if ($fb->{mode_a} == 120000);
+			exec qw/git-cat-file blob/, $fb->{blob} or croak $!;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
+
+		if (defined $exp) {
+			seek $base, 0, 0 or croak $!;
+			my $md5 = Digest::MD5->new;
+			$md5->addfile($base);
+			my $got = $md5->hexdigest;
+			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
+			    "expected: $exp\n",
+			    "     got: $got\n" if ($got ne $exp);
+		}
+	}
+	seek $base, 0, 0 or croak $!;
+	$fb->{fh} = $dup;
+	$fb->{base} = $base;
+	[ SVN::TxDelta::apply($base, $fh, undef, $fb->{path}, $fb->{pool}) ];
+}
+
+sub close_file {
+	my ($self, $fb, $exp) = @_;
+	my $hash;
+	my $path = $fb->{path};
+	if (my $fh = $fb->{fh}) {
+		seek($fh, 0, 0) or croak $!;
+		my $md5 = Digest::MD5->new;
+		$md5->addfile($fh);
+		my $got = $md5->hexdigest;
+		die "Checksum mismatch: $path\n",
+		    "expected: $exp\n    got: $got\n" if ($got ne $exp);
+		seek($fh, 0, 0) or croak $!;
+		if ($fb->{mode_b} == 120000) {
+			read($fh, my $buf, 5) == 5 or croak $!;
+			$buf eq 'link ' or die "$path has mode 120000",
+			                       "but is not a link\n";
+		}
+		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
+		if (!$pid) {
+			open STDIN, '<&', $fh or croak $!;
+			exec qw/git-hash-object -w --stdin/ or croak $!;
+		}
+		chomp($hash = do { local $/; <$out> });
+		close $out or croak $!;
+		close $fh or croak $!;
+		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
+		close $fb->{base} or croak $!;
+	} else {
+		$hash = $fb->{blob} or die "no blob information\n";
+	}
+	$fb->{pool}->clear;
+	my $gui = $self->{gui};
+	print $gui "$fb->{mode_b} $hash\t$path\0" or croak $!;
+	print "\t", $self->{paths}->{$path}->action,
+	      "\t$path\n" if defined $self->{paths}->{$path};
+	undef;
+}
+
+sub abort_edit {
+	my $self = shift;
+	close $self->{gui};
+	$self->SUPER::abort_edit(@_);
+}
+
+sub close_edit {
+	my $self = shift;
+	close $self->{gui} or croak;
+	$self->SUPER::close_edit(@_);
+}
 
 package SVN::Git::Editor;
 use vars qw/@ISA/;
-- 
1.4.4.1.g22a08
