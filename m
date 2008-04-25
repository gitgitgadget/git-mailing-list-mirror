From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2] Make mark parsing much more restrictive
Date: Fri, 25 Apr 2008 11:04:24 +0200
Message-ID: <1209114264-10742-1-git-send-email-joerg@alea.gnuu.de>
References: <20080422231515.GJ29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 11:48:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpKXc-0005VX-EO
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 11:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756AbYDYJrj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2008 05:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbYDYJrh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 05:47:37 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2481 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYDYJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 05:47:36 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 8CE53EC054; Fri, 25 Apr 2008 11:47:34 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpJqy-0004gO-TT; Fri, 25 Apr 2008 11:04:25 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpJqy-0002nc-LM; Fri, 25 Apr 2008 11:04:24 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <20080422231515.GJ29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80331>

The current implementation of mark parsing doesn't care for trailing
garbage like in :12a and doesn't check for unsigned numbers, i.e. it
accepts :-12 as a valid mark.

This patch enforces a number follows the colon and there comes nothing
after the bignum.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 fast-import.c |   49 ++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 11 deletions(-)

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> >
> > Another question: Is :0 a valid mark? In import_marks() is a check =
for
> > !mark, but I haven't seen it anywhere else.
>=20
> No, in fast-import ":0" is _not_ a valid mark.

Then I propose the following patch.

diff --git a/fast-import.c b/fast-import.c
index 73e5439..0c71da8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1690,12 +1690,31 @@ static void skip_optional_lf(void)
 		ungetc(term_char, stdin);
 }
=20
+static inline uintmax_t parse_mark(const const char *str, char **after=
_mark)
+{
+	char *am;
+	uintmax_t m;
+
+	if (!str || str[0] !=3D ':' || !isdigit(str[1]))
+		return 0;
+
+	m =3D strtoumax(&str[1], &am, 10);
+	if (m !=3D UINTMAX_MAX || errno =3D=3D 0) {
+		*after_mark =3D am;
+		return m;
+	}
+	return 0;
+}
+
 static void cmd_mark(void)
 {
-	if (!prefixcmp(command_buf.buf, "mark :")) {
-		next_mark =3D strtoumax(command_buf.buf + 6, NULL, 10);
+	uintmax_t mark;
+	char *after_mark =3D NULL;
+
+	if (!prefixcmp(command_buf.buf, "mark ") &&
+		(next_mark =3D parse_mark(&command_buf.buf[5], &after_mark)) &&
+		*after_mark =3D=3D '\0')
 		read_next_command();
-	}
 	else
 		next_mark =3D 0;
 }
@@ -1877,8 +1896,8 @@ static void file_change_m(struct branch *b)
 	}
=20
 	if (*p =3D=3D ':') {
-		char *x;
-		oe =3D find_mark(strtoumax(p + 1, &x, 10));
+		char *x =3D NULL;
+		oe =3D find_mark(parse_mark(p, &x));
 		hashcpy(sha1, oe->sha1);
 		p =3D x;
 	} else if (!prefixcmp(p, "inline")) {
@@ -2045,7 +2064,10 @@ static int cmd_from(struct branch *b)
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from =3D=3D ':') {
-		uintmax_t idnum =3D strtoumax(from + 1, NULL, 10);
+		char *after_mark;
+		uintmax_t idnum =3D parse_mark(from, &after_mark);
+		if (!idnum || *after_mark !=3D '\0')
+			die("Not a valid mark: %s", from);
 		struct object_entry *oe =3D find_mark(idnum);
 		if (oe->type !=3D OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2080,7 +2102,10 @@ static struct hash_list *cmd_merge(unsigned int =
*count)
 		if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from =3D=3D ':') {
-			uintmax_t idnum =3D strtoumax(from + 1, NULL, 10);
+			char *after_mark;
+			uintmax_t idnum =3D parse_mark(from, &after_mark);
+			if (!idnum || *after_mark !=3D '\0')
+				die("Not a valid mark: %s", from);
 			struct object_entry *oe =3D find_mark(idnum);
 			if (oe->type !=3D OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2228,7 +2253,10 @@ static void cmd_new_tag(void)
 		hashcpy(sha1, s->sha1);
 	} else if (*from =3D=3D ':') {
 		struct object_entry *oe;
-		from_mark =3D strtoumax(from + 1, NULL, 10);
+		char *after_mark;
+		from_mark =3D parse_mark(from, &after_mark);
+		if (!from_mark || *after_mark !=3D '\0')
+			die("Not a valid mark: %s", from);
 		oe =3D find_mark(from_mark);
 		if (oe->type !=3D OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", from_mark);
@@ -2333,9 +2361,8 @@ static void import_marks(const char *input_file)
 		if (line[0] !=3D ':' || !end)
 			die("corrupt mark line: %s", line);
 		*end =3D 0;
-		mark =3D strtoumax(line + 1, &end, 10);
-		if (!mark || end =3D=3D line + 1
-			|| *end !=3D ' ' || get_sha1(end + 1, sha1))
+		mark =3D parse_mark(line, &end);
+		if (!mark || *end !=3D ' ' || get_sha1(end + 1, sha1))
 			die("corrupt mark line: %s", line);
 		e =3D find_object(sha1);
 		if (!e) {
--=20
1.5.5.1
