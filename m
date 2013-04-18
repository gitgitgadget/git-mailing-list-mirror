From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 13/13] pretty: support %>> that steal trailing spaces
Date: Fri, 19 Apr 2013 09:08:52 +1000
Message-ID: <1366326532-28517-14-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxyR-0008O0-DF
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967255Ab3DRXKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:35 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:49718 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936487Ab3DRXKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:10:34 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so31562pbb.23
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1+zaczGSNpZ1B+6O7hXNZ/CPiaqXJs86YcEvfoxdlPk=;
        b=BalpVDwjm2iaQDiHU6rLxWm+uia47iRFoeVlG3aYNNv6ThvEzmWHLAk5ZIph7LCy0M
         rJAqUGlxIgPtMYw4Oeya3uwRf77nd8Ntn69Zjls0YWoW/7ta89w2PxGvF/kLLFZXBdPD
         DUXwOeQrGNKsoeQx2ythIWtV9psbyzeJnMzzDX5ZglMpnGho0sAAv+wQB5KmfCOwNYa8
         Q6O8McKklp7cAeq/WXSgGHx9ol2h3NdaMVLXOxL4BoVax9fJSPPFvAAfKNNb7a146ZPS
         +29exzRBo57dmVVhZAJmjdukG1PYvxZXD0UDi1o5QAufBt3G2uJfyc5hP5VYKecf1V/h
         i5Fg==
X-Received: by 10.68.193.230 with SMTP id hr6mr15933504pbc.67.1366326634207;
        Thu, 18 Apr 2013 16:10:34 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id tx9sm11184757pbc.27.2013.04.18.16.10.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:10:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:10:24 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221715>

This is pretty useful in `%<(100)%s%Cred%>(20)% an' where %s does not
use up all 100 columns and %an needs more than 20 columns. By
replacing %>(20) with %>>(20), %an can steal spaces from %s.

%>> understands escape sequences, so %Cred does not stop it from
stealing spaces in %<(100).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  5 ++++-
 pretty.c                         | 34 ++++++++++++++++++++++++++++++++=
++
 t/t4205-log-pretty-formats.sh    | 14 ++++++++++++++
 utf8.c                           |  2 +-
 utf8.h                           |  1 +
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index d3450bf..c96ff41 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -173,7 +173,10 @@ The placeholders are:
   columns, padding spaces on the right if necessary
 - '%>(<N>)', '%>|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
   respectively, but padding spaces on the left
-- '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
+- '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N>)', '%>|(<N>)'
+  respectively, except that if the next placeholder takes more spaces
+  than given and there are spaces on its left, use those spaces
+- '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
=20
 NOTE: Some placeholders may depend on other options given to the
diff --git a/pretty.c b/pretty.c
index f7c6442..d59579a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -773,6 +773,7 @@ enum flush_type {
 	no_flush,
 	flush_right,
 	flush_left,
+	flush_left_and_steal,
 	flush_both
 };
=20
@@ -1026,6 +1027,9 @@ static size_t parse_padding_placeholder(struct st=
rbuf *sb,
 		if (*ch =3D=3D '<') {
 			flush_type =3D flush_both;
 			ch++;
+		} else if (*ch =3D=3D '>') {
+			flush_type =3D flush_left_and_steal;
+			ch++;
 		} else
 			flush_type =3D flush_left;
 		break;
@@ -1334,6 +1338,36 @@ static size_t format_and_pad_commit(struct strbu=
f *sb, /* in UTF-8 */
 		total_consumed++;
 	}
 	len =3D utf8_strnwidth(local_sb.buf, -1, 1);
+
+	if (c->flush_type =3D=3D flush_left_and_steal) {
+		const char *ch =3D sb->buf + sb->len - 1;
+		while (len > padding && ch > sb->buf) {
+			const char *p;
+			if (*ch =3D=3D ' ') {
+				ch--;
+				padding++;
+				continue;
+			}
+			/* check for trailing ansi sequences */
+			if (*ch !=3D 'm')
+				break;
+			p =3D ch - 1;
+			while (ch - p < 10 && *p !=3D '\033')
+				p--;
+			if (*p !=3D '\033' ||
+			    ch + 1 - p !=3D display_mode_esc_sequence_len(p))
+				break;
+			/*
+			 * got a good ansi sequence, put it back to
+			 * local_sb as we're cutting sb
+			 */
+			strbuf_insert(&local_sb, 0, p, ch + 1 - p);
+			ch =3D p - 1;
+		}
+		strbuf_setlen(sb, ch + 1 - sb->buf);
+		c->flush_type =3D flush_left;
+	}
+
 	if (len > padding) {
 		switch (c->truncate) {
 		case trunc_left:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index b8685b9..26fbfde 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -260,4 +260,18 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left/right alignment formatting with stealing' '
+	git commit --amend -m short --author "long long long <long@me.com>" &=
&
+	git log --pretty=3D"format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual =
&&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<\EOF >expected &&
+short long  long long
+message ..   A U Thor
+add bar      A U Thor
+initial      A U Thor
+EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/utf8.c b/utf8.c
index 197414a..b1e1303 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,7 +9,7 @@ struct interval {
   int last;
 };
=20
-static size_t display_mode_esc_sequence_len(const char *s)
+size_t display_mode_esc_sequence_len(const char *s)
 {
 	const char *p =3D s;
 	if (*p++ !=3D '\033')
diff --git a/utf8.h b/utf8.h
index edde8ee..32a7bfb 100644
--- a/utf8.h
+++ b/utf8.h
@@ -3,6 +3,7 @@
=20
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
=20
+size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, int len, int skip_ansi);
 int utf8_strwidth(const char *string);
--=20
1.8.2.82.gc24b958
