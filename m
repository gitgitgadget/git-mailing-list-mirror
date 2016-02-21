From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/21] harden REALLOC_ARRAY and xcalloc against size_t
 overflow
Date: Sun, 21 Feb 2016 18:30:29 -0500
Message-ID: <20160221233029.GC4094@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112200.GD9319@sigill.intra.peff.net>
 <56C8DB50.7070606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:30:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdSW-0003Fs-7d
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbcBUXac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:30:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:46399 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752434AbcBUXac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:30:32 -0500
Received: (qmail 24816 invoked by uid 102); 21 Feb 2016 23:30:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:30:32 -0500
Received: (qmail 13200 invoked by uid 107); 21 Feb 2016 23:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:30:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2016 18:30:29 -0500
Content-Disposition: inline
In-Reply-To: <56C8DB50.7070606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286844>

On Sat, Feb 20, 2016 at 10:32:00PM +0100, Ren=C3=A9 Scharfe wrote:

> >-#define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), (alloc) * siz=
eof(*(x)))
> >+#define ALLOC_ARRAY(x, alloc) (x) =3D xmalloc(st_mult((alloc), size=
of(*(x))))
> >+#define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult((allo=
c), sizeof(*(x))))
>=20
> st_mult(x, y) calls unsigned_mult_overflows(x, y), which divides by x=
=2E This
> division can be done at compile time if x is a constant.  This can be
> guaranteed for all users of the two macros above by reversing the arg=
uments
> of st_mult(), so that sizeof comes first.  Probably not a big win, bu=
t why
> not do it if it's that easy?

I doubt it's even measurable, but as you say, it's easy enough to do, s=
o
why not.

If we really care about optimizing, I suspect that something like:

diff --git a/git-compat-util.h b/git-compat-util.h
index 5cbdd2e..1d53328 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -662,10 +662,12 @@ static inline size_t st_add(size_t a, size_t b)
=20
 static inline size_t st_mult(size_t a, size_t b)
 {
-	if (unsigned_mult_overflows(a, b))
+	size_t ret;
+
+	if (__builtin_mul_overflow(a, b, &ret))
 		die("size_t overflow: %"PRIuMAX" * %"PRIuMAX,
 		    (uintmax_t)a, (uintmax_t)b);
-	return a * b;
+	return ret;
 }
=20
 static inline size_t st_sub(size_t a, size_t b)


would do a lot more. But it needs #ifdefs for compilers besides gcc and
clang.

> Or perhaps a macro like this could help here and in other places whic=
h use
> st_mult with sizeof:
>=20
>   #define SIZEOF_MULT(x, n) st_mult(sizeof(x), (n))
>=20
> (I'd call it ARRAY_SIZE, but that name is already taken. :)

I don't think we need that; we're really only checking allocations,
which means ALLOC_ARRAY() and friends cover all the uses of sizeof (we
might still use st_mult() for _another_ part of the computation, but it
won't usually be a sizeof then).

We also may do follow-up multiplications, like:

  ALLOC_ARRAY(foo, nr);
  memset(foo, 0, nr * sizeof(*foo));

but I didn't bother doing overflow checks for those. We know that they
should be fine if the original allocation was successful (though of
course, just using xcalloc here would be better still).

-Peff
