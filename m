From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Listing files in order they are changed
Date: Thu, 23 Sep 2010 23:02:13 +0200
Message-ID: <201009232302.14925.jnareb@gmail.com>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com> <m3pqw4gpb2.fsf@localhost.localdomain> <AANLkTi=_GOBuha0cw=qbUTXyUMdiLANPZXoPSOs_rKT8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Parag Kalra <paragkalra@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 23:02:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oysw3-0004Vh-Mm
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab0IWVC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:02:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34338 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0IWVCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:02:24 -0400
Received: by fxm3 with SMTP id 3so382817fxm.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Unr2iy72aGHh0AJoOoJHqWYo/bVD23i6yrQ7AA+kgUI=;
        b=gK3JyEXE3T6PQWHLF3j8qKtNZ3XDo1A9S5BhKKsSjlbSw+AWv6ofNaGS2o6RMViQmY
         oAC0Lf0y4UJTys1BTQh1urZiZTXuYCSimAaPw1T6ENqtvpIudI+IsB0+aXe5KBlAEYIo
         XYcui0bx4BqwecDSuLuJfzUqYnZyGgDx4tElQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gFOTPQwiNqoII9rGtH5aVkq5qSj7vAiM0NQF2WqLE6NdsHAe/w2fUW/rL3giU8e56D
         aUzstlPLT0Pc86cKzvNjcCd4WXYDJ1+Tt8f4hHtWJbREO6j4LISjRhYjT/5Eb5BX8lBM
         9WU3UYE2L1Ki5m6LJOa0q/cQR2xjMexNICsL8=
Received: by 10.223.103.84 with SMTP id j20mr2650280fao.35.1285275742898;
        Thu, 23 Sep 2010 14:02:22 -0700 (PDT)
Received: from [192.168.1.13] (abvh105.neoplus.adsl.tpnet.pl [83.8.205.105])
        by mx.google.com with ESMTPS id 2sm617793faz.38.2010.09.23.14.02.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:02:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=_GOBuha0cw=qbUTXyUMdiLANPZXoPSOs_rKT8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156910>

On Thu, 23 Sep 2010, Sverre Rabbelier wrote:
> On Thu, Sep 23, 2010 at 22:48, Jakub Narebski <jnareb@gmail.com> wrote:

> > The tree blame ("git blame <directory>"), if it existed (I have
> > working prototype), would be of use here.
> 
> Ok, I'll bite. Won't you please show us your tree blame prototype Jakub? :P

I think it works correctly now also for directories other than top one.
Avert your eyes, ugly code ahead ;-) (and code copied from gitweb.perl
and Git.pm / Git/Repo.pm)  

-- >8 --
#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Encode;
use Fcntl ':mode';
use List::Compare::Functional qw(:originals);
use List::MoreUtils qw(uniq pairwise);

use constant DEBUG => 0;

