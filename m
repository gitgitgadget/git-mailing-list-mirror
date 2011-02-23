From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] format-patch: wrap long header lines
Date: Wed, 23 Feb 2011 04:58:41 -0500
Message-ID: <20110223095841.GB9222@sigill.intra.peff.net>
References: <20110223094844.GA9205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 10:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBUf-0001JU-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 10:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1BWJ6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 04:58:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab1BWJ6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 04:58:43 -0500
Received: (qmail 10786 invoked by uid 111); 23 Feb 2011 09:58:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 09:58:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 04:58:41 -0500
Content-Disposition: inline
In-Reply-To: <20110223094844.GA9205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167683>

Subject and identity headers may be arbitrarily long. In the
past, we just assumed that single-line headers would be
reasonably short. For multi-line subjects that we squish
into a single line, we just "pre-folded" the data in
pp_title_line by adding a newline and indentation.

There were two problems. One is that, although rare,
single-line messages can actually be longer than the
recommended line-length limits. The second is that the
pre-folding interacted badly with rfc2047 encoding, leading
to malformed headers.

Instead, let's stop pre-folding the subject lines, and just
fold everything based on length in add_rfc2047, whether
it is encoded or not.

Signed-off-by: Jeff King <peff@peff.net>
---
Three things to note:

  1. We call strbuf_add_wrapped_bytes for the non-encoded case. This
     nicely wraps on word and multi-character boundaries. But it will
     never do a "hard" wrap if there are no word boundaries, and it
     probably should at the 998-character mark which rfc2822 specifies
     as a hard limit.

     I don't know how much we care. For something like that you'd have
     to be maliciously trying to create a bogus patch. If you're mailin=
g
     it, you could just create the bogus mail by hand. If you're trying
     to buffer overflow somebody's "format-patch | am" script, it won't
     do anything, as mailinfo does not have a limit on line length.

  2. For the non-quoted case, technically we want to indent less on the
     first line than we do on subsequent lines (to account for "Subject=
:
     [PATCH]"). strbuf_add_wrapped_bytes doesn't support that notion. W=
e
     could add it, but it probably doesn't matter. We just end up
     wrapping the subsequent lines a little tighter than we need to.

  3. I used RFC2822's SHOULD value of 78 characters as a line length.
     That's probably unnecessarily conservative. In theory wrapping
     shouldn't make a difference to the data, but maybe people who
     hand-edit the result would prefer not to see wrapping? I dunno. In
     that case, we could set it to something higher like 120, which
     would still wrap the really ridiculous cases.

 pretty.c                |   32 +++++++++++++----
 t/t4014-format-patch.sh |   84 +++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8549934..0e167f4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -216,7 +216,15 @@ static int is_rfc2047_special(char ch)
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 		       const char *encoding)
 {
-	int i, last;
+	static const int max_length =3D 78; /* per rfc2822 */
+	int i;
+	int line_len;
+
+	/* How many bytes are already used on the current line? */
+	for (i =3D sb->len - 1; i >=3D 0; i--)
+		if (sb->buf[i] =3D=3D '\n')
+			break;
+	line_len =3D sb->len - (i+1);
=20
 	for (i =3D 0; i < len; i++) {
 		int ch =3D line[i];
@@ -225,14 +233,21 @@ static void add_rfc2047(struct strbuf *sb, const =
char *line, int len,
 		if ((i + 1 < len) && (ch =3D=3D '=3D' && line[i+1] =3D=3D '?'))
 			goto needquote;
 	}
-	strbuf_add(sb, line, len);
+	strbuf_add_wrapped_bytes(sb, line, len, 0, 1, max_length - line_len);
 	return;
=20
 needquote:
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
-	for (i =3D last =3D 0; i < len; i++) {
+	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
+	for (i =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
+
+		if (line_len >=3D max_length - 2) {
+			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
+			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
+		}
+
 		/*
 		 * We encode ' ' using '=3D20' even though rfc2047
 		 * allows using '_' for readability.  Unfortunately,
@@ -240,12 +255,14 @@ needquote:
 		 * leave the underscore in place.
 		 */
 		if (is_rfc2047_special(ch) || ch =3D=3D ' ') {
-			strbuf_add(sb, line + last, i - last);
 			strbuf_addf(sb, "=3D%02X", ch);
-			last =3D i + 1;
+			line_len +=3D 3;
+		}
+		else {
+			strbuf_addch(sb, ch);
+			line_len++;
 		}
 	}
-	strbuf_add(sb, line + last, len - last);
 	strbuf_addstr(sb, "?=3D");
 }
=20
@@ -1106,11 +1123,10 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *encoding,
 		   int need_8bit_cte)
 {
-	const char *line_separator =3D (fmt =3D=3D CMIT_FMT_EMAIL) ? "\n " : =
" ";
 	struct strbuf title;
=20
 	strbuf_init(&title, 80);
-	*msg_p =3D format_subject(&title, *msg_p, line_separator);
+	*msg_p =3D format_subject(&title, *msg_p, " ");
=20
 	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 027c13d..9c66367 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -709,4 +709,88 @@ test_expect_success TTY 'format-patch --stdout pag=
inates' '
 	test_path_is_missing .git/pager_used
 '
=20
+test_expect_success 'format-patch handles multi-line subjects' '
+	rm -rf patches/ &&
+	echo content >>file &&
+	for i in one two three; do echo $i; done >msg &&
+	git add file &&
+	git commit -F msg &&
+	git format-patch -o patches -1 &&
+	grep ^Subject: patches/0001-one.patch >actual &&
+	echo "Subject: [PATCH] one two three" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format-patch handles multi-line encoded subjects'=
 '
+	rm -rf patches/ &&
+	echo content >>file &&
+	for i in en tv=C3=A5 tre; do echo $i; done >msg &&
+	git add file &&
+	git commit -F msg &&
+	git format-patch -o patches -1 &&
+	grep ^Subject: patches/0001-en.patch >actual &&
+	echo "Subject: [PATCH] =3D?UTF-8?q?en=3D20tv=3DC3=3DA5=3D20tre?=3D" >=
expect &&
+	test_cmp expect actual
+'
+
+M8=3D"foo bar "
+M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
+M512=3D$M64$M64$M64$M64$M64$M64$M64$M64
+cat >expect <<'EOF'
+Subject: [PATCH] foo bar foo bar foo bar foo bar foo bar foo bar foo b=
ar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
+ foo bar foo bar foo bar foo bar
+EOF
+test_expect_success 'format-patch wraps extremely long headers (ascii)=
' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "$M512" &&
+	git format-patch --stdout -1 >patch &&
+	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	test_cmp expect subject
+'
+
+M8=3D"f=C3=B6=C3=B6 bar "
+M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
+M512=3D$M64$M64$M64$M64$M64$M64$M64$M64
+cat >expect <<'EOF'
+Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3D=
B6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+EOF
+test_expect_success 'format-patch wraps extremely long headers (rfc204=
7)' '
+	rm -rf patches/ &&
+	echo content >>file &&
+	git add file &&
+	git commit -m "$M512" &&
+	git format-patch --stdout -1 >patch &&
+	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	test_cmp expect subject
+'
+
 test_done
--=20
1.7.2.5.15.gfdd1c
