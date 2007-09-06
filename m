From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/7] Simplify strbuf uses in archive-tar.c using the  proper functions.
Date: Thu, 06 Sep 2007 20:08:58 +0200
Message-ID: <20070906180858.GJ8451@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <1189101569.3423.17.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8jNwmpfkpox/fiJK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLmr-0000f7-US
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbXIFSJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 14:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755690AbXIFSJA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:09:00 -0400
Received: from pan.madism.org ([88.191.52.104]:47816 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672AbXIFSI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 14:08:59 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DE7441E523;
	Thu,  6 Sep 2007 20:08:58 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8183128B322; Thu,  6 Sep 2007 20:08:58 +0200 (CEST)
Mail-Followup-To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1189101569.3423.17.camel@hinata.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57920>


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 05:59:29PM +0000, Kristian H=C3=B8gsberg wrote:
> On Thu, 2007-09-06 at 13:20 +0200, Pierre Habouzit wrote:
> > +	strbuf_grow(sb, len);
> > +	strbuf_addf(sb, "%u %s=3D", len, keyword);
> > +	strbuf_add(sb, value, valuelen);
> > +	strbuf_addch(sb, '\n');
> >  }
>=20
> This entire function can be collapsed to just:
>=20
> 	strbuf_addf(sb, "%u %s=3D%.*s\n", len, keyword, valuelen, value);

  yes, but it's less efficient, because %.*s says that sprintf must copy
at most valuelen bytes from value, but it still has to stop if it finds
a \0 before. And the strbuf_grow has sense because the extend policy at
snprintf time is optimistic: we try to write, and if it didn't fit, we
try again. So there is a huge benefit if we have a clue of the final
size.

  I would not change a thing.

> > +	strbuf_init(&ext_header);
>=20
> Just use your STRBUF_INIT macro?

  Many people dilike it, I'm not sure it's a good idea either, and the
performance hit should be negligible, if it's not, then we can still
make the _init() function an inline.

> >  	if (ext_header.len > 0) {
> >  		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
> > -		free(ext_header.buf);
> >  	}
>=20
> Remove excess braces?

  bah, I don't like to strip braces so I won't do that, else you end up
with stupidities like:

  if (foo)
    // bar();

  do_some_very_important_stuff();

  Call me paranoid but well, it saved me so many times ...

> > -	memcpy(path.buf, base, baselen);
> > -	memcpy(path.buf + baselen, filename, filenamelen);
> > -	path.len =3D baselen + filenamelen;
> > -	path.buf[path.len] =3D '\0';
> > +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
> > +	strbuf_reset(&path);
>=20
> Does strbuf_reset() do anything here?
>=20
> > +	strbuf_add(&path, base, baselen);

  Yes _reset() sets length to 0. so the add here will write at the start
of the buffer again. It definitely is important !

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4EI6vGr7W6HudhwRAnLWAJkBdpvRr5mu/6PENisvYNx71akvSQCfVz4N
ArSEMTktCCwCeKkn85uxUDU=
=CJpx
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