# ----------------------------------------------------------------------
{
package Git::Repo;

use strict;
use warnings;

use IPC::Open2 qw(open2);
use IO::Handle;

use base qw(Exporter);

our @EXPORT = qw();
our @EXPORT_OK = qw();

# Auxiliary subroutines

sub _assert_opts {
	die "must have an even number of arguments for named options"
		unless $#_ % 2;
}

sub _assert_sha1 {
	my $sha1 = shift;
	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
		unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
}

sub new {
	my $class = shift;
	_assert_opts @_;
	my $self = {@_};
	bless $self, $class;
	die 'no repo_dir given' unless $self->{repo_dir};
	return $self;
}

# Return the first items of the git command line, for instance
# qw(/usr/bin/git --git-dir=/path/to/repo.git).
sub _git_cmd {
	my $self = shift;
	return ($self->{git_binary} || 'git', '--git-dir=' . $self->{repo_dir});
}

sub get_sha1 {
	my ($self, $object_id) = @_;

	die 'no object identifier given' unless $object_id;
	die 'object identifier must not contain newlines' if $object_id =~ /\n/;

	unless ($self->{sha1_stdout}) {
		# Open bidi pipe the first time get_sha1 is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{sha1_pid} =
			open2($self->{sha1_stdout}, $self->{sha1_stdin},
			      $self->_git_cmd, 'cat-file', '--batch-check');
	}
	$self->{sha1_stdin}->printflush("$object_id\n")
		or die "cannot write to pipe: $!";
	my $output = $self->{sha1_stdout}->getline()
		or die "cannot read from pipe: $!";
	chomp $output;
	return if $output =~ /missing$/;
	my ($sha1, $type, $size) =
		($output =~ /^([0-9a-f]{40}) ([a-z]+) ([0-9]+)$/)
		or die "invalid response: $output";
	return wantarray ? ($sha1, $type, $size) : $sha1;
}


sub get_object {
	my ($self, $object_id) = @_;

	unless ($self->{object_stdout}) {
		# Open bidi pipe the first time get_object is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{object_pid} =
			open2($self->{object_stdout}, $self->{object_stdin},
			      $self->_git_cmd, 'cat-file', '--batch');
	}
	$self->{object_stdin}->printflush("$object_id\n")
		or die "get_object: cannot write to pipe: $!";
	my ($sha1, $type, $size) =
		split ' ', $self->{object_stdout}->getline()
		or die "get_object: cannot read from pipe: $!";
	die "'$object_id' not found in repository"
		if $type eq 'missing';
	$self->{object_stdout}->read(my $content, $size);
	$self->{object_stdout}->getline();  # eat trailing newline
	return wantarray ? ($sha1, $type, $size, $content) : $content;
}

sub get_commit_difftree {
	my ($self, $commit_id, $parent_id, $path) = @_;

	$path =~ s!([^/])$!$1/!; # add trailing '/' if it is not present
	unless ($self->{difftree_stdout}) {
		# Open bidi pipe the first time get_object is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{difftree_pid} =
			open2($self->{difftree_stdout}, $self->{difftree_stdin},
			      $self->_git_cmd, 'diff-tree', '--stdin', '--raw', '--no-commit-id',
			                       '--root', '--no-renames',
			#                       defined $path ? ('--', $path) : ());
			                       defined $path ? ("--relative=$path", "-t") : ());
	}
	# the additional LF ("\n") is to able to detect end of difftree
	$self->{difftree_stdin}->printflush("$commit_id $parent_id\n\n")
		or die "get_commit_difftree: cannot write to pipe: $!";

	my @difftree_lines;
	while (my $line = $self->{difftree_stdout}->getline()) {
		chomp $line;
		last unless $line;

		push @difftree_lines, $line;
	}
	return wantarray ? @difftree_lines : \@difftree_lines;
}


sub DESTROY {
	my $self = shift;

	if (exists $self->{object_stdout}) {
		close $self->{object_stdout}
			or die "Closing stdout of git-cat-file --batch failed: $!";
	}
	if (exists $self->{object_stdin}) {
		close $self->{object_stdin}
			or die "Closing stdin of git-cat-file --batch  failed: $!";
	}
	if (exists $self->{object_pid}) {
		waitpid $self->{object_pid}, 0
			or die "Waiting for pid=$self->{object_pid} failed: $!";
	}

	if (exists $self->{sha1_stdout}) {
		close $self->{sha1_stdout}
			or die "Closing stdout of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{sha1_stdin}) {
		close $self->{sha1_stdin}
			or die "Closing stdin of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{sha1_pid}) {
		waitpid $self->{sha1_pid}, 0
			or die "Waiting for pid=$self->{sha1_pid} failed: $!";
	}

	if (exists $self->{difftree_stdout}) {
		close $self->{difftree_stdout}
			or die "Closing stdout of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{difftree_stdin}) {
		close $self->{difftree_stdin}
			or die "Closing stdin of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{difftree_pid}) {
		waitpid $self->{difftree_pid}, 0
			or die "Waiting for pid=$self->{difftree_pid} failed: $!";
	}
}

} # end package Git::Repo;

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sub set_signals {
	my $pid = shift;

	$SIG{'PIPE'} = 'IGNORE';
	$SIG{'CHLD'} = 'IGNORE';

	$SIG{'CHLD'} = sub {
		print "REAPER: status $? on $pid\n" 
			if waitpid($pid, 0) > 0;
	};
}

sub cat_file_gitrepo {
	my ($repo, $object_name) = @_;

	my ($ret_sha1, $type, $size, $content) =
		$repo->get_object($object_name);
	return wantarray ? ("$ret_sha1 $type $size", $content) : $content;
}

# ----------------------------------------------------------------------

my $fallback_encoding = 'latin1';
# decode sequences of octets in utf8 into Perl's internal form,
# which is utf-8 with utf8 flag set if needed.  gitweb writes out
# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
sub to_utf8 {
	my $str = shift;
	if (utf8::valid($str)) {
		utf8::decode($str);
		return $str;
	} else {
		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
	}
}

