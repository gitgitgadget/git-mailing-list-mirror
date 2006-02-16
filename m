From: Eric Wong <normalperson@yhbt.net>
Subject: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Wed, 15 Feb 2006 23:38:26 -0800
Message-ID: <20060216073826.GA12055@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
X-From: git-owner@vger.kernel.org Thu Feb 16 08:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9dit-0002Ez-TB
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 08:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWBPHi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 02:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBPHi2
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 02:38:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34705 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932505AbWBPHi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 02:38:27 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id BBDF22DC01A; Wed, 15 Feb 2006 23:38:26 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16277>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I've written a simple tool for interoperating between git and
svn.  I wrote this so I could use git to work on projects where other
developers use Subversion.  I really hate using svn, but some projects I
work on require it, and svk isn't nearly as fast nor simple as git.

git-svn does not replace git-svnimport, git-svnimport handles branches
and tags automatically, but is too inflexible about repository layouts
to be useful for a good number of projects I follow, and of course
git-svnimport can't commit to Subversion repositories :)

git-svn only cares about a single branch/trunk in SVN[1], but you can
use as many branches in git as you want.  This makes it much easier to
use and allows it to handle just about any repository layout, not just
those recommended in the SVN book/developers.

Although importing changesets from SVN is mostly a linear affair,
committing to SVN is the opposite.  You may commit git tree objects in
any order you want.  It simply clobbers the existing svn tree as
'git-checkout -f' would, but tags file renames/copies carefully so users
on the SVN side can see them.  You can even do some wacky things with
patch reordering.

Basic day-to-day usage is pretty simple, and is designed to work with
and also work like normal git commands:

# Initialize a tree (like git init-db)::
	git-svn init http://svn.foo.org/project/trunk

# Fetch remote revisions::
	git-svn fetch

# Create your own branch to hack on::
	git checkout -b my-branch git-svn-HEAD

# Commit only the git commits you want to SVN::
	git-svn commit <tree-ish> [<tree-ish_2> ...] 

# Commit all the git commits from my-branch that don't exist in SVN::
	git rev-list --pretty=oneline git-svn-HEAD..my-branch | git-svn commit

# Something is committed to SVN, pull the latest into your branch::
	git-svn fetch && git pull . git-svn-HEAD

@ Junio: Is there room for this in the git distribution alongside
git-svnimport?

Thanks for reading,

[1] - there are some a hacks that lets you handle branches and tags, but
it's not automated in any way, requires a bit of imagination to use to
its full potential, and is very much a hack.  See the man page :)

-- 
Eric Wong

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-svn

#!/usr/bin/env perl
use warnings;
use strict;
use vars qw/	$AUTHOR $VERSION
		$SVN_URL $SVN_INFO $SVN_WC
		$GIT_SVN_INDEX $GIT_SVN
		$GIT_DIR $REV_DIR/;
$AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
$VERSION = '0.9.0';
$GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
$GIT_SVN = $ENV{GIT_SVN_ID} || 'git-svn';
$GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
$ENV{GIT_DIR} ||= $GIT_DIR;
$SVN_URL = undef;
$REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
$SVN_WC = "$GIT_DIR/$GIT_SVN/tree";

# make sure the svn binary gives consistent output between locales and TZs:
$ENV{TZ} = 'UTC';
$ENV{LC_ALL} = 'C';

# If SVN:: library support is added, please make the dependencies
# optional and preserve the capability to use the command-line client.
# See what I do with XML::Simple to make the dependency optional.
use Carp qw/croak/;
use IO::File qw//;
use File::Basename qw/dirname basename/;
use File::Path qw/mkpath/;
use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
use File::Spec qw//;
my $sha1 = qr/[a-f\d]{40}/;
my $sha1_short = qr/[a-f\d]{6,40}/;
my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit);

GetOptions(	'revision|r=s' => \$_revision,
		'no-ignore-externals' => \$_no_ignore_ext,
		'stdin|' => \$_stdin,
		'edit|e' => \$_edit,
		'rmdir' => \$_rmdir,
		'help|H|h' => \$_help,
		'no-stop-copy' => \$_no_stop_copy );
my %cmd = (
	fetch => [ \&fetch, "Download new revisions from SVN" ],
	init => [ \&init, "Initialize and fetch (import)"],
	commit => [ \&commit, "Commit git revisions to SVN" ],
	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)" ],
	help => [ \&usage, "Show help" ],
);
my $cmd;
for (my $i = 0; $i < @ARGV; $i++) {
	if (defined $cmd{$ARGV[$i]}) {
		$cmd = $ARGV[$i];
		splice @ARGV, $i, 1;
		last;
	}
};

