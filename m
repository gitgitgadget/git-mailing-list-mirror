From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Mon, 21 Apr 2008 22:39:18 -0400
Message-ID: <20080422023918.GA5402@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 04:40:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo8QU-0006Dd-28
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 04:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757671AbYDVCjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 22:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbYDVCjW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 22:39:22 -0400
Received: from peff.net ([208.65.91.99]:2204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756926AbYDVCjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 22:39:22 -0400
Received: (qmail 10777 invoked by uid 111); 22 Apr 2008 02:39:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 21 Apr 2008 22:39:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Apr 2008 22:39:18 -0400
Content-Disposition: inline
In-Reply-To: <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80053>

On Mon, Apr 21, 2008 at 05:53:34PM -0400, Avery Pennarun wrote:

> Does anyone know the most efficient way to do this with
> git-filter-branch, when there are already thousands of files in the
> repo with CRLF in them?  Running dos2unix on all the files for every
> single revision could take a *very* long time.

Yes, a tree filter would probably be quite slow due to checking out, and
then munging all of the files.

You could maybe do an index filter that gets the blob SHA1 of each file
that is new, and just munges those. But I think it is even simpler to
just keep a cache of original blob hashes mapping to munged blob hashes.

Something like:

  git filter-branch --index-filter '
    git ls-files --stage |
    perl /path/to/caching-munger |
    git update-index --index-info
  '

where your caching munger looks something like:

-- >8 --
#!/usr/bin/perl

use strict;
use DB_File;
use Fcntl;
tie my %cache, 'DB_File', "$ENV{HOME}/filter-cache", O_RDWR|O_CREAT, 0666
  or die "unable to open db: $!";

while(<>) {
  my ($mode, $hash, $path) = /^(\d+) ([0-9a-f]{40}) \d\t(.*)/
    or die "bad ls-files line: $_";
  $cache{$hash} = munge($hash)
    unless exists $cache{$hash};
  print "$mode $cache{$hash}\t$path\n";
}

sub munge {
  my $h = shift;
  my $r = scalar `git show $h | sed 's/\$/\\r/' | git hash-object -w --stdin`;
  chomp $r;
  return $r;
}
-- 8< --

so we keep a dbm of the hash mapping, and do no work if we have already
seen this blob. If we don't, then we actually do the expensive 'show |
munge | hash-object'. And here our munge adds a CR, but you should be
able to do an arbitrary transformation.

-Peff
