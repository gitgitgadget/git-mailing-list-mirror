From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] faking cvs annotate
Date: Thu, 15 Dec 2005 22:09:54 -0800
Message-ID: <20051216060953.GA22150@mail.yhbt.net>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com> <7vpsnxlsw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 07:11:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En8n0-00039w-2m
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 07:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVLPGJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 01:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVLPGJz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 01:09:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:64154 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932144AbVLPGJy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 01:09:54 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 13E3B2DC033; Thu, 15 Dec 2005 22:09:54 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsnxlsw7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13730>

Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > Suggestions of GIT machinery that would shortcut the trip from
> >
> >      git-rev-list HEAD $path
> >
> > to a annotate-ish output. Did I dream it or is qgit showing something
> > annotate-ish in its screenshots?
> 
> I haven't actively done anything but one of the good things that
> could happen is to split out the access routines for annotate
> database qgit build when run the first time in the repository,
> and make them available to other Porcelains.  There is no need
> to reinvent the wheel.

I started working on something using Algorithm::Annotate on CPAN during
an ADD excursion a few weeks ago, but mostly forgot about it (thanks
again to ADD :).  A few versions of git later and it still seems to
work as well as I remembered it.

It doesn't handle renames/copies yet, but it does let you customize the
left-hand side output unlike most/(all?) annotate implementations.

I guess it's also quite useful when the output is piped to vim with a
repository browser like the one I brought up in
<20051124093322.GA3899@mail.yhbt.net>

---------- 8< ---------

#!/usr/bin/env perl
# Copyright (c) 2005, Eric Wong <normalperson@yhbt.net>
#
# This file is licensed under the GPL v2, or a later version
# at the discretion of Linus.
#
# Read git-whatchanged output and let all Algorithm::Annotate do all
# the hard work for us.  Thanks to Chia-liang Kao for the awesome 
# Algorithm::Annotate module.
#
# Formatting options of annotation output is available.
# Dates can be formatted through strftime strings using the -D switch,
# and annotation expansion can be done using the -F switch
# on following variables:

=cut
	%commit% %tree% %author_name% %author_email% %author_date%
	%committer_name% %committer_email% %commit_date% %message%
=cut
use warnings;
use strict;

sub usage ($) {
	print '* git-annotate ',
		'[-w <width>] [-D <date-format>] [-F <annotate-format>] ',
		'[--localtime] [--line-prefix <str>] [--line-postfix <str>] ',
		'<file>', "\n";
	exit $_[0];
}

# everybody with Perl 5 should have these, right?
use POSIX qw(strftime);
use Getopt::Long qw(:config gnu_getopt no_ignore_case no_auto_abbrev);

my %_o; # options
usage(1) unless (GetOptions(\%_o, qw(help|H|h width|w=i
		line_prefix|line-prefix:s line_postfix|line-postfix:s
		format|F=s date_format|date-format|D=s localtime|l)));
usage(0) if $_o{help};

# ok, see if we can do more than show a help message:
require Algorithm::Annotate or die
		"Can't find Algorithm::Annotate, get it from CPAN ($!)\n";

my $file = shift or usage(1);
unless (-f $file) {
	print STDERR "File does not exist or is not a file: $file\n";
	exit 1;
}

my $date_format = $_o{date_format} || '%Y-%m-%dT%H-%M-%SZ'; # ISO 8601

my $re_sha1 = qr/[a-f0-9]{40}/; # match 40 char hex strings
my @blobs; # we read from newest to oldest, but $ann needs it reversed

sub t ($) {
	return localtime($_[0]) if $_o{'localtime'};
	return gmtime($_[0]);
}

