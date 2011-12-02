From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Fri, 2 Dec 2011 12:45:46 -0500
Message-ID: <20111202174546.GA24093@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:46:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWXBP-0007A4-6g
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261Ab1LBRpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 12:45:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39061
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258Ab1LBRpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:45:50 -0500
Received: (qmail 8542 invoked by uid 107); 2 Dec 2011 17:52:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 12:52:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 12:45:46 -0500
Content-Disposition: inline
In-Reply-To: <7vobvqoozr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186233>

On Fri, Dec 02, 2011 at 09:35:52AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When the objects become unreferenced, we eject them from the pack into
> > loose form again. If they don't become referenced in the 2-week window,
> > they get pruned then. So yes, you drop the age information, but they do
> > eventually go away.
> 
> If you update gc/repack -A to put them in a separate pack, then you would
> never be able to get rid of them, no? You pack, then eject (which gives
> them a fresher timestamp), then notice that you are within the 2-week window
> and pack them again,...

But we shouldn't be packing totally unreferenced objects. Barring bugs,
the life cycle of such an object should be something like:

  1. Object X is created on branch 'foo'.

  2. Branch 'foo' is deleted, but its commits are still in the HEAD
     reflog, referencing X.

  3. 90 days pass (actually, I think this might be the 30-day
     expire-unreachable time)

  4. "git gc" runs "git repack -Ad", which will eject X from the pack
     into a loose form (because it is not becoming part of the new pack
     we are writing).

  5. Two weeks pass.

  6. "git gc" runs "git prune --expire=2.weeks.ago", which removes the
     object.

"gc" runs between (4) and (6) will not re-pack the object, because it
remains unreferenced.

I think things might be slowed somewhat by "gc --auto", which will not
do a "repack -A" until we have too many packs. So steps (3) and (4) are
really more like "gc runs git-repack without -A" 50 times, and then we
finally run "git repack -A".

-Peff
