From: Jeff King <peff@peff.net>
Subject: Re: [RFD] Alternative to git-based wiki: wiki as foreign VCS
Date: Tue, 22 Feb 2011 11:11:14 -0500
Message-ID: <20110222161114.GD27178@sigill.intra.peff.net>
References: <vpqoc6a8x0k.fsf@bauges.imag.fr>
 <vpq7hcsmk9c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 22 17:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prupf-0001zb-Jv
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab1BVQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 11:11:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39497 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab1BVQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 11:11:17 -0500
Received: (qmail 2427 invoked by uid 111); 22 Feb 2011 16:11:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 16:11:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 11:11:14 -0500
Content-Disposition: inline
In-Reply-To: <vpq7hcsmk9c.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167560>

On Tue, Feb 22, 2011 at 11:33:19AM +0100, Matthieu Moy wrote:

> So, nobody's more inspired to comment on this proposal? ;-)

No, just busy. :)

> > One solution is to use a git-based wiki, like ikiwiki [1], golum
> > [2], ... but in many contexts, this is not applicable: because one
> > has an existing wiki and doesn't want to migrate, because the
> > git-based wiki lacks features XYZ that you rely on, or because one is
> > a small contributor to a large project (say, wikipedia) and cannot
> > force the project to change.
> >
> > I'm thinking of an alternative to this: implement a foreign VCS
> > interface for a wiki engine. Today, one can interact with, say, SVN,
> > using Git (via git-svn [3]). This way, we can get most of the Git
> > goodness locally, and just "publish" the changes on an SVN repository.

I think this a great idea. I made some first steps with the import I did
here:

  https://github.com/peff/wikitest

I'll include my quick-and-dirty mediawiki fast-exporter at the end of
this mail.  I'm sure it probably has some bugs or corner-cases it
doesn't handle, but maybe it can help as a starting point.

And then of course we'd need incremental fetching (which I planned to do
by hitting the "recent changes" API in mediawiki). And some method for
pushing changes back up, which I didn't even look at.

> > * Ability to import only a subset of the wiki (nobody want to "git
> >   clone" the whole wikipedia ;-) ). At least a manually-specified list
> >   of pages, and better, the content of one category.

Neat idea. One thing that might be useful for a site like wikipedia is
"fetch this page, and any pages it links to, pages they link to, and so
on, to a recursion depth of N". So if you are interested in some topic
you could get related topics. But that's a lot harder, since it means
fetching and parsing the mediawiki, whereas the rest can be done through
the API.

Anyway, here is my mediawiki fast-exporter. Like I said, quick and
dirty.

-- >8 --
#!/usr/bin/perl

use strict;
use MediaWiki::API;
use DB_File;
use Storable qw(freeze thaw);
use DateTime::Format::ISO8601;
use Encode qw(encode_utf8);

my $url = shift;

my $mw = MediaWiki::API->new;
$mw->{config}->{api_url} = "$url/api.php";

my $pages = $mw->list({
    action => 'query',
    list => 'allpages',
    aplimit => 500,
});

# Keep everything in a db so we are restartable.
my $revdb = tie my %revisions, 'DB_File', 'revisions.db';
print STDERR "Fetching revisions...\n";
my $n = 1;
foreach my $page (@$pages) {
  my $id = $page->{pageid};

  print STDERR "$n/", scalar(@$pages), ": $page->{title}\n";
  $n++;

  next if exists $revisions{$id};

  my $q = {
    action => 'query',
    prop => 'revisions',
    rvprop => 'content|timestamp|comment|user|ids',
    rvlimit => 10,
    pageids => $page->{pageid},
  };
  my $p;
  while (1) {
    my $r = $mw->api($q);

    # Write out all content to files.
    foreach my $rev (@{$r->{query}->{pages}->{$id}->{revisions}}) {
      my $fn = "$rev->{revid}.rev";
      open(my $fh, '>', $fn)
        or die "unable to open $fn: $!";
      binmode $fh, ':utf8';
      print $fh $rev->{'*'};
      close($fh);
      delete $rev->{'*'};
    }

    # And then save the rest, appending if necessary.
    if (defined $p) {
      push @{$p->{revisions}}, @{$r->{query}->{pages}->{$id}->{revisions}};
    }
    else {
      $p = $r->{query}->{pages}->{$id};
    }

    # And continue or quit, depending on the output.
    last unless $r->{'query-continue'};
    $q->{rvstartid} = $r->{'query-continue'}->{revisions}->{rvstartid};
  }

  print STDERR "  Fetched ", scalar(@{$p->{revisions}}), " revisions.\n";
  $revisions{$id} = freeze($p);
  $revdb->sync;
}

# Make a flat list of all page revisions, so we can
# interleave them in date order.
my @revisions = map {
  my $page = thaw($revisions{$_});
  my @revisions = @{$page->{revisions}};
  delete $page->{revisions};
  $_->{page} = $page foreach @revisions;
  @revisions
} keys(%revisions);

print STDERR "Writing export data...\n";
binmode STDOUT, ':binary';
$n = 1;
foreach my $rev (sort { $a->{timestamp} cmp $b->{timestamp} } @revisions) {
  my $user = $rev->{user} || 'Anonymous';
  my $dt = DateTime::Format::ISO8601->parse_datetime($rev->{timestamp});
  my $fn = "$rev->{revid}.rev";
  my $size = -s $fn;
  my $comment = defined $rev->{comment} ? $rev->{comment} : '';
  my $title = $rev->{page}->{title};
  $title =~ y/ /_/;

  print STDERR "$n/", scalar(@revisions), ": $rev->{page}->{title}\n";
  $n++;

  print "commit refs/remotes/origin/master\n";
  print "committer $user <none\@example.com> ", $dt->epoch, " +0000\n";
  print "data ", bytes::length(encode_utf8($comment)), "\n", encode_utf8($comment);
  print "M 644 inline $title.wiki\n";
  print "data $size\n";
  open(my $fh, '<', $fn)
    or die "unable to open $fn: $!";
  binmode $fh, ':binary';
  while (read($fh, my $buf, 4096)) {
    print $buf;
  }
}
