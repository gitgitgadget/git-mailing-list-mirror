From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Sat, 21 Mar 2015 04:19:09 -0400
Message-ID: <20150321081909.GA8221@peff.net>
References: <20150320100429.GA17354@peff.net>
 <CAPig+cRCbhMR58_PSFnsWoyo_aZoTOVZM2YeYC6Tvo7iXMZwBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 09:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZEcz-0001lD-IG
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 09:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbbCUITP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 04:19:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:36407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751174AbbCUITM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 04:19:12 -0400
Received: (qmail 31992 invoked by uid 102); 21 Mar 2015 08:19:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 03:19:12 -0500
Received: (qmail 32427 invoked by uid 107); 21 Mar 2015 08:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 04:19:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2015 04:19:09 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRCbhMR58_PSFnsWoyo_aZoTOVZM2YeYC6Tvo7iXMZwBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266015>

On Fri, Mar 20, 2015 at 07:18:47PM -0400, Eric Sunshine wrote:

> Ironically, one of the broken here-doc &&-links you detected with
> --chain-lint and fixed in 4/25 was from a patch from me: 5a9830cb
> (t8001/t8002 (blame): add blame -L :funcname tests, 2013-07-17).

Heh. I was afraid to look at my own.

I wondered if we had a good way of finding who wrote the specific lines
that were changed in a patch.  I wrote the script below before realizing
that contrib/contacts does something similar (though I think it blames
whole hunks, including context, and I really want to care specifically
only about touched lines; I wonder if that is a distinction git-contacts
should make).

Running:

  git diff origin origin/jk/test-chain-lint |
  perl diff-blame.pl jk/test-chain-lint |
  grep EOF

was fun. At least I am not the only one. :)

Nor the worst in the "severe" category. I will leave using the script to
read the list of "severe" names as an exercise to the reader; reading
such output is probably not overly healthy (and besides, to be fair it
really should be normalized over the number of contributions).

-- >8 --
# diff-blame.pl
use warnings FATAL => 'all';
use strict;

my $head = shift
  or die "usage: git diff <start> <end> | $0 <start> [blame-opts]";

my $file;
my @lines;
my $line_nr;

while (<STDIN>) {
  if (m{^--- .*?/(.*)}) {
    flush();
    $file = $1;
    @lines = ();
  }
  elsif (m{^@@ -(\d+)}) {
    $line_nr = $1;
  }
  elsif (m{^ }) {
    $line_nr++;
  }
  elsif (m{^-}) {
    push @lines, $line_nr++;
  }
}
flush();
exit 0;

sub flush {
  return unless defined $file && @lines > 0;

  # XXX coalesce blocks of adjacent lines into ranges?
  system(qw(git --no-pager blame), @ARGV,
         (map { "-L$_,$_" } @lines), $head, $file);
}
