From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 09/11] format-patch: stricter S-o-b detection
Date: Sun, 25 Nov 2012 17:45:57 -0800
Message-ID: <1353894359-6733-10-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:48:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcno8-0007of-ES
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab2KZBsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 20:48:08 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:57052 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2KZBsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:48:07 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3474331dak.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x/dX++E/U5Yc3la/rtyXb4Ld8DFpf/O+k/NfqybgXRc=;
        b=eHHnBtXsoMJF1DLOfd2ZWfd5rPxSfDR4ipF4ugF9f5JqkNxspqoUD4/L5zLEDgusZJ
         u2XQw+m3ecdE3k4gA0794jx6O3nOHpmznuPx4nDhzkzapbFNM2eZzV4wpqYCwCdzx1Kl
         ScuNKop4iR7oXlow2qbJJmaAA/GXF3egu+LcipXMc5rL60tfN5RwFjVSyRvKJZ2k2lxq
         s5sOgT1v8TlSWn9pttbWHTv0xtib8q3yRsXPCg4djBGOKFsZOT+FYGDfl/+OHvnacQ49
         zyuflwPiUYKuPkoI+nPl0eKR0dvDXicPgamJpb98FGwLELTp29Jsg/bGM62dKt4180b8
         Apiw==
Received: by 10.68.239.104 with SMTP id vr8mr33265115pbc.59.1353894487214;
        Sun, 25 Nov 2012 17:48:07 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.48.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:48:06 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210399>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

S-o-b in the middle of a sentence, at the beginning of the sentence
but it is just because of text wrapping, or a full paragraph of valid
S-o-b in the middle of the message. All these are not S-o-b, but
detected as is. Fix them.

[bc: add two additional tests to demonstrate shortcomings of the curren=
t
   code:

   1. failure to detect non-conforming elements in the footer when last
      line matches committer's s-o-b.
   2. failure to handle various s-o-b -like elements in the footer as
      conforming. e.g. "Change-id: IXXXX or Bug: 1234"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 log-tree.c              | 37 +++++++++++++++++--
 t/t4014-format-patch.sh | 95 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4f86def..14ebf69 100644
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
index dfe9209..30e37a7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1062,6 +1062,60 @@ EOF
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
@@ -1109,4 +1163,45 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'signoff: detect garbage in non-conforming footer'=
 '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Tested-by: my@house
+Some Trash
+Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+13:Signed-off-by: C O Mitter <committer@example.com>
+14:
+15:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_failure 'signoff: footer begins with non-signoff without @=
 sign' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Tested-by: my@house
+Change-id: Ideadbeef
+Signed-off-by: C O Mitter <committer@example.com>
+Bug: 1234
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+13:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.0.284.g959048a
