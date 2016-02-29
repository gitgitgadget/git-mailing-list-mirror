From: Jeff King <peff@peff.net>
Subject: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 04:28:16 -0500
Message-ID: <20160229092816.GA23910@sigill.intra.peff.net>
References: <56D3E56A.5010608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 10:28:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaK7w-0002Dd-BB
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 10:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbcB2J2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 04:28:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:51224 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753388AbcB2J2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 04:28:20 -0500
Received: (qmail 9346 invoked by uid 102); 29 Feb 2016 09:28:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 04:28:20 -0500
Received: (qmail 24037 invoked by uid 107); 29 Feb 2016 09:28:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 04:28:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 04:28:16 -0500
Content-Disposition: inline
In-Reply-To: <56D3E56A.5010608@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287813>

On Mon, Feb 29, 2016 at 07:30:02AM +0100, Torsten B=C3=B6gershausen wro=
te:

> I haven't digged further,
> but trying to verify t9115 under Windows gave this:
>=20
> compat/mingw.c: In function 'mingw_spawnve_fd':
> compat/mingw.c:1072:10: warning: implicit declaration of function
> 'xmalloc_array' [-Wimplicit-function-declaration]
>   wargs =3D xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wch=
ar_t));
>           ^

Yikes.

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
I think this means "master" is broken for mingw builds.

Sorry, Windows people, for breaking your build. I'm happy to hold back
such repo-wide cleanups from the mingw code in the future, since I can'=
t
actually compile them. But the flipside is that if I _do_ improve
things, you don't get the benefit until somebody manually ports it over=
=2E

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
