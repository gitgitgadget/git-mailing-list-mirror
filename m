From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Fri, 2 Dec 2011 12:10:17 -0500
Message-ID: <20111202171017.GB23447@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWWcy-00070S-RQ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab1LBRKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 12:10:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39035
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab1LBRKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:10:19 -0500
Received: (qmail 8266 invoked by uid 107); 2 Dec 2011 17:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 12:16:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 12:10:17 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186230>

On Fri, Dec 02, 2011 at 08:56:34AM -0800, Linus Torvalds wrote:

> On Fri, Dec 2, 2011 at 8:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
> >
> >> Maybe we should make "git gc --auto" remove any unreachable object=
s?
> >
> > Wouldn't that mean that any loose commit objects you have lying aro=
und
> > would be removed by the automatic git gc?
> >
> > One feature of git that I personally rely on is that I can liberall=
y
> > move heads around / make commits on detached heads and not have tho=
se
> > commits gc'd unless I explicitly ask for it for a while.
>=20
> Well, with reflogs, you actually do have those objects reachable for
> quite a while (90 days by default).
>=20
> The "unreachable objects" tends to happen when you do fetches without
> ever merging the result or actually remove branches (and/or expiring
> the reflogs early etc). Not from the normal "use 'git reset' and
> friends to move heads around".
>=20
> That said, I do agree that removing loose objects is the much less
> safe approach.

We do remove loose objects that are totally unreferenced, but there is
still a time-delay, because we don't want to prune something like an
in-progress commit operation. The default delay for that is 2 weeks,
which I think is an arbitrary number that was "wow, if your git
operation takes longer than this, you're way too patient".

And in general, it works OK because people don't tend to accumulate mor=
e
than the auto-gc number of objects within a 2 week period. So perhaps
you're just special in your usage patterns.

One solution is just dropping that "2 weeks" down to something smaller,
but still conservative (say, 3 days?).

If you still have the repo in question, what is the date breakdown on
your loose objects?

> Of course, repacking the objects results in problems too: now you've
> entirely lost the age information for that object, so now you cannot
> prune it based on age any more.

When the objects become unreferenced, we eject them from the pack into
loose form again. If they don't become referenced in the 2-week window,
they get pruned then. So yes, you drop the age information, but they do
eventually go away.

-Peff
