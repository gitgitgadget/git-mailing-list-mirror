From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Thu, 20 Sep 2007 10:27:01 +0200
Message-ID: <20070920082701.GA2053@artemis.corp>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <7vwsumkll8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="vtzGhvizbBRQ85DL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 10:27:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYHNS-00008p-6D
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 10:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXITI1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 04:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbXITI1I
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 04:27:08 -0400
Received: from pan.madism.org ([88.191.52.104]:55295 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbXITI1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 04:27:05 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A380420C6F;
	Thu, 20 Sep 2007 10:27:02 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9D9822D1BD2; Thu, 20 Sep 2007 10:27:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsumkll8.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58762>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2007 at 04:27:31AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > * drop nfasprintf.
> > * move nfvasprintf into imap-send.c back, and let it work on a 8k buffe=
r,
> >   and die() in case of overflow. It should be enough for imap commands,=
 if
> >   someone cares about imap-send, he's welcomed to fix it properly.
> > * replace nfvasprintf use in merge-recursive with a copy of the strbuf_=
addf
> >   logic, it's one place, we'll live with it.
> >   To ease the change, output_buffer string list is replaced with a strb=
uf ;)
>=20
> While I'd agree with all of the above,
>=20
> > * rework trace.c API's so that only one of the trace functions takes a
> >   vararg. It's used to format strerror()s and git command names, it sho=
uld
> >   never be more than a few octets long, let it work on a 8k static buff=
er
> >   with vsnprintf or die loudly.
>=20
> and I'd agree with this in principle, there is a minor nit with
> the implementation and use in trace.c.  E.g.
>=20
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 9b74ed2..c0f954e 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -97,7 +97,8 @@ int execv_git_cmd(const char **argv)
> >  		tmp =3D argv[0];
> >  		argv[0] =3D git_command;
> > =20
> > -		trace_argv_printf(argv, -1, "trace: exec:");
> > +		trace_printf("trace: exec:");
> > +		trace_argv(argv, -1);
>=20
> This used to be a single call into trace.c which would format a
> single string to write(2) out.  Now these two messages go
> through separate write(2) and can be broken up.  I think the
> atomicity of the log/trace message was the primary reason the
> original had such a strange calling convention.

  Okay, given that the formats (as you can see) are always very short,
and that it will always fit in a big enough static buffer, I'll
reinstate this and use a vsnprintf twice then.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8i7VvGr7W6HudhwRAjjdAJ9gf/sVl+FU9Bd1LcOJiO8cEE8d7QCgn3uT
MQxHxCQf8wvGdbvgjgDglZo=
=zB5v
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