# we may be called as git-svn-(command), or git-svn(command).
foreach (keys %cmd) {
	if (/git\-svn\-?($_)(?:\.\w+)?$/) {
		$cmd = $1;
		last;
	}
}
usage(0) if $_help;
usage(1) unless (defined $cmd);
svn_check_ignore_externals();
$cmd{$cmd}->[0]->(@ARGV);
exit 0;

####################### primary functions ######################
sub usage {
	my $exit = shift || 0;
	my $fd = $exit ? \*STDERR : \*STDOUT;
	print $fd <<"";
git-svn - bidirectional operations between a single Subversion tree and git
Usage: $0 <command> [options] [arguments]\n
Available commands:

	foreach (sort keys %cmd) {
		print $fd '  ',pack('A10',$_),$cmd{$_}->[1],"\n";
	}
	print $fd <<"";
\nGIT_SVN_ID may be set in the environment to an arbitrary identifier if
you're tracking multiple SVN branches/repositories in one git repository
and want to keep them separate.

	exit $exit;
}

sub rebuild {
	$SVN_URL = shift or undef;
	my $repo_uuid;
	my $newest_rev = 0;
	
	my $pid = open(my $rev_list,'-|');
	defined $pid or croak $!;
	if ($pid == 0) {
		exec("git-rev-list","$GIT_SVN-HEAD") or croak $!;
	}
	my $first;
	while (<$rev_list>) {
		chomp;
		my $c = $_;
		croak "Non-SHA1: $c\n" unless $c =~ /^$sha1$/o;
		my @commit = grep(/^git-svn-id: /,`git-cat-file commit $c`);
		next if (!@commit); # skip merges
		my $id = $commit[$#commit];
		my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
						\s([a-f\d\-]+)$/x);
		if (!$rev || !$uuid || !$url) {
			# some of the original repositories I made had
			# indentifiers like this:
			($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)
							\@([a-f\d\-]+)/x);
			if (!$rev || !$uuid) {
				croak "Unable to extract revision or UUID from ",
					"$c, $id\n";
			}
		}
		print "r$rev = $c\n";
		unless (defined $first) {
			if (!$SVN_URL && !$url) {
				croak "SVN repository location required: $url\n";
			}
			$SVN_URL ||= $url;
			$repo_uuid = setup_git_svn();
			$first = $rev;
		}
		if ($uuid ne $repo_uuid) {
			croak "Repository UUIDs do not match!\ngot: $uuid\n",
						"expected: $repo_uuid\n";
		}
		assert_revision_eq_or_unknown($rev, $c);
		sys('git-update-ref',"$GIT_SVN/revs/$rev",$c);
		$newest_rev = $rev if ($rev > $newest_rev);
	}
	close $rev_list or croak $?;
	if (!chdir $SVN_WC) {
		my @svn_co = ('svn','co',"-r$first");
		push @svn_co, '--ignore-externals' unless $_no_ignore_ext;
		sys(@svn_co, $SVN_URL, $SVN_WC);
		chdir $SVN_WC or croak $!;
	}
	
	$pid = fork;
	defined $pid or croak $!;
	if ($pid == 0) {
		my @svn_up = qw(svn up);
		push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
		sys(@svn_up,"-r$newest_rev");
		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX; 
		git_addremove();
		exec('git-write-tree');
	}
	waitpid $pid, 0;
}

sub init {
	$SVN_URL = shift or croak "SVN repository location required\n";
	unless (-d $GIT_DIR) {
		sys('git-init-db');
	}
	setup_git_svn();
}

sub fetch {
	my (@parents) = @_;
	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
	if (-d $SVN_WC && !$_revision) {
		$_revision = 'BASE:HEAD';
	}
	push @log_args, "-r$_revision" if $_revision;
	push @log_args, '--stop-on-copy' unless $_no_stop_copy;

	eval { require XML::Simple or croak $! };
	my $svn_log = $@ ? svn_log_raw(@log_args) : svn_log_xml(@log_args);
	
	my $base = shift @$svn_log or croak "No base revision!\n";
	my $last_commit = undef;
	unless (-d $SVN_WC) {
		my @svn_co = ('svn','co',"-r$base->{revision}");
		push @svn_co,'--ignore-externals' unless $_no_ignore_ext;
		sys(@svn_co, $SVN_URL, $SVN_WC);
		chdir $SVN_WC or croak $!;
		$last_commit = git_commit($base, @parents);
		unless (-f "$GIT_DIR/refs/heads/master") {
			sys(qw(git-update-ref refs/heads/master),$last_commit);
		}
		assert_svn_wc_clean($base->{revision}, $last_commit);
	} else {
		chdir $SVN_WC or croak $!;
		$last_commit = file_to_s("$REV_DIR/$base->{revision}");
	}
	my @svn_up = qw(svn up);
	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
	my $last_rev = $base->{revision};
	foreach my $log_msg (@$svn_log) {
		assert_svn_wc_clean($last_rev, $last_commit);
		$last_rev = $log_msg->{revision};
		sys(@svn_up,"-r$last_rev");
		$last_commit = git_commit($log_msg, $last_commit, @parents);
	}
	assert_svn_wc_clean($last_rev, $last_commit);
	return pop @$svn_log;
}

