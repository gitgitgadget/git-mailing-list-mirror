From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Wed, 24 Dec 2008 11:11:46 +0100
Message-ID: <20081224101146.GA10008@artemis.corp>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org> <20081223102127.GA21485@artemis.corp> <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qMm9M+Fa2AknHoGS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFQjp-0007ut-68
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 11:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYLXKLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 05:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbYLXKLy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 05:11:54 -0500
Received: from pan.madism.org ([88.191.52.104]:48507 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbYLXKLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 05:11:53 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 060212C158;
	Wed, 24 Dec 2008 11:11:47 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 600FF9149EF; Wed, 24 Dec 2008 11:11:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103858>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2008 at 06:16:01PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 23 Dec 2008, Pierre Habouzit wrote:
> >
> > when readlink fails, the strbuf shall not be destroyed. It's not how
> > read_file_or_gitlink works for example.
>=20
> I disagree.
>=20
> This patch just makes things worse. Just leave the "strbuf_release()" in=
=20
> _one_ place.

The "problem" is that the strbuf API usually works that way: functions
append things to a buffer, or do nothing, but always keep the buffer in
a state where you can append more stuff to it.

If read_file_or_gitlink or strbuf_readlink destroy the buffer, then you
break the second expectation people (should) have about the strbuf API.

The reason is that if you built things in the buffer, you really don't
want it to be undone just because the last bit you add went wrong for
some reason. Or if you have a buffer that is reused in a loop, you don't
want the buffer you allocated to be dropped just because one error
occurred.


Alternatively, we could pass a flag to tell function performing reads
(fread, read, readlink, whatever) that those should destroy the buffer
on error or just report it. I don't really know. It sounds like
over-engineering though.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklSCuAACgkQvGr7W6Hudhx0fwCfVGa6isg6+wDCeUpWHr3+icfC
wqcAnioidOhSF28NT5LTP8bRFXd237Xv
=lnTC
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
