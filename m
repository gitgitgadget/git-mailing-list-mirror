From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 12:59:42 -0400
Message-ID: <20130520165942.GB27788@sigill.intra.peff.net>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
 <CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
 <7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 18:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeTRB-0007Hg-4z
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 18:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab3ETQ7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 12:59:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:59896 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255Ab3ETQ7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 12:59:44 -0400
Received: (qmail 27355 invoked by uid 102); 20 May 2013 17:00:17 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 May 2013 12:00:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2013 12:59:42 -0400
Content-Disposition: inline
In-Reply-To: <7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224963>

On Mon, May 20, 2013 at 09:37:30AM -0700, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > For server-class installations we need ref storage that can be read
> > (and updated?) atomically, and the current system of loose + packed
> > files won't work since reading (and updating) more than a single file
> > is not an atomic operation. Trivially, one could resolve this by
> > dropping loose refs, and always using a single packed-refs file, but
> > that would make it prohibitively expensive to update refs (the entire
> > packed-refs file must be rewritten for every update).
> >
> > Now, observe that we don't have these race conditions in the object
> > database, because it is an add-only immutable data store.
> >
> > What if we stored the refs as a tree object in the object database,
> > referenced by a single (loose) ref?
> 
> What is the cost of updating a single branch with that scheme?

Yeah, I had the same thoughts as you here; I don't think this is really
much better than updating a single packed-refs file. You may only
have to touch log(N) of the entries to update the trees along the path
to your ref (assuming you have a bushy refs/ tree; in practice, of
course, you have a lot of entries in refs/heads/, so you do not quite
get log behavior). So algorithmically it may be slightly better, but you
pay a much higher constant, in that you are creating many tree objects
along the path (and reading them on lookup).

But more importantly, it introduces contention between two unrelated
refs that are being updated. Even if we reconcile the differences
automatically (e.g., with a "merge-and-retry" strategy), that is going
to be a serious performance regression for a busy repository, as we
repeatedly try to reconcile the serialized updates to the refs/ root
tree.

Any transactional solution needs to have the equivalent of ref-level
locking (i.e., row-level locking in a relational setting). It is OK for
two simultaneous updates to different rows to happen in random order; we
don't care about that level of atomicity. The important thing is that
the _readers_ see transactions in consistent order; if we know that
update B started after update A finished, then we must never see update
A without update B reflected. And I think that is more or less a solved
problem in the database world.

That is what prevents:

  git update-ref A B
  git update-ref -d B

from creating a view where the reader sees neither A nor B (which is
what can happen with the current filesystem view).

-Peff
