From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 11:15:15 +0200
Message-ID: <20080731091515.GC12867@artemis.madism.org>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090348.GB20691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OBd5C1Lgu00Gd/Tn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 11:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOUGi-0004AM-J7
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYGaJPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYGaJPT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:15:19 -0400
Received: from pan.madism.org ([88.191.52.104]:52894 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbYGaJPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:15:18 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 579CB3C5FA;
	Thu, 31 Jul 2008 11:15:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5097D2E04; Thu, 31 Jul 2008 11:15:15 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080731090348.GB20691@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90917>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2008 at 09:03:49AM +0000, Jeff King wrote:
> Not necessarily. The logic there goes:
>=20
>   1. it's not a revision option, so pass to diff
>   2. it's not a diff opt, so it is unknown; we parsed no options
>   3. the caller sees we failed to parse, so it barfs
>=20
> but the logic here is:
>=20
>   1. it _is_ a revision option. Our handling of it is just a little odd,
>      in that we need to parse it later, when we are in setup_revisions.
>      So put it aside for now as a "revision" that just happens to look
>      like an option.
>   2. caller sees we parsed, and doesn't complain
>   3. caller later passes the "revision" to setup_revisions, which knows
>      what to do
>=20
> Now my patch doesn't just operate on "--all", but rather several other
> options including --no-walk. And maybe that is not right, and --all
> should be handled separately (though I think --remotes would follow the
> same logic). I'm not really sure why --no-walk is separated like that.

--no-walk alters how add_pending_object_with_mode works, which is called
by handle_revision_arg. IOW, <ref1> --no-walk <ref2> is not the same as
--no-walk <ref1> <ref2>. IOW reference arguments and --no-walk ordering
must be preserved, IOW --no-walk is a pseudo-argument like --all --tags
or --remote are.

It's okay for parse_revision_opt to take out any option that doesn't
alter handle_revision_arg (as for parse_option based parsers it's the
sole thing setup_revision will be doing: consuming revisions in a loop
with handle_revision_arg), but only those.

The full list (that I made when I wrote parse_revision_opt) is actually:

  pseudo arguments: --all --branches --tags --remotes --reflog
  combining operator: --not
  behavior modifying: --no-walk --do-walk


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiRgqMACgkQvGr7W6HudhzHtQCfdtB7kGHFaqRRJw63dG7enS0D
/1cAnjlwIq4KdhvN515Of8TzRrNe2F3z
=huxe
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
