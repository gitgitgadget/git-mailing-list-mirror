From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 19:09:08 -0500
Message-ID: <7KKnonc5d5_rj_95MtHHlpKzcnmvDte62cL2vYgfQQkHguIG9qjT2A@cipher.nrlssc.navy.mil>
References: <S3I346LWUOykFBiCrFLgbfYptyYvHyj1Jcdo6EHe-2fWosEUh4Va3g@cipher.nrlssc.navy.mil> <hh0bQq8TcM0saDTuJo6qVdOMgn-14aysvhF_S70syB678Of7zQOsY9jLajG2WpeGXid8jtG4kVA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 02:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Rg9-0001Yp-GK
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 02:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab0JWAJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 20:09:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57371 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0JWAJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 20:09:38 -0400
Received: by mail.nrlssc.navy.mil id o9N099bK004569; Fri, 22 Oct 2010 19:09:09 -0500
In-Reply-To: <hh0bQq8TcM0saDTuJo6qVdOMgn-14aysvhF_S70syB678Of7zQOsY9jLajG2WpeGXid8jtG4kVA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Oct 2010 00:09:09.0124 (UTC) FILETIME=[8397EC40:01CB7246]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159766>


I was curious about something like this earlier this week,
and I wrote this little hack.

Got anything better?

---- >8 ----
#!/usr/bin/perl -w

use lib (split(/:/, $ENV{GITPERLLIB} || "/your/git/installation/lib/perl5/site_perl/5.8.8"));

use strict;
use Git;

use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;

$main::VERSION = 0.1;

sub usage {
	my $name;

	eval {
		require File::Basename;
		$name = File::Basename::basename($0);
	} or do {
		$name = substr $0, rindex($0, '/') + 1;
	};

	print "Usage: $name [--help] [-flstv] <tree-ish> [paths...]\n";
}

sub main::HELP_MESSAGE {

	usage;

	print "\nOPTIONS\n\n",
	      " -f  use file centric view\n",
	      " -l  use longer format\n",
	      " -s  use short format\n",
	      " Both -l and -s produce an even longer format\n",
	      " -t  print total lines at the end\n",
	      " -v  print more information while processing\n",
	      "\n";
}

sub new_parser {
	my $fh = shift;
	my $ctx = shift;
	return { FH => $fh, CTX => $ctx, buf => ''};
}

sub get_next_line {
	my $obj = shift;
	my $fh = $obj->{'FH'};

	defined($obj->{'buf'} = <$fh>);
}

sub parse_blame_entry {
	my $obj = shift;

	return () unless get_next_line $obj;
	$_ = $obj->{'buf'};
	chomp;

	my ($sha1, $sourceline, $resultline, $num_lines) = split ' ', $_, 4;

	return () unless defined $num_lines;

	my %h = ( sha1 => $sha1, sourceline => $sourceline,
		  resultline => $resultline, lines => $num_lines );
	while (get_next_line $obj) {
		$_ = $obj->{'buf'};
		chomp;
		my ($key, $val) = split ' ', $_, 2;
		$h{$key} = $val;
		last if m/^filename /;
	}

	return %h;
}

sub parse_blame {
	my $obj = shift;
        my $authors = shift;

	my %commits;
	while (my %h = parse_blame_entry $obj) {

		if (! exists $commits{$h{'sha1'}}) {

			if (! exists $authors->{$h{'author'}}->{$obj->{'filename'}}) {
				$authors->{$h{'author'}}->{$obj->{'filename'}} = 0;
			}
			$commits{$h{'sha1'}} =
				\$authors->{$h{'author'}}->{$obj->{'filename'}};
		}

		${$commits{$h{'sha1'}}} += $h{'lines'};
	}
}

sub count_total_lines {
	my $authors = shift;

	my $lines = 0;

	for (values %{$authors}) {
		for (values %{$_}) { $lines += $_; }
	}

	return $lines;
}

sub count_author_lines {
	my $authors = shift;

	my %alines;

	foreach my $author (keys %{$authors}) {
		my $lines = 0;
		for (values %{$authors->{$author}}) { $lines += $_; }
		$alines{$author} = $lines;
	}

	return %alines;
}

sub count_file_lines {
	my $authors = shift;

	my %flines;

	for (values %{$authors}) {
		foreach my $file (keys %{$_}) {
			$flines{$file} += $_->{$file};
		}
	}

	return %flines;
}

sub print_short {
	my $authors = shift;

	my %alines = count_author_lines $authors;

	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
		printf "%6d  %s\n", $alines{$author}, $author;
	}
}

