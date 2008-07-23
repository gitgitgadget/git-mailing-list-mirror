From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 17:30:12 +0200
Message-ID: <20080723153012.GE20614@artemis.madism.org>
References: <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet> <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet> <alpine.DEB.1.00.0807231407040.8986@racer> <20080723134448.GB11679@atjola.homenet> <alpine.DEB.1.00.0807231537420.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BI5RvnYi6R4T2M87";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgJC-0002mc-7X
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYGWPaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYGWPaR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:30:17 -0400
Received: from pan.madism.org ([88.191.52.104]:36991 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYGWPaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:30:16 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E1CF03A656;
	Wed, 23 Jul 2008 17:30:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C63D83B10F0; Wed, 23 Jul 2008 17:30:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231537420.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89685>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 02:41:14PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
>=20
> > diff --git a/index-pack.c b/index-pack.c
> > index ac20a46..33ba8ef 100644
> > --- a/index-pack.c
> > +++ b/index-pack.c
> > @@ -699,6 +699,9 @@ static struct object_entry *append_obj_to_pack(
> >  	write_or_die(output_fd, header, n);
> >  	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
> >  	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
> > +	obj[0].hdr_size =3D n;
> > +	obj[0].type =3D type;
> > +	obj[0].size =3D size;
> >  	obj[1].idx.offset =3D obj[0].idx.offset + n;
> >  	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[0]=
=2E.idx.crc32);
> >  	hashcpy(obj->idx.sha1, sha1);
>=20
> I confirm that the issues I saw went away with this patch, and it looks=
=20
> obviously like the correct approach.
>=20
> The only things valgrind is still complaining about (apart from libz,=20
> which I will not bother commenting about) are uninitialized parts of the=
=20
> data being written to disk, and a crc over them.
>=20
> Judging from the addresses, those are probably the bytes that are padded=
=20
> for 4- or 8-byte alignment, so they are probably fine.

  I confirm this analysis having done the same independently and reached
the same conclusions.

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHToQACgkQvGr7W6Hudhxm6ACZAYCYHn2HQy45Angoox/H0L/L
ldYAoIUEptO4nkCK7pQ/hxM/4YUh/zAS
=VshC
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
