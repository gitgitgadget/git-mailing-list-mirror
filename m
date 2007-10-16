From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add  callbacks.
Date: Tue, 16 Oct 2007 18:50:45 +0200
Message-ID: <20071016165045.GB13946@artemis.corp>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="H1spWtNR+x+ondvy";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpdE-0005SF-IV
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759751AbXJPQut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759709AbXJPQut
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:50:49 -0400
Received: from pan.madism.org ([88.191.52.104]:41076 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759473AbXJPQus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:50:48 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 514C9244A7;
	Tue, 16 Oct 2007 18:50:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C7D5E32BACC; Tue, 16 Oct 2007 18:50:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <4714E90C.80305@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61209>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 04:38:36PM +0000, Ren=C3=A9 Scharfe wrote:
> Pierre Habouzit schrieb:
> > This bit is to allow to aggregate options with arguments together when
> > the argument is numeric.
> >=20
> >     +#if 0
> >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> >     +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->opt, 10);
> >     +			return 0;
> >     +		}
> >     +#endif
>=20
> I don't like it, it complicates number options with unit suffixes (e.g.
> --windows-memory of git-pack-objects).

  Oh yeah, you're right, well you example is not an issue, but indeed
you pointed out a real probable issue:

  With that chunk, if an option that takes now an integer, becomes an
option with a suffix, we would then break backward compatibility. I'm
not sure I'm clear, but if you had a -S option (for size) that for now
gets sizes in kilooctet, git foo -S1000. Then if we decide that it's
worth understanting M/G/.. suffixes for this option, we would make the
type of the option be a CALLBACK using git_parse_ulong. This would mean
that with such a change:

before:
  git foo -S1000a would mean git foo -S1000 -a

After:
  git foo -S1000a would be rejected because 'a' isn't a valid size
  suffix.

  This of course become worse if we take git foo -S1000k where the
breakage would be silent.


  This is a very strong argument _against_ this chunk IMO.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFOvlvGr7W6HudhwRAjFoAKCEJPlmyGUYkECOfikHvSX1+DUQBgCcCnhm
0JIDRzmmdgiaLm8Zk1c5NvM=
=7ydN
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
