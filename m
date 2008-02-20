From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 13:15:14 -0500
Message-ID: <20080220181513.GA16289@sigill.intra.peff.net>
References: <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site> <7vzltwavf9.fsf@gitster.siamese.dyndns.org> <20080220140306.GA6928@sigill.intra.peff.net> <7vk5kz7btw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:16:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtU7-0007gX-Hz
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYBTSPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYBTSPT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:15:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2812 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbYBTSPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:15:17 -0500
Received: (qmail 7363 invoked by uid 111); 20 Feb 2008 18:15:15 -0000
Received: from lawn-128-61-31-98.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.31.98)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Feb 2008 13:15:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 13:15:14 -0500
Content-Disposition: inline
In-Reply-To: <7vk5kz7btw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74528>

On Wed, Feb 20, 2008 at 09:54:35AM -0800, Junio C Hamano wrote:

> > +++ b/builtin-push.c
> > @@ -68,8 +68,7 @@ static int do_push(const char *repo, int flags)
> >  	if (!refspec
> >  		&& !(flags & TRANSPORT_PUSH_ALL)
> >  		&& remote->push_refspec_nr) {
> > -		refspec = remote->push_refspec;
> > -		refspec_nr = remote->push_refspec_nr;
> > +		set_refspecs(remote->push_refspec, remote->push_refspec_nr);
> >  	}
> >  	errs = 0;
> >  	for (i = 0; i < remote->url_nr; i++) {
> 
> Yeah, we are on the same page.  See the patch I sent out last night ;-)

Meaning you will take this patch? (And yes, I think the "+HEAD" patch
you sent is a good fix, regardless of everything else we've talked
about).

> > How are you detecting that the remote is a shared repository?
> 
> I am not.  I only said "... may even be able to" ;-).
> 
> The autodetection is not even the first step to tackle this
> issue anyway.  The "HEAD" magic (or if somebody comes up with a
> better design, that one) comes first, deciding if such an
> autodetection is even a good idea comes next, and then iff we
> decide that it is a good idea finally comes the task of finding
> out how we do so.

Didn't the "HEAD" magic just come? :) Is there some part of that that
you are unhappy with?

> I'd presume that the upload-pack side can internally check "int
> shared_repository" and the protocol extension that conveys that
> information to the other end is easy enough.  As always, dumb
> transports are second class citizens and need their own hacks.

Reasonable.

> > By the core.sharedrepository config option? I use several
> > shared repositories, and I never set that variable; instead
> > ...
> 
> It is _your_ problem that you do not use published interface,
> isn't it?

I would agree with you if core.sharedRepository had ever been introduced
as a signal flag for a particular workflow, and not simply as a way to
set up the umask.

If you want to introduce those semantics to sharedRepository, that is
not unreasonable, but:

  - recognize that you don't automagically turn on this feature for
    repositories using the shared workflow, since they may or may not
    even have this flag enabled

  - recognize that people who _do_ want this new behavior might not want
    the umask side effects (and in fact, those side effects can reduce
    security if the users are in a group with untrusted users)

so I think that a new config option is probably safer, and not
necessarily less likely to work automatically.

That being said, I think this sort of automatic detection should wait at
least one release cycle. Once the behavior is configurable at all, we
can see how people adopt it into their workflows and if there is really
any desire for detection at all.

-Peff
