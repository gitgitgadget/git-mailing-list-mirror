From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 05 Oct 2007 17:50:23 +0200
Message-ID: <20071005155023.GA20305@artemis.corp>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org> <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pf9I7BMVVzbSWLtt";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpRs-0007WK-B0
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbXJEPuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757205AbXJEPuc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:50:32 -0400
Received: from pan.madism.org ([88.191.52.104]:46331 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbXJEPub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:50:31 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 90AC2238E4;
	Fri,  5 Oct 2007 17:50:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3E095C379; Fri,  5 Oct 2007 17:50:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60096>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 03:26:44PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Fri, 5 Oct 2007, Pierre Habouzit wrote:
> > =20
> > -	strbuf_grow(buf, len);
> > +	/* only grow if not in place */
> > +	if (strbuf_avail(buf) + buf->len < len)
> > +		strbuf_grow(buf, len - buf->len);
>=20
> Umm. This is really ugly.

  I agree.

> The whole point of strbuf's was that you shouldn't be doing your own=20
> allocation decisions etc. So why do it?

  the point here is that it's in a "filter" that is called like this:

some_filter(buf->buf, buf->len, buf);
            src       len       dst

  You can call the filter with src/len being data from anywere,
including the current content of the destination buffer.

  Then there is two cases, either the filter is known to be done in
place, either we can't know or we know it wont.

  In the latter case, we have a bit of code like that:

      char *to_free =3D NULL;

      if (buf->buf =3D=3D src)
	  to_free =3D strbuf_detach(&buf);

      .. hack ..
      free(to_free);


  In the former case, then there is a small glitch, being that if we are
doing in place editing, we should not touch buffer at all (or it would
invalidate "src"). If we are not in the in-place editing code though,
then we have to make the resulting buffer be big enough...

> Wouldn't it be much better to have a strbuf_make_room() interface that=20
> just guarantees that there is enough room fo "len"?=20

  Right, that would do the same btw ;)

> Otherwise, code like the above would seem to make the whole point of a=20
> safer string interface rather pointless. The above code only makes sense=
=20
> if you know how the strbuf's are internally done, so it should not exists=
=20
> except as internal strbuf code. No?

  Well, the above code is used in filters to spare reallocations. So if
we want to "blackbox" such a think, strbuf_make_room isn't the proper
API. We should rather use
  void *strbuf_begin_filter(struct strbuf *sb, const char *src, size_t resl=
en);
  strbuf_end_filter(void *);

  `strbuf_begin_filter` would decide upon the hint `reslen` argument if
we know if we can work in place or not (has a meaning iff src points
into the strbuf buffer). If not, it could stash the strbuf buffer in the
returned void * to be freed at the end of the filter. It seems like a
better alternative than a strbuf_make_room.

  Of course, strbuf_begin_filter() would really be simple and basically
be:

    char *tmp;
    if (src points into sb->buf && reslen > sb->alloc - 1) {
        // in place editing is OK
        return NULL;
    }
    tmp =3D strbuf_release(&sb);
    strbuf_grow(&sb, len);
    return tmp;


  and strbuf_end_filter would just be "free" :)


  We could even make "reslen" be a ssize_t so that -1 would mean "I've
absolutely no idea how much space I'll need (or just in place editing is
not supported). This way, both hacks I described in this mail could be
hidden in the strbuf module, and be properly documented _and_ safe _and_
efficient.

What do you think ?

[Though if we do that, I still think it's more important to fix the
bug in master, and have a new patch implementing this approach]
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBl0/vGr7W6HudhwRAigZAJ0ah9QHzqLApzYiY03VonzKxxwbVACfS/Zp
c0zamPcGiyDZ1zY69fVsXUM=
=dsao
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
