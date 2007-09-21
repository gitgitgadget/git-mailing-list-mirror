From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Fri, 21 Sep 2007 00:18:21 -0400
Message-ID: <20070921041821.GA28245@coredump.intra.peff.net>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site> <20070920123849.GD12076@jukie.net> <Pine.LNX.4.64.0709201403540.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 06:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYZyI-000217-SU
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 06:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbXIUESY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 00:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbXIUESY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 00:18:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2354 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXIUESY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 00:18:24 -0400
Received: (qmail 18623 invoked by uid 111); 21 Sep 2007 04:18:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Sep 2007 00:18:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2007 00:18:21 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201403540.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58824>

On Thu, Sep 20, 2007 at 02:12:54PM +0100, Johannes Schindelin wrote:

> Further, it probably makes sense to have the option to say _both_: "Find 
> me a commit that contains Bart in one line, but not Simpson, and that 
> does not contain the word "Sverdoolaege" at all."

This is perhaps a little hack-ish compared to better grep support in the
core, but I find complex logic through command line options to be
somewhat unreadable. I prefer something more Perl-ish like this:

  git-revgrep 'message =~ /bart/i
               && message !~ /Simpson/
               && author_name !~ /Sverdoolaege/'

or if you want to get complex:

  git-revgrep '
    return 0 if message =~ /Sverdoolaege/;
    while(my $line = message =~ /^(.*bart.*)/gmi) {
      return 1 if $line !~ /Simpson/;
    }
    return 0;'

where revgrep is the script below:

-- >8 --
#!/usr/bin/perl
use strict;

my $matcher = shift || '';
my $matcher_sub = eval "sub { $matcher }";
die $@ if $@;

my $input = do {
  if(@ARGV == 1 && $ARGV[0] eq '-') {
    \*STDIN;
  }
  else {
    open(my $fh, '-|', qw(git log --pretty=raw), @ARGV)
      or die "unable to open pipe to git log: $!";
    $fh;
  }
};

our $commit;
while(<$input>) {
  if(/^commit /) {
    try_match() if $commit;
    $commit = $_;
  }
  else {
    $commit .= $_;
  }
}
try_match() if $commit;
exit 0;

sub try_match {
  if($matcher_sub->()) {
    print STDOUT $commit;
  }
}

sub parse_person { $_[0] =~ /([^<]*) <([^>]*)> (.*)/ }
sub parse_author { return parse_person($commit =~ /^author (.*)/m) }
sub parse_committer { return parse_person($commit =~ /^committer (.*)/m) }
sub author_name { return (parse_author)[0] }
sub author_email { return (parse_author)[1] }
sub author_time { return (parse_author)[2] }
sub committer_name { return (parse_committer)[0] }
sub committer_email { return (parse_committer)[1] }
sub committer_time { return (parse_committer)[2] }
sub message { return ($commit =~ /^( +.*?^$)/ms)[0] }
