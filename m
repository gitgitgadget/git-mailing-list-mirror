From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Wed, 19 Sep 2007 15:36:47 +0200
Message-ID: <20070919133647.GA17192@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224119.17650344AB3@madism.org> <20070919144604.7deca4f7.froese@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pWyiEgJYm5f9v55/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Edgar Toernig <froese@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 15:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXzjo-0003Vt-Fu
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 15:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224AbXISNgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 09:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbXISNgw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 09:36:52 -0400
Received: from pan.madism.org ([88.191.52.104]:45895 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851AbXISNgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 09:36:51 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5575E20B3A;
	Wed, 19 Sep 2007 15:36:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 276FA120D; Wed, 19 Sep 2007 15:36:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Edgar Toernig <froese@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070919144604.7deca4f7.froese@gmx.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58712>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 12:46:04PM +0000, Edgar Toernig wrote:
> Pierre Habouzit wrote:
> >
> > +void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
> > +{
> > +	int len;
> > +
> > +	len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> > +	if (len < 0) {
> > +		len =3D 0;
> > +	}
> > +	if (len > strbuf_avail(sb)) {
> > +		strbuf_grow(sb, len);
> > +		len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> > +		if (len > strbuf_avail(sb)) {
> > +			die("this should not happen, your snprintf is broken");
> > +		}
> > +	}
> > +	strbuf_setlen(sb, sb->len + len);
> > +}
>=20
> The second vsnprintf won't work as the first one consumed all args
> from va_list ap.  You need to va_copy the ap.  But iirc va_copy poses
> compatibility issues.  Unless va_copy is made available somehow,
> I would suggest to let the caller know that the buffer was too small
> (but isn't any more) and it has to call the function again:

  That's what I thought, and then nfvasprintf in trace.c suffers from
the same issue, as I copied the code from there.

> 	do {
> 		va_start(ap, fmt);
> 		again =3D strbuf_addvf(sb, fmt, ap);
> 		va_end(ap);
> 	} while (again);

  in fact doing it twice is enough but either way I don't like to impose
that to the caller :/ I mean it's totally stupid to have to do that on a
strbuf. of course we could provide a macro doing that ...
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8SXvvGr7W6HudhwRAqaWAJ446Nut+zSVnmcSJP6dviOs7vBQgwCcDmL4
uOBXgYmrRvMDNO1bdmd/YuQ=
=6Ds4
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