sub commit {
	my (@commits) = @_;
	if ($_stdin || !@commits) {
		print "Reading from stdin...\n";
		@commits = ();
		while (<STDIN>) {
			if (/^([a-f\d]{6,40})\b/) {
				unshift @commits, $1;
			}
		}
	}
	my @revs;
	foreach (@commits) {
		push @revs, (safe_qx('git-rev-parse',$_));
	}
	chomp @revs;
	
	fetch();
	chdir $SVN_WC or croak $!;
	my $svn_current_rev =  svn_info('.')->{'Last Changed Rev'};
	foreach my $c (@revs) {
		print "Committing $c\n";
		svn_checkout_tree($svn_current_rev, $c);
		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
	}
	print "Done committing ",scalar @revs," revisions to SVN\n";
		
}

########################### utility functions #########################

sub setup_git_svn {
	defined $SVN_URL or croak "SVN repository location required\n";
	unless (-d $GIT_DIR) {
		croak "GIT_DIR=$GIT_DIR does not exist!\n";
	}
	mkpath(["$GIT_DIR/$GIT_SVN"]);
	mkpath(["$GIT_DIR/$GIT_SVN/info"]);
	mkpath([$REV_DIR]);
	s_to_file($SVN_URL,"$GIT_DIR/$GIT_SVN/info/url");
	my $uuid = svn_info($SVN_URL)->{'Repository UUID'} or
					croak "Repository UUID unreadable\n";
	s_to_file($uuid,"$GIT_DIR/$GIT_SVN/info/uuid");

	open my $fd, '>>', "$GIT_DIR/$GIT_SVN/info/exclude" or croak $!;
	print $fd '.svn',"\n";
	close $fd or croak $!;
	return $uuid;
}

sub assert_svn_wc_clean {
	my ($svn_rev, $commit) = @_;
	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
	croak "$commit is not a sha1!\n" unless ($commit =~ /^$sha1$/o);
	my $svn_info = svn_info('.');
	if ($svn_rev != $svn_info->{'Last Changed Rev'}) {
		croak "Expected r$svn_rev, got r",
				$svn_info->{'Last Changed Rev'},"\n";
	}
	my @status = grep(!/^Performing status on external/,(`svn status`));
	@status = grep(!/^\s*$/,@status);
	if (scalar @status) {
		print STDERR "Tree ($SVN_WC) is not clean:\n";
		print STDERR $_ foreach @status;
		croak;
	}
	my ($tree_a) = grep(/^tree $sha1$/o,`git-cat-file commit $commit`);
	$tree_a =~ s/^tree //;
	chomp $tree_a;
	chomp(my $tree_b = `GIT_INDEX_FILE=$GIT_SVN_INDEX git-write-tree`);
	if ($tree_a ne $tree_b) {
		croak "$svn_rev != $commit, $tree_a != $tree_b\n";
	}
}

sub parse_diff_tree {
	my $diff_fh = shift;
	local $/ = "\0";
	my $state = 'meta';
	my @mods;
	while (<$diff_fh>) {
		chomp $_; # this gets rid of the trailing "\0"
		print $_,"\n";
		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
					$sha1\s($sha1)\s([MTCRAD])\d*$/xo) {
			push @mods, {	mode_a => $1, mode_b => $2,
					sha1_b => $3, chg => $4 };
			if ($4 =~ /^(?:C|R)$/) {
				$state = 'file_a';
			} else {
				$state = 'file_b';
			}
		} elsif ($state eq 'file_a') {
			my $x = $mods[$#mods] or croak __LINE__,": Empty array\n";
			if ($x->{chg} !~ /^(?:C|R)$/) {
				croak __LINE__,": Error parsing $_, $x->{chg}\n";
			}
			$x->{file_a} = $_;
			$state = 'file_b';
		} elsif ($state eq 'file_b') {
			my $x = $mods[$#mods] or croak __LINE__,": Empty array\n";
			if (exists $x->{file_a} && $x->{chg} !~ /^(?:C|R)$/) {
				croak __LINE__,": Error parsing $_, $x->{chg}\n";
			}
			if (!exists $x->{file_a} && $x->{chg} =~ /^(?:C|R)$/) {
				croak __LINE__,": Error parsing $_, $x->{chg}\n";
			}
			$x->{file_b} = $_;
			$state = 'meta';
		} else {
			croak __LINE__,": Error parsing $_\n";
		}
	}
	close $diff_fh or croak $!;
	return \@mods;
}

sub svn_check_prop_executable {
	my $m = shift;
	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
		sys(qw(svn propset svn:executable 1), $m->{file_b});
	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
		sys(qw(svn propdel svn:executable), $m->{file_b});
	}
}