sub parse_commit {
	my ($commit_text) = @_;
	my @commit_lines = split '\n', $commit_text;
	my %co;

	if (! @commit_lines) {
		return;
	}

	my @parents;
 HEADER:
	while (my $line = shift @commit_lines) {
		last if $line eq "\n";
		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
			$co{'tree'} = $1;
		} elsif ($line =~ m/^parent ([0-9a-fA-F]{40})$/) {
			push @parents, $1;
		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
			$co{'author'} = to_utf8($1);
			$co{'author_epoch'} = $2;
			$co{'author_tz'} = $3;
			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
				$co{'author_name'}  = $1;
				$co{'author_email'} = $2;
			} else {
				$co{'author_name'} = $co{'author'};
			}
		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
			$co{'committer'} = to_utf8($1);
			$co{'committer_epoch'} = $2;
			$co{'committer_tz'} = $3;
			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
				$co{'committer_name'}  = $1;
				$co{'committer_email'} = $2;
			} else {
				$co{'committer_name'} = $co{'committer'};
			}
		}
	}
	if (!defined $co{'tree'}) {
		return;
	};
	$co{'parents'} = \@parents;
	$co{'parent'}  =  $parents[0];

	$co{'comment'} = \@commit_lines;

	return wantarray ? %co : \%co;
}

sub unquote { return $_[0] }

# parse line of git-ls-tree output
sub parse_ls_tree_line {
	my $line = shift;
	my %opts = @_;
	my %res;

	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;

	$res{'mode'} = $1;
	$res{'type'} = $2;
	$res{'hash'} = $3;
	if ($opts{'-z'}) {
		$res{'name'} = $4;
	} else {
		$res{'name'} = unquote($4);
	}

	return wantarray ? %res : \%res;
}

# parse line of git-diff-tree "raw" output
sub parse_difftree_raw_line {
	my $line = shift;
	my %res;

	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
		$res{'from_mode'} = $1;
		$res{'to_mode'} = $2;
		$res{'from_id'} = $3;
		$res{'to_id'} = $4;
		$res{'status'} = $5;
		$res{'similarity'} = $6;
		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
		} else {
			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
		}
	}
	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
	# combined diff (for merge commit)
	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
		$res{'nparents'}  = length($1);
		$res{'from_mode'} = [ split(' ', $2) ];
		$res{'to_mode'} = pop @{$res{'from_mode'}};
		$res{'from_id'} = [ split(' ', $3) ];
		$res{'to_id'} = pop @{$res{'from_id'}};
		$res{'status'} = [ split('', $4) ];
		$res{'to_file'} = unquote($5);
	}
	# 'c512b523472485aef4fff9e57b229d9d243c967f'
	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
		$res{'commit'} = $1;
	}

	return wantarray ? %res : \%res;
}

# ......................................................................

# parse one entry of raw 'tree' object output (from 'git cat-file --batch')
sub decode_tree_entry {
	my $buf = shift;
	#use bytes;

	$buf =~ s/^([0-7]+) //;
	my ($mode_str) = $1;
	my ($filename, $sha1_str) = unpack('Z*H[40]', $buf);

	return ($mode_str, $filename, $sha1_str);
}

sub tree_entry_len {
	my ($mode_str, $filename) = @_;
	#use bytes;

	# length of mode string + separator + 20 bytes of SHA-1
	# + length of filename (in bytes) + terminating NUL ('\0')
	length($mode_str)+1 + length($filename)+1 + 20;
}

use constant {
	S_IFINVALID => 0030000,
	S_IFGITLINK => 0160000,
};

# submodule/subproject, a commit object reference
sub S_ISGITLINK {
	my $mode = shift;

	return (($mode & S_IFMT) == S_IFGITLINK)
}

sub type_from_mode {
	my $mode = oct shift;

	if (S_ISGITLINK($mode)) {
		return "commit";
	} elsif (S_ISDIR($mode & S_IFMT)) {
		return "tree";
	}
		return "blob";
}

# ......................................................................

sub decode_tree {
	my $contents = shift;
	#use bytes;

	my @result;

	while (my @entry = decode_tree_entry($contents)) {
		#print join(' ', @entry)."\n";
		#printf("%06d %s\t%s\n", $entry[0], $entry[2], $entry[1]);

		push @result,
			{ 'mode' => $entry[0],
			  'type' => type_from_mode($entry[0]),
			  'name' => $entry[1],
			  'hash' => $entry[2] };

		my $len = tree_entry_len(@entry);
		#print substr($contents, 0, $len)."\n";
		$contents = substr($contents, $len);
		last unless $contents;
	}

	return wantarray ? @result : \@result;
}

