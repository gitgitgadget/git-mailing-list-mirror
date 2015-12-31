From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] diff.c: refactor diff_words_append()
Date: Thu, 31 Dec 2015 19:37:32 +0700
Message-ID: <1451565457-18756-3-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUX-0001LF-DX
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbbLaMh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:37:59 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36420 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbbLaMh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:37:58 -0500
Received: by mail-pa0-f49.google.com with SMTP id yy13so59481112pab.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GRHAn41JObw9xjKUOV2bUNcb+hoC1PdPMZsLlVEzjdM=;
        b=jT7b8cTIrUgaxxmCdW77yeS5i1bXRHF5Y3gBZUneyshgwuF3rjfsImwoti+ZXu6yQI
         ueGgc8jM/pUfgFwwvbMjfmWJlZcPaGlyw0iKdz2723OmM28JcN71j4dYSqSP1tK8lVbw
         ZfTsgovVA4J2Zu6e37VfHxF+EV0V5ZkMDaowTDMs4GdSR00oNAsmW5dLDFXsBUJhyYuN
         50rj+IfKQC5idRlSzyJROEWjcrGEZDqEgKK1OeMrZw0k+dLsGeCeAW7FabYRFXq104Th
         Y+zIQlQw6sVhNGr24S/htxLdJ2+BMqIAy5ZnX6V63Qq77mCdKdB/FlkjP/3rQIaOISwk
         01JA==
X-Received: by 10.66.101.36 with SMTP id fd4mr102023908pab.76.1451565477622;
        Thu, 31 Dec 2015 04:37:57 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id p17sm67668402pfi.54.2015.12.31.04.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:37:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:37:54 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283238>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index dfbed41..8af1df1 100644
--- a/diff.c
+++ b/diff.c
@@ -788,9 +788,17 @@ struct diff_words_data {
 	struct diff_words_style *style;
 };
=20
-static void diff_words_append(char *line, unsigned long len,
-		struct diff_words_buffer *buffer)
+static void diff_words_append(struct diff_words_data *diff_words,
+			      char *line, unsigned long len)
 {
+	struct diff_words_buffer *buffer;
+
+	if (line[0] =3D=3D '-')
+		buffer =3D &diff_words->minus;
+	else {
+		assert(line[0] =3D=3D '+');
+		buffer =3D &diff_words->plus;
+	}
 	ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
 	line++;
 	len--;
@@ -1252,13 +1260,8 @@ static void fn_out_consume(void *priv, char *lin=
e, unsigned long len)
 	}
=20
 	if (ecbdata->diff_words) {
-		if (line[0] =3D=3D '-') {
-			diff_words_append(line, len,
-					  &ecbdata->diff_words->minus);
-			return;
-		} else if (line[0] =3D=3D '+') {
-			diff_words_append(line, len,
-					  &ecbdata->diff_words->plus);
+		if (line[0] =3D=3D '-' || line[0] =3D=3D '+') {
+			diff_words_append(ecbdata->diff_words, line, len);
 			return;
 		} else if (starts_with(line, "\\ ")) {
 			/*
--=20
2.3.0.rc1.137.g477eb31
