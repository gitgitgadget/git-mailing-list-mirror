From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Thu, 13 Sep 2012 08:11:02 +0200
Organization: OPTEYA
Message-ID: <1347516662.1961.23.camel@test.quest-ce.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
	 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
	 <20120912183833.GA20795@sigill.intra.peff.net>
	 <1347482230.1961.4.camel@test.quest-ce.net>
	 <20120912210455.GA30679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 08:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC2e1-0002l9-3z
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 08:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab2IMGLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 02:11:12 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:53284 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2IMGLL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 02:11:11 -0400
Received: from [127.0.0.1] (helo=localhost)
	by mx-out.ocsa-data.net with esmtp (Exim - FreeBSD Rulez)
	id 1TC2dl-000FcI-Bo; Thu, 13 Sep 2012 08:11:05 +0200
Received: from mx-out.ocsa-data.net ([127.0.0.1])
	by localhost (node2-3.ouvaton.local [127.0.0.1]) (amavisd-new, port 10028)
	with ESMTP id JaYB65fGRuol; Thu, 13 Sep 2012 08:11:05 +0200 (CEST)
Received: from [82.233.246.172] (helo=[192.168.0.25])
	by mx-out.ocsa-data.net with esmtpsa (Exim - FreeBSD Rulez)
	id 1TC2dl-000Fc1-9z; Thu, 13 Sep 2012 08:11:05 +0200
In-Reply-To: <20120912210455.GA30679@sigill.intra.peff.net>
X-Mailer: Evolution 3.4.4 (3.4.4-1.fc17) 
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-20 required=2
	tests=[ALL_TRUSTED=-1.44]
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205354>

Le mercredi 12 septembre 2012 =C3=A0 17:04 -0400, Jeff King a =C3=A9cri=
t :

> > > Wouldn't this break all of the code that is planning to index "W"=
 by
> > > 32-bit words (see the definitions of setW in block-sha1/sha1.c)?
> > >=20
> > That's not the same "W" ... This part of the code is indeed unclear=
=2E
>=20
> Sorry, you're right, that's a different work array (though it has the
> identical issue, no?).

No, this one is really accessed as int. But would probably benefit bein=
g
declared as uint32_t.

> But the point still stands.  Did you audit the
> block-sha1 code to make sure nobody is ever indexing the W array?=20

Yes. It was the first thing to do before changing its definition
(for alignment purpose especially).

> If you didn't, then your change is not safe. If you did, then you sho=
uld really
> mention that in the commit message.
>=20

Sorry about this.
I thought having the test suite OK was enough to prove this.

> > > If that is indeed the problem, wouldn't the simplest fix be using
> > > uint32_t instead of "unsigned int"?
> >=20
> > It's another way to fix this oddity, but not simpler.
>=20
> It is simpler in the sense that it does not have any side effects (li=
ke
> changing how every user of the data structure needs to index it).
>=20

There's no other user than blk_SHA1_Update()

> > > Moreover, would that be sufficient to run on such a platform? At =
the
> > > very least, "H" above would want the same treatment. And I would =
not be
> > > surprised if some of the actual code in block-sha1/sha1.c needed
> > > updating, as well.
> >=20
> > ctx->H is actually used as an array of integer, so it would benefit=
s of
> > being declared uint32_t for an ILP64 system. This fix would also be
> > required for blk_SHA1_Block() function.
>=20
> So...if we are not ready to run on an ILP system after this change, t=
hen
> what is the purpose?
>=20

Readility: in blk_SHA1_Block(), the ctx->W array is used a 64 bytes len
array, so, AFAIK, there's no point of having it defined as a 16 int len=
=2E
It's disturbing while reading the code.

This could allows us to change the memcpy() call further:

@@ -246,7 +246,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void
*data, unsigned long len)
                unsigned int left =3D 64 - lenW;
                if (len < left)
                        left =3D len;
-               memcpy((char *)ctx->W + lenW, data, left);
+               memcpy(ctx->W + lenW, data, left);
                lenW =3D (lenW + left) & 63;
                if (lenW)

Regards.

--=20
Yann Droneaud
OPTEYA