sub tree_entry_eq {
	my ($a, $b) = @_;

	return
		$a->{'mode'} == $b->{'mode'} &&
		$a->{'type'} eq $b->{'type'} &&
		$a->{'name'} eq $b->{'name'} &&
		$a->{'hash'} eq $b->{'hash'};
}

# ......................................................................

sub print_parsed_tree {
	my $tree = shift;

	foreach my $tree_entry (@$tree) {
		print format_tree_entry($tree_entry)."\n";
	}
}

sub print_tree_blame {
	my ($tree, $tree_blame) = @_;

	foreach my $tree_entry (@$tree) {
		#print format_tree_blame_entry($tree_blame->{$tree_entry->{'hash'}})."\n";
		print format_tree_blame_entry($tree_entry)."\n";
	}
}

sub format_tree_entry {
	my $tree_entry = shift;

	return sprintf("%06d %s %s\t%s",
		$tree_entry->{'mode'}, $tree_entry->{'type'},
		$tree_entry->{'hash'}, $tree_entry->{'name'});
}

sub format_tree_blame_entry {
	my $tree_entry = shift;

	#my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday)
	#	= gmtime($tree_entry->{'author_epoch'});
	#return sprintf("%06d %s %.8s %.8s %.15s %02d-%02d-%04d\t%s",
	#	$tree_entry->{'mode'}, $tree_entry->{'type'},
	#	$tree_entry->{'hash'}, $tree_entry->{'commit'},
	#	$tree_entry->{'author_name'}, $mday, $mon, 1900 + $year,
	#	$tree_entry->{'name'});
	return sprintf("%06d %s %.8s %.8s\t%.10s\t%s",
		$tree_entry->{'mode'}, $tree_entry->{'type'},
		$tree_entry->{'hash'}, $tree_entry->{'commit'},
		$tree_entry->{'name'}, $tree_entry->{'summary'});
}

# ======================================================================

sub tree_blame_commit {
	my ($repo, $commit_id, $tree_blame, $path) = @_;

	my ($commit_sha1, undef, undef, $commit_text) =
		$repo->get_object($commit_id);
	my %commit = parse_commit($commit_text);

	my $nunblamed = scalar grep { !exists $_->{'commit'} } @$tree_blame;
	printf("processing %6s (%1d parents, %d unblamed): %s\n",
	       substr($commit_sha1,0,6), scalar @{$commit{'parents'}},
	       $nunblamed, $commit{'comment'}[0])
		if DEBUG >= 1;
	print Dumper($tree_blame)
		if DEBUG >= 2;
	return unless $nunblamed > 0;

	foreach my $parent (@{$commit{'parents'}}) {
		my @difftree = $repo->get_commit_difftree($commit_sha1, $parent, $path);
		#my @difftree = $repo->get_commit_difftree("$commit_sha1:$path", "$parent:$path");
		if (DEBUG >= 1) {
			print "$_\n" foreach (@difftree);
		}
		@difftree = map { { parse_difftree_raw_line($_) } } @difftree;
		# work around current deficiences of '--relative[=<path>]'
		# which require for this script to use '-t' (recursive mode)
		@difftree = grep { index($_->{'to_file'}, '/') == -1 } @difftree
			if (defined $path);

		printf("processing %6s: parent %6s has %d in difftree\n",
		       substr($commit_sha1,0,6), substr($parent,0,6),
		       scalar @difftree)
			if DEBUG >= 1;

		no warnings 'recursion';

		# mark entries from @difftree
		#mark_changed($tree_blame, \@difftree, [ $commit_sha1 ]);
		mark_changed($tree_blame, \@difftree, \$commit_sha1);
		# pass blame to parent
		tree_blame_commit($repo, $parent, $tree_blame, $path);
		# remove marks
		#remove_marks($tree_blame, [ $commit_sha1 ]);
		remove_marks($tree_blame, \$commit_sha1);
	}

	my $nblames_this = 0;
	foreach my $tree_entry (@$tree_blame) {
		if (!exists $tree_entry->{'commit'}) {
			$tree_entry->{'commit'}  = $commit_sha1;
			$tree_entry->{'summary'} = $commit{'comment'}[0];
			$tree_entry->{'author_name'} = $commit{'author_name'};
			if ($commit{'author_email'} &&
			    $commit{'author_email'} =~ /^([^@]+)@/) {
				$tree_entry->{'author_user'} = $1;
			}
			$tree_entry->{'author_epoch'} = $commit{'author_epoch'};

			my @difftree = $repo->get_commit_difftree($commit_sha1, '-m', $path);
			@difftree = map { { parse_difftree_raw_line($_) } } @difftree;
			$tree_entry->{'difftree'} =
				[ grep { $_->{'to_id'} eq $tree_entry->{'hash'} } @difftree ];

			$nblames_this++;
		}
	}

	printf("done %6s (got blamed by %1d, %d unblamed left)\n",
	       substr($commit_sha1,0,6), $nblames_this,
	       scalar grep { !exists $_->{'commit'} } @$tree_blame)
		if DEBUG >= 1;
}

