From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Fri, 3 Oct 2014 20:09:02 -0400
Message-ID: <20141004000901.GB17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003203931.GM16293@peff.net>
 <xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaCuO-0001CJ-Ir
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261AbaJDAJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 20:09:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:54962 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757971AbaJDAJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:09:04 -0400
Received: (qmail 12194 invoked by uid 102); 4 Oct 2014 00:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:09:04 -0500
Received: (qmail 16461 invoked by uid 107); 4 Oct 2014 00:09:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:09:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:09:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257882>

On Fri, Oct 03, 2014 at 02:47:57PM -0700, Junio C Hamano wrote:

> Sorry but this part is beyond a simple panda brain.

I probably didn't explain it very well. I found it rather confusing to
reason about. Let's see if we can go through it together.

> I can understand this
> 
> 	If we have an object, even if it is unreachable, we
> 	should have its referent.
>         
> as a description of the desired behaviour.  If we have a tree that
> is unreachable, we must make sure that we do not discard blobs that
> are reachable from that tree, or we would end up corrupting our
> repository if we ever allow that tree to become reachable from our
> refs later.

Yes, exactly.

> >   - if we are creating new objects, then we cannot create
> >     the parent object without having the child
> 
> We cannot create the parent (e.g. "tree") without having the child
> (e.g. "blob that is referred to by the tree we are creating").
> So this bullet point is repeating the same thing?

Sort of. The first statement "if we have an object, we should have its
referent" is a desired state. The bullet points are trying to reason
about the _changes_ in state, and argue that there are no state changes
that take us from a valid state to an invalid one.

There are two actions that affect the state of the object database:
adding objects and removing objects.

We cannot go from a valid state to an invalid state by adding objects,
because we cannot create the parent without having the child. That is
already the case before this patch (though as noted, you can "cheat"
if you know the sha1 from another repository and bypass git's safety
checks, but I do not think that is a case worth worrying about).

> >   - and if we are pruning objects, will not prune the child
> >     if we are keeping the parent
> 
> We will not prune "blob" that are reachable from a "tree" that we
> are not yet ready to prune.  So this again is repeating the same
> thing?

This is the other action. When removing objects, we will keep the child
along with the parent, and therefore we cannot move to an invalid state.
That's the part that this patch does.

> With this patch applied, the system will not prune unreachable old
> objects that are reachable from a recent object (the recent object
> itself may or may not be reachable but that does not make any
> difference).  And that is sufficient to ensure the integrity of the
> repository even if you allow new objects to be created reusing any
> of these unreachable objects that are left behind by prune, because
> the reachability check done during prune (with this patch applied)
> makes sure any object left in the repository can safely be used as a
> starting point of connectivity traversal.

Yes, exactly.

> Ok, I think I got it now, but then do we still need to utime(2) the
> loose object files for unreachable objects that are referenced by
> a recent object (which is done in a later patch), or is that purely
> an optimization for the next round of gc where you would have more
> recent objects (i.e. you do not have to traverse to find out an old
> one is reachable from a new one, as there will be fewer old ones)?

No, we don't need to utime() the loose objects. As long as there is a
recently-written object that refers to them, they are considered worth
keeping.

The later patch that calls utime() on objects is really about defeating
the write_sha1_file optimization. That is, you might _think_ you have
written a recent object that refers to other objects, but the sha1-file
code silently turned it into a noop.

Does that make more sense?

-Peff
