From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Tue, 06 Nov 2007 10:12:22 +0100
Message-ID: <20071106091222.GE4435@artemis.corp>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cYtjc4pxslFTELvY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 10:12:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKUD-0005bn-BZ
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbXKFJM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbXKFJM0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:12:26 -0500
Received: from pan.madism.org ([88.191.52.104]:41398 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXKFJMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:12:24 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3D2A228B19;
	Tue,  6 Nov 2007 10:12:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id EA38B34EFF6; Tue,  6 Nov 2007 10:12:22 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711052317170.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63648>


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 11:18:36PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 5 Nov 2007, Bj?rn Steinbrink wrote:
>=20
> > On 2007.11.05 13:57:53 -0500, Kristian H?gsberg wrote:
> >
> > > The shell script just has
> > >=20
> > > case "$all,$interactive,$also,$#" in
> > > *t,*t,*)
> > >         die "Cannot use -a, --interactive or -i at the same time." ;;
> > >=20
> > > which doesn't seem to care about the value of $also.  As far as I=20
> > > understand git commit, it doesn't make sense to pass any of -a, -i, -=
o=20
> > > or --interactive at the same time so I guess I could join the checks
> >=20
> > Note that there are only two commas. The asterisks catch everything and
> > $# won't be "t", so that catches anything with at least two t's.
>=20
> So shouldn't it be
>=20
> 	if (!!all + !!interactive + !!also > 1)

Btw, I'm starting to work slowly on the diff_opt_parse conversion to the
macro we discussed, and the need for new option parsing callbacks
arised, and I've created a:

  parse_opt_mask_{or,and,xor} commands that you declare this way:

    OPT_MASK_OR('a', "all",         &mode, "...", MASK_ALL),
    OPT_MASK_OR('i', "interactive", &mode, "...", MASK_INTERACTIVE),
    ...

And if you chose MASK_ALL/INTERACTIVE/.. to be single bits,

    if (!!all + !!interactive ... > 1)

becomes[0]:

    if (mode & (mode - 1)) {

    }

I've not read your patch thoroughly, but if you feel such a thing would
help you, I could send a preliminar set of patches to enable this
feature for people that may need it. Though you can look at my WIP on my
git public repository[1].

For those who care, this need arised because parse_diff_opts have a
_lot_ of single bit options, and that expansing it on many many full
blown integers looked like a regression, so I took the option to have a
`flags` member with explicit masks, and those masks will be used from
the parse-option callbacks[2]


  [0] for those who don't already know it, (i & (i - 1)) =3D=3D 0
      iff i is 0 or a power of 2.

  [1] the patch[3]:
      http://git.madism.org/?p=3Dgit.git;a=3Dcommitdiff;h=3D9d75b0a00915fa8=
1657934f36318c1c0f5bac96b
      example of use:
      http://git.madism.org/?p=3Dgit.git;a=3Dcommitdiff;h=3D74aacc487579d0c=
bd638adf883e743caeaee0f76
      http://git.madism.org/?p=3Dgit.git;a=3Dcommitdiff;h=3Daf15793dde94119=
faa1577c9eec7e839ae628011

  [2] http://git.madism.org/?p=3Dgit.git;a=3Dcommitdiff;h=3D86032204f1bdf5d=
a2fee555ec917709b3e6f662c#patch10

  [3] oh boy gitweb urls are really way too long :/
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMC/2vGr7W6HudhwRAtCcAJ9uT7mVd0PfuaxB1qvnqY+04Y1KCwCfc8/c
rgTYDQcZeWlWbkBhAm5ZSjo=
=FA7g
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
