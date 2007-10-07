From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Sun, 07 Oct 2007 18:52:18 +0200
Message-ID: <20071007165218.GE10024@artemis.corp>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home> <20071007145355.GC10024@artemis.corp> <20071007160707.GA3270@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Uwl7UQhJk99r8jnw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZMq-0007oh-AA
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXJGQwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXJGQwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:52:25 -0400
Received: from pan.madism.org ([88.191.52.104]:60476 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbXJGQwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:52:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9EF7723956;
	Sun,  7 Oct 2007 18:52:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 03A8D2A02; Sun,  7 Oct 2007 18:52:18 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071007160707.GA3270@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60200>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 04:07:07PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Sun, Oct 07, 2007 16:53:55 +0200:
> > On Sat, Oct 06, 2007 at 09:06:21AM +0000, Alex Riesen wrote:
> > > If you continue to insist the code is generic enough to justify its
> > > residence in strbuf.c, continue reading.
> > >
> > > First off, what was wrong with dumb
> > >
> > >     void strbuf_make_room(struct strbuf *, size_t newsize);
> > >
> > > again?
> >=20
> >   If newsize is >=3D sb->alloc then the area is reallocated, the pointer
> > may move, and the "src" pointer would then be invalidated.
>=20
> So what? You already _have_ to know it points inside the strbuf, so
> you can't expect it to be valid after any serious strbuf operation.

  Then you can't write a filter, because you need to reallocate the
buffer before even starting to read the input buffer sometimes. If you
reallocate the strbuf, and that your original buffer was in there, you
lose.

> >   The idea is to have a unified API to deal with both the cases where
> > the filtering is known not to work in place by the caller, or for the
> > cases where it could if enough space is allocated but that a realloc is
> > needed.
>
> this just makes it convoluted and opaque (as in "not transparent")

  I'm totally open to better alternatives. We could probably easily get
rid of strbuf_end_filter, as whichever way to deal with the issue I try
to solve in a better way, in the end, it will always be just a "free".

  So, maybe there is a way to rename strbuf_start_filter so that it's
more straightforward. The way to use the API is:

 @  char *to_free =3D NULL;
 @  if ((src is inside dst && need_realloc) || operation is not in-place)
 @      to_free =3D strbuf_detach(dst, NULL);
 @  strbuf_make_room(dst, needed_size);

    // do whatever you want with src and dst

    free(to_free);

strbuf_start_filter tries to implement the block marked with `@'.  Of
course:
  * need_realloc =3D=3D (needed_size >=3D dst->alloc)
  * src is inside dst means:
    src > dst->buf && src < dst->buf + dst->alloc
Though, those are both things that I find ugly to "know" in convert.c.
How things are allocated in strbufs is one of the few things we don't
want to assume anywhere outside of the strbuf module.

> > > It is for the first "if", for example. free() wont free the buf in sb.
> > > Oh, right, one can check if returned pointer !NULL. Which just adds
> > > more code to handle your API.
> >
> >   I don't get that part. free(NULL) is totally ok.
>
> Not that. One have to store the result of start_filter and check it

  Why check it ? You don't have to check. You have to keep it until
you're done with "src". Whichever the result was. The return of
strbuf_start_filter intends to stash a pointer to be freed for the cases
where "src" points into the destination buffer.

> >   Note that I did not created this semantics, it was how convert.c
> > worked already, in a even more convoluted way before.
>
> And why shouldn't these semantics kept to convert.c?

  I missed where having this live in convert.c rather than in strbuf.c
makes it less ugly or better in any sense.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCQ7CvGr7W6HudhwRApuTAKCGxaK54O70YlLyZOlN9TENjj0Y8ACeIuCj
m2yt6i15AIaVt/jtuUA2ZvI=
=c15C
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
