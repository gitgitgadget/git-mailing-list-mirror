From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Sun, 29 Apr 2012 07:34:32 -0400
Message-ID: <20120429113431.GA24254@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 13:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOSPK-00020N-Tv
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 13:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2D2Lef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 07:34:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50726
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab2D2Lee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 07:34:34 -0400
Received: (qmail 13909 invoked by uid 107); 29 Apr 2012 11:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Apr 2012 07:34:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Apr 2012 07:34:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196506>

On Sat, Apr 28, 2012 at 01:11:48PM -0400, Nicolas Pitre wrote:

> > Here's a list of commands and the pack sizes they yield on the repo:
> > 
> >   1. `git repack -ad`: 246M
> >   2. `git repack -ad -f`: 376M
> >   3. `git repack -ad --window=250`: 246M
> >   4. `git repack -ad -f --window=250`: 145M
> > 
> > The most interesting thing is (4): repacking with a larger window size
> > yields a 100M (40%) space improvement. The other commands show that it
> > is not that the current pack is simply bad; command (2) repacks from
> > scratch and actually ends up with a worse pack. So the increased window
> > size really is important.
> 
> Absolutely.  This doesn't surprises me.

I was somewhat surprised, because this repo behaves very differently
from other ones as the window size increases. Our default window of 10
is somewhat arbitrary, but I think there was a sense from early tests
that you got diminishing returns from increasing it (this is my vague
recollection; I didn't actually search for old discussions). But here
are some charts showing "repack -adf" with various window sizes on a few
repositories. The first column is the window size; the second is the
resulting pack size (and its percentage of the window=10 case); the
third is the number of seconds of CPU time (and again, the percentage of
the window=10 case).

Here's git.git:

  10 | 31.3M (100%) |   54s (100%)
  20 | 28.8M ( 92%) |   72s (133%)
  40 | 27.4M ( 87%) |  101s (187%)
  80 | 26.3M ( 84%) |  153s (282%)
 160 | 25.7M ( 82%) |  247s (455%)
 320 | 25.4M ( 81%) |  415s (763%)

You can see we get some benefit from increasing window size to 20 or
even 40, but we hit an asymptote around 80%. Meanwhile, CPU time keeps
jumping. Something like 20 or 40 seems like it might be a nice
compromise.

Here's linux-2.6:

  10 | 564M (100%) |  990s (100%)
  20 | 521M ( 92%) | 1323s (134%)
  40 | 495M ( 88%) | 1855s (187%)
  80 | 479M ( 85%) | 2743s (277%)
 160 | 470M ( 83%) | 4284s (432%)
 320 | 463M ( 82%) | 7064s (713%)

It's quite similar, asymptotically heading towards ~80%. And the CPU
numbers look quite similar, too.

And here's the phpmyadmin repository (the one I linked to earlier):

  10 | 386M (100%) | 1592s (100%)
  20 | 280M ( 72%) | 1947s (122%)
  40 | 209M ( 54%) | 2514s (158%)
  80 | 169M ( 44%) | 3386s (213%)
 160 | 151M ( 39%) | 4822s (303%)
 320 | 142M ( 37%) | 6948s (436%)

The packfile size improvements go on for much longer as we increase the
window size. For this repo, a window size of 80-100 is probably a good
spot.

That leads me to a few questions:

  1. Should we bump our default window size? The numbers above show that
     typical repos would benefit from jumping to 20 or even 40.

  2. Is there a heuristic or other metric we can figure out to
     differentiate the first two repositories from the third, and use a
     larger window size on the latter?

  3. Does the phpmyadmin case give us any insight into whether we can
     improve our window sorting algorithm? Looking at the repo, ~55K of
     the ~75K commits are small changes in the po/ directory (it looks
     like they were using a web-based tool to let non-committers tweak
     the translation files). In particular, I see a lot of commits in
     which most of the changes are simply line number changes as the po
     files are refreshed from the source. I wonder if that is making the
     size-sorting heuristics perform poorly, as we end up with many
     files of the same size, and the good deltas get pushed further
     along the window.

  4. What is typical? I suspect that git.git and linux-2.6 are typical,
     and the weird po-files in the phpmyadmin repository are not. But
     I'd be happy to test more repos if people have suggestions. And the
     scripts that generated the charts are included below if anybody
     wants to try it themselves.

-Peff

-- >8 --
cat >collect <<\EOF
#!/bin/sh
# usage: collect /path/to/repo >foo.out

windows='10 20 40 80 160 320'

for i in $windows; do
  echo >&2 "Repacking with window $i..."
  rm -rf tmp && cp -a "$1" tmp && (
    cd tmp &&
    time=`time -f %U -o /dev/stdout git repack -adf --window=$i`
    size=`du -bc objects/pack/pack-*.pack | tail -1 | awk '{print $1}'`
    echo "$i $size $time"
  )
done
EOF

cat >chart <<\EOF
#!/usr/bin/perl
# usage: chart <foo.out

use strict;

my @base;
while (<>) {
  chomp;
  my ($window, $size, $time) = split;

  @base = ($size, $time) unless @base;

  printf '%4s', $window;
  print ' | ', humanize($size);
  printf ' (%3d%%)', int($size / $base[0] * 100 + 0.5);
  printf ' | %4ds', $time;
  printf ' (%d%%)', int($time / $base[1] * 100 + 0.5);
  print "\n";
}

sub human_digits {
  my $n = shift;
  my $digits = $n >= 100 ? 0 :
               $n >=  10 ? 1 :
               2;
  return sprintf '%.*f', $digits, $n;
}

sub humanize {
  my $n = shift;
  my $u;
  foreach $u ('', qw(K M G)) {
    return human_digits($n) . $u if $n < 900;
    $n /= 1024;
  }
  return human_digits($n) . $u;
}
EOF
