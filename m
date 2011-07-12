From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 17:36:07 -0400
Message-ID: <20110712213607.GA12447@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
 <20110712194540.GA21180@sigill.intra.peff.net>
 <20110712210716.GB17322@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:36:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgkcu-0007QS-OU
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab1GLVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 17:36:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab1GLVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 17:36:09 -0400
Received: (qmail 17510 invoked by uid 107); 12 Jul 2011 21:36:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 17:36:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 17:36:07 -0400
Content-Disposition: inline
In-Reply-To: <20110712210716.GB17322@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176984>

On Tue, Jul 12, 2011 at 11:07:16PM +0200, Clemens Buchacher wrote:

> On Tue, Jul 12, 2011 at 03:45:40PM -0400, Jeff King wrote:
> >
> > It has been a long time since I've looked at darcs, but from my
> > recollection, it will only work with specific patch types. That is, it
> > works if B and C are commutative. For text patches that touch the same
> > area, that is not the case. But if "B" were a token-renaming patch, for
> > example, I think it might work.
> 
> If they were commutative, we would not have a problem in git
> either.

Except that git doesn't support many commutative special forms, like
token-renaming patches.

> > Anyway, that is not really relevant to git. I think we decided long ago
> > that being simple and stupid about the content changes (i.e., blob A
> > became blob B) is better in general, even when there are a few corner
> > cases that might have been better off the other way.
> 
> Yes, but that only applies to git merge. When we talk about
> rebasing we are looking at individual patches rather than a single
> global merge. For rebase I think "patch algebra" is very relevant,
> and we have already implemented a simple patch algebra with
> patch-id's.

I can buy that argument, but I think most of the benefit in darcs comes
from annotating your patch as "this is just renaming 'foo' to 'bar'" and
other special patch types. Because the algebraic properties of those
types is more interesting. And what we really don't want in git is
having to put the burden on users of making those annotations (not just
because it's annoying to do, but because when the annotation doesn't
match what's in the blobs, the results would be extremely confusing).

But if you are proposing that we could do run-time detection on those
sorts of patch properties and use the result in making a better rebase,
I don't think that's a bad idea (though I do wonder if the amount of
code will be worth it).

Again, it has been a long time since I've looked at darcs, and I was
never a serious user of it, so everything I say above may be utterly
wrong.

> > I'd be curious to see an example worked out. In my experience, even if
> > something like patch-ids don't match, it's not a big deal for the hunks
> > that do match, because when we get to the actual content merge, we will
> > realize that both sides made the same change to that hunk.  So it's not
> > like you are getting unrelated conflicts; whatever small part of the
> > diff made the patch-id different will be the part where you get the
> > conflict, and the should merge cleanly.
> 
> I am reading that last part as "they should not merge cleanly".

Sorry, it was supposed to be "...and the rest should merge cleanly". But
I think you got my meaning.

> Exactly. The case I am talking about is where the patch-id's are
> different but there are no conflicts. I have worked out an example
> for git and darcs. Below are two scripts to demonstrate. In the
> example, the patch-id is different because upstream changes the
> patch in a way that does not conflict with the original patch. It
> simply adds another change that goes into a different hunk. Git
> fails to merge cleanly because the patch-id's are different. It
> presents the user with an awkward conflict that looks like a
> revert. Darcs, on the other hand, merges cleanly. It recognizes the
> fact that all changes from the original patch are contained
> upstream and do not conflict with the upstream version. The fact
> that more changes are added on top does not bother darcs.

Ah, OK, I see. Let me try to amend what I said earlier to make sure.

In the normal case of applying patch B on top of patch A, it doesn't
matter if we use per-hunk patch-ids or normal patch-ids. Because even if
we decide to actually go through with the merge of B on top of A, any
hunks that _would have_ had their per-hunk patch-ids match will merge
cleanly.

But in the real world, it is about applying patch Z on top of patches
A..Y, where Z has similar hunks to patch N. And then it _does_ make a
difference, because it is about skipping hunks from Z that are already
in N, but will end up applied on top of Y. And what's in Y and what's in
N may be quite different.

Does that sound right?

> Now, one might argue that this is a corner case. But it's actually
> very common. In the example, the patch-id changes because of an
> extra change in a different text area. That is indeed unlikely.
> However, the same problem will occur in a much more common case.
> Let's say we have a patch with 10 hunks. The patch is applied
> upstream, with only one difference in one of the hunks.
> Subsequently, text areas affected by any of the other hunks change
> upstream. When the original patch is rebased on top of that, it
> will conflict with the one hunk that was changed in the upstream
> version of that patch. And that's ok. Git should not decide which
> version is correct. But in addition to that conflict there will
> also be conflicts for all the other hunks, which the upstream patch
> did _not_ modify. And all of those conflicts will look like
> reverts.

Right, that makes sense to me now.

-Peff
