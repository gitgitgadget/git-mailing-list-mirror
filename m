From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Sun, 07 Oct 2007 16:53:55 +0200
Message-ID: <20071007145355.GC10024@artemis.corp>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Fig2xvG2VGoz8o/s";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 16:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeXWB-0005j9-Gq
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbXJGOx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJGOx6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:53:58 -0400
Received: from pan.madism.org ([88.191.52.104]:37094 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbXJGOx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:53:57 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0BFF623C86;
	Sun,  7 Oct 2007 16:53:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id ADB5A146E4F; Sun,  7 Oct 2007 16:53:55 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071006090621.GB2711@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60183>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 06, 2007 at 09:06:21AM +0000, Alex Riesen wrote:
> Pierre Habouzit, Fri, Oct 05, 2007 22:19:30 +0200:
> > Those are helpers to build functions that transform a buffer into a
> > strbuf, allowing the "buffer" to be taken from the destination buffer.
>=20
> They are horrible. And very specialized for these "filter" routines.
> To the point where I would move them into the file where they are used
> (convert.c only, isn't it?)

  For now they are, but moving them into convert.c is at the very least
awkward.

> If you continue to insist the code is generic enough to justify its
> residence in strbuf.c, continue reading.
>
> First off, what was wrong with dumb
>
>     void strbuf_make_room(struct strbuf *, size_t newsize);
>
> again?

  If newsize is >=3D sb->alloc then the area is reallocated, the pointer
may move, and the "src" pointer would then be invalidated.

> > +void *strbuf_start_filter(struct strbuf *sb, const char *src, ssize_t =
hint)
> > +{
> > +	if (src < sb->buf || src >=3D sb->buf + sb->alloc) {
> > +		if (hint > 0 && (size_t)hint >=3D sb->alloc)
> > +			strbuf_grow(sb, hint - sb->len);
> > +		return NULL;
> > +	}
> > +
> > +	if (hint < 0)
> > +		return strbuf_detach(sb, NULL);

> what is that for? Why can't the caller just use strbuf_detach? (He
> already has to pass negative hint somehow, which should be a concious
> action).

  The idea is to have a unified API to deal with both the cases where
the filtering is known not to work in place by the caller, or for the
cases where it could if enough space is allocated but that a realloc is
needed.


> > +	if ((size_t)hint >=3D sb->alloc) {
> > +		void *tmp =3D strbuf_detach(sb, NULL);
> > +		strbuf_grow(sb, hint);
> > +		return tmp;
> > +	}
> > +
> > +	return NULL;
> > +}
>
> How can one know when it sb is safe to use after strbuf_end_filter?

  We could document it, that's not an issue.

> It is for the first "if", for example. free() wont free the buf in sb.
> Oh, right, one can check if returned pointer !NULL. Which just adds
> more code to handle your API.

  I don't get that part. free(NULL) is totally ok.

> What actually happens to sb? Is it detached? Is it reallocated?
> When it is detached and when it is reallocated?

  It is detached if the filter does not works in place (caller says that
with '-1' as a hint) or if it works in place but needs a buffer
reallocation.

> Why is the returned pointer useful only for giving it to
> strbuf_end_filter?

  Because the filter works on a {src, len} buffer, that points into the
buffer that we must free later in strbuf_end_filter.

> Take for example your change in crlf_to_git:
> @@ -85,6 +85,7 @@ static int crlf_to_git(const char *path, const char *sr=
c, size_t len,
>  {
>  	struct text_stat stats;
>  	char *dst;
> +	void *tmp;
> =20
>  	if ((action =3D=3D CRLF_BINARY) || !auto_crlf || !len)
>  		return 0;
> @@ -110,9 +111,7 @@ static int crlf_to_git(const char *path, const char *=
src, size_t len,
>  			return 0;
>  	}
> =20
> -	/* only grow if not in place */
> -	if (strbuf_avail(buf) + buf->len < len)
> -		strbuf_grow(buf, len - buf->len);
> +	tmp =3D strbuf_start_filter(buf, src, len);
>  	dst =3D buf->buf;
>  	if (action =3D=3D CRLF_GUESS) {
>  		/*
> @@ -133,13 +132,14 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
>  		} while (--len);
>  	}
>  	strbuf_setlen(buf, dst - buf->buf);
> +	strbuf_end_filter(tmp);
>  	return 1;
>  }
>=20
> And try to rewrite it with the strbuf_make_room:
>=20
> @@ -110,9 +111,7 @@ static int crlf_to_git(const char *path, const char *=
src, size_t len,
>  			return 0;
>  	}
> =20
> -	/* only grow if not in place */
> -	if (strbuf_avail(buf) + buf->len < len)
> -		strbuf_grow(buf, len - buf->len);
> +	strbuf_make_room(buf, len);
>  	dst =3D buf->buf;
>  	if (action =3D=3D CRLF_GUESS) {
>  		/*
>=20
> The change looks rather simple

  but is wrong because you may just break "src". It's not the case here
because len always fits, but it's IMHO the kind of knowledge of the
internals of strbufs we should not rely on.

> > +/*----- filter API -----*/
> > +extern void *strbuf_start_filter(struct strbuf *, const char *, ssize_=
t);
> > +extern void strbuf_end_filter(void *p);
>=20
> I find the naming very confusing: what filtering takes place where?
> If strbuf_end_filter is just free, why is it needed at all? For the
> sake of wrapping free()?

  Those are not filters, but help writing filters that would have this
prototype:

  int some_filter(const char *src, size_t len, struct strbuf *dst);

  Allowing [src..src+len[ to be a subpart of `dst'. The usual semantics
of such filters is that it returns 0 if it did nothing, 1 if it wrote in
dst.

  This way, you can write filter_all being filter1, filter2, filter3
done one after the other this way:

int filter_all(const char *src, size_t len, struct strbuf *dst) {
    int res =3D 0;

    res |=3D filter1(src, len, dst);
    if (res) {
        src =3D dst->buf;
        len =3D dst->len;
    }
    res |=3D filter2(src, len, dst);
    if (res) {
        src =3D dst->buf;
        len =3D dst->len;
    }
    return res | filter3(src, len, dst);
}

  Note that I did not created this semantics, it was how convert.c
worked already, in a even more convoluted way before.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCPMDvGr7W6HudhwRAjEqAJ4p/xW92GEm45Zsi6Cg6V3ZUSUyCACdG5m5
6mekoBWQ8708PDJ+spm0mYE=
=0r/m
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
