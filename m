From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 08:09:00 -0800
Message-ID: <20090128160900.GJ1321@spearce.org>
References: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 17:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSCzp-0004R8-Tu
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbZA1QJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 11:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZA1QJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:09:09 -0500
Received: from george.spearce.org ([209.20.77.23]:46397 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZA1QJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 11:09:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 143EA38210; Wed, 28 Jan 2009 16:09:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107544>

Junio C Hamano <gitster@pobox.com> wrote:
>=20
> I've been toying with an idea for an alternative solution, and need
> somebody competent to bounce it around with.

Heh, then we need to wait for Nico... :-)
=20
> pack-objects ends up doing eventually
>=20
>     rev-list --objects $send1 $send2 $send3 ... --not $have1 $have2 .=
=2E.
>=20
> which lists commits and associated objects reachable from $sendN,
> excluding the ones that are reachable from $haveN.
>=20
> The tentative solution Bj=F6rn Steinbrink and I came up with excludes
> missing commit from $haveN to avoid rev-list machinery to barf, but i=
t
> violates the ref-object contract as I explained to Bj=F6rn in my othe=
r
> message.

Oh, OK, I now _finally_ understand what you were trying to say
by the reachability thing.  I kept scratching my head trying to
understand you, and was going to say something stupid on list;
but waited because I just didn't get what the big deal was...

Its the crash in rev-list that you were worried about.

> Checking if each commit is reachable from any of the refs is quite
> expensive, and it would especially be so if it is done once per ".hav=
e"
> and real ref we receive from the other end.

Yup.
=20
> An alternative is to realize that rev-list traversal already does
> something quite similar to what is needed to prove if these ".have"s =
are
> reachable from refs when listing the reachable objects.  This computa=
tion
> is what it needs to do anyway, so if we teach rev-list to ignore miss=
ing
> or broken chain while traversing negative refs, we do not have to inc=
ur
> any overhead over existing code.

EXACTLY.

JGit does this.

The functional equivilant of rev-list in JGit will by default
throw an exception if any object is missing when we try to walk it.
That includes things we've painted UNINTERESTING, as it is a sure
sign of repository corruption.

However; our equivilant of pack-objects can toggle what you are
calling "ignore-missing-negative" when it starts enumeration.
Any UNINTERESTING object which is missing or failed to parse is
simply tossed aside.  Yes, the pack may be larger than necessary
like in Peff's example of:

       Q-R
      /
  D--E
      \
       A-C

If the other side has C reachable, we are pushing R, and we have
C but are missing A, we'll "over push" D-E, but its still a clean
and valid push.  Its no worse than we were before the ".have" came
about, or if C hadn't been downloaded locally at all.  (Of course
your tell-me-more extension would help fix this over-push, but lets
not get off topic.)

IMHO, this corruption of A is harmless if C isn't reachable.

It isn't really local corruption unless C was reachable by a ref.
But we don't tend to see much corruption like that, and if it did
exist, it would show up during *other* operations that access a
larger set of local refs, such as "git gc".

> I have a mild suspicion that it may even be the right thing to ignore=
 them
> unconditionally, and it might even match the intention of Linus's ori=
ginal
> code.  That would make many hunks in this patch much simpler.

I don't think its right to ignore broken UNINTERESTING chains all
of the time.  Today we would see fatal errors if I asked for

  git log R ^C

and A was missing, but R and C are both local refs.  I still want
to see that fatal error.  Its a local corruption that should be
raised quickly to the user.  In fact by A missing we'd compute the
wrong result and produce D-E too, which is wrong.

IMHO, the *only* time this missing uninteresting A is safe is
during send-pack, upload-pack, or bundle creation, where you are
bringing the other side up to R by transferring any amount of data
necessary to reach that goal.  Which is why JGit enables this.
(Though at the API level we do let the caller flag if they want
the error to be fatal instead, but AFAIK nobody sets it for "fatal".)

=46WIW, Linus' most recent message on this thread about hoisting the
UNINTERESTING test up sooner makes sense too.
=20
> The evidences behind this suspicion are found in a handful of places =
in
> revision.c.  mark_blob_uninteresting() does not complain if the calle=
r
> fails to find the blob.  mark_tree_uninteresting() does not, either.
> mark_parents_uninteresting() does not, either, and it even has a comm=
ent
> that strongly suggests the original intention was not to care about
> missing UNINTERESTING objects.

That feels wrong to me... given the "git log R ^C" example I give above=
=2E
=20
--=20
Shawn.
