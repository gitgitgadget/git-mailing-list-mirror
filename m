From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead of custom buffers.
Date: Sat, 08 Sep 2007 14:28:34 +0200
Message-ID: <20070908122834.GB21864@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <1189252399316-git-send-email-madcoder@debian.org> <11892523992038-git-send-email-madcoder@debian.org> <851wd9xt98.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wzJLGUyc3ArbnUjN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 14:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITzQj-0005kf-H5
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 14:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbXIHM2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 08:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbXIHM2g
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 08:28:36 -0400
Received: from pan.madism.org ([88.191.52.104]:57974 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbXIHM2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 08:28:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 90EC41E9ED;
	Sat,  8 Sep 2007 14:28:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 179E06431; Sat,  8 Sep 2007 14:28:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <851wd9xt98.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58125>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On sam, sep 08, 2007 at 11:59:31 +0000, David Kastrup wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Also remove the "len" parameter, as:
> >   (1) it was used as a max boundary, and every caller used ~0u
> >   (2) we check for final NUL no matter what, so it doesn't help for spe=
ed.
>=20
> That sounds like a change that makes improvement of callers impossible
> when it is found out that it leads to a performance issue.  Is it only
> the pretty-print that is affected?

  Speaking of performance, here is a small interesting bench:

$ for i in `seq 1 10`; do time git-log >| /dev/null; done
git-log >| /dev/null  2,12s user 0,08s system 99% cpu 2,205 total
git-log >| /dev/null  2,14s user 0,06s system 99% cpu 2,208 total
git-log >| /dev/null  2,12s user 0,08s system 99% cpu 2,205 total
git-log >| /dev/null  2,10s user 0,10s system 99% cpu 2,209 total
git-log >| /dev/null  2,14s user 0,07s system 99% cpu 2,211 total
git-log >| /dev/null  2,11s user 0,09s system 99% cpu 2,210 total
git-log >| /dev/null  2,15s user 0,05s system 99% cpu 2,213 total
git-log >| /dev/null  2,12s user 0,07s system 99% cpu 2,203 total
git-log >| /dev/null  2,13s user 0,06s system 99% cpu 2,204 total
git-log >| /dev/null  2,17s user 0,09s system 100% cpu 2,254 total

$ for i in `seq 1 10`; do time ~/dev/scm/git/git-log >| /dev/null; done
~/dev/scm/git/git-log >| /dev/null  2,06s user 0,11s system 99% cpu 2,185 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,11s user 0,07s system 99% cpu 2,192 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,10s user 0,10s system 99% cpu 2,207 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,10s user 0,08s system 99% cpu 2,188 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,10s user 0,08s system 99% cpu 2,187 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,10s user 0,10s system 100% cpu 2,196 =
total
~/dev/scm/git/git-log >| /dev/null  2,08s user 0,11s system 99% cpu 2,195 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,11s user 0,08s system 99% cpu 2,193 t=
otal
~/dev/scm/git/git-log >| /dev/null  2,10s user 0,08s system 100% cpu 2,188 =
total
~/dev/scm/git/git-log >| /dev/null  2,12s user 0,07s system 98% cpu 2,213 t=
otal

$ git rev-list --all | wc -l
64271


  The underling repository is a not so old linux-2.6 git repository.
git-log is the default unstable git-log, (a pristine 1.5.3.1,
pre-new-strbuf).

  ~/dev/scm/git/git-log is obviously the new one with the whole strbuf
patch series applied. Strbufs definitely made the code more readable (at
least it's my impression), here is the proof that it did not affected an
inch from performance (we even seem to have a marginal 0.5% gain in
performance ;p).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4pVyvGr7W6HudhwRAr7wAKCER8j34NNiHiG+PM1H55M4a3hy/QCghiA8
vnEINfndAvlxMHeLtJZppqo=
=6UAy
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
