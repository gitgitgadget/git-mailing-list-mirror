From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 8 Sep 2011 17:02:17 -0400
Message-ID: <20110908210217.GA32522@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
 <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1oLD-0000pG-Fa
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab1IHXtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:49:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56677
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab1IHXtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:49:00 -0400
Received: (qmail 16838 invoked by uid 107); 8 Sep 2011 21:03:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 17:03:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 17:02:17 -0400
Content-Disposition: inline
In-Reply-To: <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181008>

On Thu, Sep 08, 2011 at 01:48:07PM -0700, Junio C Hamano wrote:

> > I think (1) is actually not all that interesting. The server already has
> > credentials for each user via ssh or http. So it knows who each pusher
> > is already. It can't relay that information cryptographically to a
> > client who fetches later, of course, but we are just talking about
> > whether or not to accept the push at this moment.
> >
> > But if you really did want to do that, it seems like a pre-receive hook
> > would be sufficient.
> 
> I see two flaws in that reasoning. The server's authentication may be
> found not trustworthy for some reason long after commits hit the tree, and
> GPG signature made by the _pusher_ would assert the integrity.

Right, but that is not about (1), but rather about (2). IOW, there are
two times to authenticate: at the moment you take the push, and every
moment thereafter, no matter who you are. But I think we are just
splitting hairs. We both agree that signed pushes are a good thing.

When I said "a pre-receive hook is sufficient", I emphatically _didn't_
mean that the server should sign in the hook, or create a cryptographic
trail starting there. I meant that git doesn't need to carry the code
internally, and that a pre-receive hook can check the push certificate
itself, just as a client would.

BTW, is the name "push certificate" right? It seems like they are not
necessarily about pushing, but about signing "I would like to move ref X
from Y to Z". Is there value to making such signatures locally (i.e.,
not over the git protocol, but such that you could later check the
integrity of what's on the disk cryptographically)? Would it not be
possible to generate this information in one step, and then have a
remote fetch from you, with no pushes at all?

> Also this will open the door to accept push over an unauthenticated
> connection and allowing only signed pushes.

Yes, though a pre-receive hook could do that, too.

> Exactly. That is why the signed push certificate is stored without the
> server doing anything funky, only to annotate the pushed commits in the
> notes tree---the fetchers can peek the notes and verify the GPG signature.
> But not _forcing_ that the push certificate be placed in a notes tree on
> the client side allows different server hosting sites to additionally do
> different things using that data.

Hmm. So you seem to take the approach of:

  1. Client needs only know "I am pushing with a signed cert".

  2. Server can convert that signed cert into other formats as they see
     fit, including breaking the signature out into a notes ref.

  3. Other clients fetch from the server, seeing the notes ref (or not).

But that seems backwards to me. In a decentralized system, the endpoints
are what is important. So the pushing client in 1 should be the one
deciding what other clients see, no? Otherwise, if I care about what's
in the notes tree, I have to care whether I am pulling from kernel.org
or github.com, or whatever. The server stops being dumb storage.

> > The only issue I foresee is one of atomicity.
> 
> The very initial thinking was to create a notes tree commit on the client
> side and push that along with what is pushed, but that approach has an
> inherent flaw of causing unnecessary collisions between two people who are
> pushing to unrelated branches, and that is why I decided to let the server
> side handle it.

Yeah, it is a potential problem, but it just seems wrong to put too much
policy work onto the server. Perhaps it would make more sense to keep
one notes tree per ref, which would also resolve that locking issue?

-Peff
