From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 9 Sep 2011 11:34:41 -0400
Message-ID: <20110909153441.GB28480@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
 <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
 <20110908210217.GA32522@sigill.intra.peff.net>
 <7v7h5iwub9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:34:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R236P-0007rc-1n
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab1IIPeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:34:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50961
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab1IIPen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:34:43 -0400
Received: (qmail 31280 invoked by uid 107); 9 Sep 2011 15:35:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 11:35:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 11:34:41 -0400
Content-Disposition: inline
In-Reply-To: <7v7h5iwub9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181079>

On Thu, Sep 08, 2011 at 03:19:54PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, it is a potential problem, but it just seems wrong to put too much
> > policy work onto the server.
> 
> My take on it is somewhat different. The only thing in the end result we
> want to see is that the pushed commits are annotated with GPG signatures
> in the notes tree, and there is no reason for us to cast in stone that
> there has to be any significance in the commit history of the notes tree.

Hmm. Is order really irrelevant? If you push a commit to master, moving
it from X to Y, then push-rewind it back to X, then push a new commit Z,
how do I cryptographically determine the correct final state of master?

I'll see two push-certs, one going X..Y and one X..Z. They'll have
timestamps, which can be used for ordering. But what if the first and
third actions above are done by different people. Now you're trusting
that their clocks are synced to order them properly.

Note that simply keeping an unsigned but ordered notes history doesn't
solve this problem, either; you'd probably want a parent pointer in your
push cert saying "and this is the previous push cert I am based on".

And maybe this is a use case we don't care about. Maybe it's enough for
the push-cert to say "at some point in time, I thought it was a good
idea to push these commits into master; signed, me".

But I'm not really clear on exactly what the security goals are. The
series you sent looks interesting, but I haven't seen the verification
side of these signatures. What are they going to be used for? What
guarantees are we attempting to provide? For that matter, what is our
threat model? What are attackers capable of?

> In a busy hosting site that has many branches being pushed simultaneously,
> it is entirely plausible that the server side may just want to store each
> received push certificate in a new flat file in a filesystem, and have
> asynchronous process sweep the new certificates to update the notes tree,
> possibly creating a single notes tree commit that records updates by
> multiple pushes, for performance purposes, in its implementation of
> record_signed_push() in receive-pack.

OK, I see. It is not "the server can do whatever it likes with the
information" as much as "the server can do whatever it likes, but at the
very least should eventually create a notes tree of a given form".

-Peff
