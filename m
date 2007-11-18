From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 21:39:43 -0500
Message-ID: <20071118023942.GA4560@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125602.GC23186@sigill.intra.peff.net> <7vir40z7nm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 03:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ita4x-0008Ho-0S
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 03:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbXKRCjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 21:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbXKRCjt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 21:39:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4759 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbXKRCjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 21:39:48 -0500
Received: (qmail 7311 invoked by uid 111); 18 Nov 2007 02:39:45 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 21:39:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 21:39:43 -0500
Content-Disposition: inline
In-Reply-To: <7vir40z7nm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65334>

On Sat, Nov 17, 2007 at 05:03:57PM -0800, Junio C Hamano wrote:

> > +	for (ref = refs; ref; ref = ref->next) {
> > +		const char *msg;
> > +		if (prefixcmp(line, ref->name))
> > +			continue;
> 
> It probably would not matter for sane repositories, but with
> thousands of refs, strlen() and prefixcmp() may start to hurt:

It is actually _just_ prefixcmp. Or do you mean the strlen we call in
prefixcmp? If so, I think the right solution is to make prefixcmp
faster.  :)

> but the "hint" optimization probably make the above
> micro-optimization irrelevant.

Agreed.

> It is preferred to have a multi-line comment like this:
> 
> 	/*
>          * A return value of -1 ...
> 	 * ...
> 	 * ... couldn't even get that far.
> 	 */

OK. Since it is already in next, do you want a style fixup patch?

> Before receive_status() is called, can the refs already have the
> error status and string set?

Nothing else sets the string, so the latter is not possible (perhaps it
should be "remote_error" for clarity). It is less clear that we are not
overwriting another status; however, if you look at do_send_pack, we
only actually send the remote refs that are getting REF_STATUS_OK.

A broken or malicious remote could change the push status of an
arbitrary ref to rejection, but I don't really see the point. We could
explicitly check that we are changing from OK to REMOTE_REJECTED in
set_ref_error.

> >  	if (expect_status_report) {
> > -		if (receive_status(in))
> > +		ret = receive_status(in, remote_refs);
> > +		if (ret == -2)
> >  			return -1;
> 
> Hmm.  When we did not receive status, we cannot tell what
> succeeded or failed, but what we _can_ tell the user is which
> refs we attempted to push.  I wonder if robbing that information
> from the user with this "return -1" is a good idea.  Perhaps we
> would instead want to set the status of all the refs to error
> and call print_push_status() anyway?  I dunno.

That is a reasonable behavior (although they have already seen an
"error: " message, I think). We might also consider returning something
besides "-1" to differentiate "ok, but some refs failed" from "terribly
broken". The old code used to use "-2" and "-4", but I checked and all
of the error checking paths seemed to end up as a boolean.

I can work up a patch if there is consensus.

-Peff
