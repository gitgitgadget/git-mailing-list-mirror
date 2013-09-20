From: Jeff King <peff@peff.net>
Subject: Re: breakage in revision traversal with pathspec
Date: Fri, 20 Sep 2013 01:11:07 -0400
Message-ID: <20130920051107.GA17609@sigill.intra.peff.net>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
 <522F8ED2.9000408@bracey.fi>
 <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
 <5230AD23.2050009@bracey.fi>
 <20130911182444.GD4326@google.com>
 <5230C6E3.3080406@bracey.fi>
 <xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
 <xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
 <20130920033541.GC15101@sigill.intra.peff.net>
 <xmqqioxwqec0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Bracey <kevin@bracey.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 07:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMszy-0008Kl-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 07:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab3ITFLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 01:11:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:41739 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3ITFLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 01:11:18 -0400
Received: (qmail 27714 invoked by uid 102); 20 Sep 2013 05:11:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Sep 2013 00:11:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Sep 2013 01:11:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioxwqec0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235058>

On Thu, Sep 19, 2013 at 09:58:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One question, though. With your patch, if I do "tag1..tag2", I get both
> > the tags and the peeled commits in the pending object list. Whereas with
> > "^tag1 tag2", we put only the tags into the list, and we expect the
> > traversal machinery to peel them later. I cannot off-hand think of a
> > reason this difference should be a problem, but I am wondering if there
> > is some code path that does not traverse, but just looks at pending
> > objects, that might care.
> 
> Did I really do that?
> 
> I thought that the original was pushing peeled tag1^0 and tag2^0
> (and nothing else) for "tag1..tag2", and the intent of the patch was
> to see if "a" (which is "tag1^0" in this case) has the same object
> name as the object originally given on the side of the dots
> (i.e. "tag1").  If they differ, that means "a" is the peeled object,
> and instead use the original "tag1" for "a_obj" that is pushed into
> the pending (and if they are the same, "a_obj" is just "&a->object",
> the object itself).  The same for "b", "tag2" and "b_obj".  So at
> least I didn't mean to push four objects into the pending list
> before prepare_revision_walk() kicks in.
> 
> Perhaps I missed something?

Hrm, no, it is me misreading the diff.

My original question was going to be: why bother peeling at all if we
are just going to push the outer objects, anyway?

And after staring at it, I somehow convinced myself that the answer was
that you were pushing both. But that is not the case. Sorry for the
noise.

The other reason I considered is that we want to make sure they do peel
to commits. I do not think that is technically required for "A..B",
which can operate on non-commits. But it is for "A...B", and I do not
see any advantage in loosening "A..B" for the non-commit case. It would
just complicate the code.

> Now, when prepare_revision_walk() picks up objects from the pending
> list, they are fed to handle_commit(), and these two tags will be
> peeled and their commits are returned to be queued in revs->commits
> linked list, while the tags themselves are sent to the pending list
> to be emitted in "--objects" output. But that should be the same
> between "tag1..tag2" and "^tag1 tag2".

Yes, I was specifically concerned about sites that did not call
prepare_revision_walk(), but since the state is the same for both cases,
it's a non-issue.

> it").  But I do not think any code just tries to grab an object
> using a random object name outside the revision traversal and decide
> to do things that results in semantically different behaviour if the
> resulting object has (or has not) already been parsed.

Yeah, I think any code relying on that would be insane, from a
modularity perspective. The caching of parsed object state is an
optimization, and callers have no business making assumptions about it.
Otherwise they are fragile with respect to a previous traversal being
added in the same in-memory process.

So I think your patch is doing the right thing, and my concern was just
from mis-reading. Again, sorry for the confusion.

-Peff
