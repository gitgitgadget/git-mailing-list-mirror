From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 14:41:02 +0200
Message-ID: <20070928124102.GA21309@artemis.corp>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site> <Pine.LNX.4.64.0709280046241.5926@iabervon.org> <7vhclfqisq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709281259050.28395@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="WIyZ46R2i8wDzkSu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbF9r-0001VC-RA
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXI1MlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbXI1MlL
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 08:41:11 -0400
Received: from pan.madism.org ([88.191.52.104]:37100 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbXI1MlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 08:41:09 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2733122303;
	Fri, 28 Sep 2007 14:41:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BBB86CFC; Fri, 28 Sep 2007 14:41:02 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709281259050.28395@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59390>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 12:01:28PM +0000, Johannes Schindelin wrote:
> But should the signature of alloc_ref() not be changed, then, to read
>=20
> 	struct ref *alloc_ref(unsigned name_alloc);
>=20
> Hm?
>=20
> Further, I am quite sure that the same mistake will happen again, until w=
e=20
> change the function to get the name length, not the number of bytes to=20
> allocate.

<janitor cap on>

  While being at it, I noticed that the following code pattern is used
in many places in git:

  struct something *ptr =3D xmalloc(sizeof(struct something) + some_string_=
len + 1);
  memset(ptr, 0, sizeof(struct something));
  memcpy(ptr->name, somestring, some_string_len + 1);

  With name being a flex array.

  Maybe we could deal with all of these, and make a generic construction
that would take care of allocating the proper space

  I believe we could have function doing that, that would factorize this
code, and use a nice api =C3=A0 la xmemdupz for this.

  It would be something like:

	void *xflexdupz(size_t offset, void *src, size_t len)
	{
		char *p =3D xmalloc(offset + len + 1);
		memset(p, 0, offset);
		memcpy(p + offset, src, len);
		p[offset + len] =3D '\0';
		return p;
	}

  Then alloc_ref could be a wrapper around:
  xflexdupz(offsetof(struct ref, name), ..., ...).

  Of course right now alloc_ref doesn't perform any kind of copy, but a
grep -A1 will convince you that it's not a problem:

	$ grep -A1 alloc_ref **/*.[hc]
	builtin-fetch.c:			rm =3D alloc_ref(strlen(ref_name) + 1);
	builtin-fetch.c-			strcpy(rm->name, ref_name);
	builtin-fetch.c:			rm->peer_ref =3D alloc_ref(strlen(ref_name) + 1);
	builtin-fetch.c-			strcpy(rm->peer_ref->name, ref_name);
	--
	connect.c:		ref =3D alloc_ref(len - 40);
	connect.c-		hashcpy(ref->old_sha1, old_sha1);
	--
	remote.c:struct ref *alloc_ref(unsigned namelen)
	remote.c-{
	--
	remote.c:		ref =3D alloc_ref(20);
	remote.c-		strcpy(ref->name, "(delete)");
	--
	remote.c:	ref =3D alloc_ref(len);
	remote.c-	memcpy(ref->name, name, len);
	--
	remote.c:	ret =3D alloc_ref(len);
	remote.c-	memcpy(ret->name, name, len);
	--
	remote.c:			cpy->peer_ref =3D alloc_ref(local_prefix_len +
	remote.c-						  strlen(match) + 1);
	--
	remote.c:		ret =3D alloc_ref(strlen(name) + 1);
	remote.c-		strcpy(ret->name, name);
	--
	remote.c:		ret =3D alloc_ref(strlen(name) + 6);
	remote.c-		sprintf(ret->name, "refs/%s", name);
	--
	remote.c:	ret =3D alloc_ref(strlen(name) + 12);
	remote.c-	sprintf(ret->name, "refs/heads/%s", name);
	--
	remote.h:struct ref *alloc_ref(unsigned namelen);
	remote.h-
	--
	transport.c:		struct ref *ref =3D alloc_ref(strlen(e->name));
	transport.c-		hashcpy(ref->old_sha1, e->sha1);

</janitor>

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/PZevGr7W6HudhwRAsAzAJ9yDzp4qGXSTueM3YRfEDYAcFl30ACfVL93
uT+49ibgJf1AEJ/6wqq2KIk=
=9nyG
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
