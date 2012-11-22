From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] format-patch: stricter S-o-b detection
Date: Thu, 22 Nov 2012 23:38:07 +0700
Message-ID: <1353602289-9418-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
 <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbcd0-0008Ej-W6
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab2KVTbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 14:31:47 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33774 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab2KVTbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:31:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3059016pad.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l3OSg3nbOTX1htkIYWC6LFi9+gPAIsTkaKbj0Hx0AVI=;
        b=F1yEKM81NTdMr6/J+Bzw9uzCu1va41UVX/5YnVpP+QUsycnW0Pee9kkrIxGZfsqn4u
         1Ec/B3IChQHUFyVepqvkSb3JfY0l5JysaZiZVjN4PaAWDg/nLbB038T2zvVqEnkG9w3V
         C57rCYkPUkLgR50/UxIKuul0/IrISpGw7l59vyFQIS0gxuoU3pyGtkfLfynwQY1sAF/d
         Ojh/P+vf4w05O1ILNWrYMaBpGZ4lQATfM+Rt8wDa+VknBFZWO3PFpMwSMMWYiSndyUmX
         1/HsJx2xm05zh4gGBTEzcLaQhnyI2CWYRm7dGi7bNYjOFnCToTbx1I/vbKy1LgVxMCOE
         R0nw==
Received: by 10.69.1.9 with SMTP id bc9mr6302985pbd.61.1353602294304;
        Thu, 22 Nov 2012 08:38:14 -0800 (PST)
Received: from lanh ([115.74.40.93])
        by mx.google.com with ESMTPS id o5sm2142183paz.32.2012.11.22.08.38.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:38:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Nov 2012 23:38:26 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210198>

S-o-b in the middle of a sentence, at the beginning of the sentence
but it is just because of text wrapping, or a full paragraph of valid
S-o-b in the middle of the message. All these are not S-o-b, but
detected as is. Fix them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c              | 37 +++++++++++++++++++++++++++++++--
 t/t4014-format-patch.sh | 54 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c894930..aff7c0a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -260,14 +260,47 @@ static void append_signoff(struct strbuf *sb, con=
st char *signoff)
 	int has_signoff =3D 0;
 	char *cp;
=20
-	cp =3D sb->buf;
+	/*
+	 * Only search in the last paragrah, don't be fooled by a
+	 * paragraph full of valid S-o-b in the middle.
+	 */
+	cp =3D sb->buf + sb->len - 1;
+	while (cp > sb->buf) {
+		if (cp[0] =3D=3D '\n' && cp[1] =3D=3D '\n') {
+			cp +=3D 2;
+			break;
+		}
+		cp--;
+	}
=20
 	/* First see if we already have the sign-off by the signer */
 	while ((cp =3D strstr(cp, signed_off_by))) {
+		const char *s =3D cp;
+		cp +=3D strlen(signed_off_by);
+
+		if (!has_signoff && s > sb->buf) {
+			/*
+			 * S-o-b in the middle of a sentence is not
+			 * really S-o-b
+			 */
+			if (s[-1] !=3D '\n')
+				continue;
+
+			if (s - 1 > sb->buf && s[-2] =3D=3D '\n')
+				; /* the first S-o-b */
+			else if (!detect_any_signoff(sb->buf, s - sb->buf))
+				/*
+				 * The previous line looks like an
+				 * S-o-b. There's still no guarantee
+				 * that it's an actual S-o-b. For that
+				 * we need to look back until we find
+				 * a blank line, which is too costly.
+				 */
+				continue;
+		}
=20
 		has_signoff =3D 1;
=20
-		cp +=3D strlen(signed_off_by);
 		if (cp + signoff_len >=3D sb->buf + sb->len)
 			break;
 		if (strncmp(cp, signoff, signoff_len))
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c8d5d29..d0b3c85 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -989,6 +989,60 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'signoff: not really a signoff' '
+	append_signoff <<\EOF >actual &&
+subject
+
+I want to mention about Signed-off-by: here.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:I want to mention about Signed-off-by: here.
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: not really a signoff (2)' '
+	append_signoff <<\EOF >actual &&
+subject
+
+My unfortunate
+Signed-off-by: example happens to be wrapped here.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:Signed-off-by: example happens to be wrapped here.
+11:
+12:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
+	append_signoff <<\EOF >actual &&
+subject
+
+Signed-off-by: my@house
+Signed-off-by: your@house
+
+A lot of houses.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:Signed-off-by: my@house
+10:Signed-off-by: your@house
+11:
+13:
+14:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'signoff: the same signoff at the end' '
 	append_signoff <<\EOF >actual &&
 subject
--=20
1.8.0.4.g5d0415a
