From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 19:58:15 -0600
Message-ID: <200902101958.21284.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2527904.F8EehSksuT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 03:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX4OG-0007lj-Kf
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 02:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbZBKB6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 20:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbZBKB6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 20:58:25 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:55627 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbZBKB6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 20:58:24 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090211015824.VYHD23750.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Tue, 10 Feb 2009 20:58:24 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id ERyN1b0022i4SyG02RyPfV; Tue, 10 Feb 2009 20:58:23 -0500
X-Authority-Analysis: v=1.0 c=1 a=kahiNejmDeEA:10 a=2p8oXooCbN8A:10
 a=Fq1VQ0LPAAAA:8 a=g5MTTETZpcmJMd6_8TQA:9 a=smFSSdp-uYp6zytQ4mgA:7
 a=GVl_6f4wgnJCjeOdlBjexapcTKsA:4 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=nQwsU0KE4TZviDOQGkIA:9 a=PrH3SBCaFU0gV8UEucDoE2agfi4A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LX4Mn-000LqN-Dd; Tue, 10 Feb 2009 19:58:21 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090210131600.GD17305@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109366>

--nextPart2527904.F8EehSksuT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 10 February 2009 07:16:00 you wrote:
> On Tue, Feb 10, 2009 at 01:58:41AM -0600, Boyd Stephen Smith Jr. wrote:
> > On Monday 09 February 2009 15:12:06 Johannes Schindelin wrote:
> > > So I think it would be a sane plan to do the following when a commit
> > > note is requested:
> >
> > So, something like a Trie data structure?  I think that is a great way =
to
> > store fixed-length strings from a limited alphabet with arbitrary data
> > attached.
>
> I don't think a Trie quite makes sense here. We still have to look
> linearly through each git tree (an artifact of the tree implementation).

Perhaps it's not a traditional trie structure but that was the closest anal=
ogy=20
I could come up with.  I was actually thinking of something between a trie =
and=20
a b-tree, I think.  (It has been a long time since data structures class...)

The issue, as I understand it, it that we don't have gargantuan tree object=
s. =20
Reading and writing are slow and they'd also take up way to much memory if =
you=20
are only trying to find a few commits.

So, we figure out a maximum tree size that is reasonable, figure out a fan-=
out=20
that prevents the tree from growing above that size, but *dynamically* appl=
y=20
that fan-out.  I.e. if the fanout is 2 characters, and we've added notes fo=
r=20
both ff82730c and ff23abc0, then our tree would have ff/ -> some_tree_sha, =
but=20
if we had only a note for the one one our tree would have ff82730c... ->=20
some_note_sha.  Unlike .git/objects, we should probably also do dynamic fan=
out=20
in subtrees.

Yes, this would require a custom merge strategy for notes to flatten -> mer=
ge=20
=2D> canonicalize.

> Or did you mean something else entirely?

Yeah, that.

While I'm throwing out crazy ideas, why not makes a notes tree look just li=
ke=20
=2Egit/objects, including info and pack directories?
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart2527904.F8EehSksuT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSMLgACgkQ55pqL7G1QFlgPgCeMuXNDMfjSin/17TtRiLFVakm
7aAAn1q6oKypHhQgB655PNB3BxYlY/x9
=KUpj
-----END PGP SIGNATURE-----

--nextPart2527904.F8EehSksuT--
