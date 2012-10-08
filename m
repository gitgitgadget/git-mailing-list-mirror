From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH 3/5] format-patch: introduce helper function last_line_length()
Date: Mon,  8 Oct 2012 19:33:27 +0200
Message-ID: <1349717609-4770-4-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 19:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHSW-0006lz-2z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab2JHRta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 13:49:30 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:48593 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab2JHRt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:49:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 1F90A7DF0
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 19:39:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id W3hVXFs4g-jJ 08635-17;
	Mon,  8 Oct 2012 19:39:08 +0200 (CEST) 13628
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Mon,  8 Oct 2012 19:39:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207250>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

Currently, an open-coded loop to calculate the length of the last
line of a string buffer is used in multiple places.

Move that code into a function of its own.

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
 pretty.c | 25 +++++++++++++------------
 1 Datei ge=C3=A4ndert, 13 Zeilen hinzugef=C3=BCgt(+), 12 Zeilen entfer=
nt(-)

diff --git a/pretty.c b/pretty.c
index daf8581..ee76219 100644
--- a/pretty.c
+++ b/pretty.c
@@ -240,6 +240,17 @@ static int has_rfc822_specials(const char *s, int =
len)
 	return 0;
 }
=20
+static int last_line_length(struct strbuf *sb)
+{
+	int i;
+
+	/* How many bytes are already used on the last line? */
+	for (i =3D sb->len - 1; i >=3D 0; i--)
+		if (sb->buf[i] =3D=3D '\n')
+			break;
+	return sb->len - (i + 1);
+}
+
 static void add_rfc822_quoted(struct strbuf *out, const char *s, int l=
en)
 {
 	int i;
@@ -280,13 +291,7 @@ static void add_rfc2047(struct strbuf *sb, const c=
har *line, int len,
 {
 	static const int max_length =3D 76; /* per rfc2047 */
 	int i;
-	int line_len;
-
-	/* How many bytes are already used on the current line? */
-	for (i =3D sb->len - 1; i >=3D 0; i--)
-		if (sb->buf[i] =3D=3D '\n')
-			break;
-	line_len =3D sb->len - (i+1);
+	int line_len =3D last_line_length(sb);
=20
 	for (i =3D 0; i < len; i++) {
 		int ch =3D line[i];
@@ -344,7 +349,6 @@ void pp_user_info(const struct pretty_print_context=
 *pp,
 	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
 		char *name_tail =3D strchr(line, '<');
 		int display_name_length;
-		int final_line;
 		if (!name_tail)
 			return;
 		while (line < name_tail && isspace(name_tail[-1]))
@@ -359,10 +363,7 @@ void pp_user_info(const struct pretty_print_contex=
t *pp,
 			add_rfc2047(sb, quoted.buf, quoted.len, encoding);
 			strbuf_release(&quoted);
 		}
-		for (final_line =3D 0; final_line < sb->len; final_line++)
-			if (sb->buf[sb->len - final_line - 1] =3D=3D '\n')
-				break;
-		if (namelen - display_name_length + final_line > 78) {
+		if (namelen - display_name_length + last_line_length(sb) > 78) {
 			strbuf_addch(sb, '\n');
 			if (!isspace(name_tail[0]))
 				strbuf_addch(sb, ' ');
--=20
1.7.12
