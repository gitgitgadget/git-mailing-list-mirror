From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 22:37:10 +0200
Organization: OPTEYA
Message-ID: <1347482230.1961.4.camel@test.quest-ce.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
	 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
	 <20120912183833.GA20795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:01:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBu3S-0005TF-TU
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab2ILVAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Sep 2012 17:00:55 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:58846 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab2ILVAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 17:00:54 -0400
Received: from [127.0.0.1] (helo=localhost)
	by mx-out.ocsa-data.net with esmtp (Exim - FreeBSD Rulez)
	id 1TBtgQ-0002f1-87; Wed, 12 Sep 2012 22:37:14 +0200
Received: from mx-out.ocsa-data.net ([127.0.0.1])
	by localhost (node2-2.ouvaton.local [127.0.0.1]) (amavisd-new, port 10028)
	with ESMTP id qDpqEY3jpj+s; Wed, 12 Sep 2012 22:37:10 +0200 (CEST)
Received: from [82.233.246.172] (helo=[192.168.0.25])
	by mx-out.ocsa-data.net with esmtpsa (Exim - FreeBSD Rulez)
	id 1TBtgM-0002eW-9G; Wed, 12 Sep 2012 22:37:10 +0200
In-Reply-To: <20120912183833.GA20795@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205337>

Le mercredi 12 septembre 2012 =C3=A0 14:38 -0400, Jeff King a =C3=A9cri=
t :
> On Wed, Sep 12, 2012 at 12:30:45PM +0200, Yann Droneaud wrote:
>=20
> > The SHA context is holding a temporary buffer for partial block.
> >=20
> > This block must 64 bytes long. It is currently described as
> > an array of 16 integers.
> >=20
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > ---
> >  block-sha1/sha1.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> > index b864df6..d29ff6a 100644
> > --- a/block-sha1/sha1.h
> > +++ b/block-sha1/sha1.h
> > @@ -9,7 +9,7 @@
> >  typedef struct {
> >  	unsigned long long size;
> >  	unsigned int H[5];
> > -	unsigned int W[16];
> > +	unsigned char W[64];
> >  } blk_SHA_CTX;
>=20
> Wouldn't this break all of the code that is planning to index "W" by
> 32-bit words (see the definitions of setW in block-sha1/sha1.c)?
>=20

That's not the same "W" ... This part of the code is indeed unclear.

> You do not describe an actual problem in the commit message, but read=
ing
> between the lines it would be "system X would like to use block-sha1,
> but has an "unsigned int" that is not 32 bits". IOW, an ILP64 type of
> architecture. Do you have some specific platform in mind?
>=20
> If that is indeed the problem, wouldn't the simplest fix be using
> uint32_t instead of "unsigned int"?
>=20

It's another way to fix this oddity, but not simpler.


> Moreover, would that be sufficient to run on such a platform? At the
> very least, "H" above would want the same treatment. And I would not =
be
> surprised if some of the actual code in block-sha1/sha1.c needed
> updating, as well.
>=20

ctx->H is actually used as an array of integer, so it would benefits of
being declared uint32_t for an ILP64 system. This fix would also be
required for blk_SHA1_Block() function.

Regards.

--=20
Yann Droneaud
OPTEYA