if (my $pid = open my $child, '-|') {
	my $meta;
	while (<$child>) {
		chomp;
		if (/^diff-tree ($re_sha1) /o) {
			$meta = { commit => $1, message => [] };
		} elsif (/^tree ($re_sha1)$/) {
			$meta->{tree} = $1;
		} elsif (/^author (.*) <(\S+)> (\d+) [\+\-]?\d+$/) {
			$meta->{author_name} = $1;
			$meta->{author_email} = $2;
			$meta->{author} = "$1 <$2>";
			$meta->{author_date} = strftime($date_format, t($3));
		} elsif (/^committer (.*) <(\S+)> (\d+) [\+\-]?\d+$/) {
			$meta->{committer_name} = $1;
			$meta->{committer_email} = $2;
			$meta->{committer} = "$1 <$2>";
			$meta->{commit_date} = strftime($date_format, t($3));
		} elsif (/^\s{4}(.*)$/) {
			push @{$meta->{message}}, $1;
		} elsif (/^:\d{6} \d{6} $re_sha1 ($re_sha1)/o) {
			my $blob = $1;
			if ($blob =~ /^0{40}$/) {
				# nonexistent (hopefully!) blob
				$meta = undef;
				next;
			}
			
			$meta->{message} = join("\n",@{$meta->{message}});
			push @blobs, { meta => $meta, blob => $blob };
			$meta = undef;
		}
	}
} else {
	exec('git-whatchanged','-m','--pretty=raw','--',$file) or die
			"Unable to execute git-whatchanged $file: $? $!";
}

my $msg_format = $_o{format} || '%commit% %commit_date%';
my $max_len = 0;
my $ann = Algorithm::Annotate->new;

foreach my $x (reverse @blobs) {
	my @contents;
	
	# no need to do safe pipe opens since we know $x->{blob} is a hex sum
	@contents = `git-cat-file blob $x->{blob}`;

	# $msg is the left hand side of our final annotation output,
	# format it according to $msg_format
	my $msg = $msg_format;
	my $meta = $x->{meta};

	# our annotation message templating engine:
	$msg =~ s/\%$_\%/$meta->{$_}/g foreach keys %$meta;
	$msg =~ s/\\t/\t/g;
	$msg =~ s/\\n/\n/g;

	$ann->add($msg, \@contents);
	if ($msg !~ /\n/) {
		$max_len = length $msg if length $msg > $max_len;
	} else {
		foreach (split /\n/, $msg) {
			$max_len = length $_ if length $_ > $max_len;
		}
	}
}

# see if we can annotate local changes, too
my $local_change;
my @diff_opts = qw(-z -C --find-copies-harder --name-only);
{ # see if we've changed $file in the working tree
	if (my $pid = open my $child, '-|') {
		$local_change = (<$child>);
	} else {
		exec('git-diff-files',@diff_opts,'--',$file);
	}
}

unless ($local_change) {
	# see if we've changed $file in the working tree
	if (my $pid = open my $child, '-|') {
		$local_change = (<$child>);
	} else {
		exec('git-diff-index',@diff_opts,'--cached','HEAD','--',$file);
	}
}

open my $fd,'<',$file or die "Error opening file: $file: $!\n";
my @contents = <$fd>;

if ($local_change) {
	my $msg = '(uncommitted): ';
	$ann->add($msg, \@contents);
	$max_len = length $msg if length $msg > $max_len;
}

# $result here is an array ref, each element corresponding to a line of
# the annotated file contents
my $result = $ann->result or do {
	print STDERR "Unable to annotate $file.  Is it tracked by git?\n";
	exit 1;
};

my $pre = defined $_o{line_prefix} ? $_o{line_prefix} : '';
my $post = defined $_o{line_postfix} ? $_o{line_postfix} : ': ';
my $width = $_o{width} || $max_len;

foreach (@contents) {
	my $msg = shift @$result;
	if ($msg !~ /\n/) {
		print ($pre, pack("A$width", $msg), $post, $_);
	} else {
		my @msgs = split /\n/, $msg;
		print ($pre, pack("A$width", shift @msgs), $post, $_);
		foreach my $m (@msgs) {
			print ($pre, pack("A$width", $m), $post,"\n");
		}
	}
}

close $fd;

exit 0;

-- 
Eric Wong
