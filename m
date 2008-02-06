From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for  format-patch
Date: Wed, 06 Feb 2008 23:56:48 +0100
Message-ID: <20080206225648.GB23510@artemis.madism.org>
References: <alpine.LNX.1.00.0802061140360.13593@iabervon.org> <7vsl05vncj.fsf@gitster.siamese.dyndns.org> <20080206211326.GA9441@artemis.madism.org> <alpine.LNX.1.00.0802061703230.13593@iabervon.org> <20080206225335.GA23510@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OwLcNYc0lM97+oe1";
	protocol="application/pgp-signature"; micalg=SHA1
To: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 23:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtCv-0008GJ-8i
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761866AbYBFW4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758525AbYBFW4v
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:56:51 -0500
Received: from pan.madism.org ([88.191.52.104]:35758 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761901AbYBFW4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:56:50 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2BABA32DA7;
	Wed,  6 Feb 2008 23:56:49 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A371C2BD7E1; Wed,  6 Feb 2008 23:56:48 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080206225335.GA23510@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72870>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2008 at 10:53:35PM +0000, Pierre Habouzit wrote:
> On Wed, Feb 06, 2008 at 10:10:30PM +0000, Daniel Barkalow wrote:
> > On Wed, 6 Feb 2008, Pierre Habouzit wrote:
> >=20
> > > On Wed, Feb 06, 2008 at 08:31:08PM +0000, Junio C Hamano wrote:
> > > > I wonder how the rule established by b315c5c (strbuf change: be
> > > > sure ->buf is never ever NULL) and at the beginning of strbuf.h
> > > > applies here.  I think the current implementation of strbuf
> > > > happens to allow this, and it is very handy.  Perhaps the rule
> > > > stated there should be loosened and allow copying the buf away
> > > > when you know you have stuff in there (i.e. ->buf !=3D slopbuf).
> > > > Pierre, what do you think?
> > > >=20
> > > > What the patch does itself is much nicer than the original.
> > >=20
> > >   Why wouldn't you just use strbuf_detach ? I mean replacing:
> > >=20
> > > +	info->message_id =3D buf.buf;
> > >=20
> > > with:
> > >=20
> > > +	info->message_id =3D strbuf_detach(&buf, NULL);
> > >=20
> > >   isn't really hard to read, and has the nice side effect to prevent
> > > errors that could happen in the future (like reusing buf and screwing
> > > with info->message_id without noticing it). I'd rather stand on the s=
afe
> > > side here, it's more forward-compatible and idiot-proof[0].
> >=20
> > Is it actually right to have buf go out of scope right after=20
> > strbuf_detach()? It sort of looks like it would leak memory from buf.bu=
f.=20
> > I'm happy to do whatever the API wants there, and I didn't see anything=
 to=20
> > leave the struct as if strbuf_release were called, but with the string=
=20
> > extracted for the caller.
>=20
>   err no, strbuf_detach gives you a pointer you are supposed to free()
> later, and inits the strbuf passed as its argument to be used again,
> though if you don't, you leak nothing.

  In fact, strbuf_detach is the rough equivalent of doing that:

  info->message_id =3D buf.buf;
  buf.buf =3D NULL;


  Except that it sets buf.buf to a magic place so that it's never NULL,
and that it also keeps the internal invariants in place. But after a
strbuf_detach, a strbuf doesn't holds any allocated memory anymore.
You'll see in many places in the code that
`return strbuf_detach(&sb, NULL)` is quite idiomatic, and the function
does exactly what it means "Please detach the memory allocated in that
buffer and give it to me".

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHqjswvGr7W6HudhwRAr2KAJ41rPipKGnK8l1BQpjSezqh55rChwCeL5zb
udnVKYKxepqQkpX/HIm4ieA=
=RsTR
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