sub svn_ensure_parent_path {
	my $dir_b = dirname(shift);
	svn_ensure_parent_path($dir_b) if ($dir_b ne File::Spec->curdir);
	mkpath([$dir_b]) unless (-d $dir_b);
	sys(qw(svn add -N), $dir_b) unless (-d "$dir_b/.svn");
}

sub svn_checkout_tree {
	my ($svn_rev, $commit) = @_;
	my $from = file_to_s("$REV_DIR/$svn_rev");
	assert_svn_wc_clean($svn_rev,$from);
	print "diff-tree '$from' '$commit'\n";
	my $pid = open my $diff_fh, '-|';
	defined $pid or croak $!;
	if ($pid == 0) {
		exec(qw(git-diff-tree -z -r -C), $from, $commit) or croak $!;
	}
	my $mods = parse_diff_tree($diff_fh);
	unless (@$mods) {
		# git can do empty commits, SVN doesn't allow it...
		return $svn_rev;
	}
	my %rm;
	foreach my $m (@$mods) {
		if ($m->{chg} eq 'C') {
			svn_ensure_parent_path( $m->{file_b} );
			sys(qw(svn cp),		$m->{file_a}, $m->{file_b});
			blob_to_file(		$m->{sha1_b}, $m->{file_b});
			svn_check_prop_executable($m);
		} elsif ($m->{chg} eq 'D') {
			$rm{dirname $m->{file_b}}->{basename $m->{file_b}} = 1;
			sys(qw(svn rm --force), $m->{file_b});
		} elsif ($m->{chg} eq 'R') {
			svn_ensure_parent_path( $m->{file_b} );
			sys(qw(svn mv --force), $m->{file_a}, $m->{file_b});
			blob_to_file(		$m->{sha1_b}, $m->{file_b});
			svn_check_prop_executable($m);
			$rm{dirname $m->{file_a}}->{basename $m->{file_a}} = 1;
		} elsif ($m->{chg} eq 'M') {
			if ($m->{mode_b} =~ /^120/ && $m->{mode_a} =~ /^120/) {
				unlink $m->{file_b} or croak $!;
				blob_to_symlink($m->{sha1_b}, $m->{file_b});
			} else {
				blob_to_file($m->{sha1_b}, $m->{file_b});
			}
			svn_check_prop_executable($m);
		} elsif ($m->{chg} eq 'T') {
			sys(qw(svn rm --force),$m->{file_b});
			if ($m->{mode_b} =~ /^120/ && $m->{mode_a} =~ /^100/) {
				blob_to_symlink($m->{sha1_b}, $m->{file_b});
			} else {
				blob_to_file($m->{sha1_b}, $m->{file_b});
			}
			svn_check_prop_executable($m);
			sys(qw(svn add --force), $m->{file_b});
		} elsif ($m->{chg} eq 'A') {
			svn_ensure_parent_path( $m->{file_b} );
			blob_to_file(		$m->{sha1_b}, $m->{file_b});
			if ($m->{mode_b} =~ /755$/) {
				chmod 0755, $m->{file_b};
			}
			sys(qw(svn add --force), $m->{file_b});
		} else {
			croak "Invalid chg: $m->{chg}\n";
		}
	}
	if ($_rmdir) {
		my $old_index = $ENV{GIT_INDEX_FILE};
		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
		foreach my $dir (keys %rm) {
			my $files = $rm{$dir};
			my @files;
			foreach (safe_qx('svn','ls',$dir)) {
				chomp;
				push @files, $_ unless $files->{$_};
			}
			sys(qw(svn rm),$dir) unless @files;
		}
		if ($old_index) {
			$ENV{GIT_INDEX_FILE} = $old_index;
		} else {
			delete $ENV{GIT_INDEX_FILE};
		}
	}
}

