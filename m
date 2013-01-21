From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Mon, 21 Jan 2013 18:40:02 -0500
Message-ID: <20130121234002.GE17156@sigill.intra.peff.net>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
 <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
 <20130118010638.GA29453@sigill.intra.peff.net>
 <CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQyc-0007QS-GR
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3AUXkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:40:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41826 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab3AUXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:40:05 -0500
Received: (qmail 20752 invoked by uid 107); 21 Jan 2013 23:41:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 18:41:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:40:02 -0500
Content-Disposition: inline
In-Reply-To: <CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214177>

On Thu, Jan 17, 2013 at 09:18:50PM -0600, Chris Rorvick wrote:

> On Thu, Jan 17, 2013 at 7:06 PM, Jeff King <peff@peff.net> wrote:
> > However, if instead of the rule being
> > "blobs on the remote side cannot be replaced", if it becomes "the old
> > value on the remote side must be referenced by what we replace it with",
> > that _is_ something we can calculate reliably on the sending side.
> 
> Interesting.  I would have thought knowing reachability implied having
> the old object in the sending repository.

No, because if you do not have it, then you know it is not reachable
from your refs (or your repository is corrupted). If you do have it, it
_might_ be reachable. For commits, checking is cheap (merge-base) and we
already do it. For trees and blobs, it is much more expensive, as you
have to walk the whole object graph.  While it might be "more correct"
in some sense to say "it's OK to replace a tree with a commit that
points to it", in practice I doubt anyone cares, so you can probably
just punt on those ones and say "no, it's not a fast forward".

> > And
> > that is logically an extension of the fast-forward rule, which is why I
> > suggested placing it with ref_newer (but the latter should probably be
> > extended to not suggest merging if we _know_ it is a non-commit object).
> 
> Sounds great, especially if it is not dependent on the sender actually
> having the old object.  Until this is implemented, though, I don't
> understand what was wrong with doing the checks in the
> is_forwardable() helper function (of course after fixing the
> regression/bug.)

I don't think it is wrong per se; I just think that the check would go
more naturally where we are checking whether the object does indeed
fast-forward. Because is_forwardable in some cases must say "I don't
know; I don't have the object to check its type, so maybe it is
forwardable, and maybe it is not". Whereas when we do the actual
reachability check, we can say definitely "this is not reachable because
I don't have it, or this is not reachable because it is a commit and I
checked, or this might be reachable but I don't care to check because it
has a funny type".

I think looking at it as the latter makes it more obvious how to handle
the "maybe" situation (e.g., the bug in is_forwardable was hard to see).

Anyway, I do not care that much where it goes. To me, the important
thing is the error message. I do think the error "already exists" is a
reasonable one for refs/tags (we do not allow non-force pushes of
existing tags), but not necessarily for other cases, like trying to push
a blob over a blob. The problem there is not "already exists" but rather
"a blob is not something that can fast-forward". Using the existing
REJECT_NONFASTFORWARD is insufficient (because later code will recommend
pull-then-push, which is wrong). So I'd be in favor of creating a new
error status for it.

-Peff
