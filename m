From: Martin Stenberg <martin@gnutiken.se>
Subject: Re: [PATCH] fix incorrect line number report for bad gitconfig
Date: Mon, 12 Mar 2012 13:01:05 +0100
Message-ID: <20120312120105.GA19176@gnutiken.se>
References: <20120309223014.GA6380@gnutiken.se>
 <7v8vj94c1a.fsf@alter.siamese.dyndns.org>
 <7vhaxuuzvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:01:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73vy-00081t-FX
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab2CLMAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 08:00:54 -0400
Received: from gnutiken.se ([109.74.202.65]:44862 "EHLO gnutiken.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab2CLMAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:00:53 -0400
Received: from gnutiken.se (c83-248-130-230.bredband.comhem.se [83.248.130.230])
	by gnutiken.se (Postfix) with ESMTPSA id 2AE04EA005;
	Mon, 12 Mar 2012 13:00:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhaxuuzvt.fsf@alter.siamese.dyndns.org>
X-Disclaimer: 815934693
X-Mailer: mutt
X-Evilbit: 0
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192858>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 11, 2012 at 10:55:34PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Martin Stenberg <martin@gnutiken.se> writes:
> >
> >> From c88f00e06cb877f9d944fdec480f53a7a42dd990 Mon Sep 17 00:00:00 2001
> >> From: Martin Stenberg <martin@gnutiken.se>
> >> Date: Fri, 9 Mar 2012 22:57:54 +0100
> >> Subject: [PATCH] fix incorrect line number report for bad gitconfig
> >
> > Please drop these four lines. The commit object name is no use to
> > me, and the other lines duplicate what you have in the mail header.
> > ...
> > Please have a paragraph break before your S-o-b: line.
> >
> > Thanks. Review of the patch text follows.
> > ...
>=20
> Also could you add a couple of tests (you identified two cases in
> your log message) to make sure this fix will not be broken in the
> future, perhaps to t1300?
>=20
> Thanks.

Thanks for the feedback. Fixed the code and added two test cases.

New commit description and patch follows.

fix incorrect line number report for bad config

A section in a config file with a missing "]" reports the next line as being
bad, same goes to a value with a missing end quote.

This happens because the error is not detected until the end of the line, w=
hen
line number is already increased. Fix this issue by decreasing line number =
by
one for these cases.

Signed-off-by: Martin Stenberg <martin@gnutiken.se>
---
 config.c               |   14 ++++++++++----
 t/t1300-repo-config.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index ad03908..0019b1c 100644
--- a/config.c
+++ b/config.c
@@ -197,7 +197,7 @@ static char *parse_value(void)
 		int c =3D get_next_char();
 		if (c =3D=3D '\n') {
 			if (quote)
-				return NULL;
+				goto error_incomplete_line;
 			return cf->value.buf;
 		}
 		if (comment)
@@ -245,6 +245,9 @@ static char *parse_value(void)
 		}
 		strbuf_addch(&cf->value, c);
 	}
+error_incomplete_line:
+	cf->linenr--;
+	return NULL;
 }
=20
 static inline int iskeychar(int c)
@@ -287,7 +290,7 @@ static int get_extended_base_var(char *name, int basele=
n, int c)
 {
 	do {
 		if (c =3D=3D '\n')
-			return -1;
+			goto error_incomplete_line;
 		c =3D get_next_char();
 	} while (isspace(c));
=20
@@ -299,13 +302,13 @@ static int get_extended_base_var(char *name, int base=
len, int c)
 	for (;;) {
 		int c =3D get_next_char();
 		if (c =3D=3D '\n')
-			return -1;
+			goto error_incomplete_line;
 		if (c =3D=3D '"')
 			break;
 		if (c =3D=3D '\\') {
 			c =3D get_next_char();
 			if (c =3D=3D '\n')
-				return -1;
+				goto error_incomplete_line;
 		}
 		name[baselen++] =3D c;
 		if (baselen > MAXNAME / 2)
@@ -316,6 +319,9 @@ static int get_extended_base_var(char *name, int basele=
n, int c)
 	if (get_next_char() !=3D ']')
 		return -1;
 	return baselen;
+error_incomplete_line:
+	cf->linenr--;
+	return -1;
 }
=20
 static int get_base_var(char *name)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 5f249f6..dac3008 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -985,4 +985,40 @@ test_expect_success 'git config --edit respects core.e=
ditor' '
 	test_cmp expect actual
 '
=20
+cat > expect <<EOF
+fatal: bad config file line 1 in .git/config
+EOF
+
+cat > .git/config <<\EOF
+[section
+key =3D value
+EOF
+
+test_expect_success 'incomplete section line' '
+	if git config --get section.key 2>actual
+	then
+		echo config should have failed
+		false
+	fi &&
+	cmp actual expect
+'
+
+cat > expect <<EOF
+fatal: bad config file line 2 in .git/config
+EOF
+
+cat > .git/config <<\EOF
+[section]
+    key =3D "value
+EOF
+
+test_expect_success 'incomplete quoted line' '
+	if git config --get section.key 2>actual
+	then
+		echo config should have failed
+		false
+	fi &&
+	cmp actual expect
+'
+
 test_done
--=20
1.7.9.1


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPXeV7AAoJEGP7bLlG/aTxjyAP/ifGGxdtwVK15kUFRaVCMFeb
I/dkgGp5Ybien5iiaXY1k2FsPyrBcsMBc6OsUvJ8IdJjVs5Z7We8FcNu28FuOE/0
96tjStNCfKy3VMVsxIcrHyyZa/AW1qUJhmQqUikR56X7GzaJc7yyykWHxSTOoIFY
M0WabFr04QvKFMjauc7UOosDvyhtdCcjpK4I2yoxkYD9wcHj1FRUW4GIUaLJr2yU
dhi+Yzp7ANnDMWg0hMv/gKL4aN2cNr9qF/c7sn9Xho8VWN/ALZfqXImCETOWL2ns
bWGY8eZi/Z/IV2w2f0Dw8dywFGLD/r6sYTNjQPoQmADDPcbbON/IsOol4c+dAMQA
7D9C4RY/8P7db8A1wQ1o86bXgYsN1CPO4Lqy3YscjVWtcwLqtUXJOw0tFVpiDeO3
Q0BEgD+bU3qAx64mGpe7xtqMdQ1uQCJPCXd+3WYXBjaLd4lGObHCUtoUmOM2WqSd
YIn5deDSYvJn3xuvXsHYqp+KpZAp6kONUpRLuO/3js2f8iiDb2JnNpASQqxJYcCe
HhRxfd9sSC5s0kMhFfX3McitGYytETcH7VQ262bKwJLNC2+J62+Vho5ljlhRsj4z
dYkp0gZ/GzuQCzPrC6K/f2jYLGep1nI/Qum6XYnSZrGBLDCuK4UfKLVpikRcji8v
Nm4pxfLrlK+4FleOeerM
=72SO
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
