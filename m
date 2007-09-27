From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Use of strbuf.buf when strbuf.len == 0
Date: Thu, 27 Sep 2007 12:13:00 +0200
Message-ID: <20070927101300.GD10289@artemis.corp>
References: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/3yNEOqWowh/8j+e";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 12:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaqMr-00058l-D0
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 12:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbXI0KNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 06:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbXI0KNF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 06:13:05 -0400
Received: from pan.madism.org ([88.191.52.104]:32934 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbXI0KNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 06:13:02 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2A53F21CCC;
	Thu, 27 Sep 2007 12:13:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 748728D5A; Thu, 27 Sep 2007 12:13:00 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59280>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 06:21:24AM +0000, Junio C Hamano wrote:
> It might be an easier and safer fix to define that strbuf_init()
> to always have allocation.  Use of a strbuf in the code _and_
> not adding any contents to the buffer should be an exception and
> avoiding malloc()/free() for that special case feels optimizing
> for the wrong case.
>=20
> However, there are strbuf instances that are not initialized
> (i.e. in BSS or initialized by declaring with STRBUF_INIT), so
> we still need to handle (.len =3D=3D 0 && .alloc =3D=3D 0) case
> specially anyway.

  I can see a way, that would need special proof-reading of the strbuf
module, but should not harm its users, that would be to change
STRBUF_INIT to work this way:

  { .buf =3D "", .len =3D 0, .alloc =3D 0 }

  It needs to make strbuf_grow and strbuf_release check for ->alloc
before doing anything stupid.

  Though we may have some bits of code that rely on .buf being NULL if
nothing happened. I tried to track them down, but some may remain.

  If you agree with this change, that would solve most of the issues
with almost no cost, then I'll propose a new patch with this change.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+4IsvGr7W6HudhwRAquXAKCSiQiPwCJEuspPDocTY+x1kKp7FwCgj+XL
YgZuuGTCeu/daLksZlFY6Ic=
=0BAX
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
