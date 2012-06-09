From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] git-svn: make Git::SVN::Editor a separate file
Date: Sat, 9 Jun 2012 17:25:56 -0500
Message-ID: <20120609222556.GE28412@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120609222039.GD28412@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdU6k-0004Hr-MT
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 00:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab2FIW0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 18:26:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61172 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab2FIW0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 18:26:02 -0400
Received: by yenm10 with SMTP id m10so1931125yen.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jhtGYu169JP6dvSGEZnx4VLvd56g81WzaONrzDENPKk=;
        b=FnfGSucGnjwg94I5kvTW6zYBLEqjyVWXycDYDEYB2NMNGNxidXpVskh8/CVmPxEuUp
         3rByD5oonJG4Ep2I97iBieLeB6KDONgwvFZKOC7J62hN/7Smcz/odmzKHvlpDZGTSHYc
         b/mA7XYD8+oSYUX8QE3m/0pzqCK56LK9jqLh5ED8Bk9XUPF9IM31FPnDp584Op/xcg9J
         c0YkTI05XlhoI2cEklueW8Z1TsQTA+RAYK5aldqGSxnZsS/nrYm22f3vyx1fRTIe2qpy
         mTKEVFiqiWzEgZJrdjiY5uCLvQXVSvjiLgftcGaulerq378Hri8hTdX+A4LPLzAVExeL
         U9Wg==
Received: by 10.236.75.164 with SMTP id z24mr13826647yhd.69.1339280761466;
        Sat, 09 Jun 2012 15:26:01 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id d10sm16969757anm.17.2012.06.09.15.25.59
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 15:26:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120609222039.GD28412@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199562>

This makes the git-svn script shorter and less scary for beginners to
read through for the first time.  Take the opportunity to explain the
purpose and basic interface of the Git::SVN::Editor class while at it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl            |  472 +----------------------------------------
 perl/Git/SVN/Editor.pm  |  536 +++++++++++++++++++++++++++++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm |    3 +-
 perl/Makefile.PL        |    1 +
 4 files changed, 541 insertions(+), 471 deletions(-)
 create mode 100644 perl/Git/SVN/Editor.pm

diff --git a/git-svn.perl b/git-svn.perl
index 7870cc15..7cec4416 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -68,7 +68,6 @@ sub _req_svn {
 }
 my $can_compress = eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
-push @Git::SVN::Editor::ISA, 'SVN::Delta::Editor';
 use Carp qw/croak/;
 use Digest::MD5;
 use IO::File qw//;
@@ -79,6 +78,7 @@ use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Git::SVN::Editor qw//;
 use Git::SVN::Fetcher qw//;
 use Git::SVN::Prompt qw//;
 use Memoize;  # core since 5.8.0, Jul 2002
