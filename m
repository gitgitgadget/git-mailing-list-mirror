From: Jeff King <peff@peff.net>
Subject: Re: git filter-branch --subdirectory-filter
Date: Sat, 10 May 2008 01:53:32 -0400
Message-ID: <20080510055332.GB11556@sigill.intra.peff.net>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com> <20080509013300.GA7836@sigill.intra.peff.net> <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com> <20080509080039.GA15393@sigill.intra.peff.net> <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Sadler <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 07:54:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jui2b-0004dB-9M
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 07:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbYEJFxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 01:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYEJFxb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 01:53:31 -0400
Received: from peff.net ([208.65.91.99]:3442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbYEJFxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 01:53:30 -0400
Received: (qmail 25047 invoked by uid 111); 10 May 2008 05:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 May 2008 01:53:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2008 01:53:32 -0400
Content-Disposition: inline
In-Reply-To: <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81652>

On Sat, May 10, 2008 at 01:31:37PM +1000, James Sadler wrote:

> Does anybody have a script that can take an existing repo, and create
> a new one with garbled-but-equivalent commits?  i.e.  file and
> directory structure is same with names changed, and there is a one-one
> relationship between lines of text in new repo and old one except the
> lines have been scrambled?  It would be a useful tool for distributing
> private repositories for debugging reasons.

This is only lightly tested, but the script below should do the trick.
It works as an index filter which munges all content in such a way that
a particular line is always given the same replacement text. That means
that diffs will look approximately the same, but will add and remove
lines that say "Fake line XXX" instead of the actual content.

You can munge the commit messages themselves by just replacing them with
some unique text; in the example below, we just replace them with the
md5sum of the content.

This will leave the original author, committer, and date, which is
presumably non-proprietary.

-- >8 --
#!/usr/bin/perl
#
# Obscure a repository while still maintaining the same history
# structure and diffs.
#
# Invoke as:
#   git filter-branch \
#     --msg-filter md5sum \
#     --index-filter /path/to/this/script

use strict;
use IPC::Open2;
use DB_File;
use Fcntl;
tie my %blob_cache, 'DB_File', 'blob-cache', O_RDWR|O_CREAT, 0666;
tie my %line_cache, 'DB_File', 'line-cache', O_RDWR|O_CREAT, 0666;

open(my $lsfiles, '-|', qw(git ls-files --stage))
  or die "unable to open ls-files: $!";
open(my $update, '|-', qw(git update-index --index-info))
  or die "unable to open upate-inex: $!";

while(<$lsfiles>) {
  my ($mode, $hash, $path) = /^(\d+) ([0-9a-f]{40}) \d\t(.*)/
    or die "bad ls-files line: $_";
  $blob_cache{$hash} = munge($hash)
    unless exists $blob_cache{$hash};
  print $update "$mode $blob_cache{$hash}\t$path\n";
}

close($lsfiles);
close($update);
exit $?;

sub munge {
  my $h = shift;

  open(my $in, '-|', qw(git show), $h)
    or die "unable to open git show: $!";
  open2(my $hash, my $out, qw(git hash-object -w --stdin));

  while(<$in>) {
    $line_cache{$_} ||= 'Fake line ' . $line_cache{CURRENT}++ . "\n";
    print $out $line_cache{$_};
  }

  close($in);
  close($out);

  my $r = <$hash>;
  chomp $r;
  return $r;
}
