From: Jeff King <peff@peff.net>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Tue, 21 Aug 2012 04:27:19 -0400
Message-ID: <20120821082719.GA13252@sigill.intra.peff.net>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mhagger@alum.mit.edu,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 10:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3joD-00050F-44
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 10:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab2HUI10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 04:27:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43575 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037Ab2HUI1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 04:27:23 -0400
Received: (qmail 29643 invoked by uid 107); 21 Aug 2012 08:27:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 04:27:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 04:27:19 -0400
Content-Disposition: inline
In-Reply-To: <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203954>

On Sat, Aug 18, 2012 at 01:39:41PM -0700, Junio C Hamano wrote:

> mhagger@alum.mit.edu writes:
> 
> > Given that a flag day would anyway be required to add a d/f-tolerant
> > system, I could live with a separate "graveyard" namespace as
> > originally proposed by Jeff.
> >
> > However, I still think that as long as we are making a jump, we could
> > try to land closer to the ultimate destination.
> 
> Do we _know_ already what the "ultimate destination" looks like?  
> 
> If the answer is yes, then I agree, but otherwise, I doubt it is a
> good idea to introduce unnecessary complexity to the system that may
> have to be ripped out and redone.
> 
> I didn't get the impression that we know the "ultimate destination"
> from the previous discussion, especially if we discount the tangent
> around "having next and next/foo at the same time" which was on
> nobody's wish, but I may be misremembering things.

Sorry for the slow response on this topic; I was traveling all last week
and am still catching up with emails.

I don't think we know what the ultimate destination looks like. If I had
to choose, it would probably be something like:

  refs/heads/next.ref
  refs/heads/next/foo.ref

which is easy to read and manipulate. But this is not compatible with
the current system, because:

  1. It cannot use ".ref", as that is allowed in ref names currently.

  2. This can't co-exist with existing, non-tweaked refs, since
     "refs/heads/next" would still conflict (you'd have to instead do
     "refs/heads.dir/next.dir/foo".

But since making a change like this would involve bumping the
repositoryformatversion flag _anyway_, so at that point we don't really
have to care about compatibility, and we are free to design what looks
good.

So in other words, I do not think any ultimate destination that I find
palatable would be achievable without making the full format jump
anyway. If all things were equal, I'd say there is no reason not to get
as close as we can. But I find some of the proposals significantly less
readable (in particular, the directory-munging is IMHO much harder to
read). And it is not as if it is buying us anything; you still have to
make a magic translation between a dead log and a live one.

Another option I've considered is simply holding back the graveyard
topic, working on the d/f tolerant storage, and then implementing the
graveyards on top (which is basically free at that point). But as you
note, it is not really a commonly-requested feature. If it were easy,
I'd say let's do it. But the idea of bumping repositoryformatversion for
the first time in git's history just to add a feature nobody wants is
not very appealing to me.

-Peff