sub mark_changed {
	my ($tree_blame, $difftree, $value) = @_;

	my @blame_sha1    = map { $_->{'hash'} }  @$tree_blame;
	my @difftree_sha1 = map { $_->{'to_id'} } @$difftree;
	# not optimized: both @$tree_blame and @$difftree are sorted by filename
	my @common_sha1 = get_intersection('--unsorted', [ \@blame_sha1, \@difftree_sha1 ]);

	my %tree_blame = map { $_->{'hash'} => $_ } @$tree_blame;
	map { $_->{'commit'} = $value unless exists $_->{'commit'} }
		@tree_blame{@common_sha1};
	@$tree_blame = values %tree_blame;

	return @$tree_blame;
}

sub remove_marks {
	my ($tree_blame, $value) = @_;

	map {
		delete($_->{'commit'})
			#if (ref($_->{'commit'}) && ($_->{'commit'}->[0] eq $value->[0]))
			if (ref($_->{'commit'}) && (${$_->{'commit'}} eq $$value))
	}	@$tree_blame;

	return @$tree_blame;
}

# ======================================================================
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ----------------------------------------------------------------------
# MAIN

my $git_dir = "/home/jnareb/git/gitweb/test/.git";
my $tree_path    = "sub";
#my $tree_path    = "";
my $start_commit = "HEAD";

#my $git_dir = "/home/jnareb/git/.git";
#my $tree_path = "contrib";
#my $start_commit = "HEAD";
#my $tree_path    = '';
#my $start_commit = "todo";

my $repo = Git::Repo->new(repo_dir=>$git_dir);

my ($sha1, $type, $size, $obj_data) =
	$repo->get_object("$start_commit:$tree_path");
my @tree_blame = decode_tree($obj_data);

tree_blame_commit($repo, $start_commit, \@tree_blame, $tree_path);

print Dumper(\@tree_blame)
	if DEBUG >= 2;

print_tree_blame(\@tree_blame)
	if DEBUG < 2;

#print Dumper(\@tree_blame);
#print Dumper($tree_blame[0]);

__END__
# ----------------------------------------------------------------------
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ======================================================================

#http://git.or.cz/gitwiki/ExampleScripts#Findingwhichcommitslasttouchedthefiles
#http://gist.github.com/247395

my %attributions = ();
my @files = ();

open IN, "git ls-tree -r --full-name HEAD |" or die;
while (<IN>) {
	if (/^\S+\s+blob \S+\s+(\S+)$/) {
		$files[$#files + 1] = $1;
		$attributions{$1} = -1;
	}
}
close IN;

my $remaining = $#files + 1;

open IN, "git log -r --root --raw --no-abbrev --pretty=format:%h~%an~%ad~ |" or die;
while (<IN>) {
	if (/^([^:~]+)~(.*)~([^~]+)~$/) {
		($commit, $author, $date) = ($1, $2, $3);
	} elsif (/^:\S+\s+1\S+\s+\S+\s+\S+\s+\S\s+(.*)$/) {
		if ($attributions{$1} == -1) {
			$attributions{$1} = "$author, $date ($commit)";
			$remaining--;
			if ($remaining <= 0) {
				break;
			}
		}
	}
}
close IN;

for $f (@files) {
	print "$f	$attributions{$f}\n";
}

# ######################################################################
# ######################################################################
__DATA__
Currently git-blame supports only ordinary files (blobs).  If you try to 
use git-blame on directory, it errors-out with a bit cryptic error 
message:

  $ git blame Documentation
  fatal: unsupported file type Documentation

Meanwhile some git web interface (e.g. GitHub and Gitorious), most 
probably following web interfaces for file-based VCS like ViewVC for 
CVS and Subversion, provide kind of "tree blame" view as default view 
for directory contents.  It means that for each element (entry) in 
given directory it shows 'last changed' info, namely author, date and 
summary of commit that changed given entry to current version.

I don't know what algorithm they use to generate this info (well,
I could find out in the case of Gitorious... if I read Ruby ;-)), 
but I suspect that they might a bit inefficient algorithm to find such 
info.  Some time ago I tried to add such 'tree_blame' view to gitweb:
you can check the result in the 'gitweb/tree_blame' branch in my 
git/jnareb-git.git repository at repo.or.cz:
  http://repo.or.cz/w/git/jnareb-git.git?a=commitdiff;h=gitweb/tree_blame


