From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: mark parsing in fast-import
Date: Mon, 21 Apr 2008 01:44:38 +0200
Message-ID: <20080420234438.GC12865@alea.gnuu.de>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 01:56:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnjO6-0002zU-Ss
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 01:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYDTXzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbYDTXzP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 19:55:15 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4555 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbYDTXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 19:55:14 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 6ECF248808B; Mon, 21 Apr 2008 01:55:11 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JnjKt-00063U-2C; Mon, 21 Apr 2008 01:52:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JnjD4-0003My-Ci; Mon, 21 Apr 2008 01:44:38 +0200
Content-Disposition: inline
In-Reply-To: <20080414232958.GE20979@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80005>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Shawn,

Shawn O. Pearce schrieb am Mon 14. Apr, 19:29 (-0400):
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > The format of the marks is as close as possible to the format of the
> > marks used by fast-export and fast-import,
>=20
> Yay.
>=20
> > i.e. :001 =3D=3D :1 and
> > =E2=80=9C:12a=E2=80=9D=C2=A0=3D=3D=C2=A0:12. It differs from the format=
 of fast-import in that point
> > that it requires a digit after the colon, i.e. =E2=80=9C:abc=E2=80=9D !=
=3D :0 and =E2=80=9C:-12=E2=80=9D
> > and =E2=80=9C:+12=E2=80=9D aren't allowed.
>=20
> Uh, that's a bug in fast-import.  ":4abc" is _not_ a mark if you
> read the language specification.  Only ":4" is a mark.  So we are
> accepting crap and reading it in odd ways.  Not good.

What about this:

diff --git a/fast-import.c b/fast-import.c
index 73e5439..f60e4ab 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1690,10 +1690,31 @@ static void skip_optional_lf(void)
 		ungetc(term_char, stdin);
 }
=20
+static inline int parse_mark(const const char *str, uintmax_t* mark,
+	char **after_mark)
+{
+	if (!str || str[0] !=3D ':' || !isdigit(str[1]))
+		return 1;
+
+	char *am;
+	const uintmax_t m =3D strtoumax(&str[1], &am, 10);
+	if (errno =3D=3D 0) {
+		*mark =3D m;
+		*after_mark =3D am;
+		return 0;
+	}
+	return 1;
+}
+
 static void cmd_mark(void)
 {
-	if (!prefixcmp(command_buf.buf, "mark :")) {
-		next_mark =3D strtoumax(command_buf.buf + 6, NULL, 10);
+	uintmax_t mark =3D 0;
+	char *after_mark =3D NULL;
+
+	if (!prefixcmp(command_buf.buf, "mark ") &&
+		parse_mark(&command_buf.buf[5], &mark, &after_mark) &&
+		*after_mark =3D=3D '\0') {
+		next_mark =3D mark;
 		read_next_command();
 	}
 	else
@@ -1878,7 +1899,10 @@ static void file_change_m(struct branch *b)
=20
 	if (*p =3D=3D ':') {
 		char *x;
-		oe =3D find_mark(strtoumax(p + 1, &x, 10));
+		uintmax_t m;
+		if (parse_mark(p, &m, &x))
+			die("Invalid mark: %s", p);
+		oe =3D find_mark(m);
 		hashcpy(sha1, oe->sha1);
 		p =3D x;
 	} else if (!prefixcmp(p, "inline")) {
@@ -2045,7 +2069,11 @@ static int cmd_from(struct branch *b)
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from =3D=3D ':') {
-		uintmax_t idnum =3D strtoumax(from + 1, NULL, 10);
+		char *after_mark;
+		uintmax_t idnum;
+		if (parse_mark(from, &idnum, &after_mark) ||
+			*after_mark !=3D '\0')
+			die("Not a valid mark: %s", from);
 		struct object_entry *oe =3D find_mark(idnum);
 		if (oe->type !=3D OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2080,7 +2108,11 @@ static struct hash_list *cmd_merge(unsigned int *cou=
nt)
 		if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from =3D=3D ':') {
-			uintmax_t idnum =3D strtoumax(from + 1, NULL, 10);
+			char *after_mark;
+			uintmax_t idnum;
+			if (parse_mark(from, &idnum, &after_mark) ||
+				*after_mark !=3D '\0')
+				die("Not a valid mark: %s", from);
 			struct object_entry *oe =3D find_mark(idnum);
 			if (oe->type !=3D OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2228,7 +2260,10 @@ static void cmd_new_tag(void)
 		hashcpy(sha1, s->sha1);
 	} else if (*from =3D=3D ':') {
 		struct object_entry *oe;
-		from_mark =3D strtoumax(from + 1, NULL, 10);
+		char *after_mark;
+		if (parse_mark(from, &from_mark, &after_mark) ||
+			*after_mark !=3D '\0')
+			die("Not a valid mark: %s", from);
 		oe =3D find_mark(from_mark);
 		if (oe->type !=3D OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", from_mark);
@@ -2333,9 +2368,8 @@ static void import_marks(const char *input_file)
 		if (line[0] !=3D ':' || !end)
 			die("corrupt mark line: %s", line);
 		*end =3D 0;
-		mark =3D strtoumax(line + 1, &end, 10);
-		if (!mark || end =3D=3D line + 1
-			|| *end !=3D ' ' || get_sha1(end + 1, sha1))
+		if (parse_mark(line, &mark, &end) || !mark ||
+			*end !=3D ' ' || get_sha1(end + 1, sha1))
 			die("corrupt mark line: %s", line);
 		e =3D find_object(sha1);
 		if (!e) {

Bye, J=C3=B6rg.
--=20
Wer eher stirbt ist l=C3=A4nger tot.
    	 	    	       			(Un B. Kant)

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIC9Vmwe0mZwH1VIARAu1cAKCx4c32imiwn4CENwg3VGwHVRK46QCeLqOG
QiGC3olSh43jwa5ASVtAfzc=
=li0/
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
