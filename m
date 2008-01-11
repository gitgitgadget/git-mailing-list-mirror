From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 10:45:16 +0100
Message-ID: <20080111094516.GD20141@artemis.madism.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Q0rSlbzrZN6k9QnT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 10:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDGSc-0008Bn-Eh
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 10:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbYAKJpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 04:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760571AbYAKJpX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 04:45:23 -0500
Received: from pan.madism.org ([88.191.52.104]:50282 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760249AbYAKJpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 04:45:19 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 840CA2E706;
	Fri, 11 Jan 2008 10:45:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2AB6DE8D4; Fri, 11 Jan 2008 10:45:17 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70144>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 08:39:07PM +0000, Nicolas Pitre wrote:
> On Thu, 10 Jan 2008, Pierre Habouzit wrote:

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index a39cb82..252b03e 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -433,7 +433,10 @@ static unsigned long write_object(struct sha1file *f,
>  		}
>  		/* compress the data to store and put compressed length in datalen */
>  		memset(&stream, 0, sizeof(stream));
> -		deflateInit(&stream, pack_compression_level);
> +		if (obj_type =3D=3D OBJ_REF_DELTA || obj_type =3D=3D OBJ_OFS_DELTA)
> +			deflateInit(&stream, 0);
> +		else
> +			deflateInit(&stream, pack_compression_level);
>  		maxsize =3D deflateBound(&stream, size);
>  		out =3D xmalloc(maxsize);
>  		/* Compress it */
>=20
> You then only need to run 'git repack -a -f -d' with and without the=20
> above patch.

  Using as a PoC a test that is if (size <=3D 512) instead, I get:

vanilla git:

$ du -k .git/**/*.pack
180808 .git/objects/pack/pack-7bc9f383c92cbffe366da2d2a62b67bb33a53365.pack
$ repeat 5 time git blame MAINTAINERS >|/dev/null
git blame MAINTAINERS >| /dev/null  7,34s user 0,09s system 99% cpu 7,433 t=
otal
git blame MAINTAINERS >| /dev/null  7,31s user 0,16s system 100% cpu 7,475 =
total
git blame MAINTAINERS >| /dev/null  7,35s user 0,08s system 100% cpu 7,431 =
total
git blame MAINTAINERS >| /dev/null  7,30s user 0,18s system 99% cpu 7,482 t=
otal
git blame MAINTAINERS >| /dev/null  7,33s user 0,16s system 99% cpu 7,492 t=
otal


With a compression disabled for sizes <=3D 512:

$ du -k .git/**/*.pack
188840.git/objects/pack/pack-7bc9f383c92cbffe366da2d2a62b67bb33a53365.pack
$ repeat 5 time git blame MAINTAINERS >|/dev/null
git blame MAINTAINERS >| /dev/null  7,06s user 0,09s system 100% cpu 7,150 =
total
git blame MAINTAINERS >| /dev/null  7,08s user 0,13s system 99% cpu 7,209 t=
otal
git blame MAINTAINERS >| /dev/null  7,07s user 0,08s system 99% cpu 7,168 t=
otal
git blame MAINTAINERS >| /dev/null  7,02s user 0,15s system 99% cpu 7,177 t=
otal
git blame MAINTAINERS >| /dev/null  7,07s user 0,13s system 99% cpu 7,243 t=
otal

Okay, the size doesn't even budge, it's not even near being fun. Though
we gain 3% of wall clock time


Let's try with a limit of 1024 then !

$ du -k .git/**/*.pack
201725	.git/objects/pack/pack-7bc9f383c92cbffe366da2d2a62b67bb33a53365.pack
$ repeat 5 time git blame MAINTAINERS >|/dev/null
git blame MAINTAINERS >| /dev/null  6,93s user 0,16s system 77% cpu 9,109 t=
otal
git blame MAINTAINERS >| /dev/null  6,88s user 0,08s system 99% cpu 6,965 t=
otal
git blame MAINTAINERS >| /dev/null  6,84s user 0,10s system 99% cpu 6,952 t=
otal
git blame MAINTAINERS >| /dev/null  6,86s user 0,12s system 99% cpu 6,983 t=
otal
git blame MAINTAINERS >| /dev/null  6,81s user 0,18s system 99% cpu 6,994 t=
otal


Okay, the packs grows 10%, and the blame takes 6% less time.


Okay the numbers are still not that impressive, but my patch doesn't
touches _only_ deltas, but also log comments I said, so I've redone my
tests with git log and *TADAAAA*:

vanilla git:
    repeat 5 time git log >|/dev/null
    git log >| /dev/null  2,54s user 0,12s system 99% cpu 2,660 total
    git log >| /dev/null  2,52s user 0,12s system 99% cpu 2,653 total
    git log >| /dev/null  2,57s user 0,07s system 99% cpu 2,637 total
    git log >| /dev/null  2,56s user 0,09s system 99% cpu 2,659 total
    git log >| /dev/null  2,54s user 0,10s system 99% cpu 2,660 total

with the 512 octets limit:

    $ repeat 5 time git log >|/dev/null
    git log >| /dev/null  2,10s user 0,10s system 99% cpu 2,193 total
    git log >| /dev/null  2,08s user 0,10s system 99% cpu 2,189 total
    git log >| /dev/null  2,06s user 0,11s system 100% cpu 2,162 total
    git log >| /dev/null  2,04s user 0,13s system 100% cpu 2,172 total
    git log >| /dev/null  2,06s user 0,13s system 99% cpu 2,198 total

    That's already a 20% time reduction.


with the 1024 octets limits:
    $ repeat 5 time git log >|/dev/null
    git log >| /dev/null  1,39s user 0,12s system 99% cpu 1,512 total
    git log >| /dev/null  1,38s user 0,12s system 100% cpu 1,498 total
    git log >| /dev/null  1,41s user 0,10s system 99% cpu 1,514 total
    git log >| /dev/null  1,41s user 0,10s system 100% cpu 1,506 total
    git log >| /dev/null  1,40s user 0,10s system 100% cpu 1,504 total

    Yes that's 43% time reduction !

  As a side note, repacking with the 1024 octets limits takes 4:06 here,
and 4:26 without the limit at all, which is 8% less time. I know it
doesn't matters a lot as repack is a once time operation, but still, it
would speed up git gc --auto which is not something to neglect
completely.


I say it's worth investigating a _lot_, and the patch is that complicated:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..f454929 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -433,7 +433,7 @@ static unsigned long write_object(struct sha1file *f,
                }
                /* compress the data to store and put compressed length in =
datalen */
                memset(&stream, 0, sizeof(stream));
-               deflateInit(&stream, pack_compression_level);
+               deflateInit(&stream, size > 1024 ? pack_compression_level :=
 0);
                maxsize =3D deflateBound(&stream, size);
                out =3D xmalloc(maxsize);
                /* Compress it */


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhzqsvGr7W6HudhwRAiBTAJ4zUKIycHUZ813dicRtwqnwTs/DGwCgouP8
QVmpv6+uLKIRgGFp25JmOTw=
=/Lpi
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
