From: Jeff King <peff@peff.net>
Subject: Re: weird diff output?
Date: Wed, 30 Mar 2016 00:55:55 -0400
Message-ID: <20160330045554.GA11007@sigill.intra.peff.net>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 06:58:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al8Cq-0002nS-N9
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 06:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbcC3Ez7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 00:55:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:40588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750963AbcC3Ez6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 00:55:58 -0400
Received: (qmail 438 invoked by uid 102); 30 Mar 2016 04:55:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 00:55:57 -0400
Received: (qmail 31522 invoked by uid 107); 30 Mar 2016 04:55:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 00:55:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 00:55:55 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290268>

On Tue, Mar 29, 2016 at 04:05:57PM -0700, Jacob Keller wrote:

> > This is what we want in both cases.
> > And I would argue it would appease many other kinds of text as well, because
> > an empty line is usually a strong indicator for any text that a
> > different thing comes along.
> > (Other programming languages, such as Java, C++ and any other C like
> > language behaves
> > that way; even when writing latex figures you'd rather want to break
> > at new lines?)
> >
> > Thanks,
> > Stefan
> 
> This seems like a good heuristic. Can we think of any examples where
> it would produce wildly confusing diffs? I don't think it necessarily
> needs to be default but just a possible option when formatting diffs,
> much like we already have today.

One thing I like to do when playing with new diff ideas is to pipe all
of "log -p" for a real project through it and see what differences it
produces.

Below is a perl script that implements Stefan's heuristic. I checked its
output on git.git with:

  git log --format='commit %H' -p >old
  perl /path/to/script <old >new
  diff -F ^commit -u old new | less

which shows the differences, with the commit id in the hunk header
(which makes it easy to "git show $commit | perl /path/to/script" to
see the new diff with more context.

In addition to the cases discussed, it seems to improve C comments by
turning:

   /*
  + * new function
  + */
  +void foo(void);
  +
  +/*
    * old function
    ...

into:

  +/*
  + * my function
  + */
  +void foo(void);
  +
   /*
    * old function
    ...

See 47fe3f6e for an example.

It also seems to do OK with shell scripts. Commit e6bb5f78 is an example
where it improves a here-doc, as in the motivating example from this
thread. Similarly, the headers in 4df1e79 are much improved (though I'm
confused why the final one in that diff doesn't seem to have been
caught).

I also ran into an interesting case in 86d26f24, where we have:

  + test_expect_success '
  +   foo
  +
  +'
  +

and there are _two_ blank lines to choose from. It looks really terrible
if you use the first one, but the second one looks good (and the script
below chooses the second, as it's closest to the hunk boundary). There
may be cases where that's bad, though.

This is just a proof of concept. I guess we'd want to somehow integrate
the heuristic into git.

-- >8 --
#!/usr/bin/perl

use strict;
use warnings 'all';

use constant {
  STATE_NONE => 0,
  STATE_LEADING_CONTEXT => 1,
  STATE_IN_CHUNK => 2,
};
my $state = STATE_NONE;
my @hunk;
while(<>) {
  if ($state == STATE_NONE) {
    print;
    if (/^@/) {
      $state = STATE_LEADING_CONTEXT;
    }
  } else {
    if (/^ /) {
      flush_hunk() if $state != STATE_LEADING_CONTEXT;
      push @hunk, $_;
    } elsif(/^[-+]/) {
      push @hunk, $_;
      $state = STATE_IN_CHUNK;
    } else {
      flush_hunk();
      $state = STATE_NONE;
      print;
    }
  }
}
flush_hunk();

sub flush_hunk {
  my $context_len = 0;
  while ($context_len < @hunk && $hunk[$context_len] =~ /^ /) {
    $context_len++;
  }

  # Find the length of the ambiguous portion.
  # Assumes our hunks have context first, and ambiguous additions at the end,
  # which is how git generates them
  my $ambig_len = 0;
  while ($ambig_len < $context_len) {
    my $i = $context_len - $ambig_len - 1;
    my $j = @hunk - $ambig_len - 1;
    if ($hunk[$j] =~ /^\+/ && substr($hunk[$i], 1) eq substr($hunk[$j], 1)) {
      $ambig_len++;
    } else {
      last;
    }
  }

  # Now look for an empty line in the ambiguous portion (we can just look in
  # the context side, as it is equivalent to the addition side at the end).
  # We count down, though, as we prefer to use the line closest to the
  # hunk as the cutoff.
  my $empty;
  for (my $i = $context_len - 1; $i >= $context_len - $ambig_len; $i--) {
    if (length($hunk[$i]) == 2) {
      $empty = $i;
      last;
    }
  }

  if (defined $empty) {
    # move empty lines after the chunk to be part of it
    for (my $i = $empty + 1; $i < $context_len; $i++) {
      $hunk[$i] =~ s/^ /+/;
      $hunk[@hunk - $context_len + $i] =~ s/^\+/ /;
    }
  }

  print @hunk;
  @hunk = ();
}
