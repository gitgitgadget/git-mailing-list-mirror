From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 02:27:04 -0700
Message-ID: <20060515092704.GB6855@localdomain>
References: <1147660345772-git-send-email-normalperson@yhbt.net> <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Greg KH <greg@kroah.com>, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon May 15 11:27:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZM8-0006fH-FO
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWEOJ1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 05:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEOJ1I
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:27:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:3235 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751442AbWEOJ1H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 05:27:07 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C50D57DC005;
	Mon, 15 May 2006 02:27:04 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 02:27:04 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20036>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This should make local mailing possible for machines without
> > a connection to an SMTP server.
> 
> Which is a good thing, but
> 
> > It'll default to using /usr/sbin/sendmail or /usr/lib/sendmail
> > if no SMTP server is specified (the default).  If it can't find
> > either of those paths, it'll fall back to connecting to an SMTP
> > server on localhost.
> 
> I do not know if it is OK to change the default to first prefer
> local MDA executable and then "localhost".  That is, ...
> 
> > @@ -179,8 +180,14 @@ if (!defined $initial_reply_to && $promp
> >  	$initial_reply_to =~ s/(^\s+|\s+$)//g;
> >  }
> >  
> > -if (!defined $smtp_server) {
> > -	$smtp_server = "localhost";
> > +if (!$smtp_server) {
> > +	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
> > +		if (-x $_) {
> > +			$smtp_server = $_;
> > +			last;
> > +		}
> > +	}
> > +	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
> >  }
> >  
> >  if ($compose) {
> 
> Without this hunk, people who did not specify --smtp-server=host
> could get away with having anything that listens to 25/tcp on
> the localhost that is not either of the above two paths; now
> they have to explicitly say --smtp-server=localhost to defeat
> what this hunk does.  I do not know if it is a big deal, though.

I believe this is what Martin wanted.  I think it's a good idea since
sendmail binaries tend to be more flexible, but I'm ok with it either
way.

Of course, Greg and Ryan were the original authors of this, so I'd
like their take on it, too.

> > +	if ($smtp_server =~ m#^/#) {
> 
> I like this if(){}else{} here, but have a feeling that the
> logging part should be placed outside it to be shared.

Cleaned that up a bit, patch coming.  Also removed the Port: printout
completely, as it's rather redundant (see below).

> While we are at it, we might want to enhance $smtp_server parsing
> to take host:port notation so that people can use message
> submission port 587/tcp (RFC 4409) instead.

This already works, IO::Socket::INET (behind Net::SMTP) takes care of
it :)

-- 
Eric Wong