@@ -89,8 +89,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Editor
-			Git::SVN::Migration Git::SVN::Log Git::SVN),
+		for my $package ( qw(Git::SVN::Migration Git::SVN::Log Git::SVN),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -1066,7 +1065,6 @@ sub cmd_branch {
 		            " with the --destination argument.\n";
 		}
 		foreach my $g (@{$allglobs}) {
-			# Git::SVN::Editor could probably be moved to Git.pm..
 			my $re = Git::SVN::Editor::glob2pat($g->{path}->{left});
 			if ($_branch_dest =~ /$re/) {
 				$glob = $g;
@@ -4328,472 +4326,6 @@ sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
 
-package Git::SVN::Editor;
-use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
-use strict;
-use warnings;
-use Carp qw/croak/;
-use IO::File;
-
-sub new {
-	my ($class, $opts) = @_;
-	foreach (qw/svn_path r ra tree_a tree_b log editor_cb/) {
-		die "$_ required!\n" unless (defined $opts->{$_});
-	}
-
-	my $pool = SVN::Pool->new;
-	my $mods = generate_diff($opts->{tree_a}, $opts->{tree_b});
-	my $types = check_diff_paths($opts->{ra}, $opts->{svn_path},
-	                             $opts->{r}, $mods);
-
-	# $opts->{ra} functions should not be used after this:
-	my @ce  = $opts->{ra}->get_commit_editor($opts->{log},
-	                                        $opts->{editor_cb}, $pool);
-	my $self = SVN::Delta::Editor->new(@ce, $pool);
-	bless $self, $class;
-	foreach (qw/svn_path r tree_a tree_b/) {
-		$self->{$_} = $opts->{$_};
-	}
-	$self->{url} = $opts->{ra}->{url};
-	$self->{mods} = $mods;
-	$self->{types} = $types;
-	$self->{pool} = $pool;
-	$self->{bat} = { '' => $self->open_root($self->{r}, $self->{pool}) };
-	$self->{rm} = { };
-	$self->{path_prefix} = length $self->{svn_path} ?
-	                       "$self->{svn_path}/" : '';
-	$self->{config} = $opts->{config};
-	$self->{mergeinfo} = $opts->{mergeinfo};
-	return $self;
-}
-
-sub generate_diff {
-	my ($tree_a, $tree_b) = @_;
-	my @diff_tree = qw(diff-tree -z -r);
-	if ($_cp_similarity) {
-		push @diff_tree, "-C$_cp_similarity";
-	} else {
-		push @diff_tree, '-C';
-	}
-	push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
-	push @diff_tree, "-l$_rename_limit" if defined $_rename_limit;
-	push @diff_tree, $tree_a, $tree_b;
-	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
-	local $/ = "\0";
-	my $state = 'meta';
-	my @mods;
-	while (<$diff_fh>) {
-		chomp $_; # this gets rid of the trailing "\0"
-		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
-					($::sha1)\s($::sha1)\s
-					([MTCRAD])\d*$/xo) {
-			push @mods, {	mode_a => $1, mode_b => $2,
-					sha1_a => $3, sha1_b => $4,
-					chg => $5 };
-			if ($5 =~ /^(?:C|R)$/) {
-				$state = 'file_a';
-			} else {
-				$state = 'file_b';
-			}
-		} elsif ($state eq 'file_a') {
-			my $x = $mods[$#mods] or croak "Empty array\n";
-			if ($x->{chg} !~ /^(?:C|R)$/) {
-				croak "Error parsing $_, $x->{chg}\n";
-			}
-			$x->{file_a} = $_;
-			$state = 'file_b';
-		} elsif ($state eq 'file_b') {
-			my $x = $mods[$#mods] or croak "Empty array\n";
-			if (exists $x->{file_a} && $x->{chg} !~ /^(?:C|R)$/) {
-				croak "Error parsing $_, $x->{chg}\n";
-			}
-			if (!exists $x->{file_a} && $x->{chg} =~ /^(?:C|R)$/) {
-				croak "Error parsing $_, $x->{chg}\n";
-			}
-			$x->{file_b} = $_;
-			$state = 'meta';
-		} else {
-			croak "Error parsing $_\n";
-		}
-	}
-	command_close_pipe($diff_fh, $ctx);
-	\@mods;
-}
-
-sub check_diff_paths {
-	my ($ra, $pfx, $rev, $mods) = @_;
-	my %types;
-	$pfx .= '/' if length $pfx;
-
-	sub type_diff_paths {
-		my ($ra, $types, $path, $rev) = @_;
-		my @p = split m#/+#, $path;
-		my $c = shift @p;
-		unless (defined $types->{$c}) {
-			$types->{$c} = $ra->check_path($c, $rev);
-		}
-		while (@p) {
-			$c .= '/' . shift @p;
-			next if defined $types->{$c};
-			$types->{$c} = $ra->check_path($c, $rev);
-		}
-	}
-
-	foreach my $m (@$mods) {
-		foreach my $f (qw/file_a file_b/) {
-			next unless defined $m->{$f};
-			my ($dir) = ($m->{$f} =~ m#^(.*?)/?(?:[^/]+)$#);
-			if (length $pfx.$dir && ! defined $types{$dir}) {
-				type_diff_paths($ra, \%types, $pfx.$dir, $rev);
-			}
-		}
-	}
-	\%types;
-}
-
-sub split_path {
-	return ($_[0] =~ m#^(.*?)/?([^/]+)$#);
-}
-
-sub repo_path {
-	my ($self, $path) = @_;
-	if (my $enc = $self->{pathnameencoding}) {
-		require Encode;
-		Encode::from_to($path, $enc, 'UTF-8');
-	}
-	$self->{path_prefix}.(defined $path ? $path : '');
-}
-
-sub url_path {
-	my ($self, $path) = @_;
-	if ($self->{url} =~ m#^https?://#) {
-		$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
-	}
-	$self->{url} . '/' . $self->repo_path($path);
-}
-
-sub rmdirs {
-	my ($self) = @_;
-	my $rm = $self->{rm};
-	delete $rm->{''}; # we never delete the url we're tracking
-	return unless %$rm;
-
-	foreach (keys %$rm) {
-		my @d = split m#/#, $_;
-		my $c = shift @d;
-		$rm->{$c} = 1;
-		while (@d) {
-			$c .= '/' . shift @d;
-			$rm->{$c} = 1;
-		}
-	}
-	delete $rm->{$self->{svn_path}};
-	delete $rm->{''}; # we never delete the url we're tracking
-	return unless %$rm;
-
-	my ($fh, $ctx) = command_output_pipe(qw/ls-tree --name-only -r -z/,
-	                                     $self->{tree_b});
-	local $/ = "\0";
-	while (<$fh>) {
-		chomp;
-		my @dn = split m#/#, $_;
-		while (pop @dn) {
-			delete $rm->{join '/', @dn};
-		}
-		unless (%$rm) {
-			close $fh;
-			return;
-		}
-	}
-	command_close_pipe($fh, $ctx);
-
-	my ($r, $p, $bat) = ($self->{r}, $self->{pool}, $self->{bat});
-	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
-		$self->close_directory($bat->{$d}, $p);
-		my ($dn) = ($d =~ m#^(.*?)/?(?:[^/]+)$#);
-		print "\tD+\t$d/\n" unless $::_q;
-		$self->SUPER::delete_entry($d, $r, $bat->{$dn}, $p);
-		delete $bat->{$d};
-	}
-}
-
-sub open_or_add_dir {
-	my ($self, $full_path, $baton, $deletions) = @_;
-	my $t = $self->{types}->{$full_path};
-	if (!defined $t) {
-		die "$full_path not known in r$self->{r} or we have a bug!\n";
-	}
-	{
-		no warnings 'once';
-		# SVN::Node::none and SVN::Node::file are used only once,
-		# so we're shutting up Perl's warnings about them.
-		if ($t == $SVN::Node::none || defined($deletions->{$full_path})) {
-			return $self->add_directory($full_path, $baton,
-			    undef, -1, $self->{pool});
-		} elsif ($t == $SVN::Node::dir) {
-			return $self->open_directory($full_path, $baton,
-			    $self->{r}, $self->{pool});
-		} # no warnings 'once'
-		print STDERR "$full_path already exists in repository at ",
-		    "r$self->{r} and it is not a directory (",
-		    ($t == $SVN::Node::file ? 'file' : 'unknown'),"/$t)\n";
-	} # no warnings 'once'
-	exit 1;
-}
-
-sub ensure_path {
-	my ($self, $path, $deletions) = @_;
-	my $bat = $self->{bat};
-	my $repo_path = $self->repo_path($path);
-	return $bat->{''} unless (length $repo_path);
-
-	my @p = split m#/+#, $repo_path;
-	my $c = shift @p;
-	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''}, $deletions);
-	while (@p) {
-		my $c0 = $c;
-		$c .= '/' . shift @p;
-		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0}, $deletions);
-	}
-	return $bat->{$c};
-}
-
-# Subroutine to convert a globbing pattern to a regular expression.
-# From perl cookbook.
-sub glob2pat {
-	my $globstr = shift;
-	my %patmap = ('*' => '.*', '?' => '.', '[' => '[', ']' => ']');
-	$globstr =~ s{(.)} { $patmap{$1} || "\Q$1" }ge;
-	return '^' . $globstr . '$';
-}
-
-sub check_autoprop {
-	my ($self, $pattern, $properties, $file, $fbat) = @_;
-	# Convert the globbing pattern to a regular expression.
-	my $regex = glob2pat($pattern);
-	# Check if the pattern matches the file name.
-	if($file =~ m/($regex)/) {
-		# Parse the list of properties to set.
-		my @props = split(/;/, $properties);
-		foreach my $prop (@props) {
-			# Parse 'name=value' syntax and set the property.
-			if ($prop =~ /([^=]+)=(.*)/) {
-				my ($n,$v) = ($1,$2);
-				for ($n, $v) {
-					s/^\s+//; s/\s+$//;
-				}
-				$self->change_file_prop($fbat, $n, $v);
-			}
-		}
-	}
-}
-
-sub apply_autoprops {
-	my ($self, $file, $fbat) = @_;
-	my $conf_t = ${$self->{config}}{'config'};
-	no warnings 'once';
-	# Check [miscellany]/enable-auto-props in svn configuration.
-	if (SVN::_Core::svn_config_get_bool(
-		$conf_t,
-		$SVN::_Core::SVN_CONFIG_SECTION_MISCELLANY,
-		$SVN::_Core::SVN_CONFIG_OPTION_ENABLE_AUTO_PROPS,
-		0)) {
-		# Auto-props are enabled.  Enumerate them to look for matches.
-		my $callback = sub {
-			$self->check_autoprop($_[0], $_[1], $file, $fbat);
-		};
-		SVN::_Core::svn_config_enumerate(
-			$conf_t,
-			$SVN::_Core::SVN_CONFIG_SECTION_AUTO_PROPS,
-			$callback);
-	}
-}
-
-sub A {
-	my ($self, $m, $deletions) = @_;
-	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir, $deletions);
-	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-					undef, -1);
-	print "\tA\t$m->{file_b}\n" unless $::_q;
-	$self->apply_autoprops($file, $fbat);
-	$self->chg_file($fbat, $m);
-	$self->close_file($fbat,undef,$self->{pool});
-}
-
-sub C {
-	my ($self, $m, $deletions) = @_;
-	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir, $deletions);
-	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
-	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
-	$self->chg_file($fbat, $m);
-	$self->close_file($fbat,undef,$self->{pool});
-}
-
-sub delete_entry {
-	my ($self, $path, $pbat) = @_;
-	my $rpath = $self->repo_path($path);
-	my ($dir, $file) = split_path($rpath);
-	$self->{rm}->{$dir} = 1;
-	$self->SUPER::delete_entry($rpath, $self->{r}, $pbat, $self->{pool});
-}
-
-sub R {
-	my ($self, $m, $deletions) = @_;
-	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir, $deletions);
-	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
-	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
-	$self->apply_autoprops($file, $fbat);
-	$self->chg_file($fbat, $m);
-	$self->close_file($fbat,undef,$self->{pool});
-
-	($dir, $file) = split_path($m->{file_a});
-	$pbat = $self->ensure_path($dir, $deletions);
-	$self->delete_entry($m->{file_a}, $pbat);
-}
-
-sub M {
-	my ($self, $m, $deletions) = @_;
-	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir, $deletions);
-	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
-				$pbat,$self->{r},$self->{pool});
-	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
-	$self->chg_file($fbat, $m);
-	$self->close_file($fbat,undef,$self->{pool});
-}
-
-sub T { shift->M(@_) }
-
-sub change_file_prop {
-	my ($self, $fbat, $pname, $pval) = @_;
-	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
-}
-
-sub change_dir_prop {
-	my ($self, $pbat, $pname, $pval) = @_;
-	$self->SUPER::change_dir_prop($pbat, $pname, $pval, $self->{pool});
-}
-
-sub _chg_file_get_blob ($$$$) {
-	my ($self, $fbat, $m, $which) = @_;
-	my $fh = $::_repository->temp_acquire("git_blob_$which");
-	if ($m->{"mode_$which"} =~ /^120/) {
-		print $fh 'link ' or croak $!;
-		$self->change_file_prop($fbat,'svn:special','*');
-	} elsif ($m->{mode_a} =~ /^120/ && $m->{"mode_$which"} !~ /^120/) {
-		$self->change_file_prop($fbat,'svn:special',undef);
-	}
-	my $blob = $m->{"sha1_$which"};
-	return ($fh,) if ($blob =~ /^0{40}$/);
-	my $size = $::_repository->cat_blob($blob, $fh);
-	croak "Failed to read object $blob" if ($size < 0);
-	$fh->flush == 0 or croak $!;
-	seek $fh, 0, 0 or croak $!;
-
-	my $exp = ::md5sum($fh);
-	seek $fh, 0, 0 or croak $!;
-	return ($fh, $exp);
-}
-
-sub chg_file {
-	my ($self, $fbat, $m) = @_;
-	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable','*');
-	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable',undef);
-	}
-	my ($fh_a, $exp_a) = _chg_file_get_blob $self, $fbat, $m, 'a';
-	my ($fh_b, $exp_b) = _chg_file_get_blob $self, $fbat, $m, 'b';
-	my $pool = SVN::Pool->new;
-	my $atd = $self->apply_textdelta($fbat, $exp_a, $pool);
-	if (-s $fh_a) {
-		my $txstream = SVN::TxDelta::new ($fh_a, $fh_b, $pool);
-		my $res = SVN::TxDelta::send_txstream($txstream, @$atd, $pool);
-		if (defined $res) {
-			die "Unexpected result from send_txstream: $res\n",
-			    "(SVN::Core::VERSION: $SVN::Core::VERSION)\n";
-		}
-	} else {
-		my $got = SVN::TxDelta::send_stream($fh_b, @$atd, $pool);
-		die "Checksum mismatch\nexpected: $exp_b\ngot: $got\n"
-		    if ($got ne $exp_b);
-	}
-	Git::temp_release($fh_b, 1);
-	Git::temp_release($fh_a, 1);
-	$pool->clear;
-}
-
-sub D {
-	my ($self, $m, $deletions) = @_;
-	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir, $deletions);
-	print "\tD\t$m->{file_b}\n" unless $::_q;
-	$self->delete_entry($m->{file_b}, $pbat);
-}
-
-sub close_edit {
-	my ($self) = @_;
-	my ($p,$bat) = ($self->{pool}, $self->{bat});
-	foreach (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$bat) {
-		next if $_ eq '';
-		$self->close_directory($bat->{$_}, $p);
-	}
-	$self->close_directory($bat->{''}, $p);
-	$self->SUPER::close_edit($p);
-	$p->clear;
-}
-
-sub abort_edit {
-	my ($self) = @_;
-	$self->SUPER::abort_edit($self->{pool});
-}
-
-sub DESTROY {
-	my $self = shift;
-	$self->SUPER::DESTROY(@_);
-	$self->{pool}->clear;
-}
-
-# this drives the editor
-sub apply_diff {
-	my ($self) = @_;
-	my $mods = $self->{mods};
-	my %o = ( D => 0, C => 1, R => 2, A => 3, M => 4, T => 5 );
-	my %deletions;
-
-	foreach my $m (@$mods) {
-		if ($m->{chg} eq "D") {
-			$deletions{$m->{file_b}} = 1;
-		}
-	}
-
-	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
-		my $f = $m->{chg};
-		if (defined $o{$f}) {
-			$self->$f($m, \%deletions);
-		} else {
-			fatal("Invalid change type: $f");
-		}
-	}
-
-	if (defined($self->{mergeinfo})) {
-		$self->change_dir_prop($self->{bat}{''}, "svn:mergeinfo",
-			               $self->{mergeinfo});
-	}
-	$self->rmdirs if $_rmdir;
-	if (@$mods == 0 && !defined($self->{mergeinfo})) {
-		$self->abort_edit;
-	} else {
-		$self->close_edit;
-	}
-	return scalar @$mods;
-}
-
 package Git::SVN::Ra;
 use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
