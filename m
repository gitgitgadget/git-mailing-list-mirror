From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parseopt: introduce OPT_RECURSE to specify shared options
Date: Mon, 05 Nov 2007 13:39:23 +0100
Message-ID: <20071105123923.GC25574@artemis.corp>
References: <Pine.LNX.4.64.0711051209061.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Izn7cH1Com+I3R9J";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1Ey-0003a9-95
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbXKEMj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbXKEMj0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:39:26 -0500
Received: from pan.madism.org ([88.191.52.104]:56658 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307AbXKEMjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:39:25 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 21E7D2889C;
	Mon,  5 Nov 2007 13:39:24 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id BAAC5A007; Mon,  5 Nov 2007 13:39:23 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711051209061.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63506>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 12:09:41PM +0000, Johannes Schindelin wrote:
>=20
> The diff options should not need to be defined in every user of the
> diffcore.  This provides the framework:
>=20
> 	extern struct option *diff_options;
>=20
> 	struct option options[] =3D {
> 		OPT_RECURSE(diff_options),
> 		...
> 		OPT_END(),
> 	};
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	This is not yet clever enough to show the correct usage when
> 	some sub option uses the same short or long name as one that
> 	has already been printed.
>=20
> 	Add the superlevel options struct as another parameter to
> 	usage_show_options(), and write an unset_option() function
> 	which takes a short name, a long name, and that superlevel
> 	options struct, and unsets all options which match.

  Alternatively you can have a 256-bit bitfield to mark short options
that have already been seen and a hashtable of long options already
printed out, and while outputting an option, one should check that
either the short option or the long option is new.

  This is nicer as some of the struct option may live in .rodata

>  parse-options.c          |   68 +++++++++++++++++++++++++++++++++++-----=
------
>  parse-options.h          |    2 +
>  t/t0040-parse-options.sh |   24 ++++++++++++++++
>  test-parse-options.c     |   10 +++++++
>  4 files changed, 88 insertions(+), 16 deletions(-)

  Okay, we discussed this with Johannes on IRC. I came up with the
relocation thing because I feared that the msys port (and maybe other ?)
that are about to use (or already do) threads would step on each other
toes while recursing into a sub-array of options.

  Johannes thinks that this never happens in our codebase, hence that my
patches are an overkill.

  The likely users of this feature are currently diff options (diff.c
diff_opt_parse) and revisions (builtin-log.c setup_revisions).

  Using Johannes patch, we will have to export a global struct
diff_option (resp. struct rev_info) from diff.c (resp. revisions.c) and
no function (or almost) would take struct diff_option (resp struct
rev_info) as an argument because everyone would work on the global
variable[0].

  With my patches, we can work like we do now, with a more functional
approach.

  I like the kind of code that I allow to write better (I tend to
dislike big fat global variables), though it's obvious that Johannes
patch is a lot simpler and I like that.


  [0] actually we don't *need* to remove the struct diff_options argument
      from many functions except from diff_opt_parse, it's just that for
      real, everybody will work on the same global structure anyway.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLw77vGr7W6HudhwRAgCWAJ4meBdvvhhRNzIomUmsbr20YVw3rwCfVxpM
Ziw9JW2A38Hd8DIMC8As1qo=
=IyHD
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
