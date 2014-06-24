From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] diff: mark any file larger than core.bigfilethreshold binary
Date: Tue, 24 Jun 2014 18:45:36 +0700
Message-ID: <1403610336-27761-4-git-send-email-pclouds@gmail.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
 <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 13:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPAw-0004Pw-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 13:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbaFXLqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2014 07:46:08 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:37446 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaFXLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 07:46:05 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so154238pdi.13
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nFEIQ8uBqN+0keA7ujQivlzJKyXzwbxYlnjFEGqX510=;
        b=u8QK5aER897Ce1nHg+uX1T6KErH3l5DO7aBVok6bpHUC2hBQpZcrwUDjebO7I3kL/H
         vJAcujtlrpUSGuJDR0b5Oy3wEb9oKHBOBhoVrHTX8Nn8PJIqMC9fYPHou0rVbLWP8ckr
         qJ4trt/KWXqydj18Q0zp8xOToeiUMeXhtUDpfdmwye8xi4HwRoPFPIjGmbU7rYBLi4EN
         cwlejkAoiz5eJg2OGBQyaoF7Hkfi6qPSpF2PprAWwwqQLbaR0YVxi9SNxd2N9eaJ8b3z
         MoFwA+x09uVa5BAZjGBos18ZZzRxDVM03KdyYcqGDJKx147DDkNyzN12cuDPQbM2JEDi
         s4og==
X-Received: by 10.68.200.133 with SMTP id js5mr651092pbc.138.1403610365189;
        Tue, 24 Jun 2014 04:46:05 -0700 (PDT)
Received: from lanh ([115.73.210.12])
        by mx.google.com with ESMTPSA id fb4sm142642pac.30.2014.06.24.04.46.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jun 2014 04:46:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 24 Jun 2014 18:46:00 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252401>

Too large files may lead to failure to allocate memory. If it happens
here, it could impact quite a few commands that involve
diff. Moreover, too large files are inefficient to compare anyway (and
most likely non-text), so mark them binary and skip looking at their
content.

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt        |  3 ++-
 Documentation/gitattributes.txt |  4 ++--
 diff.c                          | 26 ++++++++++++++++++--------
 diffcore.h                      |  1 +
 t/t1050-large.sh                |  4 ++++
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f467d3..a865850 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -499,7 +499,8 @@ core.bigFileThreshold::
 	Files larger than this size are stored deflated, without
 	attempting delta compression.  Storing large files without
 	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage.
+	slight expense of increased disk usage. Additionally files
+	larger than this size are allways treated as binary.
 +
 Default is 512 MiB on all platforms.  This should be reasonable
 for most projects as source code and other text files can still
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 643c1ba..9b45bda 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -440,8 +440,8 @@ Unspecified::
=20
 	A path to which the `diff` attribute is unspecified
 	first gets its contents inspected, and if it looks like
-	text, it is treated as text.  Otherwise it would
-	generate `Binary files differ`.
+	text and is smaller than core.bigFileThreshold, it is treated
+	as text. Otherwise it would generate `Binary files differ`.
=20
 String::
=20
diff --git a/diff.c b/diff.c
index a489540..7a977aa 100644
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
index 5642f84..00d2f33 100755
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
