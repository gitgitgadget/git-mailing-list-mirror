From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] git-svn: make Git::SVN::Fetcher a separate file
Date: Mon, 28 May 2012 02:03:58 -0500
Message-ID: <20120528070358.GE10976@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120528003901.GA11103@burratino>
 <20120528065723.GC10976@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 28 09:04:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYtzw-0001BK-12
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 09:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab2E1HEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 03:04:05 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55049 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab2E1HED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 03:04:03 -0400
Received: by gglu4 with SMTP id u4so1654793ggl.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U2taRXmZYHk+Lykp36e1M7OutPf9xRrBL9RPNQ0r+4M=;
        b=bDyuOSUpyZeC9DGinpiaZAFLNNKCWNcT3JWc1gb6EniWbn5c1eicQa1XSAsbonBAmF
         q+iFQ45KGezath1GmKJF4MmnrEb72ioRK8QpBe3M80Wul5xDcaoxvDFe6TDE+/14acy7
         od+RMxnwbioxgtUH+2W2lfzgj3Qu/iUn7VmdiKwTfxBtD8RNh4I6yN4ygfaNmBFbSmPc
         WomUsBfk8zplXQ1JLMJO4mp2gSiQLckOEmmtwZ4ShtUgxP5U/EreggAOGxISTn4KRyt7
         SFJXrq4SQQNjNfeG/EMf9w5A46F6IX4A8woJY0X02nWodpTR1/BZZVtoUSmhDhhCadiq
         FJXQ==
Received: by 10.50.41.196 with SMTP id h4mr3763016igl.33.1338188641673;
        Mon, 28 May 2012 00:04:01 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ut5sm8237824igc.13.2012.05.28.00.04.00
        (version=SSLv3 cipher=OTHER);
        Mon, 28 May 2012 00:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120528065723.GC10976@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198631>

