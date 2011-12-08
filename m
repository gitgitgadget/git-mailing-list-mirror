From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 7 Dec 2011 19:49:31 -0500
Message-ID: <20111208004931.GB23015@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 01:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYSB9-0004mJ-8E
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 01:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab1LHAte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 19:49:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42989
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300Ab1LHAte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 19:49:34 -0500
Received: (qmail 22159 invoked by uid 107); 8 Dec 2011 00:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 19:56:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 19:49:31 -0500
Content-Disposition: inline
In-Reply-To: <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186524>

On Sat, Dec 03, 2011 at 01:42:22PM -0600, Brandon Casey wrote:

> > =C2=A04. "git gc" runs "git repack -Ad", which will eject X from th=
e pack
> > =C2=A0 =C2=A0 into a loose form (because it is not becoming part of=
 the new pack
> > =C2=A0 =C2=A0 we are writing).
>=20
> Actually, it is right here when the newly loosened unreferenced
> objects will be deleted.  Objects ejected from a pack _are_ given the
> timestamp of the pack they were ejected from.  So, if the pack is
> older than two weeks (90 days in your example), then so will be the
> loosened objects, and git prune will delete them when called by git
> gc.

Thanks, I didn't notice that when looking at the code.

> Decreasing gc.pruneExpire as you suggested should make it much less
> likely to run into this problem.

I'd be more comfortable with that solution if we had data on what the
timestamps look like when it actually happens (e.g., an "ls -lR" listin=
g
of a repository that in practice is wanting to auto-gc too often).

> I wonder if it is worth trying to limit how often gc --auto is run to
> not be more often than gc.pruneExpire or something.  If we modified
> the timestamp that is assigned to fetched packs, maybe we could use
> the pack timestamps as an indicator of how recently git gc has run.

I'm worried you run into other corner cases, there. Like a repository
which is generating new, referenced objects at a fast rate (e.g.,
because you're importing something) should trigger auto-gc much sooner
than that, and this rule would prevent it.

-Peff