sub print_long {
	my $authors = shift;

	my %alines = count_author_lines $authors;

	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
		print "$author (", $alines{$author}, "):\n";
		foreach my $file (sort
		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
		    keys %{$authors->{$author}}) {
			printf "  %10d %s\n", $authors->{$author}->{$file},
			      $file;
		}
	}
}

sub print_longer {
	my $authors = shift;

	my %alines = count_author_lines $authors;
	my $total_lines = count_total_lines $authors;

	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
		printf "%s (%d, %.2f%%):\n", $author, $alines{$author},
			100. * $alines{$author} / $total_lines;
		foreach my $file (sort
		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
		    keys %{$authors->{$author}}) {
			printf "  %10d (%5.2f%%) %s\n",
			       $authors->{$author}->{$file},
			       100. *
			       $authors->{$author}->{$file} / $alines{$author},
			       $file;
		}
	}
}

sub print_with_file_percentage {
	my $authors = shift;

	my %alines = count_author_lines $authors;
	my %flines = count_file_lines $authors;
	my $total_lines = count_total_lines $authors;
	my $total_files = scalar(keys %flines);

	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
		printf "%s (%d lines in %d files, " .
		       "%.2f%% of all lines, %.2f%% of all files):\n",
		       $author, $alines{$author},
		       scalar(keys %{$authors->{$author}}),
		       100. * $alines{$author} / $total_lines,
		       100. * scalar(keys %{$authors->{$author}})/$total_files;
		foreach my $file (sort
		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
		    keys %{$authors->{$author}}) {
			printf "  %10d (%6.2f%%) of %6d (%6.2f%%) %s\n",
			       $authors->{$author}->{$file},
			       100. *
			       $authors->{$author}->{$file} / $flines{$file},
			       $flines{$file},
			       100. *
			       $authors->{$author}->{$file} / $alines{$author},
			       $file;
		}
	}
}

sub print_with_file_perspective {
	my $authors = shift;

	my %flines = count_file_lines $authors;

	foreach my $file (sort keys %flines) {
		my @auths = grep {exists $authors->{$_}->{$file}}
			keys %{$authors};
		print "$file ($flines{$file}):\n";
		foreach my $author (sort
		    {$authors->{$b}->{$file} <=> $authors->{$a}->{$file}}
		    @auths) {
			printf " %10d %s\n", $authors->{$author}->{$file},
				$author;
		}
	}
}


my $verbose = 0;
my $output_format = 0;
my $show_total = 0;

our ($opt_f, $opt_l, $opt_s, $opt_t, $opt_v);
getopts("flstv") or die "Invalid options specified";

	if ($opt_f) {
		$output_format = 4;
	} elsif ($opt_l && $opt_s) {
		$output_format = 3;
	} elsif ($opt_l) {
		$output_format = 2;
	} elsif ($opt_s) {
		$output_format = 1;
	}
	if ($opt_t) {
		$show_total = 1;
	}
	if ($opt_v) {
		$verbose = 1;
	}

eval {select STDERR; usage; exit 1;} unless $#ARGV >= 0;

my %authors;
my $repo = Git->repository();

my ($fh, $ctx) = $repo->command_output_pipe('ls-tree', '-r', '--name-only', '--', @ARGV);
my $ls_tree = new_parser $fh, $ctx;
while (get_next_line $ls_tree) {
	chomp $ls_tree->{'buf'};

        my $is_text = `file "$ls_tree->{'buf'}"` =~ m/text/;

	if ($is_text) {
		if ($verbose) {
			print STDERR "Processing file: ", $ls_tree->{'buf'},
				"\n";
		}
	} else {
		if ($verbose) {
			print STDERR "Skipping non-text file: ",
				$ls_tree->{'buf'}, "\n";
		}
		next;
	}

	($fh, $ctx) =
	    $repo->command_output_pipe('blame', '-C', '-C', '-w', '--incremental',
		'--', $ls_tree->{'buf'});
	my $blame_obj = new_parser $fh, $ctx;
	$blame_obj->{'filename'} = $ls_tree->{'buf'};

	parse_blame $blame_obj, \%authors;

	$repo->command_close_pipe($blame_obj->{'FH'}, $blame_obj->{'CTX'});
}
$repo->command_close_pipe($ls_tree->{'FH'}, $ls_tree->{'CTX'});


if ($output_format == 0) {
	print_long \%authors;
} elsif ($output_format == 1) {
	print_short \%authors;
} elsif ($output_format == 2) {
	print_longer \%authors;
} elsif ($output_format == 3) {
	print_with_file_percentage \%authors;
} elsif ($output_format == 4) {
	print_with_file_perspective \%authors;
}

print count_total_lines(\%authors), " total lines.\n" if ($show_total);

exit;