sub svn_commit_tree {
	my ($svn_rev, $commit) = @_;
	my $commit_msg = "$GIT_DIR/$GIT_SVN/.svn-commit.tmp.$$";
	open my $msg, '>', $commit_msg  or croak $!;
	
	chomp(my $type = `git-cat-file -t $commit`);
	if ($type eq 'commit') {
		my $pid = open my $msg_fh, '-|';
		defined $pid or croak $!;

		if ($pid == 0) {
			exec(qw(git-cat-file commit), $commit) or croak $!;
		}
		my $in_msg = 0;
		while (<$msg_fh>) {
			if (!$in_msg) {
				$in_msg = 1 if (/^\s*$/);
			} else {
				print $msg $_ or croak $!;
			}
		}
		close $msg_fh or croak $!;
	}
	close $msg or croak $!;

	if ($_edit || ($type eq 'tree')) {
		my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
		system($editor, $commit_msg);
	}
	my @ci_output = safe_qx(qw(svn commit -F),$commit_msg);
	my ($committed) = grep(/^Committed revision \d+\./,@ci_output);
	unlink $commit_msg;
	defined $committed or croak
			"Commit output failed to parse committed revision!\n",
			join("\n",@ci_output),"\n";
	my ($rev_committed) = ($committed =~ /^Committed revision (\d+)\./);

	# resync immediately
	my @svn_up = (qw(svn up), "-r$svn_rev");
	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
	sys(@svn_up);
	return fetch("$rev_committed=$commit")->{revision};
}

sub svn_log_xml {
	my (@log_args) = @_;
	my $log_fh = IO::File->new_tmpfile or croak $!;
	
	my $pid = fork;
	defined $pid or croak $!;
	
	if ($pid == 0) {
		open STDOUT, '>&', $log_fh or croak $!;
		exec (qw(svn log --xml), @log_args) or croak $!
	}
	
	waitpid $pid, 0;
	croak $? if $?;

	seek $log_fh, 0, 0;
	my @svn_log;
	my $log = XML::Simple::XMLin( $log_fh,
				ForceArray => ['path','revision','logentry'],
				KeepRoot => 0,
				KeyAttr => {	logentry => '+revision',
						paths => '+path' },
			)->{logentry};
	foreach my $r (sort {$a <=> $b} keys %$log) {
		my $log_msg = $log->{$r};
		my ($Y,$m,$d,$H,$M,$S) = ($log_msg->{date} =~
					/(\d{4})\-(\d\d)\-(\d\d)T
					 (\d\d)\:(\d\d)\:(\d\d)\.\d+Z$/x)
					 or croak "Failed to parse date: ",
						 $log->{$r}->{date};
		$log_msg->{date} = "+0000 $Y-$m-$d $H:$M:$S";

		# XML::Simple can't handle <msg></msg> as a string:
		if (ref $log_msg->{msg} eq 'HASH') {
			$log_msg->{msg} = "\n";
		} else {
			$log_msg->{msg} .= "\n";
		}
		push @svn_log, $log->{$r};
	}
	return \@svn_log;
}

sub svn_log_raw {
	my (@log_args) = @_;
	my $pid = open my $log_fh,'-|';
	defined $pid or croak $!;
	
	if ($pid == 0) {
		exec (qw(svn log), @log_args) or croak $!
	}
	
	my @svn_log;
	my $state;
	while (<$log_fh>) {
		chomp;
		if (/^\-{72}$/) {
			$state = 'rev';
			
			# if we have an empty log message, put something there:
			if (@svn_log) {
				$svn_log[0]->{msg} ||= "\n";
			}
			next;
		}
		if ($state eq 'rev' && s/^r(\d+)\s*\|\s*//) {
			my $rev = $1;
			my ($author, $date) = split(/\s*\|\s*/, $_, 2);
			my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
					/(\d{4})\-(\d\d)\-(\d\d)\s
					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
					 or croak "Failed to parse date: $date\n";
			my %log_msg = (	revision => $rev,
					date => "$tz $Y-$m-$d $H:$M:$S",
					author => $author,
					msg => '' );
			unshift @svn_log, \%log_msg;
			$state = 'msg_start';
			next;
		}
		# skip the first blank line of the message:
		if ($state eq 'msg_start' && /^$/) {
			$state = 'msg';
		} elsif ($state eq 'msg') {
			$svn_log[0]->{msg} .= $_."\n";
		}
	}
	close $log_fh or croak $?;
	return \@svn_log;
}

