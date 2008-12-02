From: Jeff King <peff@peff.net>
Subject: Re: more merge strategies : feature request
Date: Tue, 2 Dec 2008 10:30:36 -0500
Message-ID: <20081202153036.GC15134@coredump.intra.peff.net>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com> <4933AC03.6050300@op5.se> <81bfc67a0812011838m68100020v727da1c06f0bcee4@mail.gmail.com> <20081202033013.GD6804@coredump.intra.peff.net> <81bfc67a0812020628l53c209a6yca5a619d211b6bfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XEf-0003mx-SO
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbYLBPak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbYLBPak
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:30:40 -0500
Received: from peff.net ([208.65.91.99]:3186 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536AbYLBPaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:30:39 -0500
Received: (qmail 12320 invoked by uid 111); 2 Dec 2008 15:30:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 10:30:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 10:30:36 -0500
Content-Disposition: inline
In-Reply-To: <81bfc67a0812020628l53c209a6yca5a619d211b6bfc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102144>

On Tue, Dec 02, 2008 at 09:28:41AM -0500, Caleb Cushing wrote:

> I'm afraid I don't fully understand your example
> 
> 
> lets say git merge foo bar
> foo          bar
> 1             1
> 2              8
> 3              3
> 4              4
> 5              5
> 6
> 7

I notice that you don't have a "merge base" here, which is an important
part of determining conflicts. So if you are proposing to not look at
the history at all, and just show all differences, then that is
different from what I thought you meant.

> lines 6 and 7 are new in foo line 2 has a conflict because the other
> head has an 8, history wise because of an early merge the other
> direction and fix, there was the 8 in foo and it was changed to a 2,
> when I merge back it will overwrite the 8 with  a 2. however I need
> the 8 to be the 8 and the 2 to be the 2. but I want the 6 and 7 in
> both.
>
> conflict would create a conflict
> 
> such as
> 
> foo
> 1
> <<<<<< bar
> 8
> ======
> 2
> >>>>>>  foo
> 3
> 4
> 5
> 6
> 7

OK, so assume we throw away history and just look at the diff between
the two branches.  How do we know that a conflict should be created for
the 2 vs 8, but not for the added "6 7" at the end? I think you have to
create a conflict marker for both and fix them up manually. Like:

    1
    <<<<<<< foo
    2
    =======
    8
    >>>>>>> bar
    3
    4
    5
    <<<<<<< foo
    6
    7
    =======
    >>>>>>> bar

The script below munges a diff into conflict markers (and created the
output you see above). Note that it is very hacky and not very tested.
And note that at this point this really has nothing to do with _git_
specifically, since we aren't even using history. This just generates
conflict markers from two files. There may be a more mature tool that
can accomplish the same thing (personally, I would use something like
xxdiff to do an interactive merge in your case).

You can try it with:

  git config merge.conflict.driver 'perl /path/to/conflict.pl %A %B'
  echo '* merge=conflict' >.gitattributes

-->8 conflict.pl 8<--
#!/usr/bin/perl

use strict;
use warnings qw(all FATAL);

my $fn1 = shift;
my $fn2 = shift;

open(my $diff, '-|', qw(diff -U 999999), $fn1, $fn2)
  or die "unable to run diff: $!";
open(my $tmp, '>', "$fn1.tmp")
  or die "unable to open temporary file: $!";
select $tmp;

while(<$diff>) {
  last if /^@/;
}

sub start   { print "<<<<<<< $fn1\n" }
sub divider { print "=======\n" }
sub end     { print ">>>>>>> $fn2\n" }
my $conflict = 0;
while(<$diff>) {
  if (/^ (.*)/) {
    if    ($conflict == 0) { }
    elsif ($conflict == 1) { divider; end }
    elsif ($conflict == 2) { end }
    print $1, "\n";
    $conflict = 0;
  }
  elsif(/^-(.*)/) {
    if    ($conflict == 0) { start }
    elsif ($conflict == 1) { }
    elsif ($conflict == 2) { end; start }
    print $1, "\n";
    $conflict = 1;
  }
  elsif(/^\+(.*)/) {
    if    ($conflict == 0) { start; divider }
    elsif ($conflict == 1) { divider }
    elsif ($conflict == 2) { }
    print $1, "\n";
    $conflict = 2;
  }
}

if    ($conflict == 0) { }
elsif ($conflict == 1) { divider; end }
elsif ($conflict == 2) { end }

close($tmp);
rename "$fn1.tmp", $fn1;
exit 1;
