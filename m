From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 11:49:26 +0200
Message-ID: <20070906094926.GC8451@artemis.corp>
References: <20070905085720.GD31750@artemis.corp> <11890199232110-git-send-email-madcoder@debian.org> <7vlkbkb0na.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jousvV0MzM2p6OtC";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDzR-00012H-1X
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbXIFJt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbXIFJt2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:49:28 -0400
Received: from pan.madism.org ([88.191.52.104]:34964 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbXIFJt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:49:27 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A36BE173DD;
	Thu,  6 Sep 2007 11:49:26 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4F2F11A3C2; Thu,  6 Sep 2007 11:49:26 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkbkb0na.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57851>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 09:31:37AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   A strbuf can be used to store byte arrays, or as an extended string
> > library. The `buf' member can be passed to any C legacy string function,
> > because strbuf operations always ensure there is a terminating \0 at th=
e end
> > of the buffer, not accounted in the `len' field of the structure.
> >
> >   A strbuf can be used to generate a string/buffer whose final size is =
not
> > really known, and then "strbuf_detach" can be used to get the built buf=
fer,
> > and keep the wrapping "strbuf" structure usable for further work again.
> >
> >   Other interesting feature: strbuf_grow(sb, size) ensure that there is
> > enough allocated space in `sb' to put `size' new octets of data in the
> > buffer. It helps avoiding reallocating data for nothing when the proble=
m the
> > strbuf helps to solve has a known typical size.
>=20
> "Rework API semantics" needs to be accompanied with an API
> description, perhaps at the beginning of each externally
> visible function.
>=20
> Also the commit log message needs to explain what the old
> semantics was and what the improved one is, to highlight the
> changes needed to the callers.  Especially...
>=20
> > @@ -1657,11 +1656,11 @@ static void *cmd_data (size_t *size)
> >  			if (term_len =3D=3D command_buf.len
> >  				&& !strcmp(term, command_buf.buf))
> >  				break;
> > -			ALLOC_GROW(buffer, length + command_buf.len, sz);
> > +			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
> >  			memcpy(buffer + length,
> >  				command_buf.buf,
> > -				command_buf.len - 1);
> > -			length +=3D command_buf.len - 1;
> > +				command_buf.len);
> > +			length +=3D command_buf.len;
> >  			buffer[length++] =3D '\n';
> >  		}
> >  		free(term);
>=20
> .... it is not all obvious why these off-by-one changes are
> needed without such a description.  The other hunks in this
> patch to this file are all such changes.

  Yes, as I suppose you know, but I state it here again so that
everybody understands, before strbuf's were merely a byte array, not
necessarily NUL-terminated. Hence many parts of the code that wanted to
pass the buffer to str* functions had to manually insert a NUL, hence it
was accounted in the length of the buffer.

  Now, we always have a NUL after the "official" end of the buffer, so
it's not needed anymore. The off-by-ones are just that. The hunk you
quote is one where git's code was messing with strbufs internals
directly, so the ALLOC_GROW has to take the 1 octed needed to maintain
the internal invariant. Though, the patch after this one rewrites the
hunk to use strbuf's API's.

>=20
> > -static void inline strbuf_add(struct strbuf *sb, int ch) {
>=20
> > +static inline void strbuf_addch(struct strbuf *sb, size_t c) {
> > +	strbuf_grow(sb, 1);
> > +	sb->buf[sb->len++] =3D c;
> > +	sb->buf[sb->len] =3D '\0';
> > +}
>=20
> You certainly did not mean size_t wide characters.

  Oh boy, now I've been red-handed of :%s/\<int\>/\<size_t\>/ :)

  I'll repost a _clean_ patch series soon with those things fixed, and
the wrong overflow test (that should be a >=3D and not a >) as well, as we
discussed it on IRC before.

  Oh and FWIW I believe the details of the NUL always after the buffer
array has to be in strbuf.h and not in the commit comment, maybe I'll
put it in both to make everybody happy.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG380mvGr7W6HudhwRAnJoAKCbsGqItTGPqKi/4lLxgJeP2iUdSgCeLPO5
eJob4UI8NbkLAtLHnh131K8=
=ZdSf
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
