Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74301F597
	for <e@80x24.org>; Mon, 23 Jul 2018 01:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbeGWCYg (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 22:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731151AbeGWCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 22:24:36 -0400
Received: (qmail 18741 invoked by uid 109); 23 Jul 2018 01:25:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Jul 2018 01:25:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12822 invoked by uid 111); 23 Jul 2018 01:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 22 Jul 2018 21:26:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Jul 2018 21:25:53 -0400
Date:   Sun, 22 Jul 2018 21:25:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20]
 linear-assignment: a function to solve least-cost assignment problems
Message-ID: <20180723012552.GA26886@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
 <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
 <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
 <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
 <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807212347330.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807212347330.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 11:56:06PM +0200, Johannes Schindelin wrote:

> > The script that I feed a message from gmane or public-inbox when I need
> > to learn the set of commits that resulted from the message instead uses
> > "git grep $message-id notes/amlog".  And that is fast enough for my
> > purpose.
> 
> Awesome. You might want to make sure that Peff stops advertising the amlog
> notes, then, though.

Woah, what did I do now?

> > There is no good reason to abuse the notes mechanism to map a random
> > object-name looking string (i.e. hash result of message id), other
> > than the ease of "quick access" when somebody is making a lot of
> > inquiry, but that "database" does not have to be stored in notes.
> 
> Right. And it does not have to be stored anywhere, because nobody used it
> anyway, right?

If I understand the situation correctly, Junio is saying that he will
continue to produce the amlog mapping, and that it contains sufficient
information to produce the reverse mapping (which, as an aside, I did
not even know existed -- I mostly want to go the other way, from digging
in history to a mailing list conversation).

E.g., the script below builds and queries an incremental reverse
mapping.

-- >8 --
#!/usr/bin/perl

my $REF = 'refs/notes/amlog';
my $DBFILE = '.git/amlog.rev';

use DB_File;
my %h;
my $db = tie %h, 'DB_File', $DBFILE, O_CREAT|O_RDWR, 0644
  or die "unable to open/create $DBFILE: $!";

my $db_tip = $h{TIP};
chomp(my $rev_tip = `git rev-parse $REF`);
if (!defined $db_tip || $db_tip ne $rev_tip) {
  print STDERR "Updating reverse mapping...\n";
  # using -p here is quick and easy, since we know the
  # shape of the data. Using --raw and cat-file might be less
  # hacky, though.
  my @cmd = (qw(git log --format= --reverse -p), $rev_tip);
  push @cmd, "^$db_tip" if defined $db_tip;
  open(my $fh, "-|", @cmd);

  my $commit;
  while (<$fh>) {
    if (m{^\+\+\+ b/([0-9a-f/]+)}) {
      $commit = $1;
      $commit =~ s/[^0-9a-f]//g;
    } elsif (/^\+Message-Id: <(.*)>/i) {
      print STDERR "Imported $commit => $1\n";
      $h{$1} = $commit;
    }
  }
  $h{TIP} = $rev_tip;
}

print "$h{$_} $_\n" for @ARGV;
-- >8 --

That stores it in a local dbm. But it could also build a git-notes tree
if you really want that.

And if I understand what is being said here:

> > It certainly does not belong to cycles worth spending by me *while*
> > I work during the say with various history reshaping tools to record
> > and/or update the reverse mapping and that is why my post-applypatch
> > hook no longer has the "reverse map" hack.
> > 
> > It is not like anybody (including me) needs realtime up-to-date
> > reverse mapping from amlog while I run my "commit --amend", "rebase
> > -i", etc. and the reverse map is constructable by reversing the
> > forward map, obviously, with a postprocessing.  And I think that is
> > a reasonably way forward if anybody wants to have a reverse mapping.
> > The postprocessing can be done either by me before pushing out the
> > amlog ref, or done by any consumer after fetching the amlog ref from
> > me.  If I did the postprocessing and refuse to use rewrite hook you
> > wouldn't even know ;-)

It is not "I refuse to push out a reverse mapping". It is "I could make
the reverse mapping before push-out, and you would not need to know or
care if I did it all at once, or using a rewrite hook".

Though personally, I do not know if there is much point in pushing it
out, given that receivers can reverse the mapping themselves.

Or is there some argument that there is information in the reverse map
that _cannot_ be generated from the forward map?

-Peff
