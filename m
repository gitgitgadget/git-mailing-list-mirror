From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 09:43:25 -0800
Message-ID: <20130116174325.GA27525@sigill.intra.peff.net>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <20130116160131.GB22400@sigill.intra.peff.net>
 <7vfw21xde5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Horn <max@quendi.de>, Chris Rorvick <chris@rorvick.com>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvX1j-0007cP-5F
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab3APRnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:43:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35368 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab3APRna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:43:30 -0500
Received: (qmail 13624 invoked by uid 107); 16 Jan 2013 17:44:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 12:44:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 09:43:25 -0800
Content-Disposition: inline
In-Reply-To: <7vfw21xde5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213778>

On Wed, Jan 16, 2013 at 09:10:10AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I.e., we trigger the "!o" branch after the parse_object in your example.
> 
> Heh, I didn't see this message until now (gmane seems to be lagging
> a bit).

I think it is vger lagging, actually.

> I am very tempted to do this.
> 
>  * Remove unnecessary not_forwardable from "struct ref"; it is only
>    used inside set_ref_status_for_push();
> 
>  * "refs/tags/" is the only hierarchy that cannot be replaced
>    without --force;

Agreed.

>  * Remove the misguided attempt to force that everything that
>    updates an existing ref has to be a commit outside "refs/tags/"
>    hierarchy.  This code does not know what kind of objects the user
>    wants to place in "refs/frotz/" hierarchy it knows nothing about.

I agree with what your patch does, but my thinking is a bit different.

My original suggestion with respect to object types was that the rule
for --force should be "do not ever lose any objects without --force". So
a fast-forward is OK, as the new objects reference the old. A non-fast
forward is not, because objects become unreferenced. Replacing a tag
object is not OK, even if it points to the same commit, as you are
losing the old tag object (replacing an object with a tag that points to
the original object or its descendent is OK in theory, though I doubt it
is common enough to worry about).

I think that is a reasonable rule that could be applied across all parts
of the namespace hierarchy. And it could be applied by the client,
because all you need to know is whether ref->old_sha1 is reachable from
ref->new_sha1.

But it is somewhat orthogonal to the "already exists" idea, and checking
refs/tags/. Those ideas are about enforcing sane rules on the tag
hierarchy. My rule is a safety valve that is meant to extend the idea of
"is fast-forwardable" to non-commit object types. If we do it at all, it
should be part of the fast-forward check (e.g., as part of ref_newer).

The current code conflates the two under the "already exists" condition,
which is just wrong.  I think the best thing at this point is to split
the two ideas apart, keep the refs/tags check (and translate it to
"already exists" in the UI, as we do), and table the safety valve. I am
not even sure if it is something that is useful, and it can come later
if we decide it is.

> I feel moderately strongly about the last point.  Defining special
> semantics for one hierarchy (e.g. "refs/tags/") and implementing a
> policy for enforcement is one thing, but a random policy that
> depends on object type that applies globally is simply insane.  The
> user may want to do "refs/tested/" hierarchy that is meant to hold
> references to commit, with one annotated tag "refs/tested/latest"
> that points at the "latest tested version" with some commentary, and
> maintain the latter by keep pushing to it.  If that is the semantics
> the user wanted to ahve in the "refs/tested/" hierarchy, it is not
> reasonable to require --force for such a workflow.  The user knows
> better than Git in such a case.

I see what you are saying, but I think the ship has already sailed to
some degree. We already implement the non-fast-forward check everywhere,
and I cannot have a "refs/tested" hierarchy that pushes arbitrary
commits without regard to their history. If I have such a hierarchy, I
have to use "--force" (or more likely, mark the refspec with "+").

In my mind, the object-type checking is just making that fast-forward
check more thorough (i.e., extending it to non-commit objects).

>  cache.h               |  1 -
>  remote.c              | 24 +-----------------------
>  t/t5516-fetch-push.sh | 21 ---------------------
>  3 files changed, 1 insertion(+), 45 deletions(-)

The patch itself looks fine to me. Whether we agree on the fast-forward
object-type checking or not, it is the correct first step to take in
either case.

-Peff
