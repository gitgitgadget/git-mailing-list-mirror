From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix quote_path when called with negative length.
Date: Mon, 03 Dec 2007 10:06:52 +0100
Message-ID: <20071203090652.GA25154@artemis.madism.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org> <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="GvXjxJ+pjyke8COw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 10:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz7Gn-0001j9-Ah
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 10:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbXLCJG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 04:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXLCJG4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 04:06:56 -0500
Received: from pan.madism.org ([88.191.52.104]:45462 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbXLCJGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 04:06:55 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 22DD5284C6;
	Mon,  3 Dec 2007 10:06:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D83F143CA35; Mon,  3 Dec 2007 10:06:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66891>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the len passed was -1, relative paths shortening was broken, resulting
in too long paths.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    On Sun, Dec 02, 2007 at 11:39:59PM +0000, David Symonds wrote:
    > On Dec 3, 2007 9:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
    > > Please do not take this as the final decision made by the Emperor, =
whose
    > > subjects now must follow.  This is a sanity-check to see if everybo=
dy is
    > > on the same page.
    > >
    > > I am not the Emperor anyway ;-)
    > >
    >=20
    > > Topics not in 'master' yet but should be in v1.5.4
    > > --------------------------------------------------
    > >
    > > I think the following should go in, along with what we already have=
 in
    > > 'master':
    >=20
    > Can we add the git-status/git-checkout relative path stuff that's
    > currently been sitting in 'next'? It would be a good step forward for
    > usability.

    Speaking of which, there is this irritating bug in git status that
    let it show too long paths in the first chunk (the "tracked files"
    one).

    The previous version of the function was avoiding very hard to
    compute "in" length, and had quite convoluted code because of that.
    I now compute it at the beginning. The real issue was the:

 		while (prefix[off] && off < len && prefix[off] =3D=3D in[off])

    line, when len is negative, the shortening never happens. I could
    have fixed it using ((len < 0 && in[off]) || off < len), but I
    disliked the resulting code, so I went for this.

    --=20
    =C2=B7O=C2=B7  Pierre Habouzit
    =C2=B7=C2=B7O                                                madcoder@d=
ebian.org
    OOO                                                http://www.madism.org

 wt-status.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0e0439f..eb2cbea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -84,30 +84,25 @@ static void wt_status_print_trailer(struct wt_status *s)
 static char *quote_path(const char *in, int len,
 		struct strbuf *out, const char *prefix)
 {
-	if (len > 0)
-		strbuf_grow(out, len);
+	int pos =3D 0;
+
+	if (len < 0)
+		len =3D strlen(in);
+	strbuf_grow(out, len);
 	strbuf_setlen(out, 0);
=20
 	if (prefix) {
 		int off =3D 0;
 		while (prefix[off] && off < len && prefix[off] =3D=3D in[off])
-			if (prefix[off] =3D=3D '/') {
-				prefix +=3D off + 1;
-				in +=3D off + 1;
-				len -=3D off + 1;
-				off =3D 0;
-			} else
-				off++;
-
-		for (; *prefix; prefix++)
-			if (*prefix =3D=3D '/')
+			if (prefix[off++] =3D=3D '/')
+				pos =3D off;
+		while (prefix[off])
+			if (prefix[off++] =3D=3D '/')
 				strbuf_addstr(out, "../");
 	}
=20
-	for (; (len < 0 && *in) || len > 0; in++, len--) {
-		int ch =3D *in;
-
-		switch (ch) {
+	for (; pos < len; pos++) {
+		switch (in[pos]) {
 		case '\n':
 			strbuf_addstr(out, "\\n");
 			break;
@@ -115,8 +110,8 @@ static char *quote_path(const char *in, int len,
 			strbuf_addstr(out, "\\r");
 			break;
 		default:
-			strbuf_addch(out, ch);
-			continue;
+			strbuf_addch(out, in[pos]);
+			break;
 		}
 	}
=20
--=20
1.5.3.7.2065.g3d18-dirty


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHU8csvGr7W6HudhwRAg2wAJ4gzvWeM4Qjjcp047qiaNAtzE5e4ACeNGrZ
9FRuYwteOGE70xOHc87LM28=
=jc2Z
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
