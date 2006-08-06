From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: GPF in index-pack
Date: Sun, 6 Aug 2006 17:46:48 +0400
Message-ID: <20060806174648.c8cc3b44.vsu@altlinux.ru>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
	<9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
	<20060806024858.GC20565@spearce.org>
	<9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com>
	<20060806033222.GD20565@spearce.org>
	<9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
	<20060806040848.GF20565@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__6_Aug_2006_17_46_48_+0400_De99cDpC68FQpO_o"
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 15:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9iyb-0001zh-2K
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 15:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWHFNrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 09:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWHFNrU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 09:47:20 -0400
Received: from master.altlinux.org ([62.118.250.235]:58641 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750795AbWHFNrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 09:47:19 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 0853DE3242; Sun,  6 Aug 2006 17:47:12 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id 29892E56EF1; Sun,  6 Aug 2006 17:46:50 +0400 (MSD)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20060806040848.GF20565@spearce.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24976>

--Signature=_Sun__6_Aug_2006_17_46_48_+0400_De99cDpC68FQpO_o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Aug 2006 00:08:48 -0400 Shawn Pearce wrote:

> Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> > >Jon Smirl <jonsmirl@gmail.com> wrote:
[...]
> > >> Why does resolve_delta in index-pack.c need to be recursive? Is there
> > >> a better way to code that routine? If it mmaps the file that uses 1GB
> > >> address space, why does it need another 1.5GB to build an index?
> > >
> > >Probably the easiest way to code the routine.  Delta depth is
> > >bounded; in the fast-import.c that I sent out last night I hardcoded
> > >it to 10, which is (I believe) the default for GIT.  So long as that
> > >routine is recursive only along a single delta chain the recursion
> > >depth won't be very high and shouldn't be the problem.
> >=20
> > When I put index-pack in gdb at the seg fault, resolve_delta had
> > recursed more than 20,000 times. I stopped looking after that.
>=20
> Ouch.  I'm not familiar with this code, but looking at right now its
> also not entirely obviously what its recursing for.  Plus dinner
> is trying to be burned on the grill, so my attention is on that
> more than on GIT.  :-)

git-pack-objects never creates a pack file with duplicate objects,
therefore git-index-pack was never tested on such pack files - no wonder
that it breaks.

The case of patch revert (A -> B -> A again) is probably the problem -
your dumb pack generator will probably write this:

	A
	B (delta based on A)
	A (delta based on B)

git-index-pack will first unpack the first copy of A, then notice that A
is used as a delta base for B and apply the delta, then it will find the
second copy of A and apply that delta, and then it will find B again...

Please try the patch at the end of this message - it should help to
avoid the infinite recursion in git-index-pack.  However, I'm not sure
that other git parts won't do something bad when they encounter an index
with duplicate sha1 entries (and git-index-pack cannot remove these
duplicates, because the number of index entries must match the pack
header).

> > >> I had a prior 400MB pack file built with fast-import that I was able
> > >> to index ok.
> > >
> > >Dumb luck?  Maybe that had no duplicates while this one does?
> >=20
> > Is there a git command to list the sha1's in a pack that doesn't have
> > an index? I could sort it, sort it unqiue, and then diff the outputs.

git-index-pack :)

(git-unpack-objects will also have all sha1 values at the end, but the
side effect of unpacking all objects to separate files is probably not
what you want to get.)

> Not that I know of.  Packs themselves don't have the SHA1 values and
> getting them from a pack without an index is a painful exercise as
> you don't know where the base of an object resides within the pack
> when you need it to generate the object's raw content to determine
> its ID.

Yes, this is a problem.  git-unpack-objects can unpack all objects in a
single pass, but only because it temporarily saves all deltas which
cannot be resolved yet, and can read back objects which it has written
before.  git-index-pack needs to work without modifying the object
database, so it works in two passes:

	/*
	 * First pass:
	 * - find locations of all objects;
	 * - calculate SHA1 of all non-delta objects;
	 * - remember base SHA1 for all deltas.
	 */

	/*
	 * Second pass:
	 * - for all non-delta objects, look if it is used as a base for
	 *   deltas;
	 * - if used as a base, uncompress the object and apply all deltas,
	 *   recursively checking if the resulting object is used as a base
	 *   for some more deltas.
	 */

-----------------------------------------------------------------------

From: Sergey Vlasov <vsu@altlinux.ru>
Date: Sun, 6 Aug 2006 17:28:29 +0400
Subject: [PATCH] git-index-pack: Avoid infinite recursion if the pack has d=
uplicate objects

Although git-pack-objects never creates packs which contain the same
object more than once, other tools may be not so careful, so add a check
to prevents infinite recursion of resolve_delta() for such packs.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 index-pack.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index b39953d..a8e3b1f 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -257,6 +257,13 @@ static void resolve_delta(struct delta_e
 	unsigned long next_obj_offset;
 	int j, first, last;
=20
+	/*
+	 * Do nothing if this delta was resolved earlier (this can happen if
+	 * the pack contains duplicate objects for some reason).
+	 */
+	if (obj->real_type !=3D OBJ_DELTA)
+		return;
+
 	obj->real_type =3D type;
 	delta_data =3D unpack_raw_entry(obj->offset, &delta_type,
 				      &delta_size, base_sha1,
--=20
1.4.2.rc3.g23aa

--Signature=_Sun__6_Aug_2006_17_46_48_+0400_De99cDpC68FQpO_o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFE1fLKW82GfkQfsqIRAoDPAJ0atQFCR8sShpipp/XWri2w1TgcrQCfeHPs
1ntqlEneOjFuNzIxt/+yVds=
=F848
-----END PGP SIGNATURE-----

--Signature=_Sun__6_Aug_2006_17_46_48_+0400_De99cDpC68FQpO_o--
