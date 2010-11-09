From: Jeff King <peff@peff.net>
Subject: Re: Understanding and improving --word-diff
Date: Tue, 9 Nov 2010 17:01:36 -0500
Message-ID: <20101109220136.GA5617@sigill.intra.peff.net>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwGL-00064g-As
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0KIWBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 17:01:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49815 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab0KIWBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 17:01:39 -0500
Received: (qmail 10512 invoked by uid 111); 9 Nov 2010 22:01:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.34)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 22:01:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 17:01:36 -0500
Content-Disposition: inline
In-Reply-To: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161100>

On Mon, Nov 08, 2010 at 04:16:01PM +0100, Matthijs Kooijman wrote:

> E.g., I would like to see:
> 
> -a <r>b</r> c
> +a <g>x</g> c
> 
> Unfortunately, all --word-diff types currently departs from line-based -
> and + lines and show the new version of the file with the changed words
> (both old and new versions) shown inline, marked with coloring or
> {- ...  -} kind of syntax. E.g., with --word-diff=color, the above would
> look like:
> 
> a <r>b</r><g>x</g> c
> 
> Personally, I think that the first example above is easier to read than
> the second one (at least for diffs of code).

Yeah, as you figured out, word diff is really about formats that aren't
line oriented. I have seen other systems do what you are asking for, but
I'm not sure they are nearly as complex as a true word diff. In
particular, I have noticed two simplifications:

  1. Only highlight between two lines that are in part of a hunk by
     themselves. In other words, highlight on this:

        context
       -foo bar
       +foo baz
        context

     but not this:

        context
       -foo bar
       -another line
       +foo baz
       +another changed line
        context

     Even though you could perhaps match up pairs of lines (in this
     case, the first removed line obviously corresponds with the first
     added line, etc), there are a ton of cases where it would be
     uselessly distracting, as the lines simply aren't related to each
     other (of course, there are one-liner changes where that is the
     case, too, but they are hopefully less common, and since it is only
     a single pair of lines, there is no guessing about how they were
     matched up).

  2. Don't do real LCS matching between the pairs. Just find the common
     prefix and suffix, and highlight everything in the middle. This
     would yield something like:

       -a <r>b c d</r> e
       +a <g>x c z</g> e

     when you could in theory produce:

       -a <r>b</r> c <r>d</r> e
       -a <g>x</g> c <g>z</g> e

     but I suspect in practice it covers many situations.

For fun, I hacked up the perl script below which will highlight (using
ANSI reverse-codes!) a diff using both of these simplifications. It
looks for diff hunks on stdin, so you can do:

  git log | perl /path/to/script.pl

I'm curious to see how the output looks on some real-world diffs. I
admit to not having given this problem much thought, but instead just
sat down and started hacking. :)

The script tries to handle color in the input sanely, so you can see
your highlighting in color. But there are two caveats:

  1. You have to pass --color to git explicitly, since piping stdout
     turns off git's color autodetection.

  2. There is a buglet in git's color emitting code. For added lines, it
     produces "<g>+</g><g>rest of line</g>" which is annoying to parse.
     It is fixed by the patch below:

diff --git a/diff.c b/diff.c
index b1b0d3d..0efcdb7 100644
--- a/diff.c
+++ b/diff.c
@@ -363,9 +363,9 @@ static void emit_add_line(const char *reset,
 		emit_line_0(ecbdata->opt, ws, reset, '+', line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
+		emit_line_0(ecbdata->opt, set, "", '+', "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+			      ecbdata->opt->file, "", reset, ws);
 	}
 }
 

This patch, btw, is much easier to read when piped through my script. :)

Here's the script:

-- >8 --
#!/usr/bin/perl

use strict;
my $COLOR = qr/\x1b\[[0-9;]*m/;

my @window;

while (<>) {
  chomp;
  s/^($COLOR)*//; my $prefix = $&;
  s/($COLOR)*$//; my $suffix = $&;

  push @window, [$prefix, $_, $suffix];

  if ($window[0] && $window[0]->[1] =~ /^(\@| )/ &&
      $window[1] && $window[1]->[1] =~ /^-/ &&
      $window[2] && $window[2]->[1] =~ /^\+/ &&
      $window[3] && $window[3]->[1] !~ /^\+/) {
    show_line(shift @window);
    show_pair(shift @window, shift @window);
  }

  if (@window >= 4) {
    show_line(shift @window);
  }
}

if (@window == 3 &&
    $window[0] && $window[0]->[1] =~ /^(\@| )/ &&
    $window[1] && $window[1]->[1] =~ /^-/ &&
    $window[2] && $window[2]->[1] =~ /^\+/) {
  show_line(shift @window);
  show_pair(shift @window, shift @window);
}
while (@window) {
  show_line(shift @window);
}

exit 0;

sub show_line {
  my $line = shift;
  print @$line, "\n";
}

sub show_pair {
  my ($from, $to) = @_;
  my @from = split //, $from->[1];
  my @to = split //, $to->[1];

  my $prefix = 1;
  while ($from[$prefix] eq $to[$prefix]) {
    $prefix++;
  }
  my $suffix = 0;
  while ($from[$#from-$suffix] eq $to[$#to-$suffix]) {
    $suffix++;
  }

  print $from->[0], highlight($from->[1], $prefix, $suffix), $from->[2], "\n";
  print $to->[0], highlight($to->[1], $prefix, $suffix), $to->[2], "\n";
}

sub highlight {
  my ($line, $prefix, $suffix) = @_;
  my $end = length($line) - $suffix;
  return join('',
    substr($line, 0, $prefix),
    "\x1b[7m",
    substr($line, $prefix, $end - $prefix),
    "\x1b[27m",
    substr($line, $end)
  );
}
