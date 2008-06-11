From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 17:40:20 +0200
Message-ID: <20080611154020.GE28629@artemis.madism.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a+b56+3nqLzpiR9O";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 17:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6STE-0000O1-3B
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 17:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761921AbYFKPk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761864AbYFKPk0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 11:40:26 -0400
Received: from pan.madism.org ([88.191.52.104]:34299 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759376AbYFKPkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 11:40:25 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B4E782BA63;
	Wed, 11 Jun 2008 17:40:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9520116240; Wed, 11 Jun 2008 17:40:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84620>


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 03:17:04PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Wed, 11 Jun 2008, Pierre Habouzit wrote:
> >=20
> >   Could this be the source of a problem we often meet at work ? Let me
> > try to describe it.
>=20
> The fsync() *should* make no difference unless you actually crash. So my=
=20
> initial reaction is no, but non-coherent client-side write caching over=
=20
> NFS may actually make a difference.

  That's what I thought as well but =E2=80=A6 one never knows ;)

> >   We work with our git repositories (storages I should say) on NFS
> > homes, with workdirs on a local directory (NFS homes are backuped daily,
> > hence everything commited get backuped, and developers have shorter
> > compilation times thanks to the local FS).
>=20
> Ok, so your actual git object directory is on NFS?

  Yes.

> >   Quite often, when people commit, they have corrupt repositories. The
> > symptom is a `cannot read <sha1>` error message (or many at times). The
> > usual way to "fix" it is to git fsck, and git reset (because after the
> > fsck the index is totally screwed and all local files are marked new),
> > and usually everything is fine then.
>=20
> Hmm. Very interesting. That definitely sounds like a cache coherency=20
> issue (ie the "fsck" probably doesn't really _do_ anything, it just=20
> delays things and possibly causes memory pressure to throw some stuff out=
=20
> of the cache).
>=20
> What clients, what server?

  Server uses NFSv3 kernel server from Debian's 2.6.18 etch (up to
date).  Clients are various Unbuntu/Debian's with at least 2.6.18
kernels, some .22 .24 and .25.  It's a really simple setup, no clusters
are involved. The server exports an ext3 over dm-crypt partition though,
but I would be surprised it matters.

> That said, if there is some problem with that whole thing, then yes, the=
=20
> fsync() may well hide it. So yes, adding the fsync() is certainly worth=
=20
> testing.

Okay, I'll try to make my colleagues use that to see if they still have
the issues. I work on a laptop and not NFS, so I'm not the one having
the issues, only the one having to fix them on other's machines ;P

> >   This is not really a hard corruption, and it's really hard to
> > reproduce, I don't know why it happens, and I wonder if this patch could
> > help, or if it's unrelated. I can only bring speculations as it's really
> > hard to reproduce, and it quite depends on the load of the NFS server :/
>=20
> Yes, that sounds very much like a cache coherency issue. The "corruption"=
=20
> goes away when the cache gets flushed and the clients see the real state=
=20
> again. But as mentioned, git should already do things in a way that this=
=20
> should all work, but hey, that's using certain assumptions that perhaps=
=20
> aren't true in your environment.

  Well we have the issue for quite a long time actually, and given that
it's hard to reproduce, I'm never in a state to be able to give more
useful informations :/ We'll see if the fsync() helps or not=E2=80=A6

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhP8eIACgkQvGr7W6HudhzxrgCfc0Kis+JycdVg4Lthlc97pEo1
bAAAniIe73u6TtCRBUgLJqMJssvVjFJf
=ej3b
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
