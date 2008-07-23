From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 22:27:22 +0200
Message-ID: <20080723202722.GA18160@artemis.madism.org>
References: <20080723130518.GA17462@elte.hu> <alpine.LFD.1.10.0807231027030.4754@woody.linux-foundation.org> <20080723190920.GG20614@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7JfCtLOvnd9MIVvH";
	protocol="application/pgp-signature"; micalg=SHA1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 22:28:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkx4-0001Nz-96
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbYGWU1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbYGWU1d
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:27:33 -0400
Received: from pan.madism.org ([88.191.52.104]:48999 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbYGWU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:27:32 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id ADA593A7AB;
	Wed, 23 Jul 2008 22:27:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B3F543ACFA5; Wed, 23 Jul 2008 22:27:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080723190920.GG20614@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89767>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 07:09:20PM +0000, Pierre Habouzit wrote:
> On Wed, Jul 23, 2008 at 05:59:01PM +0000, Linus Torvalds wrote:
> > In fact, the two top entries in a profile look roughly like:
> >=20
> > 	102161   70.2727  libz.so.1.2.3            libz.so.1.2.3            (n=
o symbols)
> > 	7685      5.2862  git                      git                      fi=
nd_pack_entry_one
> > 	...
> >=20
> > ie 70% of the time is just purely unpacking the data, and another 5% is=
=20
> > just finding it. We could perhaps improve on it, but not a whole lot.
>=20
>   Well there is an easy way though, that could reduce that: using
> adaptative compression. I proposed a patch once upon a time, that set
> the compression strengh to 0 for "small" objects with a configurable
> cut-off. If you do that, most trees, commits messages and so on aren't
> compressed, and it will reduce (with IIRC a 5-liner) this time quite
> dramatically.
>=20
>   I could maybe resurect it to see if for people that do the kind of
> things Ingo does it helps. By setting the cut-off at 1k, I had packs
> being less than 1% bigger IIRC. I'll try to find it again and run your
> tests with it to see how much it helps.

  Unsurprisingly with a 1024o cutoff, the numbers are (first run is
forced cold-cache with /proc/.../drop_caches, second is the best run of 5):

default git:

    3.10user 0.16system 0:08.10elapsed 40%CPU (0avgtext+0avgdata 0maxreside=
nt)k
    116152inputs+0outputs (671major+35286minor)pagefaults 0swaps

    2.01user 0.11system 0:02.12elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
    0inputs+0outputs (0major+35958minor)pagefaults 0swaps

With a 1024k cutoff:

    1.16user 0.13system 0:08.29elapsed 15%CPU (0avgtext+0avgdata 0maxreside=
nt)k
    154208inputs+0outputs (947major+39777minor)pagefaults 0swaps

    0.76user 0.06system 0:00.82elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
    0inputs+0outputs (0major+40724minor)pagefaults 0swaps


According to [0], a 1k cutoff meant something like a 10% larger pack. 512o
meant an almost identical pack in size, but with reduced performance
improvements.


  [0] http://thread.gmane.org/gmane.comp.version-control.git/70019/focus=3D=
70250
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHlCkACgkQvGr7W6HudhxtgwCgm9WSqZcdeCHlGiHaKmkD4kAj
F5IAnAu7NT3pg9FGwnVe3KXg4RoZf8ST
=y0pN
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
