From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 05:02:59 -0500
Message-ID: <20160229100258.GC2950@sigill.intra.peff.net>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net>
 <56D415C6.2040203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 11:03:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKfU-00016R-W1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbcB2KDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 05:03:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:51257 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752622AbcB2KDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:03:02 -0500
Received: (qmail 10778 invoked by uid 102); 29 Feb 2016 10:03:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:03:01 -0500
Received: (qmail 24335 invoked by uid 107); 29 Feb 2016 10:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:03:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 05:02:59 -0500
Content-Disposition: inline
In-Reply-To: <56D415C6.2040203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287818>

On Mon, Feb 29, 2016 at 10:56:22AM +0100, Torsten B=C3=B6gershausen wro=
te:

> Thanks for the fast-patch.
>=20
> I manually copied the patch, But there are more probles, it seems.
>=20
> $ git diff
> diff --git a/compat/mingw.c b/compat/mingw.c
> index cfedcf9..b1163f2 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, =
const
> char **argv, char **deltaen
>                         free(quoted);
>         }
>=20
> -       wargs =3D xmalloc_array(st_add(st_mult(2, args.len), 1), size=
of(wchar_t));
> +       wargs =3D ALLOC_ARRAY(st_add(st_mult(2, args.len), 1), sizeof=
(wchar_t));
>         xutftowcs(wargs, args.buf, 2 * args.len + 1);
>         strbuf_release(&args);

Argh. Let me write "git commit -a" on the inside of my brown paper bag,
so that I actually send out the fix sitting in my working tree, not the
half-finished thing I ran "git add" on.

-- >8 --
Subject: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e

Commit 50a6c8e (use st_add and st_mult for allocation size
computation, 2016-02-22) fixed up many xmalloc call-sites
including ones in compat/mingw.c.

But I screwed up one of them, which was half-converted to
ALLOC_ARRAY, using a very early prototype of the function.
And I never caught it because I don't build on Windows.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index cfedcf9..54c82ec 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, co=
nst char **argv, char **deltaen
 			free(quoted);
 	}
=20
-	wargs =3D xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar=
_t));
+	ALLOC_ARRAY(wargs, st_add(st_mult(2, args.len), 1));
 	xutftowcs(wargs, args.buf, 2 * args.len + 1);
 	strbuf_release(&args);
=20
--=20
2.8.0.rc0.276.gddf4100