It would be nice if "git blame <directory>" would give us required 
information; for tools such like GitHub, Gitorious or gitweb one could 
use '--porcelain' or '--incremental' output.

Unfortunately I don't know this part of code good enough to write it
easily myself. I would think that it wouldn't be too hard to code it;
certainly easier than git-blame for ordinary files.

I think that ordinary git-blame output for trees (directories) could
mimic "ls -l" output format as far as possible, i.e. when currently
  $ git ls-tree --abbrev v1.6.3.3
generates the following output:
  ...
  100644 blob e57630e     walker.c
  100644 blob 8a149e1     walker.h
  100644 blob 7eb3218     wrapper.c
  100644 blob 4c29255     write_or_die.c
  100644 blob 819c797     ws.c
  100644 blob 1b6df45     wt-status.c
  100644 blob 78add09     wt-status.h
  100644 blob b9b0db8     xdiff-interface.c
  100644 blob 7352b9a     xdiff-interface.h
  040000 tree ef5d413     xdiff

then
  $ git blame --abbrev v1.6.3.3 -- .
would generate

  100644 blob e57630e ba19a80 Junio C Hamano      Feb 10 17:42   walker.c
  100644 blob 8a149e1 c13b263 Daniel Barkalow     Apr 26  2008   walker.h
  100644 blob 7eb3218 fc71db3 Alex Riesen         Apr 29 23:21   wrapper.c
  100644 blob 4c29255 559e840 Junio C Hamano      Jul 20  2008   write_or_die.c
  100644 blob 819c797 a437900 Junio C Hamano      Jun 21 02:35   ws.c
  100644 blob 1b6df45 2af202b Linus Torvalds      Jun 18 10:28   wt-status.c
  100644 blob 78add09 6c2ce04 Marius Storm-Olsen  Jun  5  2008   wt-status.h
  100644 blob b9b0db8 eb3a9dd Benjamin Kramer     Mar  7 21:02   xdiff-interface.c
  100644 blob 7352b9a 86295bb Rene Scharfe        Oct 25  2008   xdiff-interface.h
  040000 tree ef5d413 5719db9 Charles Bailey      May 25 01:21   xdiff/

or something like that.  Date doesn't have to be in this strange format
used by 'ls'.  Also instead of name we can use username part of email,
or just email; OTOH git-blame uses above format for author.

The porcelain / incremental output format for "git blame <directory>"
wouldn't need to be changed much from "git blame <file>"; line numbers
do not matter though, as what is important is SHA-1 of entry (blob, tree
or commit).
  $ git blame --porcelain v1.6.3.3 -- .
The blame output for last two lines could look like the following:
  86295bb6bac1482d29650d1f77f19d8e7a7cc2fe 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c
  author Rene Scharfe
  author-mail <rene.scharfe@lsrfire.ath.cx>
  author-time 1224941475
  author-tz +0200
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1224961771
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff-interface.h
  100644 blob 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c    xdiff-interface.h
  5719db91ce5915ee07c50f1afdc94fe34e91529f ef5d413237b3a390007fba56671b00d7c371ae1e
  author Charles Bailey
  author-mail <charles@hashpling.org>
  author-time 1243210874
  author-tz +0100
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1243234594
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff
  040000 tree ef5d413237b3a390007fba56671b00d7c371ae1e    xdiff


What do you think about adding such feature?  

It either could use infrastructure for better '--follow' implementation,
or lead to better implementation of '--follow' option (which currently
as it is now works only for simplest cases).  Probably.

-- 
Jakub Narebski
Poland