new file mode 100644
index 00000000..755092fd
--- /dev/null
+++ b/perl/Git/SVN/Editor.pm
@@ -0,0 +1,536 @@
+package Git::SVN::Editor;
+use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
+use strict;
+use warnings;
+use SVN::Core;
+use SVN::Delta;
+use Carp qw/croak/;
+use IO::File;
+use Git qw/command command_oneline command_noisy command_output_pipe
+           command_input_pipe command_close_pipe
+           command_bidi_pipe command_close_bidi_pipe/;
+BEGIN {
+	@ISA = qw(SVN::Delta::Editor);
+}
+
+sub new {
+	my ($class, $opts) = @_;
+	foreach (qw/svn_path r ra tree_a tree_b log editor_cb/) {
+		die "$_ required!\n" unless (defined $opts->{$_});
+	}
+
+	my $pool = SVN::Pool->new;
+	my $mods = generate_diff($opts->{tree_a}, $opts->{tree_b});
+	my $types = check_diff_paths($opts->{ra}, $opts->{svn_path},
+	                             $opts->{r}, $mods);
+
+	# $opts->{ra} functions should not be used after this:
+	my @ce  = $opts->{ra}->get_commit_editor($opts->{log},
+	                                        $opts->{editor_cb}, $pool);
+	my $self = SVN::Delta::Editor->new(@ce, $pool);
+	bless $self, $class;
+	foreach (qw/svn_path r tree_a tree_b/) {
+		$self->{$_} = $opts->{$_};
+	}
+	$self->{url} = $opts->{ra}->{url};
+	$self->{mods} = $mods;
+	$self->{types} = $types;
+	$self->{pool} = $pool;
+	$self->{bat} = { '' => $self->open_root($self->{r}, $self->{pool}) };
+	$self->{rm} = { };
+	$self->{path_prefix} = length $self->{svn_path} ?
+	                       "$self->{svn_path}/" : '';
+	$self->{config} = $opts->{config};
+	$self->{mergeinfo} = $opts->{mergeinfo};
+	return $self;
+}
+
+sub generate_diff {
+	my ($tree_a, $tree_b) = @_;
+	my @diff_tree = qw(diff-tree -z -r);
+	if ($_cp_similarity) {
+		push @diff_tree, "-C$_cp_similarity";
+	} else {
+		push @diff_tree, '-C';
+	}
+	push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
+	push @diff_tree, "-l$_rename_limit" if defined $_rename_limit;
+	push @diff_tree, $tree_a, $tree_b;
+	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
+	local $/ = "\0";
+	my $state = 'meta';
+	my @mods;
+	while (<$diff_fh>) {
+		chomp $_; # this gets rid of the trailing "\0"
+		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
+					($::sha1)\s($::sha1)\s
+					([MTCRAD])\d*$/xo) {
+			push @mods, {	mode_a => $1, mode_b => $2,
+					sha1_a => $3, sha1_b => $4,
+					chg => $5 };
+			if ($5 =~ /^(?:C|R)$/) {
+				$state = 'file_a';
+			} else {
+				$state = 'file_b';
+			}
+		} elsif ($state eq 'file_a') {
+			my $x = $mods[$#mods] or croak "Empty array\n";
+			if ($x->{chg} !~ /^(?:C|R)$/) {
+				croak "Error parsing $_, $x->{chg}\n";
+			}
+			$x->{file_a} = $_;
+			$state = 'file_b';
+		} elsif ($state eq 'file_b') {
+			my $x = $mods[$#mods] or croak "Empty array\n";
+			if (exists $x->{file_a} && $x->{chg} !~ /^(?:C|R)$/) {
+				croak "Error parsing $_, $x->{chg}\n";
+			}
+			if (!exists $x->{file_a} && $x->{chg} =~ /^(?:C|R)$/) {
+				croak "Error parsing $_, $x->{chg}\n";
+			}
+			$x->{file_b} = $_;
+			$state = 'meta';
+		} else {
+			croak "Error parsing $_\n";
+		}
+	}
+	command_close_pipe($diff_fh, $ctx);
+	\@mods;
+}
+
+sub check_diff_paths {
+	my ($ra, $pfx, $rev, $mods) = @_;
+	my %types;
+	$pfx .= '/' if length $pfx;
+
+	sub type_diff_paths {
+		my ($ra, $types, $path, $rev) = @_;
+		my @p = split m#/+#, $path;
+		my $c = shift @p;
+		unless (defined $types->{$c}) {
+			$types->{$c} = $ra->check_path($c, $rev);
+		}
+		while (@p) {
+			$c .= '/' . shift @p;
+			next if defined $types->{$c};
+			$types->{$c} = $ra->check_path($c, $rev);
+		}
+	}
+
+	foreach my $m (@$mods) {
+		foreach my $f (qw/file_a file_b/) {
+			next unless defined $m->{$f};
+			my ($dir) = ($m->{$f} =~ m#^(.*?)/?(?:[^/]+)$#);
+			if (length $pfx.$dir && ! defined $types{$dir}) {
+				type_diff_paths($ra, \%types, $pfx.$dir, $rev);
+			}
+		}
+	}
+	\%types;
+}
+
+sub split_path {
+	return ($_[0] =~ m#^(.*?)/?([^/]+)$#);
+}
+
+sub repo_path {
+	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, $enc, 'UTF-8');
+	}
+	$self->{path_prefix}.(defined $path ? $path : '');
+}
+
+sub url_path {
+	my ($self, $path) = @_;
+	if ($self->{url} =~ m#^https?://#) {
+		$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
+	}
+	$self->{url} . '/' . $self->repo_path($path);
+}
+
+sub rmdirs {
+	my ($self) = @_;
+	my $rm = $self->{rm};
+	delete $rm->{''}; # we never delete the url we're tracking
+	return unless %$rm;
+
+	foreach (keys %$rm) {
+		my @d = split m#/#, $_;
+		my $c = shift @d;
+		$rm->{$c} = 1;
+		while (@d) {
+			$c .= '/' . shift @d;
+			$rm->{$c} = 1;
+		}
+	}
+	delete $rm->{$self->{svn_path}};
+	delete $rm->{''}; # we never delete the url we're tracking
+	return unless %$rm;
+
+	my ($fh, $ctx) = command_output_pipe(qw/ls-tree --name-only -r -z/,
+	                                     $self->{tree_b});
+	local $/ = "\0";
+	while (<$fh>) {
+		chomp;
+		my @dn = split m#/#, $_;
+		while (pop @dn) {
+			delete $rm->{join '/', @dn};
+		}
+		unless (%$rm) {
+			close $fh;
+			return;
+		}
+	}
+	command_close_pipe($fh, $ctx);
+
+	my ($r, $p, $bat) = ($self->{r}, $self->{pool}, $self->{bat});
+	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
+		$self->close_directory($bat->{$d}, $p);
+		my ($dn) = ($d =~ m#^(.*?)/?(?:[^/]+)$#);
+		print "\tD+\t$d/\n" unless $::_q;
+		$self->SUPER::delete_entry($d, $r, $bat->{$dn}, $p);
+		delete $bat->{$d};
+	}
+}
+
+sub open_or_add_dir {
+	my ($self, $full_path, $baton, $deletions) = @_;
+	my $t = $self->{types}->{$full_path};
+	if (!defined $t) {
+		die "$full_path not known in r$self->{r} or we have a bug!\n";
+	}
+	{
+		no warnings 'once';
+		# SVN::Node::none and SVN::Node::file are used only once,
+		# so we're shutting up Perl's warnings about them.
+		if ($t == $SVN::Node::none || defined($deletions->{$full_path})) {
+			return $self->add_directory($full_path, $baton,
+			    undef, -1, $self->{pool});
+		} elsif ($t == $SVN::Node::dir) {
+			return $self->open_directory($full_path, $baton,
+			    $self->{r}, $self->{pool});
+		} # no warnings 'once'
+		print STDERR "$full_path already exists in repository at ",
+		    "r$self->{r} and it is not a directory (",
+		    ($t == $SVN::Node::file ? 'file' : 'unknown'),"/$t)\n";
+	} # no warnings 'once'
+	exit 1;
+}
+
+sub ensure_path {
+	my ($self, $path, $deletions) = @_;
+	my $bat = $self->{bat};
+	my $repo_path = $self->repo_path($path);
+	return $bat->{''} unless (length $repo_path);
+
+	my @p = split m#/+#, $repo_path;
+	my $c = shift @p;
+	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''}, $deletions);
+	while (@p) {
+		my $c0 = $c;
+		$c .= '/' . shift @p;
+		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0}, $deletions);
+	}
+	return $bat->{$c};
+}
+
+# Subroutine to convert a globbing pattern to a regular expression.
+# From perl cookbook.
+sub glob2pat {
+	my $globstr = shift;
+	my %patmap = ('*' => '.*', '?' => '.', '[' => '[', ']' => ']');
+	$globstr =~ s{(.)} { $patmap{$1} || "\Q$1" }ge;
+	return '^' . $globstr . '$';
+}
+
+sub check_autoprop {
+	my ($self, $pattern, $properties, $file, $fbat) = @_;
+	# Convert the globbing pattern to a regular expression.
+	my $regex = glob2pat($pattern);
+	# Check if the pattern matches the file name.
+	if($file =~ m/($regex)/) {
+		# Parse the list of properties to set.
+		my @props = split(/;/, $properties);
+		foreach my $prop (@props) {
+			# Parse 'name=value' syntax and set the property.
+			if ($prop =~ /([^=]+)=(.*)/) {
+				my ($n,$v) = ($1,$2);
+				for ($n, $v) {
+					s/^\s+//; s/\s+$//;
+				}
+				$self->change_file_prop($fbat, $n, $v);
+			}
+		}
+	}
+}
+
+sub apply_autoprops {
+	my ($self, $file, $fbat) = @_;
+	my $conf_t = ${$self->{config}}{'config'};
+	no warnings 'once';
+	# Check [miscellany]/enable-auto-props in svn configuration.
+	if (SVN::_Core::svn_config_get_bool(
+		$conf_t,
+		$SVN::_Core::SVN_CONFIG_SECTION_MISCELLANY,
+		$SVN::_Core::SVN_CONFIG_OPTION_ENABLE_AUTO_PROPS,
+		0)) {
+		# Auto-props are enabled.  Enumerate them to look for matches.
+		my $callback = sub {
+			$self->check_autoprop($_[0], $_[1], $file, $fbat);
+		};
+		SVN::_Core::svn_config_enumerate(
+			$conf_t,
+			$SVN::_Core::SVN_CONFIG_SECTION_AUTO_PROPS,
+			$callback);
+	}
+}
+
+sub A {
+	my ($self, $m, $deletions) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir, $deletions);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+					undef, -1);
+	print "\tA\t$m->{file_b}\n" unless $::_q;
+	$self->apply_autoprops($file, $fbat);
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub C {
+	my ($self, $m, $deletions) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir, $deletions);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+				$self->url_path($m->{file_a}), $self->{r});
+	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub delete_entry {
+	my ($self, $path, $pbat) = @_;
+	my $rpath = $self->repo_path($path);
+	my ($dir, $file) = split_path($rpath);
+	$self->{rm}->{$dir} = 1;
+	$self->SUPER::delete_entry($rpath, $self->{r}, $pbat, $self->{pool});
+}
+
+sub R {
+	my ($self, $m, $deletions) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir, $deletions);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+				$self->url_path($m->{file_a}), $self->{r});
+	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_autoprops($file, $fbat);
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+
+	($dir, $file) = split_path($m->{file_a});
+	$pbat = $self->ensure_path($dir, $deletions);
+	$self->delete_entry($m->{file_a}, $pbat);
+}
+
+sub M {
+	my ($self, $m, $deletions) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir, $deletions);
+	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
+				$pbat,$self->{r},$self->{pool});
+	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub T { shift->M(@_) }
+
+sub change_file_prop {
+	my ($self, $fbat, $pname, $pval) = @_;
+	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
+}
+
+sub change_dir_prop {
+	my ($self, $pbat, $pname, $pval) = @_;
+	$self->SUPER::change_dir_prop($pbat, $pname, $pval, $self->{pool});
+}
+
+sub _chg_file_get_blob ($$$$) {
+	my ($self, $fbat, $m, $which) = @_;
+	my $fh = $::_repository->temp_acquire("git_blob_$which");
+	if ($m->{"mode_$which"} =~ /^120/) {
+		print $fh 'link ' or croak $!;
+		$self->change_file_prop($fbat,'svn:special','*');
+	} elsif ($m->{mode_a} =~ /^120/ && $m->{"mode_$which"} !~ /^120/) {
+		$self->change_file_prop($fbat,'svn:special',undef);
+	}
+	my $blob = $m->{"sha1_$which"};
+	return ($fh,) if ($blob =~ /^0{40}$/);
+	my $size = $::_repository->cat_blob($blob, $fh);
+	croak "Failed to read object $blob" if ($size < 0);
+	$fh->flush == 0 or croak $!;
+	seek $fh, 0, 0 or croak $!;
+
+	my $exp = ::md5sum($fh);
+	seek $fh, 0, 0 or croak $!;
+	return ($fh, $exp);
+}
+
+sub chg_file {
+	my ($self, $fbat, $m) = @_;
+	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable','*');
+	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable',undef);
+	}
+	my ($fh_a, $exp_a) = _chg_file_get_blob $self, $fbat, $m, 'a';
+	my ($fh_b, $exp_b) = _chg_file_get_blob $self, $fbat, $m, 'b';
+	my $pool = SVN::Pool->new;
+	my $atd = $self->apply_textdelta($fbat, $exp_a, $pool);
+	if (-s $fh_a) {
+		my $txstream = SVN::TxDelta::new ($fh_a, $fh_b, $pool);
+		my $res = SVN::TxDelta::send_txstream($txstream, @$atd, $pool);
+		if (defined $res) {
+			die "Unexpected result from send_txstream: $res\n",
+			    "(SVN::Core::VERSION: $SVN::Core::VERSION)\n";
+		}
+	} else {
+		my $got = SVN::TxDelta::send_stream($fh_b, @$atd, $pool);
+		die "Checksum mismatch\nexpected: $exp_b\ngot: $got\n"
+		    if ($got ne $exp_b);
+	}
+	Git::temp_release($fh_b, 1);
+	Git::temp_release($fh_a, 1);
+	$pool->clear;
+}
+
+sub D {
+	my ($self, $m, $deletions) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir, $deletions);
+	print "\tD\t$m->{file_b}\n" unless $::_q;
+	$self->delete_entry($m->{file_b}, $pbat);
+}
+
+sub close_edit {
+	my ($self) = @_;
+	my ($p,$bat) = ($self->{pool}, $self->{bat});
+	foreach (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$bat) {
+		next if $_ eq '';
+		$self->close_directory($bat->{$_}, $p);
+	}
+	$self->close_directory($bat->{''}, $p);
+	$self->SUPER::close_edit($p);
+	$p->clear;
+}
+
+sub abort_edit {
+	my ($self) = @_;
+	$self->SUPER::abort_edit($self->{pool});
+}
+
+sub DESTROY {
+	my $self = shift;
+	$self->SUPER::DESTROY(@_);
+	$self->{pool}->clear;
+}
+
+# this drives the editor
+sub apply_diff {
+	my ($self) = @_;
+	my $mods = $self->{mods};
+	my %o = ( D => 0, C => 1, R => 2, A => 3, M => 4, T => 5 );
+	my %deletions;
+
+	foreach my $m (@$mods) {
+		if ($m->{chg} eq "D") {
+			$deletions{$m->{file_b}} = 1;
+		}
+	}
+
+	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
+		my $f = $m->{chg};
+		if (defined $o{$f}) {
+			$self->$f($m, \%deletions);
+		} else {
+			fatal("Invalid change type: $f");
+		}
+	}
+
+	if (defined($self->{mergeinfo})) {
+		$self->change_dir_prop($self->{bat}{''}, "svn:mergeinfo",
+			               $self->{mergeinfo});
+	}
+	$self->rmdirs if $_rmdir;
+	if (@$mods == 0 && !defined($self->{mergeinfo})) {
+		$self->abort_edit;
+	} else {
+		$self->close_edit;
+	}
+	return scalar @$mods;
+}
+
+1;
+__END__
+
+Git::SVN::Editor - commit driver for "git svn set-tree" and dcommit
+
+=head1 SYNOPSIS
+
+	use Git::SVN::Editor;
+	use Git::SVN::Ra;
+
+	my $ra = Git::SVN::Ra->new($url);
+	my %opts = (
+		r => 19,
+		log => "log message",
+		ra => $ra,
+		config => SVN::Core::config_get_config($svn_config_dir),
+		tree_a => "$commit^",
+		tree_b => "$commit",
+		editor_cb => sub { print "Committed r$_[0]\n"; },
+		mergeinfo => "/branches/foo:1-10",
+		svn_path => "trunk"
+	);
+	Git::SVN::Editor->new(\%opts)->apply_diff or print "No changes\n";
+
+	my $re = Git::SVN::Editor::glob2pat("trunk/*");
+	if ($branchname =~ /$re/) {
+		print "matched!\n";
+	}
+
+=head1 DESCRIPTION
+
+This module is an implementation detail of the "git svn" command.
+Do not use it unless you are developing git-svn.
+
+This module adapts the C<SVN::Delta::Editor> object returned by
+C<SVN::Delta::get_commit_editor> and drives it to convey the
+difference between two git tree objects to a remote Subversion
+repository.
+
+The interface will change as git-svn evolves.
+
+=head1 DEPENDENCIES
+
+Subversion perl bindings,
+the core L<Carp> and L<IO::File> modules,
+and git's L<Git> helper module.
+
+C<Git::SVN::Editor> has not been tested using callers other than
+B<git-svn> itself.
+
+=head1 SEE ALSO
+
+L<SVN::Delta>,
+L<Git::SVN::Fetcher>.
+
+=head1 INCOMPATIBILITIES
+
+None reported.
+
+=head1 BUGS
+
+None.
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 4e9c77d7..ef8e9ed2 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -591,7 +591,8 @@ B<git-svn> itself.
 
 =head1 SEE ALSO
 
-L<SVN::Delta>.
+L<SVN::Delta>,
+L<Git::SVN::Editor>.
 
 =head1 INCOMPATIBILITIES
 
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 424890a1..32caf214 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -28,6 +28,7 @@ my %pm = (
 	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
 	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
 	'Git/SVN/Fetcher.pm' => '$(INST_LIBDIR)/Git/SVN/Fetcher.pm',
+	'Git/SVN/Editor.pm' => '$(INST_LIBDIR)/Git/SVN/Editor.pm',
 	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
 );
 
-- 
1.7.10