This patch removes a chunk of code (the Git::SVN::Fetcher consumer of
libsvn's tree delta protocol) from git-svn.perl and documents its
interface so the hurried reader does not have to read that code right
away.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl            |  507 +--------------------------------------
 perl/Git/SVN/Fetcher.pm |  602 +++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL        |    1 +
 3 files changed, 605 insertions(+), 505 deletions(-)
 create mode 100644 perl/Git/SVN/Fetcher.pm

diff --git a/git-svn.perl b/git-svn.perl
index d0bcf3f1..35073dea 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -69,7 +69,6 @@ sub _req_svn {
 my $can_compress = eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @Git::SVN::Editor::ISA, 'SVN::Delta::Editor';
-push @Git::SVN::Fetcher::ISA, 'SVN::Delta::Editor';
 use Carp qw/croak/;
 use Digest::MD5;
 use IO::File qw//;
@@ -80,6 +79,7 @@ use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Git::SVN::Fetcher qw//;
 use Git::SVN::Prompt qw//;
 use Memoize;  # core since 5.8.0, Jul 2002
 
@@ -89,7 +89,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Editor Git::SVN::Fetcher
+		for my $package ( qw(Git::SVN::Editor
 			Git::SVN::Migration Git::SVN::Log Git::SVN),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
@@ -4442,509 +4442,6 @@ sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
 
-package Git::SVN::Fetcher;
-use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
-            @deleted_gpath %added_placeholder $repo_id/;
-use strict;
-use warnings;
-use Carp qw/croak/;
-use File::Basename qw/dirname/;
-use IO::File qw//;
-
-# file baton members: path, mode_a, mode_b, pool, fh, blob, base
-sub new {
-	my ($class, $git_svn, $switch_path) = @_;
-	my $self = SVN::Delta::Editor->new;
-	bless $self, $class;
-	if (exists $git_svn->{last_commit}) {
-		$self->{c} = $git_svn->{last_commit};
-		$self->{empty_symlinks} =
-		                  _mark_empty_symlinks($git_svn, $switch_path);
-	}
-
-	# some options are read globally, but can be overridden locally
-	# per [svn-remote "..."] section.  Command-line options will *NOT*
-	# override options set in an [svn-remote "..."] section
-	$repo_id = $git_svn->{repo_id};
-	my $k = "svn-remote.$repo_id.ignore-paths";
-	my $v = eval { command_oneline('config', '--get', $k) };
-	$self->{ignore_regex} = $v;
-
-	$k = "svn-remote.$repo_id.preserve-empty-dirs";
-	$v = eval { command_oneline('config', '--get', '--bool', $k) };
-	if ($v && $v eq 'true') {
-		$_preserve_empty_dirs = 1;
-		$k = "svn-remote.$repo_id.placeholder-filename";
-		$v = eval { command_oneline('config', '--get', $k) };
-		$_placeholder_filename = $v;
-	}
-
-	# Load the list of placeholder files added during previous invocations.
-	$k = "svn-remote.$repo_id.added-placeholder";
-	$v = eval { command_oneline('config', '--get-all', $k) };
-	if ($_preserve_empty_dirs && $v) {
-		# command() prints errors to stderr, so we only call it if
-		# command_oneline() succeeded.
-		my @v = command('config', '--get-all', $k);
-		$added_placeholder{ dirname($_) } = $_ foreach @v;
-	}
-
-	$self->{empty} = {};
-	$self->{dir_prop} = {};
-	$self->{file_prop} = {};
-	$self->{absent_dir} = {};
-	$self->{absent_file} = {};
-	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
-	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
-	$self;
-}
-
-# this uses the Ra object, so it must be called before do_{switch,update},
-# not inside them (when the Git::SVN::Fetcher object is passed) to
-# do_{switch,update}
-sub _mark_empty_symlinks {
-	my ($git_svn, $switch_path) = @_;
-	my $bool = Git::config_bool('svn.brokenSymlinkWorkaround');
-	return {} if (!defined($bool)) || (defined($bool) && ! $bool);
-
-	my %ret;
-	my ($rev, $cmt) = $git_svn->last_rev_commit;
-	return {} unless ($rev && $cmt);
-
-	# allow the warning to be printed for each revision we fetch to
-	# ensure the user sees it.  The user can also disable the workaround
-	# on the repository even while git svn is running and the next
-	# revision fetched will skip this expensive function.
-	my $printed_warning;
-	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
-	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
-	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
-	$pfx .= '/' if length($pfx);
-	while (<$ls>) {
-		chomp;
-		s/\A100644 blob $empty_blob\t//o or next;
-		unless ($printed_warning) {
-			print STDERR "Scanning for empty symlinks, ",
-			             "this may take a while if you have ",
-				     "many empty files\n",
-				     "You may disable this with `",
-				     "git config svn.brokenSymlinkWorkaround ",
-				     "false'.\n",
-				     "This may be done in a different ",
-				     "terminal without restarting ",
-				     "git svn\n";
-			$printed_warning = 1;
-		}
-		my $path = $_;
-		my (undef, $props) =
-		               $git_svn->ra->get_file($pfx.$path, $rev, undef);
-		if ($props->{'svn:special'}) {
-			$ret{$path} = 1;
-		}
-	}
-	command_close_pipe($ls, $ctx);
-	\%ret;
-}
-
-# returns true if a given path is inside a ".git" directory
-sub in_dot_git {
-	$_[0] =~ m{(?:^|/)\.git(?:/|$)};
-}
-
-# return value: 0 -- don't ignore, 1 -- ignore
-sub is_path_ignored {
-	my ($self, $path) = @_;
-	return 1 if in_dot_git($path);
-	return 1 if defined($self->{ignore_regex}) &&
-	            $path =~ m!$self->{ignore_regex}!;
-	return 0 unless defined($_ignore_regex);
-	return 1 if $path =~ m!$_ignore_regex!o;
-	return 0;
-}
-
-sub set_path_strip {
-	my ($self, $path) = @_;
-	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
-}
-
-sub open_root {
-	{ path => '' };
-}
-
-sub open_directory {
-	my ($self, $path, $pb, $rev) = @_;
-	{ path => $path };
-}
-
-sub git_path {
-	my ($self, $path) = @_;
-	if (my $enc = $self->{pathnameencoding}) {
-		require Encode;
-		Encode::from_to($path, 'UTF-8', $enc);
-	}
-	if ($self->{path_strip}) {
-		$path =~ s!$self->{path_strip}!! or
-		  die "Failed to strip path '$path' ($self->{path_strip})\n";
-	}
-	$path;
-}
-
-sub delete_entry {
-	my ($self, $path, $rev, $pb) = @_;
-	return undef if $self->is_path_ignored($path);
-
-	my $gpath = $self->git_path($path);
-	return undef if ($gpath eq '');
-
-	# remove entire directories.
-	my ($tree) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
-	                 =~ /\A040000 tree ([a-f\d]{40})\t\Q$gpath\E\0/);
-	if ($tree) {
-		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
-		                                     -r --name-only -z/,
-				                     $tree);
-		local $/ = "\0";
-		while (<$ls>) {
-			chomp;
-			my $rmpath = "$gpath/$_";
-			$self->{gii}->remove($rmpath);
-			print "\tD\t$rmpath\n" unless $::_q;
-		}
-		print "\tD\t$gpath/\n" unless $::_q;
-		command_close_pipe($ls, $ctx);
-	} else {
-		$self->{gii}->remove($gpath);
-		print "\tD\t$gpath\n" unless $::_q;
-	}
-	# Don't add to @deleted_gpath if we're deleting a placeholder file.
-	push @deleted_gpath, $gpath unless $added_placeholder{dirname($path)};
-	$self->{empty}->{$path} = 0;
-	undef;
-}
-
-sub open_file {
-	my ($self, $path, $pb, $rev) = @_;
-	my ($mode, $blob);
-
-	goto out if $self->is_path_ignored($path);
-
-	my $gpath = $self->git_path($path);
-	($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
-	                     =~ /\A(\d{6}) blob ([a-f\d]{40})\t\Q$gpath\E\0/);
-	unless (defined $mode && defined $blob) {
-		die "$path was not found in commit $self->{c} (r$rev)\n";
-	}
-	if ($mode eq '100644' && $self->{empty_symlinks}->{$path}) {
-		$mode = '120000';
-	}
-out:
-	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
-	  pool => SVN::Pool->new, action => 'M' };
-}
-
-sub add_file {
-	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
-	my $mode;
-
-	if (!$self->is_path_ignored($path)) {
-		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
-		delete $self->{empty}->{$dir};
-		$mode = '100644';
-
-		if ($added_placeholder{$dir}) {
-			# Remove our placeholder file, if we created one.
-			delete_entry($self, $added_placeholder{$dir})
-				unless $path eq $added_placeholder{$dir};
-			delete $added_placeholder{$dir}
-		}
-	}
-
-	{ path => $path, mode_a => $mode, mode_b => $mode,
-	  pool => SVN::Pool->new, action => 'A' };
-}
-
-sub add_directory {
-	my ($self, $path, $cp_path, $cp_rev) = @_;
-	goto out if $self->is_path_ignored($path);
-	my $gpath = $self->git_path($path);
-	if ($gpath eq '') {
-		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
-		                                     -r --name-only -z/,
-				                     $self->{c});
-		local $/ = "\0";
-		while (<$ls>) {
-			chomp;
-			$self->{gii}->remove($_);
-			print "\tD\t$_\n" unless $::_q;
-			push @deleted_gpath, $gpath;
-		}
-		command_close_pipe($ls, $ctx);
-		$self->{empty}->{$path} = 0;
-	}
-	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
-	delete $self->{empty}->{$dir};
-	$self->{empty}->{$path} = 1;
-
-	if ($added_placeholder{$dir}) {
-		# Remove our placeholder file, if we created one.
-		delete_entry($self, $added_placeholder{$dir});
-		delete $added_placeholder{$dir}
-	}
-
-out:
-	{ path => $path };
-}
-
-sub change_dir_prop {
-	my ($self, $db, $prop, $value) = @_;
-	return undef if $self->is_path_ignored($db->{path});
-	$self->{dir_prop}->{$db->{path}} ||= {};
-	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
-	undef;
-}
-
-sub absent_directory {
-	my ($self, $path, $pb) = @_;
-	return undef if $self->is_path_ignored($path);
-	$self->{absent_dir}->{$pb->{path}} ||= [];
-	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
-	undef;
-}
-
-sub absent_file {
-	my ($self, $path, $pb) = @_;
-	return undef if $self->is_path_ignored($path);
-	$self->{absent_file}->{$pb->{path}} ||= [];
-	push @{$self->{absent_file}->{$pb->{path}}}, $path;
-	undef;
-}
-
-sub change_file_prop {
-	my ($self, $fb, $prop, $value) = @_;
-	return undef if $self->is_path_ignored($fb->{path});
-	if ($prop eq 'svn:executable') {
-		if ($fb->{mode_b} != 120000) {
-			$fb->{mode_b} = defined $value ? 100755 : 100644;
-		}
-	} elsif ($prop eq 'svn:special') {
-		$fb->{mode_b} = defined $value ? 120000 : 100644;
-	} else {
-		$self->{file_prop}->{$fb->{path}} ||= {};
-		$self->{file_prop}->{$fb->{path}}->{$prop} = $value;
-	}
-	undef;
-}
-
-sub apply_textdelta {
-	my ($self, $fb, $exp) = @_;
-	return undef if $self->is_path_ignored($fb->{path});
-	my $fh = $::_repository->temp_acquire('svn_delta');
-	# $fh gets auto-closed() by SVN::TxDelta::apply(),
-	# (but $base does not,) so dup() it for reading in close_file
-	open my $dup, '<&', $fh or croak $!;
-	my $base = $::_repository->temp_acquire('git_blob');
-
-	if ($fb->{blob}) {
-		my ($base_is_link, $size);
-
-		if ($fb->{mode_a} eq '120000' &&
-		    ! $self->{empty_symlinks}->{$fb->{path}}) {
-			print $base 'link ' or die "print $!\n";
-			$base_is_link = 1;
-		}
-	retry:
-		$size = $::_repository->cat_blob($fb->{blob}, $base);
-		die "Failed to read object $fb->{blob}" if ($size < 0);
-
-		if (defined $exp) {
-			seek $base, 0, 0 or croak $!;
-			my $got = ::md5sum($base);
-			if ($got ne $exp) {
-				my $err = "Checksum mismatch: ".
-				       "$fb->{path} $fb->{blob}\n" .
-				       "expected: $exp\n" .
-				       "     got: $got\n";
-				if ($base_is_link) {
-					warn $err,
-					     "Retrying... (possibly ",
-					     "a bad symlink from SVN)\n";
-					$::_repository->temp_reset($base);
-					$base_is_link = 0;
-					goto retry;
-				}
-				die $err;
-			}
-		}
-	}
-	seek $base, 0, 0 or croak $!;
-	$fb->{fh} = $fh;
-	$fb->{base} = $base;
-	[ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
-}
-
-sub close_file {
-	my ($self, $fb, $exp) = @_;
-	return undef if $self->is_path_ignored($fb->{path});
-
-	my $hash;
-	my $path = $self->git_path($fb->{path});
-	if (my $fh = $fb->{fh}) {
-		if (defined $exp) {
-			seek($fh, 0, 0) or croak $!;
-			my $got = ::md5sum($fh);
-			if ($got ne $exp) {
-				die "Checksum mismatch: $path\n",
-				    "expected: $exp\n    got: $got\n";
-			}
-		}
-		if ($fb->{mode_b} == 120000) {
-			sysseek($fh, 0, 0) or croak $!;
-			my $rd = sysread($fh, my $buf, 5);
-
-			if (!defined $rd) {
-				croak "sysread: $!\n";
-			} elsif ($rd == 0) {
-				warn "$path has mode 120000",
-				     " but it points to nothing\n",
-				     "converting to an empty file with mode",
-				     " 100644\n";
-				$fb->{mode_b} = '100644';
-			} elsif ($buf ne 'link ') {
-				warn "$path has mode 120000",
-				     " but is not a link\n";
-			} else {
-				my $tmp_fh = $::_repository->temp_acquire(
-					'svn_hash');
-				my $res;
-				while ($res = sysread($fh, my $str, 1024)) {
-					my $out = syswrite($tmp_fh, $str, $res);
-					defined($out) && $out == $res
-						or croak("write ",
-							Git::temp_path($tmp_fh),
-							": $!\n");
-				}
-				defined $res or croak $!;
-
-				($fh, $tmp_fh) = ($tmp_fh, $fh);
-				Git::temp_release($tmp_fh, 1);
-			}
-		}
-
-		$hash = $::_repository->hash_and_insert_object(
-				Git::temp_path($fh));
-		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
-
-		Git::temp_release($fb->{base}, 1);
-		Git::temp_release($fh, 1);
-	} else {
-		$hash = $fb->{blob} or die "no blob information\n";
-	}
-	$fb->{pool}->clear;
-	$self->{gii}->update($fb->{mode_b}, $hash, $path) or croak $!;
-	print "\t$fb->{action}\t$path\n" if $fb->{action} && ! $::_q;
-	undef;
-}
-
-sub abort_edit {
-	my $self = shift;
-	$self->{nr} = $self->{gii}->{nr};
-	delete $self->{gii};
-	$self->SUPER::abort_edit(@_);
-}
-
-sub close_edit {
-	my $self = shift;
-
-	if ($_preserve_empty_dirs) {
-		my @empty_dirs;
-
-		# Any entry flagged as empty that also has an associated
-		# dir_prop represents a newly created empty directory.
-		foreach my $i (keys %{$self->{empty}}) {
-			push @empty_dirs, $i if exists $self->{dir_prop}->{$i};
-		}
-
-		# Search for directories that have become empty due subsequent
-		# file deletes.
-		push @empty_dirs, $self->find_empty_directories();
-
-		# Finally, add a placeholder file to each empty directory.
-		$self->add_placeholder_file($_) foreach (@empty_dirs);
-
-		$self->stash_placeholder_list();
-	}
-
-	$self->{git_commit_ok} = 1;
-	$self->{nr} = $self->{gii}->{nr};
-	delete $self->{gii};
-	$self->SUPER::close_edit(@_);
-}
-
-sub find_empty_directories {
-	my ($self) = @_;
-	my @empty_dirs;
-	my %dirs = map { dirname($_) => 1 } @deleted_gpath;
-
-	foreach my $dir (sort keys %dirs) {
-		next if $dir eq ".";
-
-		# If there have been any additions to this directory, there is
-		# no reason to check if it is empty.
-		my $skip_added = 0;
-		foreach my $t (qw/dir_prop file_prop/) {
-			foreach my $path (keys %{ $self->{$t} }) {
-				if (exists $self->{$t}->{dirname($path)}) {
-					$skip_added = 1;
-					last;
-				}
-			}
-			last if $skip_added;
-		}
-		next if $skip_added;
-
-		# Use `git ls-tree` to get the filenames of this directory
-		# that existed prior to this particular commit.
-		my $ls = command('ls-tree', '-z', '--name-only',
-				 $self->{c}, "$dir/");
-		my %files = map { $_ => 1 } split(/\0/, $ls);
-
-		# Remove the filenames that were deleted during this commit.
-		delete $files{$_} foreach (@deleted_gpath);
-
-		# Report the directory if there are no filenames left.
-		push @empty_dirs, $dir unless (scalar %files);
-	}
-	@empty_dirs;
-}
-
-sub add_placeholder_file {
-	my ($self, $dir) = @_;
-	my $path = "$dir/$_placeholder_filename";
-	my $gpath = $self->git_path($path);
-
-	my $fh = $::_repository->temp_acquire($gpath);
-	my $hash = $::_repository->hash_and_insert_object(Git::temp_path($fh));
-	Git::temp_release($fh, 1);
-	$self->{gii}->update('100644', $hash, $gpath) or croak $!;
-
-	# The directory should no longer be considered empty.
-	delete $self->{empty}->{$dir} if exists $self->{empty}->{$dir};
-
-	# Keep track of any placeholder files we create.
-	$added_placeholder{$dir} = $path;
-}
-
-sub stash_placeholder_list {
-	my ($self) = @_;
-	my $k = "svn-remote.$repo_id.added-placeholder";
-	my $v = eval { command_oneline('config', '--get-all', $k) };
-	command_noisy('config', '--unset-all', $k) if $v;
-	foreach (values %added_placeholder) {
-		command_noisy('config', '--add', $k, $_);
-	}
-}
-
 package Git::SVN::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
new file mode 100644
index 00000000..4e9c77d7
--- /dev/null
+++ b/perl/Git/SVN/Fetcher.pm
@@ -0,0 +1,602 @@
+package Git::SVN::Fetcher;
+use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
+            @deleted_gpath %added_placeholder $repo_id/;
+use strict;
+use warnings;
+use SVN::Delta;
+use Carp qw/croak/;
+use File::Basename qw/dirname/;
+use IO::File qw//;
+use Git qw/command command_oneline command_noisy command_output_pipe
+           command_input_pipe command_close_pipe
+           command_bidi_pipe command_close_bidi_pipe/;
+BEGIN {
+	@ISA = qw(SVN::Delta::Editor);
+}
+
+# file baton members: path, mode_a, mode_b, pool, fh, blob, base
+sub new {
+	my ($class, $git_svn, $switch_path) = @_;
+	my $self = SVN::Delta::Editor->new;
+	bless $self, $class;
+	if (exists $git_svn->{last_commit}) {
+		$self->{c} = $git_svn->{last_commit};
+		$self->{empty_symlinks} =
+		                  _mark_empty_symlinks($git_svn, $switch_path);
+	}
+
+	# some options are read globally, but can be overridden locally
+	# per [svn-remote "..."] section.  Command-line options will *NOT*
+	# override options set in an [svn-remote "..."] section
+	$repo_id = $git_svn->{repo_id};
+	my $k = "svn-remote.$repo_id.ignore-paths";
+	my $v = eval { command_oneline('config', '--get', $k) };
+	$self->{ignore_regex} = $v;
+
+	$k = "svn-remote.$repo_id.preserve-empty-dirs";
+	$v = eval { command_oneline('config', '--get', '--bool', $k) };
+	if ($v && $v eq 'true') {
+		$_preserve_empty_dirs = 1;
+		$k = "svn-remote.$repo_id.placeholder-filename";
+		$v = eval { command_oneline('config', '--get', $k) };
+		$_placeholder_filename = $v;
+	}
+
+	# Load the list of placeholder files added during previous invocations.
+	$k = "svn-remote.$repo_id.added-placeholder";
+	$v = eval { command_oneline('config', '--get-all', $k) };
+	if ($_preserve_empty_dirs && $v) {
+		# command() prints errors to stderr, so we only call it if
+		# command_oneline() succeeded.
+		my @v = command('config', '--get-all', $k);
+		$added_placeholder{ dirname($_) } = $_ foreach @v;
+	}
+
+	$self->{empty} = {};
+	$self->{dir_prop} = {};
+	$self->{file_prop} = {};
+	$self->{absent_dir} = {};
+	$self->{absent_file} = {};
+	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
+	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
+	$self;
+}
+
+# this uses the Ra object, so it must be called before do_{switch,update},
+# not inside them (when the Git::SVN::Fetcher object is passed) to
+# do_{switch,update}
+sub _mark_empty_symlinks {
+	my ($git_svn, $switch_path) = @_;
+	my $bool = Git::config_bool('svn.brokenSymlinkWorkaround');
+	return {} if (!defined($bool)) || (defined($bool) && ! $bool);
+
+	my %ret;
+	my ($rev, $cmt) = $git_svn->last_rev_commit;
+	return {} unless ($rev && $cmt);
+
+	# allow the warning to be printed for each revision we fetch to
+	# ensure the user sees it.  The user can also disable the workaround
+	# on the repository even while git svn is running and the next
+	# revision fetched will skip this expensive function.
+	my $printed_warning;
+	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
+	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
+	local $/ = "\0";
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	$pfx .= '/' if length($pfx);
+	while (<$ls>) {
+		chomp;
+		s/\A100644 blob $empty_blob\t//o or next;
+		unless ($printed_warning) {
+			print STDERR "Scanning for empty symlinks, ",
+			             "this may take a while if you have ",
+				     "many empty files\n",
+				     "You may disable this with `",
+				     "git config svn.brokenSymlinkWorkaround ",
+				     "false'.\n",
+				     "This may be done in a different ",
+				     "terminal without restarting ",
+				     "git svn\n";
+			$printed_warning = 1;
+		}
+		my $path = $_;
+		my (undef, $props) =
+		               $git_svn->ra->get_file($pfx.$path, $rev, undef);
+		if ($props->{'svn:special'}) {
+			$ret{$path} = 1;
+		}
+	}
+	command_close_pipe($ls, $ctx);
+	\%ret;
+}
+
+# returns true if a given path is inside a ".git" directory
+sub in_dot_git {
+	$_[0] =~ m{(?:^|/)\.git(?:/|$)};
+}
+
+# return value: 0 -- don't ignore, 1 -- ignore
+sub is_path_ignored {
+	my ($self, $path) = @_;
+	return 1 if in_dot_git($path);
+	return 1 if defined($self->{ignore_regex}) &&
+	            $path =~ m!$self->{ignore_regex}!;
+	return 0 unless defined($_ignore_regex);
+	return 1 if $path =~ m!$_ignore_regex!o;
+	return 0;
+}
+
+sub set_path_strip {
+	my ($self, $path) = @_;
+	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
+}
+
+sub open_root {
+	{ path => '' };
+}
+
+sub open_directory {
+	my ($self, $path, $pb, $rev) = @_;
+	{ path => $path };
+}
+
+sub git_path {
+	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, 'UTF-8', $enc);
+	}
+	if ($self->{path_strip}) {
+		$path =~ s!$self->{path_strip}!! or
+		  die "Failed to strip path '$path' ($self->{path_strip})\n";
+	}
+	$path;
+}
+
+sub delete_entry {
+	my ($self, $path, $rev, $pb) = @_;
+	return undef if $self->is_path_ignored($path);
+
+	my $gpath = $self->git_path($path);
+	return undef if ($gpath eq '');
+
+	# remove entire directories.
+	my ($tree) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
+	                 =~ /\A040000 tree ([a-f\d]{40})\t\Q$gpath\E\0/);
+	if ($tree) {
+		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
+		                                     -r --name-only -z/,
+				                     $tree);
+		local $/ = "\0";
+		while (<$ls>) {
+			chomp;
+			my $rmpath = "$gpath/$_";
+			$self->{gii}->remove($rmpath);
+			print "\tD\t$rmpath\n" unless $::_q;
+		}
+		print "\tD\t$gpath/\n" unless $::_q;
+		command_close_pipe($ls, $ctx);
+	} else {
+		$self->{gii}->remove($gpath);
+		print "\tD\t$gpath\n" unless $::_q;
+	}
+	# Don't add to @deleted_gpath if we're deleting a placeholder file.
+	push @deleted_gpath, $gpath unless $added_placeholder{dirname($path)};
+	$self->{empty}->{$path} = 0;
+	undef;
+}
+
+sub open_file {
+	my ($self, $path, $pb, $rev) = @_;
+	my ($mode, $blob);
+
+	goto out if $self->is_path_ignored($path);
+
+	my $gpath = $self->git_path($path);
+	($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
+	                     =~ /\A(\d{6}) blob ([a-f\d]{40})\t\Q$gpath\E\0/);
+	unless (defined $mode && defined $blob) {
+		die "$path was not found in commit $self->{c} (r$rev)\n";
+	}
+	if ($mode eq '100644' && $self->{empty_symlinks}->{$path}) {
+		$mode = '120000';
+	}
+out:
+	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
+	  pool => SVN::Pool->new, action => 'M' };
+}
+
+sub add_file {
+	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
+	my $mode;
+
+	if (!$self->is_path_ignored($path)) {
+		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
+		delete $self->{empty}->{$dir};
+		$mode = '100644';
+
+		if ($added_placeholder{$dir}) {
+			# Remove our placeholder file, if we created one.
+			delete_entry($self, $added_placeholder{$dir})
+				unless $path eq $added_placeholder{$dir};
+			delete $added_placeholder{$dir}
+		}
+	}
+
+	{ path => $path, mode_a => $mode, mode_b => $mode,
+	  pool => SVN::Pool->new, action => 'A' };
+}
+
+sub add_directory {
+	my ($self, $path, $cp_path, $cp_rev) = @_;
+	goto out if $self->is_path_ignored($path);
+	my $gpath = $self->git_path($path);
+	if ($gpath eq '') {
+		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
+		                                     -r --name-only -z/,
+				                     $self->{c});
+		local $/ = "\0";
+		while (<$ls>) {
+			chomp;
+			$self->{gii}->remove($_);
+			print "\tD\t$_\n" unless $::_q;
+			push @deleted_gpath, $gpath;
+		}
+		command_close_pipe($ls, $ctx);
+		$self->{empty}->{$path} = 0;
+	}
+	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
+	delete $self->{empty}->{$dir};
+	$self->{empty}->{$path} = 1;
+
+	if ($added_placeholder{$dir}) {
+		# Remove our placeholder file, if we created one.
+		delete_entry($self, $added_placeholder{$dir});
+		delete $added_placeholder{$dir}
+	}
+
+out:
+	{ path => $path };
+}
+
+sub change_dir_prop {
+	my ($self, $db, $prop, $value) = @_;
+	return undef if $self->is_path_ignored($db->{path});
+	$self->{dir_prop}->{$db->{path}} ||= {};
+	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
+	undef;
+}
+
+sub absent_directory {
+	my ($self, $path, $pb) = @_;
+	return undef if $self->is_path_ignored($path);
+	$self->{absent_dir}->{$pb->{path}} ||= [];
+	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
+	undef;
+}
+
+sub absent_file {
+	my ($self, $path, $pb) = @_;
+	return undef if $self->is_path_ignored($path);
+	$self->{absent_file}->{$pb->{path}} ||= [];
+	push @{$self->{absent_file}->{$pb->{path}}}, $path;
+	undef;
+}
+
+sub change_file_prop {
+	my ($self, $fb, $prop, $value) = @_;
+	return undef if $self->is_path_ignored($fb->{path});
+	if ($prop eq 'svn:executable') {
+		if ($fb->{mode_b} != 120000) {
+			$fb->{mode_b} = defined $value ? 100755 : 100644;
+		}
+	} elsif ($prop eq 'svn:special') {
+		$fb->{mode_b} = defined $value ? 120000 : 100644;
+	} else {
+		$self->{file_prop}->{$fb->{path}} ||= {};
+		$self->{file_prop}->{$fb->{path}}->{$prop} = $value;
+	}
+	undef;
+}
+
+sub apply_textdelta {
+	my ($self, $fb, $exp) = @_;
+	return undef if $self->is_path_ignored($fb->{path});
+	my $fh = $::_repository->temp_acquire('svn_delta');
+	# $fh gets auto-closed() by SVN::TxDelta::apply(),
+	# (but $base does not,) so dup() it for reading in close_file
+	open my $dup, '<&', $fh or croak $!;
+	my $base = $::_repository->temp_acquire('git_blob');
+
+	if ($fb->{blob}) {
+		my ($base_is_link, $size);
+
+		if ($fb->{mode_a} eq '120000' &&
+		    ! $self->{empty_symlinks}->{$fb->{path}}) {
+			print $base 'link ' or die "print $!\n";
+			$base_is_link = 1;
+		}
+	retry:
+		$size = $::_repository->cat_blob($fb->{blob}, $base);
+		die "Failed to read object $fb->{blob}" if ($size < 0);
+
+		if (defined $exp) {
+			seek $base, 0, 0 or croak $!;
+			my $got = ::md5sum($base);
+			if ($got ne $exp) {
+				my $err = "Checksum mismatch: ".
+				       "$fb->{path} $fb->{blob}\n" .
+				       "expected: $exp\n" .
+				       "     got: $got\n";
+				if ($base_is_link) {
+					warn $err,
+					     "Retrying... (possibly ",
+					     "a bad symlink from SVN)\n";
+					$::_repository->temp_reset($base);
+					$base_is_link = 0;
+					goto retry;
+				}
+				die $err;
+			}
+		}
+	}
+	seek $base, 0, 0 or croak $!;
+	$fb->{fh} = $fh;
+	$fb->{base} = $base;
+	[ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
+}
+
+sub close_file {
+	my ($self, $fb, $exp) = @_;
+	return undef if $self->is_path_ignored($fb->{path});
+
+	my $hash;
+	my $path = $self->git_path($fb->{path});
+	if (my $fh = $fb->{fh}) {
+		if (defined $exp) {
+			seek($fh, 0, 0) or croak $!;
+			my $got = ::md5sum($fh);
+			if ($got ne $exp) {
+				die "Checksum mismatch: $path\n",
+				    "expected: $exp\n    got: $got\n";
+			}
+		}
+		if ($fb->{mode_b} == 120000) {
+			sysseek($fh, 0, 0) or croak $!;
+			my $rd = sysread($fh, my $buf, 5);
+
+			if (!defined $rd) {
+				croak "sysread: $!\n";
+			} elsif ($rd == 0) {
+				warn "$path has mode 120000",
+				     " but it points to nothing\n",
+				     "converting to an empty file with mode",
+				     " 100644\n";
+				$fb->{mode_b} = '100644';
+			} elsif ($buf ne 'link ') {
+				warn "$path has mode 120000",
+				     " but is not a link\n";
+			} else {
+				my $tmp_fh = $::_repository->temp_acquire(
+					'svn_hash');
+				my $res;
+				while ($res = sysread($fh, my $str, 1024)) {
+					my $out = syswrite($tmp_fh, $str, $res);
+					defined($out) && $out == $res
+						or croak("write ",
+							Git::temp_path($tmp_fh),
+							": $!\n");
+				}
+				defined $res or croak $!;
+
+				($fh, $tmp_fh) = ($tmp_fh, $fh);
+				Git::temp_release($tmp_fh, 1);
+			}
+		}
+
+		$hash = $::_repository->hash_and_insert_object(
+				Git::temp_path($fh));
+		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
+
+		Git::temp_release($fb->{base}, 1);
+		Git::temp_release($fh, 1);
+	} else {
+		$hash = $fb->{blob} or die "no blob information\n";
+	}
+	$fb->{pool}->clear;
+	$self->{gii}->update($fb->{mode_b}, $hash, $path) or croak $!;
+	print "\t$fb->{action}\t$path\n" if $fb->{action} && ! $::_q;
+	undef;
+}
+
+sub abort_edit {
+	my $self = shift;
+	$self->{nr} = $self->{gii}->{nr};
+	delete $self->{gii};
+	$self->SUPER::abort_edit(@_);
+}
+
+sub close_edit {
+	my $self = shift;
+
+	if ($_preserve_empty_dirs) {
+		my @empty_dirs;
+
+		# Any entry flagged as empty that also has an associated
+		# dir_prop represents a newly created empty directory.
+		foreach my $i (keys %{$self->{empty}}) {
+			push @empty_dirs, $i if exists $self->{dir_prop}->{$i};
+		}
+
+		# Search for directories that have become empty due subsequent
+		# file deletes.
+		push @empty_dirs, $self->find_empty_directories();
+
+		# Finally, add a placeholder file to each empty directory.
+		$self->add_placeholder_file($_) foreach (@empty_dirs);
+
+		$self->stash_placeholder_list();
+	}
+
+	$self->{git_commit_ok} = 1;
+	$self->{nr} = $self->{gii}->{nr};
+	delete $self->{gii};
+	$self->SUPER::close_edit(@_);
+}
+
+sub find_empty_directories {
+	my ($self) = @_;
+	my @empty_dirs;
+	my %dirs = map { dirname($_) => 1 } @deleted_gpath;
+
+	foreach my $dir (sort keys %dirs) {
+		next if $dir eq ".";
+
+		# If there have been any additions to this directory, there is
+		# no reason to check if it is empty.
+		my $skip_added = 0;
+		foreach my $t (qw/dir_prop file_prop/) {
+			foreach my $path (keys %{ $self->{$t} }) {
+				if (exists $self->{$t}->{dirname($path)}) {
+					$skip_added = 1;
+					last;
+				}
+			}
+			last if $skip_added;
+		}
+		next if $skip_added;
+
+		# Use `git ls-tree` to get the filenames of this directory
+		# that existed prior to this particular commit.
+		my $ls = command('ls-tree', '-z', '--name-only',
+				 $self->{c}, "$dir/");
+		my %files = map { $_ => 1 } split(/\0/, $ls);
+
+		# Remove the filenames that were deleted during this commit.
+		delete $files{$_} foreach (@deleted_gpath);
+
+		# Report the directory if there are no filenames left.
+		push @empty_dirs, $dir unless (scalar %files);
+	}
+	@empty_dirs;
+}
+
+sub add_placeholder_file {
+	my ($self, $dir) = @_;
+	my $path = "$dir/$_placeholder_filename";
+	my $gpath = $self->git_path($path);
+
+	my $fh = $::_repository->temp_acquire($gpath);
+	my $hash = $::_repository->hash_and_insert_object(Git::temp_path($fh));
+	Git::temp_release($fh, 1);
+	$self->{gii}->update('100644', $hash, $gpath) or croak $!;
+
+	# The directory should no longer be considered empty.
+	delete $self->{empty}->{$dir} if exists $self->{empty}->{$dir};
+
+	# Keep track of any placeholder files we create.
+	$added_placeholder{$dir} = $path;
+}
+
+sub stash_placeholder_list {
+	my ($self) = @_;
+	my $k = "svn-remote.$repo_id.added-placeholder";
+	my $v = eval { command_oneline('config', '--get-all', $k) };
+	command_noisy('config', '--unset-all', $k) if $v;
+	foreach (values %added_placeholder) {
+		command_noisy('config', '--add', $k, $_);
+	}
+}
+
+1;
+__END__
+
+Git::SVN::Fetcher - tree delta consumer for "git svn fetch"
+
+=head1 SYNOPSIS
+
+    use SVN::Core;
+    use SVN::Ra;
+    use Git::SVN;
+    use Git::SVN::Fetcher;
+    use Git;
+
+    my $gs = Git::SVN->find_by_url($url);
+    my $ra = SVN::Ra->new(url => $url);
+    my $editor = Git::SVN::Fetcher->new($gs);
+    my $reporter = $ra->do_update($SVN::Core::INVALID_REVNUM, '',
+                                  1, $editor);
+    $reporter->set_path('', $old_rev, 0);
+    $reporter->finish_report;
+    my $tree = $gs->tmp_index_do(sub { command_oneline('write-tree') });
+
+    foreach my $path (keys %{$editor->{dir_prop}) {
+        my $props = $editor->{dir_prop}{$path};
+        foreach my $prop (keys %$props) {
+            print "property $prop at $path changed to $props->{$prop}\n";
+        }
+    }
+    foreach my $path (keys %{$editor->{empty}) {
+        my $action = $editor->{empty}{$path} ? 'added' : 'removed';
+        print "empty directory $path $action\n";
+    }
+    foreach my $path (keys %{$editor->{file_prop}) { ... }
+    foreach my $parent (keys %{$editor->{absent_dir}}) {
+        my @children = @{$editor->{abstent_dir}{$parent}};
+        print "cannot fetch directory $parent/$_: not authorized?\n"
+            foreach @children;
+    }
+    foreach my $parent (keys %{$editor->{absent_file}) { ... }
+
+=head1 DESCRIPTION
+
+This is a subclass of C<SVN::Delta::Editor>, which means it implements
+callbacks to act as a consumer of Subversion tree deltas.  This
+particular implementation of those callbacks is meant to store
+information about the resulting content which B<git svn fetch> could
+use to populate new commits and new entries for F<unhandled.log>.
+More specifically:
+
+=over
+
+=item * Additions, removals, and modifications of files are propagated
+to git-svn's index file F<$GIT_DIR/svn/$refname/index> using
+B<git update-index>.
+
+=item * Changes in Subversion path properties are recorded in the
+C<dir_prop> and C<file_prop> fields (which are hashes).
+
+=item * Addition and removal of empty directories are indicated by
+entries with value 1 and 0 respectively in the C<empty> hash.
+
+=item * Paths that are present but cannot be conveyed (presumably due
+to permissions) are recorded in the C<absent_file> and
+C<absent_dirs> hashes.  For each key, the corresponding value is
+a list of paths under that directory that were present but
+could not be conveyed.
+
+=back
+
+The interface is unstable.  Do not use this module unless you are
+developing git-svn.
+
+=head1 DEPENDENCIES
+
+L<SVN::Delta> from the Subversion perl bindings,
+the core L<Carp>, L<File::Basename>, and L<IO::File> modules,
+and git's L<Git> helper module.
+
+C<Git::SVN::Fetcher> has not been tested using callers other than
+B<git-svn> itself.
+
+=head1 SEE ALSO
+
+L<SVN::Delta>.
+
+=head1 INCOMPATIBILITIES
+
+None reported.
+
+=head1 BUGS
+
+None.
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 4d8e31d2..424890a1 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -27,6 +27,7 @@ MAKE_FRAG
 my %pm = (
 	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
 	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
+	'Git/SVN/Fetcher.pm' => '$(INST_LIBDIR)/Git/SVN/Fetcher.pm',
 	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
 );
 
-- 
1.7.10
