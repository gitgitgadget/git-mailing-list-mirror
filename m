From: Jeff King <peff@peff.net>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 00:51:48 -0400
Message-ID: <20071003045148.GD11905@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <4702F6BB.60908@vilain.net> <Pine.LNX.4.64.0710030506360.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwDG-0004Z3-TG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbXJCEvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbXJCEvv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:51:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2224 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXJCEvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:51:50 -0400
Received: (qmail 11955 invoked by uid 111); 3 Oct 2007 04:51:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 00:51:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 00:51:48 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710030506360.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59783>

On Wed, Oct 03, 2007 at 05:23:35AM +0100, Johannes Schindelin wrote:

> > > #!/usr/bin/perl
> > 
> > Add -w for warnings, also use strict;
> 
> <dumb>What does "use strict;" imply?</dumb>

Try "perldoc strict" for details.

> > > 	if ($par =~ /^\. /s) {
> > > 		my @lines = split(/^\. /m, $par);
> > > 		shift @lines;
> > > 		$conv->enumeration(\@lines);
> > > 	} elsif ($par =~ /^\* /s) {
> > 
> > uncuddle your elsif's;
> 
> I'm sorry... What do you mean?

I think he means reformatting to

  if (condition) {
  }
  elsif (condition) {
  }

> > $result = ( $par =~ /^\. /s      ? $conv->do_enum($par)    :
> >             $par =~ /^\[verse\]/ ? $conv->do_verse($par)  :
> >             ... )
> 
> I do not like that way... is it Perl standard to code like that?

It's quite common if you have a dispatch function, but obviously not
required.

> > > 		$title =~ s/\(\d+\)$//;
> > > 		print '.\"     Title: ' . $title
> > > 			. '.\"    Author: ' . "\n"
> > > 			. '.\" Generator: ' . $self->{generator} . "\n"
> > > 			. '.\"      Date: ' . $self->{date} . "\n"
> > > 			. '.\"    Manual: ' . $self->{manual} . "\n"
> > > 			. '.\"    Source: ' . $self->{git_version} . "\n"
> > > 			. '.\"' . "\n";
> > > 	}
> > 
> > I'd consider a HERE-doc, or multi-line qq{ } more readable than this.
> 
> Can you give me an example of a HERE-doc?  (What I tried to avoid is 
> having ugly indentation-breaking tlobs.)

print <<EOF;
foo
EOF

HERE-docs necessarily break indentation unless you strip it out manually
(which is inefficient and ugly).

But two things that might make that look better are using qq// (to avoid
having to escape quotes) and interpolating the variables:

  . qq/." Generator: $self->{generator}\n/

> I'll try to find something about qq{} in the docs.

It's in perlop, but it's basically a fancy way of double-quoting, except
that you get to choose the delimiter.

> > > 	$text =~ s/([^\n]) *\n([^\n])/\1 \2/g;
> > 
> > "." is the same as [^\n] (without the 's' modifier).
> 
> But I need the (implicit) 's' modifier, otherwise the "\n" in the middle 
> is not interpreted correctly.  This regsub is meant to unwrap the 
> paragraph and put it into a very long line (but leaving \n\n alone).

I think you might be confused about how the 's' modifier works. You are
not using it, so '.' is the same as '[^\n]'. Perl will always match a
newline if it's in your regex. If you specify 'm', then it will also
allow '^' and '$' to match at line boundaries (instead of just at the
beginning and end of the string).

-Peff
