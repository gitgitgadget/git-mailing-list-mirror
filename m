From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 10:16:07 +0100
Message-ID: <20080110091607.GA17944@artemis.madism.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KsGdsel6WgEHnImy";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 10:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtWk-0007TN-32
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 10:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYAJJQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 04:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYAJJQN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 04:16:13 -0500
Received: from pan.madism.org ([88.191.52.104]:39938 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYAJJQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 04:16:10 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 092A72E39B;
	Thu, 10 Jan 2008 10:16:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D41DE6883; Thu, 10 Jan 2008 10:16:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <4785A6DB.3080007@vilain.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70052>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 07:02:39AM +0000, Sam Vilain wrote:
> Sam Vilain wrote:
> > I do really like LZOP as far as compression algorithms go.  It seems a
> > lot faster for not a huge loss in ratio.
>=20
> Coincidentally, I read this today on an algorithm (LZMA - same as 7zip)
> which is very slow to compress, high ratio but quick decompression:
>
>   http://use.perl.org/~acme/journal/35330
>
> Which sounds excellent for squeezing those "archive packs" into even
> more ridiculously tiny spaces.

Well, lzma is excellent for *big* chunks of data, but not that impressive f=
or
small files:

$ ll git.c git.c.gz git.c.lzma git.c.lzop
-rw-r--r-- 1 madcoder madcoder 12915 2008-01-09 13:47 git.c
-rw-r--r-- 1 madcoder madcoder  4225 2008-01-10 10:00 git.c.gz
-rw-r--r-- 1 madcoder madcoder  4094 2008-01-10 10:00 git.c.lzma
-rw-r--r-- 1 madcoder madcoder  5068 2008-01-10 09:59 git.c.lzop


And lzma performs really bad if you have few memory available. The "big" se=
cret
of lzma is that it basically works with a huge window to check for repetiti=
ve
data, and even decompression needs quite a fair amount of memory, making it=
 a
really bad choice for git IMNSHO.

Though I don't agree with you (and some others) about the fact that gzip is
fast enough. It's clearly a bottleneck in many log related commands where y=
ou
would expect it to be rather IO bound than CPU bound.  LZO seems like a fai=
rer
choice, especially since what it makes gain is basically the compression of=
 the
biggest blobs, aka the delta chains heads. It's really unclear to me if we
really gain in compressing the deltas, trees, and other smallish informatio=
ns.

And when it comes to times, for a big file enough to give numbers, here are=
 the
decompression times (best of 10 runs, smaller is better, second number is t=
he
size of the packed data, original data was 7.8Mo):
  * lzma: 0.374s (2.2Mo)
  * gzip: 0.127s (2.9Mo)
  * lzop: 0.053s (3.2Mo)

For a 300k original file:
  * lzma: 0.022s (124Ko)
  * gzip: 0.008s (144Ko)
  * lzop: 0.004s (156Ko) /* most of the samples were actually 0.005 */

What is obvious to me is that lzop seems to take 10% more space than gzip,
while being around 1.5 to 2 times faster. Of course this is very sketchy an=
d a
real test with git will be better.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHheJXvGr7W6HudhwRAsggAJ9WHfVnhqR1OCo5XJoDQFil4x0vKwCeJSOk
fduoFta2tCsOQS0/1yJNyEA=
=OB3c
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
