From: Jeff King <peff@peff.net>
Subject: Re: Understanding and improving --word-diff
Date: Thu, 18 Nov 2010 01:40:50 -0500
Message-ID: <20101118064050.GA12825@sigill.intra.peff.net>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
 <20101109220136.GA5617@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 07:41:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIyB6-0001Ir-Eu
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 07:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab0KRGk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 01:40:57 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34339 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab0KRGk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 01:40:57 -0500
Received: (qmail 11798 invoked by uid 111); 18 Nov 2010 06:40:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 06:40:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 01:40:50 -0500
Content-Disposition: inline
In-Reply-To: <20101109220136.GA5617@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161651>

On Tue, Nov 09, 2010 at 05:01:36PM -0500, Jeff King wrote:

>   2. There is a buglet in git's color emitting code. For added lines, it
>      produces "<g>+</g><g>rest of line</g>" which is annoying to parse.
>      It is fixed by the patch below:
> 
> diff --git a/diff.c b/diff.c
> index b1b0d3d..0efcdb7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -363,9 +363,9 @@ static void emit_add_line(const char *reset,
>  		emit_line_0(ecbdata->opt, ws, reset, '+', line, len);
>  	else {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
> +		emit_line_0(ecbdata->opt, set, "", '+', "", 0);
>  		ws_check_emit(line, len, ecbdata->ws_rule,
> -			      ecbdata->opt->file, set, reset, ws);
> +			      ecbdata->opt->file, "", reset, ws);
>  	}
>  }

FYI, I looked further at this patch, and it should not be used. There
are cases where ws_check_emit will output a reset (e.g., because it has
colored some whitespace), and needs to be able to set the proper color
again. So while I think the intent of this patch is fine (to avoid
duplicate colorizing in the output), the actual implementation would
need to be much more complex.

Instead, here's an updated version of my color highlighting script that
handles this case.

With the patch I posted earlier today:

  [PATCH 2/2] allow command-specific pagers in pager.<cmd>
  http://article.gmane.org/gmane.comp.version-control.git/161624

you can do:

  git config pager.log '/path/to/diff-highlight.pl | less'

and get automagic coloring. Still, this is a bit of a hack, and there
are some funny corner cases, so something that used the internal diff
machinery would be much nicer.

-Peff

-- >8 --
#!/usr/bin/perl

use strict;
my $COLOR = qr/\x1b\[[0-9;]*m/;
my $RESET = "\x1b[0m";
my $RED = "\x1b[31m";
my $GREEN = "\x1b[32m";
my $REVERSE = "\x1b[7m";
my $UNREVERSE = "\x1b[27m";

my @window;

while (<>) {
  chomp;
  my $plain = $_;
  $plain =~ s/$COLOR//g;

  push @window, [$_, $plain];

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
  print $line->[0], "\n";
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

  print $RED, highlight($from->[1], $prefix, $suffix), $RESET, "\n";
  print $GREEN, highlight($to->[1], $prefix, $suffix), $RESET, "\n";
}

sub highlight {
  my ($line, $prefix, $suffix) = @_;
  my $end = length($line) - $suffix;
  return $line unless $end > $prefix;
  return join('',
    substr($line, 0, $prefix),
    $REVERSE,
    substr($line, $prefix, $end - $prefix),
    $UNREVERSE,
    substr($line, $end)
  );
}
