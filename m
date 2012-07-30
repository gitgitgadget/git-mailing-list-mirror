From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 17:57:36 +0200
Message-ID: <87k3xli6mn.fsf@thomas.inf.ethz.ch>
References: <jv5tln$96e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Sitaram Chamarty <sitaramc@gmail.com>
To: Thomas Badie <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:57:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvsLr-0001Bw-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab2G3P5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:57:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52239 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab2G3P5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:57:40 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 17:57:37 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 17:57:37 +0200
In-Reply-To: <jv5tln$96e$1@dough.gmane.org> (Thomas Badie's message of "Mon,
	30 Jul 2012 14:11:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202569>

Thomas Badie <thomas.badie@gmail.com> writes:

> The idea is to have a perl module which run through
> the log history and print 10 shortlog associated with a number
> from 0 to 9, and a message below "Select commit [| 0, 9 |] or
> next row ?" or this kind of message with several options.
>
> So I ask to the community if this module is interesting for git.
> It can be integrated everywhere a sha1 is requested (git rebase,
> git reset, ...). IMHO, it can be an enhancement.

I think this is too specific.  If you want full interactivity, use a
real interactive tool like tig.

However, your post and some quick searching gave me another idea.  Bash
actually has features to let you edit the current command line from
within key bindings.  So if only we had some clever utility, let's call
it lineselect for lack of a better name, that let us do

  git log --oneline <args> | lineselect

then we could paste the selected SHA1 into the command line.  That would
be really neat, wouldn't it?

I haven't found such a utility, so below is my first shot at making
something useful.  It has:

* a few keybinds that should make most people happy
* color rendering (yay), but because of issues with the default
  rendering, it sets white-on-black by default
* an optional regex arg to select only parts of the lines

Things that notably _don't_ work yet:

* cursor keys (I have no idea why it doesn't match KEY_UP etc.)
* ANSI attributes (colors work, of sorts)
* Searching the next occurrence of a search string

But you can probably guess that those aren't a huge problem for me.

I made a little repo too, for all your forking needs:

  https://github.com/trast/lineselect.git
  git://github.com/trast/lineselect.git

Thanks for the idea :-)


------ 8< ------
#!/usr/bin/perl

use warnings;
use strict;
use Curses;

my @lines;

open my $input, "<&STDIN" or die "Can't dup STDIN: $!";
open my $output, ">&STDOUT" or die "Can't dup STDOUT: $!";
open STDIN, "<", "/dev/tty" or die "Can't open TTY (in): $!";
open STDOUT, ">", "/dev/tty" or die "Can't open TTY (out): $!";

my $eof = -1;

sub read_more {
	my $n = $_[0];
	if ($eof > 0) {
		return;
	}
	while ($n >= scalar @lines) {
		my $read = <$input>;
		if (!defined $read) {
			$eof = scalar @lines;
			return;
		}
		push @lines, $read;
	}
}

my $pat;
my ($rows, $cols);
my $sel = 0;

my $top = 0;

my $cmdline = ":";

my $fg = 7;
my $bg = 0;
sub set_color {
	attron(COLOR_PAIR(1+$fg+8*$bg));
}

sub print_color_line {
	my $line = $_[0];
	my $remain = $cols;
	$fg = 7;
	$bg = 0;
	set_color;
	while ($line =~ m{^([^\e]*)\e\[([^m]*)m(.*)}) {
		printw($1);
		$remain -= length $1;
		$line = $3;
		if ($2 eq "") {
			$fg = 7;
			$bg = 0;
			set_color;
		} else {
			for my $c (split /;/, $2) {
				if (30 <= $c and $c < 38) {
					$fg = $c - 30;
				} elsif (40 <= $c and $c < 48) {
					$bg = $c - 30;
				}
			}
			set_color;
		}
	}
	printw($line);
	$remain -= length $line;
	if ($remain > 0) {
		printw(" "x$remain);
	}
}

sub redraw {
	read_more $top+$rows-1;
	clear;
	attron(COLOR_PAIR(8));
	for my $i (0..$rows-2) {
		if ($top+$i == $sel) {
			attron(A_STANDOUT);
		} else {
			attroff(A_STANDOUT);
		}
		move($i, 0);
		print_color_line($lines[$top+$i]);
	}
	move($rows-1, 0);
	attron(COLOR_PAIR(8));
	attron(A_STANDOUT);
	printw($cmdline);
	attroff(A_STANDOUT);
	refresh();
}

sub adjust_view {
	if ($sel < 0) {
		return;
	} elsif ($sel >= $top+$rows-1) {
		$top = $sel-$rows+2;
	} elsif ($sel < $top) {
		$top = $sel;
	}
}

sub forward;
sub backward {
	my $n = $_[0];
	$sel -= $n;
	while (defined $pat and $lines[$sel] !~ m{$pat}) {
		$sel--;
		read_more $sel;
		if ($sel < 0) {
			$sel = 0;
			forward 0;
			return;
		}
	}
	if ($sel < 0) {
		$sel = 0;
	}
	adjust_view;
}

sub forward {
	my $n = $_[0];
	$sel += $n;
	while (defined $pat and $lines[$sel] !~ m{$pat}) {
		$sel++;
		read_more $sel;
		if ($eof > 0 and $sel >= $eof) {
			$sel = $eof-1;
			backward 0;
			return;
		}
	}
	adjust_view;
}

sub search {
	my $start = $sel;
	my $search_str = "";
	while (1) {
		$sel = $start;
		my $case_sens = ($search_str ne lc $search_str);
		while (1) {
			if ($eof > 0 and $sel >= $eof) {
				$sel = -1;
				last;
			}
			if (defined $pat and $lines[$sel] !~ m{$pat}) {
				$sel++;
				read_more $sel;
				next;
			}
			if ($case_sens and $lines[$sel] =~ m{$search_str}) {
				last;
			}
			if (!$case_sens and $lines[$sel] =~ m{$search_str}i) {
				last;
			}
			$sel++;
			read_more $sel;
		}
		adjust_view;
		$cmdline = "/" . $search_str;
		$cmdline = "NO MATCH -- " . $cmdline if $sel < 0;
		redraw;
		my $c = getch();
		if ($c eq "\b" or $c eq "\x7f") {
			$search_str = substr $search_str, 0, length($search_str)-1;
		} elsif ($c eq "\n") {
			$sel = $start if $sel < 0;
			return;
		} elsif ($c eq "\033") {
			$sel = $start;
			return;
		} else {
			$search_str .= $c;
		}
	}
}

sub mainloop {
	while (1) {
		getmaxyx($rows, $cols);
		$cmdline = ":";
		redraw;
		my $c = getch();
		if ($c eq " ") {
			$sel += $rows-1;
			read_more $sel;
			$sel = $eof-1 if $eof > 0 and $sel > $eof;
			adjust_view;
		} elsif ($c eq "q") {
			return;
		} elsif ($c eq KEY_ENTER or $c eq "\n") {
			return $lines[$sel];
		} elsif ($c eq "n" or $c eq "j" or $c eq KEY_DOWN) {
			forward 1;
		} elsif ($c eq "p" or $c eq "k" or $c eq KEY_UP) {
			backward 1;
		} elsif ($c eq "/" or $c eq "f") {
			search;
		} elsif ($c eq "<" or $c eq KEY_HOME) {
			$sel = 0;
			adjust_view;
		} elsif ($c eq ">" or $c eq KEY_END) {
			while ($eof < 0) {
				$sel++;
				read_more $sel;
			}
			$sel = $eof-1;
			adjust_view;
		}
	}
}

if (0 < scalar @ARGV) {
	$pat = $ARGV[0];
}

initscr;
start_color;
for my $f (0..7) {
	for my $b (0..7) {
		init_pair(1+$f+8*$b,$f,$b);
	}
}
my $r = mainloop;
endwin;
if (defined $r) {
	$r =~ s{\e\[([^m]*)m}{}g;
	if (defined $pat) {
		$r =~ m/$pat/;
		$r = $1;
		die "BUG: should never get here" if (!defined $r);
	}
	print $output "$r";
} else {
	exit 1;
}
