Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1252F20285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbdHXOXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:23:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:47934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752563AbdHXOXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:23:12 -0400
Received: (qmail 18738 invoked by uid 109); 24 Aug 2017 14:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 14:23:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10032 invoked by uid 111); 24 Aug 2017 14:23:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 10:23:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 07:23:08 -0700
Date:   Thu, 24 Aug 2017 07:23:08 -0700
From:   Jeff King <peff@peff.net>
To:     Adam Spiers <git@adamspiers.org>
Cc:     Drew Northup <n1xim.email@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: Re: splitting off shell test framework
Message-ID: <20170824142307.3osmt2uweb3azskl@sigill.intra.peff.net>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
 <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
 <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
 <CAOkDyE_VhGUzn=PmAVsbaTe1ZeBwBVGpF4Muz5MBckMAB6cf=g@mail.gmail.com>
 <20170823154747.vxtyy2v2ofkxwrkx@sigill.intra.peff.net>
 <CAOkDyE9pWFLRQ0cZO03bc3Q9r=AzLHMUQ0kxb4bdsTJowcLz=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOkDyE9pWFLRQ0cZO03bc3Q9r=AzLHMUQ0kxb4bdsTJowcLz=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 12:23:05AM +0100, Adam Spiers wrote:

> > [1] I actually keep a local archive and convert public-inbox URLs into
> >     local requests that I view in mutt.
> 
> Sounds like a neat trick - any scripts / config worth sharing?

It's probably too specific to my setup, but here it is anyway.

I keep the archive in a normal maildir, which I index with the mairix
tool (you could do the same thing with maildir-utils or notmuch). New
messages get put into the maildir by mutt's auto-move feature after I've
read them.

Then I have a few keys bound in mutt:

  macro pager,index M '<pipe-message>gmane<enter>'
  macro pager,index B '<pipe-message>rmairix-gmane<enter>'

(you can tell from the names that these predate public-inbox entirely).

The "gmane" script just opens a browser pointing to the current message
in the archive, from which I then 'y'ank the URL into the clipboard or
pasting. The network round-trip was necessary for gmane, since the
article ids were not predictable. For public-inbox, it's not necessary,
but old habits die hard (and it's a nice cross-check that the link
you're sending out isn't broken).

Here's that script:

-- >8 --
#!/bin/sh

mid() {
  exec webview "http://public-inbox.org/git/$1"
}

article() {
  exec webview "http://public-inbox.org/git/?q=gmane:$1"
}

find_mid() {
  perl -ne 'if(/^message-id:\s*<([^>]+)>/i) { print $1, "\n"; exit 0 }'
}

case "$#" in
  0) id=`find_mid`
     case "$id" in
       "") echo >&2 "fatal: unable to extract message-id from stdin"; exit 1 ;;
        *) mid "$id" ;;
     esac
     ;;
  1) case "$1" in
       *@*) mid "$1" ;;
         *) article "$1" ;;
     esac
     ;;
  *) echo >&2 "fatal: don't know how to handle $# arguments"; exit 100 ;;
esac
-- 8< --

The "webview" command is just a personal wrapper that decides which
browser to use. You could replace it with "firefox" or "chromium" or
whatever.

The "rmairix-gmane" script picks out gmane/public-inbox references and
re-opens them in mutt. It looks like this:

-- >8 --
#!/usr/bin/env perl
use URI;
use URI::Escape;

if (@ARGV) {
  show_gmane_article($_) foreach @ARGV;
}
else {
  while(<>) {
    if (m{http://[^/]*gmane.org/[-\w/.]+}) {
      show_gmane_url($&);
    }
    if (m{https?://public-inbox.org/git/([^/]+)}) {
      show_mid(uri_unescape($1));
    }
  }
}
exit 0;

sub show_mid {
  system("rmairix -t m:" . quotemeta(shift) . " </dev/tty");
}

sub show_gmane_url {
  my ($group, $article) = extract_article(shift);
  show_gmane_article($article);
}

sub show_gmane_article {
  my $article = shift;
  my $mid = gmane_to_mid($article);
  show_mid($mid) if defined $mid;
}

sub gmane_to_mid {
  my $want = shift;

  open(my $map, "-|", qw(gunzip -c), "$ENV{HOME}/.gmane-to-mid.gz");
  while (<$map>) {
    chomp;
    my ($nr, $mid) = split / /, $_, 2;
    return $mid if $nr == $want;
  }
}

sub extract_article {
  my @path = URI->new(shift)->path_segments;

  # first one is always empty in absolute URL
  shift @path unless length($path[0]);

  # group is always next
  my $group = shift @path;

  # and then look for numbers starting from the back. E.g.,
  # focus=N for threads, or just "N" for articles
  while (@path) {
    local $_ = pop @path;
    return ($group, $&) if /\d+/;
  }

  return ($group, undef);
}
-- 8< --

The two extra bits you'd need are:

  - the ~/.gmane-to-mid.gz mapping. I don't remember if I made this
    myself or stole it from one that Eric posted. I'm happy to share if
    anybody wants it.

  - rmairix is a personal wrapper around mairix that ssh's to my imap
    server to do the search and then starts mutt on the result.

    Naturally I also use it for general queries like

      rmairix -t f:peff sanitize thread

I hope that helps.  I suspect it may be more useful to people as
inspiration and not as running code. I'm happy to answer any questions
or give any guidance I can.

-Peff
