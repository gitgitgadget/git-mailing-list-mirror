From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] diff: mark any file larger than core.bigfilethreshold binary
Date: Thu, 29 May 2014 19:57:07 +0700
Message-ID: <1401368227-14469-4-git-send-email-pclouds@gmail.com>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
 <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worley@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 14:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpzmd-0004WC-DS
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbaE2MuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2014 08:50:05 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:37072 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbaE2MuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:50:03 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so346939wes.32
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kLW2ZDQY0yBtgBAPWnx6srgcNlqwalKcoasVLRdDLmw=;
        b=Uc4I5VMJ8BTlt4roRfDctlwj7OOnvA1s/uUVqWs23FNuZkh+ZSKh9CdM2/YBfwdHNh
         iJ2+HOj7l3I8u+mq2sQtLhLEoT3aeCQHarm8bCy2dYqhCb5ZaOeLZATPcKKjX2+QwtpL
         ECEpjCuimyu0rT1ER8iAJ8xCwf91SXi0w4QX3bWcRgY7PrUHETdPdxk+xd5A81KZizmf
         IA7ivM6qAp34IOpiLkk9eAAbrmyrgcYxNvtw89r/30EPgIOG8u/QUISbwnJotU3Rr0nR
         sFBQxc5L8hInXnV1TU6Ix0knSkWW4rHuL2AI4zPgEq2c0WUXK5ghb6wZpwRgMBE2W4jm
         anNw==
X-Received: by 10.180.84.226 with SMTP id c2mr11476948wiz.50.1401367802568;
        Thu, 29 May 2014 05:50:02 -0700 (PDT)
Received: from lanh ([115.73.231.189])
        by mx.google.com with ESMTPSA id hs8sm25515846wib.10.2014.05.29.05.49.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2014 05:50:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 29 May 2014 19:57:44 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250369>

Too large files may lead to failure to allocate memory. If it happens
here, it could impact quite a few commands that involve
diff. Moreover, too large files are inefficient to compare anyway (and
most likely non-text), so mark them binary and skip looking at their
content.

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c           | 26 ++++++++++++++++++--------
 diffcore.h       |  1 +
 t/t1050-large.sh |  4 ++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 54281cb..0a2f865 100644
--- a/diff.c
+++ b/diff.c
@@ -2185,8 +2185,8 @@ int diff_filespec_is_binary(struct diff_filespec =
*one)
 			one->is_binary =3D one->driver->binary;
 		else {
 			if (!one->data && DIFF_FILE_VALID(one))
-				diff_populate_filespec(one, 0);
-			if (one->data)
+				diff_populate_filespec(one, DIFF_POPULATE_IS_BINARY);
+			if (one->is_binary =3D=3D -1 && one->data)
 				one->is_binary =3D buffer_is_binary(one->data,
 						one->size);
 			if (one->is_binary =3D=3D -1)
@@ -2721,6 +2721,11 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
 		}
 		if (size_only)
 			return 0;
+		if ((flags & DIFF_POPULATE_IS_BINARY) &&
+		    s->size > big_file_threshold && s->is_binary =3D=3D -1) {
+			s->is_binary =3D 1;
+			return 0;
+		}
 		fd =3D open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
@@ -2742,16 +2747,21 @@ int diff_populate_filespec(struct diff_filespec=
 *s, unsigned int flags)
 	}
 	else {
 		enum object_type type;
-		if (size_only) {
+		if (size_only || (flags & DIFF_POPULATE_IS_BINARY)) {
 			type =3D sha1_object_info(s->sha1, &s->size);
 			if (type < 0)
 				die("unable to read %s", sha1_to_hex(s->sha1));
-		} else {
-			s->data =3D read_sha1_file(s->sha1, &type, &s->size);
-			if (!s->data)
-				die("unable to read %s", sha1_to_hex(s->sha1));
-			s->should_free =3D 1;
+			if (size_only)
+				return 0;
+			if (s->size > big_file_threshold && s->is_binary =3D=3D -1) {
+				s->is_binary =3D 1;
+				return 0;
+			}
 		}
+		s->data =3D read_sha1_file(s->sha1, &type, &s->size);
+		if (!s->data)
+			die("unable to read %s", sha1_to_hex(s->sha1));
+		s->should_free =3D 1;
 	}
 	return 0;
 }
diff --git a/diffcore.h b/diffcore.h
index a186d7c..e7760d9 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -56,6 +56,7 @@ extern void fill_filespec(struct diff_filespec *, con=
st unsigned char *,
 			  int, unsigned short);
=20
 #define DIFF_POPULATE_SIZE_ONLY 1
+#define DIFF_POPULATE_IS_BINARY 2
 extern int diff_populate_filespec(struct diff_filespec *, unsigned int=
);
 extern void diff_free_filespec_data(struct diff_filespec *);
 extern void diff_free_filespec_blob(struct diff_filespec *);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 333909b..4d922e2 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -112,6 +112,10 @@ test_expect_success 'diff --raw' '
 	git diff --raw HEAD^
 '
=20
+test_expect_success 'diff --stat' '
+	git diff --stat HEAD^ HEAD
+'
+
 test_expect_success 'hash-object' '
 	git hash-object large1
 '
--=20
1.9.1.346.ga2b5940