sub svn_info {
	my $url = shift || $SVN_URL;

	my $pid = open my $info_fh, '-|';
	defined $pid or croak $!;
	
	if ($pid == 0) {
		exec(qw(svn info),$url) or croak $!;
	}
	
	my $ret = {};
	# only single-lines seem to exist in svn info output
	while (<$info_fh>) {
		chomp $_;
		if (m#^([^:]+)\s*:\s*(\S*)$#) {
			$ret->{$1} = $2;
			push @{$ret->{-order}}, $1;
		}
	}
	close $info_fh or croak $!;
	return $ret;
}

sub sys { system(@_) == 0 or croak $? }

sub git_addremove {
	system(	"git-ls-files -z --others ".
			"'--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude'".
				"| git-update-index --add -z --stdin; ".
		"git-ls-files -z --deleted ".
				"| git-update-index --remove -z --stdin; ".
		"git-ls-files -z --modified".
				"| git-update-index -z --stdin") == 0 or croak $?
}

sub s_to_file {
	my ($str, $file, $mode) = @_;
	open my $fd,'>',$file or croak $!;
	print $fd $str,"\n" or croak $!;
	close $fd or croak $!;
	chmod ($mode &~ umask, $file) if (defined $mode);
}

sub file_to_s {
	my $file = shift;
	open my $fd,'<',$file or croak "$!: file: $file\n";
	local $/;
	my $ret = <$fd>;
	close $fd or croak $!;
 	$ret =~ s/\s*$//s;
	return $ret;
}

sub assert_revision_unknown {
	my $revno = shift;
	if (-f "$REV_DIR/$revno") {
		croak "$REV_DIR/$revno already exists! ",
				"Why are we refetching it?";
	}
}

sub assert_revision_eq_or_unknown {
	my ($revno, $commit) = @_;
	if (-f "$REV_DIR/$revno") {
		my $current = file_to_s("$REV_DIR/$revno");
		if ($commit ne $current) {
			croak "$REV_DIR/$revno already exists!\n",
				"current: $current\nexpected: $commit\n";
		}
		return;
	}
}

sub git_commit {
	my ($log_msg, @parents) = @_;
	assert_revision_unknown($log_msg->{revision});
	my $out_fh = IO::File->new_tmpfile or croak $!;
	my $info = svn_info('.');
	my $uuid = $info->{'Repository UUID'};
	defined $uuid or croak "Unable to get Repository UUID\n";

	# commit parents can be conditionally bound to a particular
	# svn revision via: "svn_revno=commit_sha1", filter them out here:
	my @exec_parents;
	foreach my $p (@parents) {
		next unless defined $p;
		if ($p =~ /^(\d+)=($sha1_short)$/o) {
			if ($1 == $log_msg->{revision}) {
				push @exec_parents, $2;
			}
		} else {
			push @exec_parents, $p if $p =~ /$sha1_short/o;
		}
	}

	my $pid = fork;
	defined $pid or croak $!;
	if ($pid == 0) {
		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
		git_addremove();
		chomp(my $tree = `git-write-tree`);
		croak if $?;
		my $msg_fh = IO::File->new_tmpfile or croak $!;
		print $msg_fh $log_msg->{msg}, "\ngit-svn-id: ", 
					"$SVN_URL\@$log_msg->{revision}",
					" $uuid\n" or croak $!;
		$msg_fh->flush == 0 or croak $!;
		seek $msg_fh, 0, 0 or croak $!;

		$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} =
						$log_msg->{author};
		$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} =
						$log_msg->{author}."\@$uuid";
		$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} =
						$log_msg->{date};
		my @exec = ('git-commit-tree',$tree);
		push @exec, '-p', $_  foreach @exec_parents;
		open STDIN, '<&', $msg_fh or croak $!;
		open STDOUT, '>&', $out_fh or croak $!;
		exec @exec or croak $!;
	}
	waitpid($pid,0);
	croak if $?;

	$out_fh->flush == 0 or croak $!;
	seek $out_fh, 0, 0 or croak $!;
	chomp(my $commit = do { local $/; <$out_fh> });
	if ($commit !~ /^$sha1$/o) {
		croak "Failed to commit, invalid sha1: $commit\n";
	}
	my @update_ref = ('git-update-ref',"refs/heads/$GIT_SVN-HEAD",$commit);
	if (my $primary_parent = shift @exec_parents) {
		push @update_ref, $primary_parent;
	}
	sys(@update_ref);
	sys('git-update-ref',"$GIT_SVN/revs/$log_msg->{revision}",$commit);
	print "r$log_msg->{revision} = $commit\n";
	return $commit;
}

