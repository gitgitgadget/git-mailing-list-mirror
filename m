From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] strbuf's in builtin-apply
Date: Sat, 15 Sep 2007 16:12:10 +0200
Message-ID: <20070915141210.GA27494@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Dxnq1zWXvFF0Q93v";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYNd-0008Gp-8h
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbXIOOMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbXIOOMO
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:12:14 -0400
Received: from pan.madism.org ([88.191.52.104]:33911 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbXIOOMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:12:13 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CFC1478B;
	Sat, 15 Sep 2007 16:12:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C5FAF4C12A; Sat, 15 Sep 2007 16:12:10 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  I promised it, here it comes. It comes though with some possible
problems, so I'd like to see them discussed first.

  builtin-apply.c was messing with its custom buffers a lot,
reallocating the buffers and so on, hence I had to create strbuf_embed
to have a strbuf-safe API doing exactly the same. Though, because of the
"I want an extra NUL in the end"-invariant, this can come with a quite
high price. in the second patch, there is a hunk:


-		nsize =3D got;
-		nbuf =3D convert_to_git(path, buf, &nsize);
-		if (nbuf) {
-			free(buf);
-			*buf_p =3D nbuf;
-			*alloc_p =3D nsize;
-			*size_p =3D nsize;
-		}
-		return got !=3D size;
+
+		nsize =3D buf->len;
+		nbuf =3D convert_to_git(path, buf->buf, &nsize);
+		if (nbuf)
+			strbuf_embed(buf, nbuf, nsize, nsize);
+		return 0;

  Here, I've not been able to check if convert_to_git was in fact always
dealing with a NUL-terminated buffer (That would be in fact nsize+1) or
not, hence here this strbuf_embed will likely perform a realloc. I don't
know git enough to know if this can become an horrible burden though.

  Another suspicious hunk is:

-	data =3D (void*) fragment->patch;
[...]
 	case BINARY_LITERAL_DEFLATED:
-		free(desc->buffer);
-		desc->buffer =3D data;
-		dst_size =3D fragment->size;
-		break;
+		strbuf_embed(buf, fragment->patch, fragment->size, fragment->size);
+		return 0;

  TTBOMK the ->patch pointer is a pointer inside a buffer, not a buffer
that has been malloc'ed (and there are code paths before my patch that
would still realloc the buffer so I don't think I introduce an issue).
It passes the test-suite without crashing, but well, maybe this should
be a copy instead.

  The rest is pretty straightforward.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6+g6vGr7W6HudhwRAuK3AJ9SklaLHrazN9WVmPx2Yb35pM465QCgi35G
N4C3HoFceIqK+pBPBZLczPg=
=/bBD
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
