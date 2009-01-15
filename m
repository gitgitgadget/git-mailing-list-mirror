From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional regular expression describing words
Date: Thu, 15 Jan 2009 11:40:16 +0100
Message-ID: <200901151140.20215.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901150235122.3586@pacific.mpi-cbg.de> <200901150930.38100.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1384585.gpK8V8rKh7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNPfJ-00083C-Ef
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 11:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759937AbZAOKkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 05:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759934AbZAOKkG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 05:40:06 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52014 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759679AbZAOKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 05:40:04 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:40:01 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:40:01 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901150930.38100.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Jan 2009 10:40:01.0418 (UTC) FILETIME=[9E771EA0:01C976FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105779>

--nextPart1384585.gpK8V8rKh7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Johannes Schindelin wrote:
> > If a hunk header '@@ -2 +1,0 @@' is found that logically should be
> > '@@ -2 +2,0 @@', diff_words got confused.
> [...]
> > This might be a libxdiff issue, though.
>=20
> Looks like it's just bug-for-bug compatible with diff.  At least my
> GNU diffutils 2.8.7 show the same behaviour.

I think the culprit is in

  commit ca557afff9f7dad7a8739cd193ac0730d872e282
  Author: Davide Libenzi <davidel@xmailserver.org>
  Date:   Mon Apr 3 18:47:55 2006 -0700

      Clean-up trivially redundant diff.

      Also corrects the line numbers in unified output when using
      zero lines context.
[...]
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
[...]
  @@ -244,7 +257,7 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long=
 c2,
          memcpy(buf, "@@ -", 4);
          nb +=3D 4;

  -       nb +=3D xdl_num_out(buf + nb, c1 ? s1: 0);
  +       nb +=3D xdl_num_out(buf + nb, c1 ? s1: s1 - 1);

          if (c1 !=3D 1) {
                  memcpy(buf + nb, ",", 1);
  @@ -256,7 +269,7 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long=
 c2,
          memcpy(buf + nb, " +", 2);
          nb +=3D 2;

  -       nb +=3D xdl_num_out(buf + nb, c2 ? s2: 0);
  +       nb +=3D xdl_num_out(buf + nb, c2 ? s2: s2 - 1);

          if (c2 !=3D 1) {
                  memcpy(buf + nb, ",", 1);


Note how (for some reason I don't quite understand yet) "correcting"
the offsets involves subtracting 1 if there were no changes on that
side.

But skipping ahead to the end doesn't work if there are several such
instances where nothing was added.  So I think it must be fixed as
follows.

=2D--- 8< ----
diff --git a/diff.c b/diff.c
index 4174d88..d7bbf74 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -361,8 +361,9 @@ static void fn_out_diff_words_aux(void *priv, char *lin=
e, unsigned long len)
 		diff_words->plus.orig[plus_first + plus_len - 1].end;
=20
 	/*
=2D	 * since this is a --unified=3D0 diff, it can result in a single hunk
=2D	 * with a header like this: @@ -2 +1,0 @@
+	 * libxdiff subtracts one from the offset if the corresponding
+	 * length is 0.	 (This can only happen because we use
+	 * --unified=3D0.)
 	 *
 	 * This breaks the assumption that minus_first =3D=3D plus_first.
 	 *
@@ -373,10 +374,9 @@ static void fn_out_diff_words_aux(void *priv, char *li=
ne, unsigned long len)
 	 * It is only necessary for the plus part, as we show the common
 	 * words from that buffer.
 	 */
=2D	if (plus_len =3D=3D 0 && minus_first + minus_len
=2D			=3D=3D diff_words->minus.orig_nr)
+	if (plus_len =3D=3D 0)
 		plus_begin =3D plus_end =3D
=2D			diff_words->plus.orig[diff_words->plus.orig_nr - 1].end;
+			diff_words->plus.orig[plus_first + plus_len].end;
=20
 	if (diff_words->current_plus !=3D plus_begin)
 		fwrite(diff_words->current_plus,
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 744221b..875b464 100755
=2D-- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -156,4 +156,40 @@ test_expect_success 'test when words are only removed =
at the end' '
=20
 '
=20
+echo 'abcd(Xefghijklmn(YZopqrst' > pre
+echo 'abcd(efghijklmn(opqrst' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 434ff54..c4bb9f1 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+abcd(<RED>X<RESET>efghijklmn(<RED>YZ<RESET>opqrst
+EOF
+
+test_expect_success 'no added words' '
+
+	word_diff --color-words=3D.
+
+'
+
+echo 'abcd(efghijklmn(opqrst' > pre
+echo 'abcd(Xefghijklmn(YZopqrst' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index c4bb9f1..434ff54 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+abcd(<GREEN>X<RESET>efghijklmn(<GREEN>YZ<RESET>opqrst
+EOF
+
+test_expect_success 'no removed words' '
+
+	word_diff --color-words=3D.
+
+'
+
 test_done
=2D-=20
1.6.1.283.g653b2

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1384585.gpK8V8rKh7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAklvEpQACgkQqUud07tmzP06pQCXdL/SyQhyxa9JYv/jcJmM4uQD
BQCggxLbMyPalLGsowH93+cyh7z5cAg=
=Pitp
-----END PGP SIGNATURE-----

--nextPart1384585.gpK8V8rKh7--