sub blob_to_symlink {
	my ($blob, $link) = @_;
	defined $link or croak "\$link not defined!\n";
	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
	my $dest = `git-cat-file blob $blob`; # no newline, so no chomp
	symlink $dest, $link or croak $!;
}

sub blob_to_file {
	my ($blob, $file) = @_;
	defined $file or croak "\$file not defined!\n";
	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
	open my $blob_fh, '>', $file or croak "$!: $file\n";
	my $pid = fork;
	defined $pid or croak $!;

	if ($pid == 0) {
		open STDOUT, '>&', $blob_fh or croak $!;
		exec('git-cat-file','blob',$blob);
	}
	waitpid $pid, 0;
	croak $? if $?;
	
	close $blob_fh or croak $!;
}

sub safe_qx {
	my $pid = open my $child, '-|';
	defined $pid or croak $!;
	if ($pid == 0) {
		exec(@_) or croak $?;
	}
	my @ret = (<$child>);
	close $child or croak $?;
	die $? if $?; # just in case close didn't error out
	return wantarray ? @ret : join('',@ret);
}

sub svn_check_ignore_externals {
	return if $_no_ignore_ext;
	unless (grep /ignore-externals/,(safe_qx(qw(svn co -h)))) {
		print STDERR "W: Installed svn version does not support ",
				"--ignore-externals\n";
		$_no_ignore_ext = 1;
	}
}
__END__

Data structures:

@svn_log = array of log_msg hashes

$log_msg hash 
{ 
	msg => 'whitespace-formatted log entry
',						# trailing newline is preserved
	revision => '8',			# integer
	date => '2004-02-24T17:01:44.108345Z',	# commit date
	author => 'committer name' 
};


@mods = array of diff-index line hashes, each element represents one line
	of diff-index output

diff-index line ($m hash)
{
	mode_a => first column of diff-index output, no leading ':',
	mode_b => second column of diff-index output,
	sha1_b => sha1sum of the final blob,
	chg => change type [MCRAD],
	file_a => original file name of a file (iff chg is 'C' or 'R')
	file_b => new/current file name of a file (any chg)
}
;

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-svn.txt"

git-svn(1)
==========

NAME
----
git-svn - bidirectional operation between a single Subversion branch and git

SYNOPSIS
--------
'git-svn' <command> [options] [arguments]

DESCRIPTION
-----------
git-svn is a simple conduit for changesets between a single Subversion
branch and git.

git-svn is not to be confused with git-svnimport.  The were designed
with very different goals in mind.

git-svn is designed for an individual developer who wants a
bidirectional flow of changesets between a single branch in Subversion
and an arbitrary number of branches in git.  git-svnimport is designed
for read-only operation on repositories that match a particular layout
(albeit the recommended one by SVN developers).

For importing svn, git-svnimport is potentially more powerful when
operating on repositories organized under the recommended
trunk/branch/tags structure, and should be faster, too.

git-svn completely ignores the very limited view of branching that
Subversion has.  This allows git-svn to be much easier to use,
especially on repositories that are not organized in a manner that
git-svnimport is designed for.

COMMANDS
--------
init::
	Creates an empty git repository with additional metadata
	directories for git-svn.  The SVN_URL must be specified
	at this point.

fetch::
	Fetch unfetched revisions from the SVN_URL we are tracking.
	refs/heads/git-svn-HEAD will be updated to the latest revision.
	
commit::
	Commit specified commit or tree objects to SVN.  This relies on
	your imported fetch data being up-to-date.  This makes
	absolutely no attempts to do patching when committing to SVN, it
	simply overwrites files with those specified in the tree or
	commit.  All merging is assumed to have taken place
	independently of git-svn functions.

rebuild::
	Not a part of daily usage, but this is a useful command if
	you've just cloned a repository (using git-clone) that was
	tracked with git-svn.  Unfortunately, git-clone does not clone
	git-svn metadata and the svn working tree that git-svn uses for
	its operations.  This rebuilds the metadata so git-svn can
	resume fetch operations.  SVN_URL may be optionally specified if
	the directory/repository you're tracking has moved or changed
	protocols.

OPTIONS
-------
-r <ARG>::
--revision <ARG>::
	Only used with the 'fetch' command.

	Takes any valid -r<argument> svn would accept and passes it
	directly to svn. -r<ARG1>:<ARG2> ranges and "{" DATE "}" syntax
	is also supported.  This is passed directly to svn, see svn
	documentation for more details.

	This can allow you to make partial mirrors when running fetch.

