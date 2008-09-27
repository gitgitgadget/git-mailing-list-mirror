From: Jeff King <peff@peff.net>
Subject: Re: status letters consistency in log and ls-files
Date: Fri, 26 Sep 2008 23:30:05 -0400
Message-ID: <20080927033004.GA2477@coredump.intra.peff.net>
References: <ee2a733e0809261128h4c50d27bq3942bd1b3b66d3ee@mail.gmail.com> <20080926224546.GB24817@coredump.intra.peff.net> <ee2a733e0809261624y72dcfb8fw7910feb2542f501c@mail.gmail.com> <20080927002949.GA25586@coredump.intra.peff.net> <ee2a733e0809262020l318b0ac3v560400d95a5ba2b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 05:33:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjQYd-0002zb-8f
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 05:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYI0DaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 23:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYI0DaJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 23:30:09 -0400
Received: from peff.net ([208.65.91.99]:3254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbYI0DaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 23:30:08 -0400
Received: (qmail 10430 invoked by uid 111); 27 Sep 2008 03:30:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 23:30:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 23:30:05 -0400
Content-Disposition: inline
In-Reply-To: <ee2a733e0809262020l318b0ac3v560400d95a5ba2b7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96900>

On Fri, Sep 26, 2008 at 11:20:03PM -0400, Leo Razoumov wrote:

> >   git diff --name-status
> >
> >  will show you the modified and deleted files. But since you are using
> >  "-c" to show _all_ cached files, I think only ls-files can do that
> >  (since diff is, obviously, about files with differences).
> 
> Moreover, git diff would not show untracked files while git ls-files
> will include them and label '?'

Yes, but that is somewhat simpler to fix, since we know that they cannot
be part of the "git diff" output. That is, you can just append the "git
ls-files -v -o" output. Actually, since cached files use the 'H' tag
which doesn't conflict with git-diff, and since your goal was to combine
the multiple output anyway, I wonder if something like this would make
you happy:

  (
    git ls-files --exclude-standard -v -c -o &&
    git diff --name-status --cached
  ) |
  perl -e '
    my %h;
    while(<>) {
      chomp;
      my ($status, $name) = split / /, $_, 2;
      $h{$name} .= $status;
    }
    print "$h{$_} $_\n" foreach sort keys(%h);
  '

?

Personally, I find listing every cached file makes the output hard to
read, since any modified ones will be lost in the noise. But that is
what you said you wanted...

-Peff
