From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] remove the impression of unexpectedness when access is
	denied
Date: Thu, 14 Jun 2012 22:37:14 +0200
Message-ID: <20120614203712.GA51783@book.hvoigt.net>
References: <20120610182310.GB2427@book.hvoigt.net> <20120611190207.GA20889@sigill.intra.peff.net> <20120614071259.GA51076@book.hvoigt.net> <7v395xg6oh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 22:37:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfGnF-0003nA-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 22:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491Ab2FNUhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 16:37:21 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:45322 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab2FNUhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 16:37:21 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SfGn4-0005Xm-PK; Thu, 14 Jun 2012 22:37:14 +0200
Content-Disposition: inline
In-Reply-To: <7v395xg6oh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200032>

Hi,

On Thu, Jun 14, 2012 at 10:11:10AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > diff --git a/connect.c b/connect.c
> > index 912cdde..19e73d5 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -56,6 +56,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
> >  			      unsigned int flags,
> >  			      struct extra_have_objects *extra_have)
> >  {
> > +	int got_at_least_one_head = 0;
> > +
> >  	*list = NULL;
> >  	for (;;) {
> >  		struct ref *ref;
> > @@ -64,7 +66,14 @@ struct ref **get_remote_heads(int in, struct ref **list,
> >  		char *name;
> >  		int len, name_len;
> >  
> > -		len = packet_read_line(in, buffer, sizeof(buffer));
> > +		len = packet_read_line(in, buffer, sizeof(buffer), 1);
> > +		if (len < 0) {
> > +			if (got_at_least_one_head)
> > +				die("The remote end hung up unexpectedly");
> > +			else
> > +				die("Could not read remote heads");
> > +		}
> 
> I do not think it is particularly interesting to know we have (or
> haven't) read one packet before we got an error. It would be an
> improvement if the message lets the user know at what stage of the
> exchange the remote threw you a garbage, but using the same "The
> remote end hung up unexpectedly" as all the other packet_read_line()
> errors show makes it less useful.

Well I thought about the case of "access denied" or "no repository
here". I wanted to distinguish between this quite typical situation
where you did not get anything and the situation when you already got
something from the server. AFAIK its not so typical to hang up after you
got the first ref or is it?

So maybe something along the lines:

	if (got_at_least_one_head)
		die("The remote end hung up upon initial contact");
	else
		die("Could not read from remote repository.\n"
		    "\nPlease make sure you have the correct access"
		    "rights and the repository exists.");

to give the user some suggestion what might have gone wrong?

If I understand the loop correctly it reads one remote head per
iteration doesn't it?

> It seems that all callers other than this one after this patch
> behave identically as before like this patch. It would be far more
> preferable to introduce a new function that does not die on errors
> (including but not necessarily limited to short read situation you
> are interested in this patch), and update this caller that wants to
> handle these error cases to call that new function.  Perhaps
> 
> 	len = packet_read(in, buffer, sizeof(buffer));
> 
> that returns negative error numbers when it sees an error, with
> 
> 	#define PKTREAD_UNKNOWN_ERROR (-1)
>         #define PKTREAD_SHORT_READ (-2)
>         ...
> 
> and then over time we should consider converting remaining callers
> of packet_read_line() to packet_read().

Yes I agree thats what I realized to late after sending the patch. Will
implement that in the next iteration of my patch.

Cheers Heiko