-::
--stdin::
	Only used with the 'commit' command.
	
	Read a list of commits from stdin and commit them in reverse
	order.  Only the leading sha1 is read from each line, so
	git-rev-list --pretty=oneline output can be used.

--rmdir::
	Only used with the 'commit' command.

	Remove directories from the SVN tree if there are no files left
	behind.  SVN can version empty directories, and they are not
	removed by default if there are no files left in them.  git
	cannot version empty directories.  Enabling this flag will make
	the commit to SVN act like git.

-e::
--edit::
	Only used with the 'commit' command.
	
	Edit the commit message before committing to SVN.  This is off by
	default for objects that are commits, and forced on when committing
	tree objects.

COMPATIBILITY OPTIONS
---------------------
--no-ignore-externals::
	Only used with the 'fetch' and 'rebuild' command.

	By default, git-svn passes --ignore-externals to svn to avoid
	fetching svn:external trees into git.  Pass this flag to enable
	externals tracking directly via git.

	Versions of svn that do not support --ignore-externals are
	automatically detected and this flag will be automatically
	enabled for them.

	Otherwise, do not enable this flag unless you know what you're
	doing.

--no-stop-on-copy::
	Only used with the 'fetch' command.

	By default, git-svn passes --stop-on-copy to avoid dealing with
	the copied/renamed branch directory problem entirely.  A
	copied/renamed branch is the result of a <SVN_URL> being created
	in the past from a different source.  These are problematic to
	deal with even when working purely with svn if you work inside
	subdirectories.

	Do not use this flag unless you know exactly what you're getting
	yourself into.  You have been warned.

Examples
~~~~~~~~

Tracking and contributing to an Subversion managed-project:

# Initialize a tree (like git init-db)::
	git-svn init http://svn.foo.org/project/trunk
# Fetch remote revisions::
	git-svn fetch
# Create your own branch to hack on::
	git checkout -b my-branch git-svn-HEAD
# Commit only the git commits you want to SVN::
	git-svn commit <tree-ish> [<tree-ish_2> ...] 
# Commit all the git commits from my-branch that don't exist in SVN::
	git rev-list --pretty=oneline git-svn-HEAD..my-branch | git-svn commit
# Something is committed to SVN, pull the latest into your branch::
	git-svn fetch && git pull . git-svn-HEAD

DESIGN PHILOSOPHY
-----------------
Merge tracking in Subversion is lacking and doing branched development
with Subversion is cumbersome as a result.  git-svn completely forgoes
any automated merge/branch tracking on the Subversion side and leaves it
entirely up to the user on the git side.  It's simply not worth it to do
a useful translation when the the original signal is weak.

TRACKING MULTIPLE REPOSITORIES OR BRANCHES
------------------------------------------
This is for advanced users, most users should ignore this section.

Because git-svn does not care about relationships between different
branches or directories in a Subversion repository, git-svn has a simple
hack to allow it to track an arbitrary number of related _or_ unrelated
SVN repositories via one git repository.  Simply set the GIT_SVN_ID
environment variable to a name other other than "git-svn" (the default)
and git-svn will ignore the contents of the $GIT_DIR/git-svn directory
and instead do all of its work in $GIT_DIR/$GIT_SVN_ID for that
invocation.

ADDITIONAL FETCH ARGUMENTS
--------------------------
This is for advanced users, most users should ignore this section.

Unfetched SVN revisions may be imported as children of existing commits
by specifying additional arguments to 'fetch'.  Additional parents may
optionally be specified in the form of sha1 hex sums at the
command-line.  Unfetched SVN revisions may also be tied to particular
git commits with the following syntax:
		
	svn_revision_number=git_commit_sha1

This allows you to tie unfetched SVN revision 375 to your current HEAD::

	git-svn fetch 375=$(git-rev-parse HEAD)

BUGS
----
If somebody commits a conflicting changeset to SVN at a bad moment
(right before you commit) causing a conflict and your commit to fail,
your svn working tree ($GIT_DIR/git-svn/tree) may be dirtied.  The
easiest thing to do is probably just to rm -rf $GIT_DIR/git-svn/tree and
run 'rebuild'.

We ignore all SVN properties except svn:executable.  Too difficult to
map them since we rely heavily on git write-tree being _exactly_ the
same on both the SVN and git working trees and I prefer not to clutter
working trees with metadata files.

svn:keywords can't be ignored in Subversion (at least I don't know of
a way to ignore them).

Author
------
Written by Eric Wong <normalperson@yhbt.net>.

Documentation
-------------
Written by Eric Wong <normalperson@yhbt.net>.

--liOOAslEiF7prFVr--
