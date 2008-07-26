From: Scott Collins <scc@slashdot.org>
Subject: [SCRIPT] git-upstream: prints the tracking chain starting at the named ref
Date: Sat, 26 Jul 2008 10:44:29 -0400
Message-ID: <26F09105-BFA2-4FA2-86AA-B9E6F9DE3762@slashdot.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/mixed; boundary=Apple-Mail-30-405584510
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 17:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlsZ-0003cc-Dt
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYGZPjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755986AbYGZPjQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:39:16 -0400
Received: from mx-1.vasoftware.com ([208.48.95.23]:33450 "EHLO
	mx-1.vasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbYGZPjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:39:15 -0400
X-Greylist: delayed 3279 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jul 2008 11:39:14 EDT
Received: from c-68-40-201-218.hsd1.mi.comcast.net ([68.40.201.218] helo=Titan.lan)
	by mx-1.vasoftware.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.64)
	id 1KMl0Z-0003YC-Jf by VAAuthID scollins with plain
	for git@vger.kernel.org; Sat, 26 Jul 2008 07:44:34 -0700
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90246>


--Apple-Mail-30-405584510
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Howdy, all.

Here's a script I've sort of `grown' over the past few weeks.

I use it to quickly see where a tracking branch stands with respect to  
upstream refs _without_ actually fetching or even switching to the  
tracking branch.  This may not be useful for everyones' work-flows;  
but I find it handy. I'm posting because it may be of use to others  
(and feedback, if any, can only improve it).

Example:

	$ git upstream -v --abbrev master
	ce567d1... master* is behind 'origin/master' by 17 commits, and can  
be fast-forwarded.
	186458b... origin/master
	186458b... master@origin, git://git.kernel.org/pub/scm/git/git.git

For more info, try: git upstream -v -h

It's a perl script and uses Git.pm.  Tries to fit into git standard  
practices.  Supports colors (defaults to color like git branch),  
configs.  It has a few rough edges, but it's very usable.  The tiny  
pause before printing a remote tracking branch is ls-remote.  I hope  
the name doesn't conflict with anything.

I apologize for attaching rather than inserting in-line; but this is a  
complete file, not a patch and I also don't trust my mailer :-(


--Apple-Mail-30-405584510
Content-Disposition: attachment;
	filename=git-upstream
Content-Type: application/octet-stream;
	x-unix-mode=0755;
	x-mac-type=54455854;
	name="git-upstream"
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl

use warnings;
use strict;
use lib (split(/:/, $ENV{GITPERLLIB} || "/usr/local/lib/perl5/site_perl"));

use Git;
my $R = Git->repository();

use AppConfig;
my $A = AppConfig->new({ ERROR => \&usage });


sub version {
	my ($dont_exit) = @_;
	print "Version 1.0";
	unless ( $dont_exit ) {
		print "\n";
		exit 1;
	}
}

sub license {
	my ($dont_exit) = @_;
	version('don\'t exit!');
	print <<END_LICENSE;
, Copyright (c) 26 July 2008 by Scott Collins.
Licensed under the GPL v2 or, at your discretion, a later version of the GPL.
END_LICENSE
	exit 1 unless $dont_exit;
}


sub usage {
	my ($m1, $m2) = @_;
	my $error = $m2 || $m1;
	print $error . "\n\n" if $error;

	print <<END_USAGE;
Usage:

	git upstream ([options] [ref])*

Options:

	--help | -h		you're soaking in it!
				hint: try '--verbose --help'

	--verbose | -v		print extra information (defaults: abbrev=40, full-names, bold-refs)
	--no-verbose		...or not (defaults: abbrev=7, no-full-names, no-bold-refs)

	--abbrev[=<n>]		number of digits to show in commit ids; 0<=n<=40
				0 defers to verbose setting; defaults to 7 if no
				value is supplied

	--bold-refs | -b	distinguish refs from descriptive text
	--no-bold-refs		...or not

	--color			turn color output on
	--no-color		...or off
END_USAGE

	exit 1 if $error || !$A->verbose();

	print <<END_DESCRIPTION;

Description:

	Starting at the supplied refs, or else HEAD, prints the tracking chains
	(i.e., the ref itself, then the upstream ref it tracks, then the
	upstream ref _that_ ref tracks, and so on) from which you can quickly
	see if updates are needed or available (without fetching or even
	switching to that branch).  For refs in your local repo, --verbose will
	tell you how far ahead, behind, or diverged.

Configuration:

	upstream.verbose	boolean (defaults to false)

	upstream.boldrefs	'never', 'auto' (the default), or 'always'
				'auto' makes refs bold in verbose mode to
				distinguish them from descriptive text, but
				leaves them plain in non-verbose mode

	upstream.fullnames	'never', 'auto' (the default), or 'always'
				'auto' prints fully-qualified refnames in
				verbose mode, simplified names otherwise

	upstream.abbrev		integer (defaults to 0, which implies 40 when
				--verbose, 7 otherwise)

	color.upstream		boolean (defaults to color.ui)

	color.upstream.<slot>	Uses the same color slots and values as git
				branch ('current', 'local', 'remote', 'plain'),
				and defaults to color.branch.<slot> if not
				supplied.
END_DESCRIPTION

	$A->color(1);
	$A->boldrefs('auto');
	setup_output();
	my $color = $A->_ref_color();

	print <<END_EX1;

Examples:

	\$ git upstream -v --abbrev
	ce567d1... $color->{current}master$color->{reset}* is behind 'origin/master' by 17 commits, and can be fast-forwarded.
	186458b... $color->{remote}origin/master$color->{reset}
	186458b... $color->{plain}master\@origin$color->{reset}, git://git.kernel.org/pub/scm/git/git.git
END_EX1

	$A->verbose(0);
	setup_output();

	print <<END_EX2;

	\$ git upstream master
	ce567d1... $color->{current}master$color->{reset}*
	186458b... $color->{remote}origin/master$color->{reset}
	186458b... $color->{plain}master\@origin$color->{reset}
END_EX2

	$A->verbose(0);
	$A->boldrefs('never');
	setup_output();

	print <<END_EX3;

	\$ git upstream --no-bold-refs --verbose origin/master
	186458b... $color->{remote}origin/master$color->{reset}
	186458b... $color->{plain}master\@origin$color->{reset}, git://git.kernel.org/pub/scm/git/git.git
END_EX3

	exit 1;
}



sub get_commit_id {
	chomp(my $hash = $R->command_oneline('rev-parse', @_));
	return $hash;
}

sub get_fully_qualified_refname {
	my ($refname) = @_;
	chomp($refname = $R->command_oneline('rev-parse', '--symbolic-full-name', $refname)) if $refname;
	return $refname;
}

sub get_simple_refname {
	my ($refname) = @_;
	$refname =~ s{^((refs/)?(heads|remotes)/|refs/(?=tags/))}{};
	return $refname;
}

sub get_ref_kind {
	my ($refname) = @_;
	$refname = get_fully_qualified_refname($refname) if $refname !~ m{^refs/};
	$refname =~ m{^refs/(heads|tags|remotes)/};
	return $1 || 'error';
}



my $prev_is_verbose = -1;
my $prev_abbrev = -1;
my $prev_when_bold = '';
my $prev_is_color = -1;

sub setup_output {
	my $next_is_verbose = $A->verbose();
	my $next_abbrev = $A->abbrev();
	my $next_when_bold = $A->boldrefs();
	my $next_is_color = $A->color();

	my $changed_verbose = ($next_is_verbose != $prev_is_verbose);
	my $changed_abbrev = $changed_verbose || ($next_abbrev != $prev_abbrev);
	my $changed_bold = $changed_verbose || ($next_when_bold ne $prev_when_bold);
	my $changed_color = ($next_is_color ne $prev_is_color);

	($prev_is_verbose, $prev_abbrev, $prev_when_bold, $prev_is_color) =
	($next_is_verbose, $next_abbrev, $next_when_bold, $next_is_color);


	if ( $changed_abbrev ) {

		my $abbrev_from_config = $R->config_int('upstream.abbrev');
		my $abbrev_from_commandline = $next_abbrev;

		if ( $abbrev_from_commandline > 0 ) {
			$next_abbrev = $abbrev_from_commandline;
		} elsif ( $abbrev_from_commandline == 0 ) {
			$next_abbrev = 7;
		} elsif ( $abbrev_from_config ) {
			$next_abbrev = $abbrev_from_config;
		} elsif ( $next_is_verbose ) {
			$next_abbrev = 40;
		} else {
			$next_abbrev = 7;
		}

		$A->abbrev($next_abbrev);
	}

	if ( $changed_color || $changed_bold ) {
		my $ref_color = $A->_ref_color();

		my %default = (
			'current' => 'green',
			'remote' => 'red',
		);

		my $get_color = $next_is_color
				? sub { my ($slot) = @_;
					return $R->get_color("color.upstream.$slot", '')
						|| $R->get_color("color.branch.$slot", $default{$slot} || '')
						|| ''; }
				: sub { return ''; };


		my $bold = '';
		if ( $next_when_bold eq 'always' || ($next_when_bold eq 'auto' && $next_is_verbose) ) {
			$bold = $R->get_color('', 'bold');
		}

		foreach my $slot ('current', 'local', 'remote', 'plain') {
			$ref_color->{$slot} = $get_color->($slot) . $bold;
		}

		$ref_color->{'reset'} = ($next_is_color || $next_is_verbose)
					? $R->get_color('', 'reset')
					: '';
	}
}


sub print_ref {
	my ($ref_info) = @_;
	return if !$ref_info->{category} || $ref_info->{category} eq 'error';

	my $hash = $ref_info->{commit_id};
	my $width = $A->abbrev();
	$hash =~ s(^(.{$width}).*$)($1);


	print $hash . ($width<40 ? '... ' : ' ');

	my $ref_color = $A->_ref_color();

	my $label = $ref_info->{label};
	my $when_fullnames = $A->fullnames();

	if ( $ref_info->{category} ne 'url' && ($when_fullnames eq 'always' || ($when_fullnames eq 'auto' && $A->verbose())) ) {
		$label = get_fully_qualified_refname($label);
	}

	print $ref_color->{$ref_info->{slot}} . $label . $ref_color->{'reset'};
	print '*' if $ref_info->{slot} eq 'current';
	print $ref_info->{description} if $A->verbose() && $ref_info->{description};
	print "\n";
}



sub bad_ref {
	my ($refname) = @_;
	my %ref = (
		category =>	'error',
		label =>	$refname || '',
	);
	return \%ref;
}



# Given the ref you're on now, returns details of the ref it tracks, if any.
sub details_from_refname {
	my ($refname) = @_;
	return bad_ref() if ! $refname;

	my $short_refname = get_simple_refname($refname);

	my %ref_info = (
		category =>		get_ref_kind($refname),
		slot =>			'plain',
		local_refname =>	$refname,
		label =>		$refname,
		commit_id =>		get_commit_id($refname),
	);

	if ( $ref_info{category} eq 'heads' ) {
		$ref_info{slot} = $A->_current_branch() =~ /\b$refname$/ ? 'current' : 'local';

		# You gave me a branch; config tells what it tracks, if anything.
		my $remote_refname = get_fully_qualified_refname($R->config("branch.$short_refname.merge"));
		if ( $remote_refname ) {
			my $remote_name = $R->config("branch.$short_refname.remote");
			$remote_refname =~ s{^refs/heads}{refs/remotes/$remote_name} if $remote_name ne '.';

			$ref_info{remote_name} = $remote_name;
			$ref_info{local_refname} = $refname;
			$ref_info{remote_refname} = $remote_refname;

			if ( $A->verbose() ) {
				my @revs = $R->command('rev-list', '--left-right', $refname . '...' . $remote_refname);
				my ($ours, $theirs) = (0, 0);
				foreach my $elem (@revs) {
					++$ours if $elem =~ /^</;
					++$theirs if $elem =~ /^>/;
				}
				$ref_info{ours} = $ours if $ours;
				$ref_info{theirs} = $theirs if $theirs;

				my $description = '';
				my $tracked = get_simple_refname($remote_refname);
				if ( $ref_info{ours} && $ref_info{theirs} ) {
					$description = " has diverged from '$tracked'.  They have, respectively, $ref_info{ours} and $ref_info{theirs} additional commits.";
				} elsif ( $ref_info{ours} ) {
					$description = " is ahead of '$tracked' by $ref_info{ours} commit" . ($ref_info{ours}==1 ? "" : "s") . ".";
				} elsif ( $ref_info{theirs} ) {
					$description = " is behind '$tracked' by $ref_info{theirs} commit" . ($ref_info{theirs}==1 ? "" : "s") . ", and can be fast-forwarded.";
				}

				$ref_info{description} = $description;
			}
		} else {
			$ref_info{description} = " is not a tracking branch.";
		}

	} elsif ( $ref_info{category} eq 'remotes' ) {
		$ref_info{slot} = 'remote';

		$short_refname =~ m{^([^/]+)/(.*)$};

		$ref_info{remote_name} = $1;
		$ref_info{local_refname} = "refs/remotes/$short_refname";
		$ref_info{remote_refname} = $2;

		my $hash = $R->command_oneline('ls-remote', $1, $2) || '';
		$hash =~ s/^(.{40}).*$/$1/;
		$ref_info{remote_commit_id} = $hash;

		$ref_info{description} = " is behind $ref_info{remote_name}, and can (probably) be fast-forwarded." if $ref_info{commit_id} ne $hash;
	}

	return \%ref_info;
}

sub details_of_tracked_ref {
	my ($ref_info) = @_;
	return bad_ref() if ! $ref_info;
	my $tracked_ref_info = bad_ref($ref_info->{tracked_ref} || '');

	my $remote_refname = $ref_info->{remote_refname};
	if ( $ref_info->{category} eq 'remotes' ) {
		my $remote_name = $ref_info->{remote_name};

		my %info = (
			category =>		'url',
			slot =>			'plain',
			remote_refname =>	$remote_refname,
			label =>		"$remote_refname\@$remote_name",
			description =>		", " . $R->config("remote.$remote_name.url"),
			remote_name =>		$remote_name,
			commit_id =>		$ref_info->{remote_commit_id},
			#url =>			$R->config("remote.$remote_name.url"),
		);

		$tracked_ref_info = \%info;

	} elsif ( $remote_refname ) {
		$tracked_ref_info = details_from_refname(get_simple_refname($remote_refname));
	}

	return $tracked_ref_info;
}


# Decide if $refname identifies a unique local ref that could track something.
# Print $refname, the ref it tracks, the ref that tracks, and so on
sub print_ref_chain {
	my ($refname) = @_;
	$refname = $A->_current_branch() if !$refname || $refname eq 'HEAD';

	die "You are not on a branch.\n" if $refname eq 'HEAD';

	my @resolved_names =
		grep { /\b$refname$/ }
		map { $1 if /'(.+)'/ }
		$R->command('for-each-ref', "--format='%(refname)'", 'refs');

	my @matching_branches = grep { m(^refs/heads/) } @resolved_names;
	my @matching_tags = grep { m(^refs/tags/) } @resolved_names;
	my @matching_remotes = grep { m(^refs/remotes/) } @resolved_names;

	my $matches = @matching_branches + @matching_tags;

	die "The refname '" . $refname . "' is ambiguous.\n"
		if $matches>1 || !$matches && @matching_remotes>1;

	die "The refname '" . $refname . "' was not found in this repository.\n"
		if !$matches && !@matching_remotes;


	# As far as I can tell, $refname is a reasonable ref to explore.
	setup_output();
	my $ref_info = details_from_refname($refname);
	while ( $ref_info->{category} ne 'error' ) {
		print_ref($ref_info);

		last if $ref_info->{category} eq 'url' || ! $ref_info->{remote_refname};
		$ref_info = details_of_tracked_ref($ref_info);
	}
}

sub set_tristate_from_bool {
	my ($state, $name, $value) = @_;
	$state->set($name, $value=~/^1$/ ? 'always' : 'never') if $value=~/^0|1$/;
}

sub main {
	# command-line actions
	$A->define("help|h",		{ ACTION => sub { usage(); } });
	$A->define("version|V",		{ ACTION => sub { version(); } });
	$A->define("license",		{ ACTION => sub { license(); } });

	# command-line options
	$A->define("verbose|v!",	{ DEFAULT => $R->config_bool("upstream.verbose") || 0 });
	$A->define("abbrev:i",		{ DEFAULT => -1, VALIDATE => sub { my ($n, $v) = @_; return 0<=$v && $v<=40; } });
	$A->define("color!",		{ DEFAULT => $R->get_colorbool('color.upstream') });
	$A->define("boldrefs|bold-refs|bold|b!",	{ ACTION => \&set_tristate_from_bool });
	$A->define("fullnames|full-names|full!",	{ ACTION => \&set_tristate_from_bool });

	$A->boldrefs($R->config('upstream.boldrefs') || 'auto');
	$A->fullnames($R->config('upstream.fullnames') || 'auto');

	# application settings that I don't want to see on the command-line
	$A->define("_ref_color=s%");
	$A->define("_current_branch=s");
	$A->_current_branch(get_fully_qualified_refname('HEAD'));

	my $refs_processed = 0;
	do {
		# execute this loop once for each supplied ref, or just once if none (even if no option arguments)

		# investigate (and shift-off) any remaining option arguments
		$A->getopt(qw{require_order}); # stops at the first non-option
		setup_output(); # configure for current color, verbose, abbrev

		my $refname;
		if ( @ARGV ) {
			# we stopped because the next argument _isn't_ an option
			$refname = shift @ARGV; # so it must be a ref
		} elsif ( ! $refs_processed ) {
			# we stopped because we're out of arguments, and we never hit a ref
			$refname = get_simple_refname($A->_current_branch()); # so let's use the current branch
		}

		if ( $refname ) {
			print "\n" if $refs_processed++; # blank line between chains
			print_ref_chain($refname);
		}
	} while ( @ARGV ); # if there is anything left on the command-line, do another loop
}

main();

--Apple-Mail-30-405584510
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit





hopefully someone else finds this useful :-)
_____________
Scott Collins
--Apple-Mail-30-405584510--
