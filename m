From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 19:13:14 -0500
Message-ID: <20071118001312.GB4000@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125426.GA23186@sigill.intra.peff.net> <Pine.LNX.4.64.0711171217200.12193@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItXn5-0003uT-5p
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXKRANS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbXKRANS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:13:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4426 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbXKRANR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:13:17 -0500
Received: (qmail 6732 invoked by uid 111); 18 Nov 2007 00:13:15 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 19:13:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 19:13:14 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711171217200.12193@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65323>

On Sat, Nov 17, 2007 at 01:05:35PM -0500, Daniel Barkalow wrote:

> > +static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
> 
> Isn't "from" always "to->peer_ref"? It'd be nice to make this function 
> unable to print something different from what we actually did. (Actually 
> it might be "to->deletion ? NULL : to->peer_ref", but that would also be 
> better to have as an explicit feature of how you display "to", rather than 
> implicit in the set of callers.

Yes, I also considered changing "from" to "show peer" which might have
been nicer. I am not opposed to such a cleanup, but again, not sure if
it worth it now that we are merged.

> > +static const char *status_abbrev(unsigned char sha1[20])
> > +{
> > +	const char *abbrev;
> > +	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
> > +	return abbrev ? abbrev : sha1_to_hex(sha1);
> > +}
> 
> Maybe we should have a find_unique_abbrev()-like function that doesn't 
> mind if the requested object doesn't exist?

I agree, though I don't feel qualified to comment on what other places
that should be used (I was a bit surprised to find out that
find_unique_abbrev ever returned NULL, but changing the semantics at
this point is probably going to cause some subtle bug).

> > +		char quickref[83];
> Shouldn't this be 40 + 3 + 40 + 1?

Oops, yes. I think it should be hard to trigger (both commits would have
to either not be in your db, or not be unique to 40 digits). But clearly
it should be fixed, and it looks like Junio did.

It was a stupid cut-and-paste from Nicolas' fetch code, but it looks
like he correctly allocates 84 bytes for the "..." case.

> > +		char type;
> > +		const char *msg;
> > +
> > +		strcpy(quickref, status_abbrev(ref->old_sha1));
> > +		if (ref->nonfastforward) {
> > +			strcat(quickref, "...");
> > +			type = '+';
> > +			msg = " (forced update)";
> > +		}
> > +		else {
> 
> Coding style, IIRC.

Sorry, I don't see the style nit you're mentioning here.

-Peff
